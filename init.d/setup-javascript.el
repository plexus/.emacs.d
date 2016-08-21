(use-package js2-mode 
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.es6$" . js2-mode)))

(provide 'setup-javascript)
