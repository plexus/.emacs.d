(setq *hostname* (substring (shell-command-to-string "hostname") 0 -1))
(setq *auto-init-files-path* (concat user-emacs-directory "init.d"))

;;;;
;;Load path

(setq load-path 
      (append 
       (list
	(concat user-emacs-directory "elisp")
	(concat user-emacs-directory "init.d")
	)
       load-path))

;;;;
;;Init

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