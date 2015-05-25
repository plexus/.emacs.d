; Keyboard Bindings

;; I accidentally hit the following keys WAY too often.
(global-unset-key (kbd "C-x C-c")) ; save-buffers-kill-terminal
(global-unset-key (kbd "C-z"))
(global-unset-key (kbd "C-x C-z")) ; suspend-frame

;; (defun abg-revert-buffer-no-confirm ()
;;   "Revert buffer with no confirmation"
;;   (interactive)
;;   (revert-buffer nil t))
;; (global-set-key (kbd "<f5>") 'abg-revert-buffer-no-confirm)
;; (global-set-key (kbd "<f6>") 'magit-status)
;; ;(global-set-key (kbd "<f8>") 'gist-region-or-buffer)
;; (global-set-key (kbd "<f9>") 'org2blog/wp-new-entry)
;; (global-set-key (kbd "S-<f9>") 'org2blog/wp-post-buffer)

;; (global-set-key (kbd "C-<prior>") 'multi-term-prev)
;; (global-set-key (kbd "C-<next>") 'multi-term-next)

;; Expansion
(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "H-g") 'magit-status)
;;(global-set-key (kbd "M-t") 'find-file-in-project)
(global-set-key (kbd "M-t") 'projectile-find-file)
(global-set-key (kbd "C-x C-f") 'ido-find-file)

(global-set-key (kbd "<f7>")
                (lambda ()
                  (interactive)
                  (cider-interactive-eval "(overtone.live/stop)")))

(global-set-key (kbd "<f12>") 'transpose-lines)
(global-set-key (kbd "<f8>") 'evil-local-mode)
(global-set-key (kbd "<f9>") 'paredit-mode)

(kbd "<up>")
(require 'evil)
