(use-package chruby
  :ensure t
  :config
  (chruby "2.4.2"))

(use-package inf-ruby :ensure t)
(use-package ruby-hash-syntax :ensure t)

(use-package ruby-mode
  :config

  (define-key ruby-mode-map (kbd "H-;") 'ruby-toggle-hash-syntax)

  ;; mimics CIDER keybindings

  ;; switches the current buffer to the ruby process buffer.
  (define-key ruby-mode-map (kbd "C-c C-z") 'ruby-switch-to-inf)

  (define-key ruby-mode-map (kbd "C-c M-j") 'inf-ruby-console-auto)

  ;; sends the current definition to the ruby process.
  (define-key ruby-mode-map (kbd "C-M-x") 'ruby-send-definition)

  ;; sends the current region to the ruby process.
  (define-key ruby-mode-map (kbd "C-C C-r") 'ruby-send-region)

  (setq ruby-insert-encoding-magic-comment nil))

;; `ruby-send-definition-and-go' and `ruby-send-region-and-go'
;;     switch to the ruby process buffer after sending their text.




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; rcodetools / xmpfilter

;; (require 'f)

;; (defun plexus/rcodetools-path ()
;;   (f-join
;;    (shell-command-to-string "gem which rcodetools/xmpfilter")
;;    "../../.."))

;; (defun plexus/add-load-path (path)
;;   (if (not (-contains? load-path path))
;;       (setq load-path
;;             (append (list path)
;;                     load-path))))

;; (plexus/add-load-path (plexus/rcodetools-path))
;; (require 'rcodetools)
;; (define-key ruby-mode-map (kbd "C-c C-c") 'xmp)


;; (use-package flycheck :ensure t)
;; (use-package rubocop :ensure t)

;; (add-hook 'ruby-mode-hook 'flycheck-mode)

;; (flycheck-define-checker ruby-rubocop
;;   ""
;;   :command ("bundle" "exec" "rubocop" "--format" "emacs"
;;             (config-file "--config" flycheck-rubocoprc)
;;             source)
;;   :error-patterns
;;   ((warning line-start
;;             (file-name) ":" line ":" column ": " (or "C" "W") ": " (message)
;;             line-end)
;;    (error line-start
;;           (file-name) ":" line ":" column ": " (or "E" "F") ": " (message)
;;           line-end))
;;   :modes (ruby-mode))


(provide 'setup-ruby)
