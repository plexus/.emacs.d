(defun plexus-ticketsolve-js-test-runner ()
  (interactive)
  (compile (concat "/home/arne/ticketsolve/repo/spec/javascripts/support/runner.coffee "
                   "/home/arne/ticketsolve/repo/spec/javascripts/unit/runner.html")
           t))

(defun plexus-javascript-init ()
  (toggle-mode)
  (electric-pair-mode)
  (yas-minor-mode)
  (define-key js-mode-map (kbd "H-s") 'plexus-ticketsolve-js-test-runner))

(add-hook 'js-mode-hook 'plexus-javascript-init)
