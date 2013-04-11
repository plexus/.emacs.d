(defun plexus-init--term-mode-line()
  (add-to-list 'mode-line-format '(:eval plexus-shell-extra-info) t))

;; http://stackoverflow.com/questions/2886184/copy-paste-in-emacs-ansi-term-shell
(defun plexus-init--term-yank ()
  "yank in term (bound to C-c C-y)"
  (define-key term-raw-escape-map "\C-y"
    (lambda ()
       (interactive)
       (term-send-raw-string (current-kill 0)))))

(setq plexus-shell-extra-info "")

(add-hook 'term-mode-hook 'plexus-init--term-mode-line)
(add-hook 'term-mode-hook 'plexus-init--term-yank)
