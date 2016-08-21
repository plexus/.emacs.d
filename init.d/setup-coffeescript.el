(use-package coffee-mode :ensure t)
(use-package flymake-coffee :ensure t
  :config
  (add-hook 'coffee-mode-hook 'flymake-coffee-load))

(provide 'setup-coffeescript)
