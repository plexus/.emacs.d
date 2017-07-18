(use-package web-mode
  :ensure t

  :config
  (add-to-list 'auto-mode-alist '("\\.erb$" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.hbs$" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tmpl$" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.html$" . web-mode))

  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-code-indent-offset 2))

(use-package htmlize :ensure t)
(use-package http-twiddle :ensure t)
(use-package nginx-mode :ensure t)
(use-package rainbow-mode :ensure t)

(defun haml-indent-block ()
  (interactive)
  (beginning-of-line)
  (haml-mark-sexp-but-not-next-line)
  (haml-reindent-region-by haml-indent-offset))

(use-package haml-mode
  :ensure t
  :config
  (define-key haml-mode-map (kbd "<C-tab>") 'haml-indent-block))




(provide 'setup-web)

;; C-c C-m jump to matching <tag>
;; C-c C-f fold html tag
;; C-c C-s insert snippet
;; M--;    comment/uncomment
