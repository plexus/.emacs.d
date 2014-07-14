(require 'ruby-mode)

(add-auto-mode-patterns 'ruby-mode
                        "\\.rb$"
                        "\\.rake$"
                        "\\.ru$"
                        "\\.xml.builder$"
                        "\\.rhtml$"
                        "\\.gemspec$"
                        "Rakefile$"
                        "Gemfile$"
                        "Gemfile.*"
                        "Procfile$"
                        "Vagrantfile$"
                        "Guardfile$"
                        "Berksfile$"
                        "Bowerfile$"
                        "Assetfile$")

(setq ruby-indent-level 2)
(setq ruby-deep-indent-paren nil)       ; inside parameter lists, just indent two spaces rather than up to paren

(defun plexus-load-rspec ()
  ;; (require 'rspec-mode)
  ;; (setq rspec-use-rake-flag nil)
  ;; (setq rspec-spec-command "rspec")
  ;; (custom-set-variables '(rspec-key-command-prefix (kbd "H-s")))
  ;; (define-key rspec-mode-keymap (kbd "H-s") 'rspec-verify-single)
  ;(rspec-install-snippets)
  )

(defun plexus-set-rct-elisp-path ()
  (let ((path (concat user-emacs-directory "vendor/rcodetools")))
    (if (not (-contains? load-path path))
        (setq load-path
              (append (list path)
                      load-path)))))

(setq plexus-rct-rcodetools-path (f-expand
                                  (f-join user-emacs-directory
                                          "vendor/rcodetools")))


(defun plexus-prepend-env-path (env-var path)
  (setenv env-var
          (s-join ":"
                  (-uniq
                   (append
                    (list path)
                    (if (getenv env-var)
                        (s-split ":"  (getenv env-var) "")
                      '() ))))))

(defun plexus-set-rct-env ()
  (plexus-prepend-env-path "PATH" (concat plexus-rct-rcodetools-path "/bin"))
  (plexus-prepend-env-path "RUBYLIB" (concat plexus-rct-rcodetools-path "/lib")))

(defun plexus-activate-rcodetools ()
  (progn
    (plexus-set-rct-elisp-path)
    (plexus-set-rct-env)
    (require 'rcodetools)
    (define-key ruby-mode-map (kbd "C-c C-c") 'xmp)))

(require 'web-mode)
(require 'ruby-hash-syntax)
(define-key ruby-mode-map (kbd "H-;") 'ruby-toggle-hash-syntax)
(define-key web-mode-map  (kbd "H-;") 'ruby-toggle-hash-syntax)

(add-hook 'ruby-mode-hook 'plexus-activate-rcodetools)
;(add-hook 'ruby-mode-hook 'coxit-mode)
(add-hook 'ruby-mode-hook 'abbrev-mode)
(plexus-load-rspec)
            ;(robe-mode)


;; "Fix" Ruby indentation, for example.
;; f(
;;   :bar => :baz
;; )
(setq ruby-deep-indent-paren nil)
(defadvice ruby-indent-line (after unindent-closing-paren activate)
  (let ((column (current-column))
        indent offset)
    (save-excursion
      (back-to-indentation)
      (let ((state (syntax-ppss)))
        (setq offset (- column (current-column)))
        (when (and (eq (char-after) ?\))
                   (not (zerop (car state))))
          (goto-char (cadr state))
          (setq indent (current-indentation)))))
    (when indent
         (indent-line-to indent)
      (when (> offset 0) (forward-char offset)))))

(defun make-temp-ruby-buffer-name ()
  (let* ((dir (concat (getenv "HOME") "/projects/ruby-tmp"))
         (last-buffer (car (last (directory-files dir nil "^[0-9]+\.rb")))))
    (or (file-directory-p dir) (mkdir dir))
    (format "%s/%05d.rb"
            dir
            (+ 1 (string-to-number
                  (first (split-string
                          (if last-buffer last-buffer "00000.rb")
                          "\\.")))))))

(defun temp-ruby-buffer ()
  (interactive)
  (let ((buffer (make-temp-ruby-buffer-name)))
    (write-region "" nil buffer)
    (find-file buffer)
    (ruby-mode)))

(global-set-key (kbd "H-r") 'temp-ruby-buffer)

(require 'chruby)
(chruby "1.9.3")
