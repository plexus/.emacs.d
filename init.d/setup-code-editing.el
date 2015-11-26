;; Shared setup for all coding modes

;; TODO scope this to programming modes
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Show line numbers in the fringe
(add-hook 'prog-mode-hook 'linum-mode)

(provide 'setup-code-editing)
