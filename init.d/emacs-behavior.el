(setq backup-directory-alist
          `((".*" . ,(concat user-emacs-directory "backups"))))  ; Store backups in ~/.emacs.d/backups


;(setq backup-inhibited t)                      ; don't backup to a ~ file
(setq auto-save-default nil)                   ; don't autosave to a #...# file

(show-paren-mode)

(put 'upcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(setq-default indent-tabs-mode nil)            ; tabs are nasty


(defun plexus-shell-command (command &optional output-buffer error-buffer)
  "Run a shell command with the current file (or marked dired files).
In the shell command, the file(s) will be substituted wherever a '%' is."
  (interactive
   (list
    (read-shell-command "Shell command: " nil nil
      (let ((filename
             (cond
              (buffer-file-name)
              ((eq major-mode 'dired-mode)
               (dired-get-filename nil t)))))
              (and filename (file-relative-name filename))))
    current-prefix-arg
    shell-command-default-error-buffer))
  (cond ((buffer-file-name)
         (setq file-replacement (buffer-file-name)))
        ((and (equal major-mode 'dired-mode) (save-excursion (dired-move-to-filename)))
         (setq file-replacement (mapconcat 'identity (dired-get-marked-files) " "))))
  (shell-command
   (replace-regexp-in-string "%"
                             file-replacement
                             command)
   output-buffer
   error-buffer))

(global-set-key (kbd "M-!") 'plexus-shell-command)
