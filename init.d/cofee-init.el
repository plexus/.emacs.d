(add-hook 'coffee-mode-hook
          (lambda ()
            (define-key coffee-mode-map (kbd "DEL") 'delete-backward-char)))
