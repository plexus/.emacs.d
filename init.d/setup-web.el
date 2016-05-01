(use-package web-mode
  :ensure t

  :config
  (add-to-list 'auto-mode-alist '("\\.erb$" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.hbs$" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tmpl$" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.html$" . web-mode))

  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-code-indent-offset 2))

(provide 'setup-web)

;; C-c C-m jump to matching <tag>
;; C-c C-f fold html tag
;; C-c C-s insert snippet
;; M--;    comment/uncomment
