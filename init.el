(setq *hostname* (substring (shell-command-to-string "hostname") 0 -1))
(setq *auto-init-files-path* (concat user-emacs-directory "init.d"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; customize-*

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values (quote ((encoding . utf-8)))))

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
	(concat user-emacs-directory "elisp")
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
 '(font-lock-comment-face ((t (:foreground "forest green"))))
 '(font-lock-constant-face ((t (:foreground "slate blue"))))
 '(font-lock-keyword-face ((t (:foreground "magenta3"))))
 '(font-lock-string-face ((t (:foreground "red1"))))
 '(font-lock-type-face ((t (:foreground "slate blue")))))
