(setq backup-directory-alist
          `((".*" . ,(concat user-emacs-directory "backups"))))  ; Store backups in ~/.emacs.d/backups

(fset 'yes-or-no-p 'y-or-n-p)
