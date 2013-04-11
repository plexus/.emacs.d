(add-hook 'js-mode-hook (lambda ()
                          (toggle-mode)
                          (electric-pair-mode)
                          (yas-minor-mode)))
