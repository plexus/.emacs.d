;; Shared setup for all coding modes

(set-default 'plexus/keep-trailing-whitespace nil)
(make-local-variable 'plexus/keep-trailing-whitespace)

(add-hook 'before-save-hook (lambda ()
                              (when (and (or (derived-mode-p 'prog-mode)
                                             (derived-mode-p 'haml-parent-mode))
                                         (not plexus/keep-trailing-whitespace))
                                (delete-trailing-whitespace))))

;; Show line numbers in the fringe
(add-hook 'prog-mode-hook 'linum-mode)

(provide 'setup-code-editing)
