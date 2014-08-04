(defun plexus-lisp-init ()
  (paredit-mode)
  (auto-complete-mode))

(add-hook 'emacs-lisp-mode-hook 'plexus-lisp-init)
(add-hook 'lisp-mode-hook       'plexus-lisp-init)
(add-hook 'cider-mode-hook      'plexus-lisp-init)
(add-hook 'cider-repl-mode-hook 'plexus-lisp-init)

(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-mode-hook       'turn-on-eldoc-mode)

(require  'cider-eldoc)
(add-hook 'cider-mode-hook      'cider-turn-on-eldoc-mode)
(add-hook 'cider-repl-mode-hook 'cider-turn-on-eldoc-mode)
