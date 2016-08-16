(packages-install
 '(chruby
   inf-ruby
   ruby-hash-syntax))

(require 'ruby-mode)

(define-key ruby-mode-map (kbd "H-;") 'ruby-toggle-hash-syntax)

;; mimics CIDER keybindings

;; switches the current buffer to the ruby process buffer.
(define-key ruby-mode-map (kbd "C-c C-z") 'ruby-switch-to-inf)

(define-key ruby-mode-map (kbd "C-c M-j") 'inf-ruby-console-auto)

;; sends the current definition to the ruby process.
(define-key ruby-mode-map (kbd "C-M-x") 'ruby-send-definition)

;; sends the current region to the ruby process.
(define-key ruby-mode-map (kbd "C-C C-r") 'ruby-send-region)



;; `ruby-send-definition-and-go' and `ruby-send-region-and-go'
;;     switch to the ruby process buffer after sending their text.


(chruby "2.3.0")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; rcodetools

(require 'f)

(defun plexus/rcodetools-path ()
  (f-join
   (shell-command-to-string "gem which rcodetools/xmpfilter")
   "../../.."))

(defun plexus/add-load-path (path)
  (if (not (-contains? load-path path))
      (setq load-path
            (append (list path)
                    load-path))))

'(plexus/add-load-path (plexus/rcodetools-path))
'(require 'rcodetools)
'(define-key ruby-mode-map (kbd "C-c C-c") 'xmp)


(provide 'setup-ruby)
