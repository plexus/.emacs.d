(setq *hostname* (substring (shell-command-to-string "hostname") 0 -1))
(setq *auto-init-files-path* (concat user-emacs-directory "init.d"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; customize-*

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (sanityinc-tomorrow-night)))
 '(custom-safe-themes (quote ("628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" default)))
 '(rspec-key-command-prefix (kbd "H-s"))
 '(safe-local-variable-values (quote ((rainbow-mode . t) (encoding . utf-8)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Packages


(require 'package)
(package-initialize)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

(require 'pallet)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Load path

(setq load-path
      (append
       (list
	(concat user-emacs-directory "vendor")
	(concat user-emacs-directory "init.d")
	)
       load-path))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Custom Init

; load per-hostname config file
; (let ((local-rc (concat
; 		 user-emacs-directory "init." *hostname* ".el")))
;   (if (file-exists-p local-rc)
;       (load-library local-rc)
;     (beep)))

(defun plexus-load-all-in-path (base)
  (interactive)
  (add-to-list 'load-path base)
  (dolist (f (directory-files base))
    (let ((name (concat base "/" f)))
      (when (file-regular-p name)
        (load-library name)))) )

(plexus-load-all-in-path *auto-init-files-path*)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-comment-face ((((class color) (min-colors 89)) (:foreground "#93a1a1"))))
 '(font-lock-constant-face ((((class color) (min-colors 89)) (:foreground "#268bd2" :weight bold))))
 '(font-lock-keyword-face ((((class color) (min-colors 89)) (:foreground "#859900" :weight bold))))
 '(font-lock-string-face ((((class color) (min-colors 89)) (:foreground "#2aa198"))))
 '(font-lock-type-face ((((class color) (min-colors 89)) (:foreground "#b58900")))))
