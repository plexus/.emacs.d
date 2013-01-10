(setq backup-directory-alist
          `((".*" . ,(concat user-emacs-directory "backups"))))  ; Store backups in ~/.emacs.d/backups

(fset 'yes-or-no-p 'y-or-n-p)

;(setq backup-inhibited t)                      ; don't backup to a ~ file
(setq auto-save-default nil)                   ; don't autosave to a #...# file

(show-paren-mode)

(put 'upcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'downcase-region 'disabled nil)
