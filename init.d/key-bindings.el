;; * CUSTOM KEYBINDINGS *

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Emacs built-in

;; I don't need to kill emacs that easily
;; the mnemonic is C-x REALLY QUIT
(global-set-key (kbd "C-x r q") 'save-buffers-kill-terminal)

(global-set-key (kbd "H-c") 'comment-region)
(global-set-key (kbd "H-u") 'uncomment-region)

(global-set-key (kbd "C-c C-k") 'eval-buffer) ;; mimics CIDER binding

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Provided by packages

;; replace built-ins
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-x C-f") 'ido-find-file)

;; Hyper!
(global-set-key (kbd "H-]") 'er/expand-region)
(global-set-key (kbd "H-[") 'er/contract-region)
(global-set-key (kbd "H-g") 'magit-status)

;; Alternative to C-c p, but keeping the original binding as well
(define-key projectile-mode-map (kbd "H-p") 'projectile-command-map)

;; aliases
(global-set-key (kbd "M-t") 'projectile-find-file) ;; default: C-c p f
(global-set-key (kbd "C-M-<backspace>") 'sp-backward-kill-sexp)

(global-set-key (kbd "C->") 'mc/mark-next-like-this)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Custom commands

(global-set-key (kbd "C-c d") 'duplicate-thing)

(provide 'key-bindings)

