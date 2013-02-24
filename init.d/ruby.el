(require 'ruby-mode)

(setq auto-mode-alist
      (append '(("\\.rb$" . ruby-mode)
                ("\\.rake$" . ruby-mode)
                ("rakefile$" . ruby-mode)
                ("Rakefile$" . ruby-mode)
                ("\\.gemspec$" . ruby-mode)
                ("Gemfile" . ruby-mode)
                ("Gemfile.lock" . ruby-mode)
                ("Procfile" . ruby-mode)
                ("Vagrantfile" . ruby-mode)
                ("Guardfile" . ruby-mode)
                ("\\.rhtml" . ruby-mode)
                )
              auto-mode-alist))

(setq ruby-indent-level 2)
(setq ruby-deep-indent-paren nil)       ; inside parameter lists, just indent two spaces rather than up to paren

(add-hook 'ruby-mode-hook
          (lambda () (linum-mode 1)))

(defun plexus-load-rspec ()
  (progn
    (require 'rspec-mode)
    (setq rspec-use-rake-flag nil)
    (setq rspec-spec-command "rspec")
    (custom-set-variables '(rspec-key-command-prefix (kbd "s-s")))
    (define-key rspec-mode-keymap (kbd "S-s") 'rspec-verify-single)))

(defun plexus-set-rct-elisp-path ()
  (setq load-path
        (append
         (list (concat user-emacs-directory "elisp/rcodetools"))
         load-path)))

(defun plexus-set-rct-bin-path ()
  (setenv "PATH"
          (concat user-emacs-directory "elisp/rcodetools/bin" ":" (concat (getenv "PATH")))))

(defun plexus-set-rct-load-path ()
  (setenv
   "RUBYLIB"
   (concat user-emacs-directory "elisp/rcodetools/lib" ":" (concat (getenv "RUBYLIB")))))

(defun plexus-activate-rcodetools ()
  (progn
    (plexus-set-rct-elisp-path)
    (plexus-set-rct-bin-path)
    (plexus-set-rct-load-path)
    (require 'rcodetools)
    (define-key ruby-mode-map (kbd "C-c C-c") 'xmp)))

(eval-after-load 'ruby-mode
  '(progn
     (require 'rvm)
     (rvm-use-default)
     (plexus-activate-rcodetools)
     (plexus-load-rspec)))


(defun align-to-equals (begin end)
  "Align region to equal signs"
   (interactive "r")
   (align-regexp begin end "\\(\\s-*\\)=" 1 1 ))

(defun align-to-rocket (begin end)
  "Align region to equal signs"
   (interactive "r")
   (align-regexp begin end "\\(\\s-*\\)=>" 1 1 t))

(defun align-to-comma (begin end)
  "Align region in columns separated by commas"
   (interactive "r")
   (align-regexp begin end "\\(\\s-*\\)," 1 1 t))

(defun align-to-semicolon (begin end)
  "Align region to semicolumns"
   (interactive "r")
   (align-regexp begin end "\\(\\s-*\\);" 1 1 ))

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(setq ruby-deep-indent-paren nil)

; f(
;   :bar => :baz
; )
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
