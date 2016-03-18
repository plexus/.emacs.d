(add-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode)

;; Elisp go-to-definition with M-. and back again with M-,
(autoload 'elisp-slime-nav-mode "elisp-slime-nav")
(add-hook
 'emacs-lisp-mode-hook
 (lambda ()
   (elisp-slime-nav-mode t)
   (eldoc-mode 1)
   (auto-complete-mode)
   (paredit-mode)))

(define-key emacs-lisp-mode-map (kbd "C-C C-r") 'eval-region)

(provide 'setup-elisp)
