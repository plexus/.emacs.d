;; * CUSTOM KEYBINDINGS *

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Emacs built-in

;; I don't need to kill emacs that easily
;; the mnemonic is C-x REALLY QUIT
(global-set-key (kbd "C-x r q") 'save-buffers-kill-terminal)

(global-set-key (kbd "H-c") 'comment-region)
(global-set-key (kbd "H-u") 'uncomment-region)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Provided by packages

;; replace built-ins
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-x C-f") 'ido-find-file)

;; Hyper!
(global-set-key (kbd "H-]") 'er/expand-region)
(global-set-key (kbd "H-g") 'magit-status)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Custom commands

(global-set-key (kbd "C-c d") 'duplicate-thing)

(provide 'key-bindings)
