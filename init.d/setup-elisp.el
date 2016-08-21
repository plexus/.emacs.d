(use-package elisp-mode
  :config
  (use-package rainbow-delimiters
    :ensure t
    :config
    (add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode))

  ;; Elisp go-to-definition with M-. and back again with M-,
  (use-package elisp-slime-nav
    :ensure t
    :config
    (add-hook 'emacs-lisp-mode-hook 'elisp-slime-nav-mode)
    (add-hook 'emacs-lisp-mode-hook 'eldoc-mode))

  (use-package paredit
    :ensure t
    :config
    (add-hook 'emacs-lisp-mode-hook 'paredit-mode)
    (define-key emacs-lisp-mode-map (kbd "C-M-w") 'sp-copy-sexp))

  ;; Flash sexps when evaluating them
  (use-package eval-sexp-fu :ensure t)

  (define-key emacs-lisp-mode-map (kbd "C-C C-r") 'eval-region))

(provide 'setup-elisp)
