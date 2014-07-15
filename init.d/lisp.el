(defun plexus-lisp-init ()
  (paredit-mode)
  (auto-complete-mode))

(add-hook 'elisp-mode           'plexus-list-init)
(add-hook 'lisp-mode            'plexus-lisp-init)
(add-hook 'cider-mode           'plexus-lisp-init)
(add-hook 'cider-repl-mode-hook 'plexus-lisp-init)

(add-hook 'elisp-mode           'turn-on-eldoc-mode)
(add-hook 'lisp-mode            'turn-on-eldoc-mode)

(require 'cider-eldoc)
(add-hook 'cider-mode           'cider-turn-on-eldoc-mode)
(add-hook 'cider-repl-mode-hook 'cider-turn-on-eldoc-mode)
