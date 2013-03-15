(add-hook 'ruby-mode-hook (lambda () (source-mode-init)))
(add-hook 'sh-mode-hook (lambda () (source-mode-init)))
(add-hook 'emacs-lisp-mode-hook (lambda () (source-mode-init)))
(add-hook 'lisp-mode-hook (lambda () (source-mode-init)))

(defun source-mode-init ()
  (progn
    (linum-mode 1)
    (column-number-mode)

    (local-set-key (kbd "H-c") 'comment-region)
    (local-set-key (kbd "H-u") 'uncomment-region)
    (local-set-key (kbd "H-i") 'indent-region)
    (local-set-key (kbd "H-a") 'align-to-character)

    (whitespace-mode)
    (setq whitespace-style '(face empty tabs lines-tail trailing))
))

(defun align-to-character (char prefix)
  (interactive "c\nP")
  (align-regexp (region-beginning)
                (region-end)
                (concat "\\(\\s-*\\)" (make-string 1 char))
                1 1 (not (eq prefix nil))))

(defun align-to-rocket (begin end)
  "Align region to equal signs"
   (interactive "r")
   (align-regexp begin end "\\(\\s-*\\)=>" 1 1 t))
