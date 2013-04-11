(setq plexus-source-mode-hooks
      '(prog-mode-hook
        haskell-mode-hook
        html-mode-hook
        coffee-mode-hook
        ))

(mapcar
 (lambda(mode)
   (add-hook mode (lambda () (plexus-source-mode-init)))) plexus-source-mode-hooks)

(setq-default tab-width 2)

(defun plexus-source-mode-init ()
  (progn
    (linum-mode 1)
    (column-number-mode)

    (local-set-key (kbd "H-c") 'comment-region)
    (local-set-key (kbd "H-u") 'uncomment-region)
    (local-set-key (kbd "H-i") 'indent-region)
    (local-set-key (kbd "H-a") 'align-to-character)
    (local-set-key (kbd "H-t") 'align-table)

    ;;(whitespace-mode)
    (setq whitespace-style '(face empty tabs lines-tail trailing))
))

(defun align-to-character (char prefix)
  (interactive "c\nP")
  (align-regexp (region-beginning)
                (region-end)
                (concat "\\(\\s-*\\)" (regexp-quote (make-string 1 char)))
                1 1 (not (eq prefix nil))))

(defun align-to-rocket (begin end)
  "Align region to equal signs"
   (interactive "r")
   (align-regexp begin end "\\(\\s-*\\)=>" 1 1 t))

(defun align-table ()
  (interactive)
  (progn
    (mark-paragraph)
    (align-to-character ?| t)))
