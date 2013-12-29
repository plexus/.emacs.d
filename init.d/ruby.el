(require 'ruby-mode)

(setq auto-mode-alist
      (append '(("\\.rb$" . ruby-mode)
                ("\\.rake$" . ruby-mode)
                ("\\.ru$" . ruby-mode)
                ("rakefile$" . ruby-mode)
                ("Rakefile$" . ruby-mode)
                ("\\.gemspec$" . ruby-mode)
                ("Gemfile$" . ruby-mode)
                ("Gemfile.*" . ruby-mode)
                ("Procfile$" . ruby-mode)
                ("Vagrantfile$" . ruby-mode)
                ("Guardfile$" . ruby-mode)
                ("Berksfile$" . ruby-mode)
                ("\\.rhtml$" . ruby-mode)
                ("\\.xml.builder$" . ruby-mode)
                )
              auto-mode-alist))

(setq ruby-indent-level 2)
(setq ruby-deep-indent-paren nil)       ; inside parameter lists, just indent two spaces rather than up to paren

(defun plexus-load-rspec ()
  (require 'rspec-mode)
  (setq rspec-use-rake-flag nil)
  (setq rspec-spec-command "rspec")
  (custom-set-variables '(rspec-key-command-prefix (kbd "H-s")))
  (define-key rspec-mode-keymap (kbd "H-s") 'rspec-verify-single)
  )

(defun plexus-set-rct-elisp-path ()
  (setq load-path
        (append
         (list (concat user-emacs-directory "vendor/rcodetools"))
         load-path)))

(defun plexus-set-rct-bin-path ()
  (setenv
   "PATH"
   (file-truename
    (concat user-emacs-directory
            "vendor/rcodetools/bin"
            ":"
            (concat (getenv "PATH"))))))

(defun plexus-set-rct-load-path ()
  (setenv
   "RUBYLIB"
   (file-truename
    (concat user-emacs-directory
            "vendor/rcodetools/lib"
            ":"
            (concat (getenv "RUBYLIB"))))))

(defun plexus-activate-rcodetools ()
  (progn
    (plexus-set-rct-elisp-path)
    (plexus-set-rct-bin-path)
    (plexus-set-rct-load-path)
    (require 'rcodetools)
    (define-key ruby-mode-map (kbd "C-c C-c") 'xmp)))

(add-hook 'ruby-mode-hook 'plexus-activate-rcodetools)
(add-hook 'ruby-mode-hook 'coxit-mode)
(add-hook 'ruby-mode-hook 'abbrev-mode)
            ;(plexus-load-rspec)
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

(require 'chruby)
(chruby "1.9.3")
