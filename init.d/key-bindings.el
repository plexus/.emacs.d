;; * CUSTOM KEYBINDINGS *

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Emacs built-in

;; I don't need to kill emacs that easily
;; the mnemonic is C-x REALLY QUIT
(global-set-key (kbd "C-x r q") 'save-buffers-kill-terminal)

(global-set-key (kbd "H-c") 'comment-region)
(global-set-key (kbd "H-u") 'uncomment-region)

(global-set-key (kbd "C-c C-k") 'eval-buffer) ;; mimics CIDER binding

(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Provided by packages

;; replace built-ins
(global-set-key (kbd "M-x") 'helm-M-x)
;; (global-set-key (kbd "C-x C-f") 'helm-find-files)

;; Hyper!
(global-set-key (kbd "H-]") 'er/expand-region)
(global-set-key (kbd "H-[") 'er/contract-region)

(global-set-key (kbd "H-g") 'magit-status)
(global-set-key (kbd "C-M-s-g") 'magit-status)
(global-set-key (kbd "H-b") 'magit-blame)
(global-set-key (kbd "C-M-s-b") 'magit-blame)

(global-set-key (kbd "H-s") 'helm-projectile-ag) ; search in project on steroids
(global-set-key (kbd "C-M-s-s") 'helm-projectile-ag) ; until I figure out how to have my ergodox send hyper

(global-set-key (kbd "H-k") 'kill-this-buffer)

;; Alternative to C-c p, but keeping the original binding as well
(define-key projectile-mode-map (kbd "H-p") 'projectile-command-map)

;; aliases
(global-set-key (kbd "M-t") 'helm-projectile-find-file) ;; default: C-c p f
(global-set-key (kbd "C-M-<backspace>") 'sp-backward-kill-sexp)

(global-set-key (kbd "C->") 'mc/mark-next-like-this)

;; Not having this work everywhere is a major source of frustration
(global-set-key (kbd "C-M-k") #'sp-kill-sexp)
(global-set-key (kbd "C-M-w") #'sp-copy-sexp)

(global-set-key (kbd "s-`") #'hs-toggle-hiding)
(global-set-key (kbd "M-:") #'eval-expression)

(global-set-key (kbd "H-y") (lambda () (interactive) (insert (pop kill-ring-yank-pointer))))
(global-set-key (kbd "H-Y") (lambda ()
                              (interactive)
                              (insert (pop kill-ring-yank-pointer))
                              (insert "\n") (recenter 20)))
(global-set-key (kbd "H-j") (lambda () (interactive) (insert "\n") (recenter 20)))
;; (global-set-key (kbd "C-x C-f") #'ido-find-file)

;; disable suspend
(global-unset-key [(control z)])
(global-unset-key [(control x) (control z)])

;; might as well
(global-set-key [(control z)] #'undo)
(global-set-key [(control shift z)] #'undo-tree-redo)

(global-set-key (kbd "C-c d") #'duplicate-thing)

(provide 'key-bindings)
