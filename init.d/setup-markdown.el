;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; edit source blocks in markdown

(use-package markdown-mode :ensure t)

(defvar plexus/restore-mode-map (make-sparse-keymap)
  "Keymap while plexus/restore-mode is active.")

(define-minor-mode plexus/restore-mode
  "A temporary minor mode to go back to the markdown you're editing"
  nil
  :lighter " ♻"
  plexus/restore-mode-map)

(defun plexus/edit-md-source-block ()
  (interactive)
  (let ((buffer nil))
    (save-excursion
      (re-search-backward "\n```\[a-z- \]+\n")
      (re-search-forward "\n``` *")
      (let ((lang (thing-at-point 'symbol))
            (md-buffer (current-buffer)))
        (forward-line)
        (let ((start (point)))
          (re-search-forward "\n```")
          (let* ((end (- (point) 4))
                 (source (buffer-substring-no-properties start end)))
            (setq buffer (get-buffer-create (concat "*markdown-" lang "*")))
            (set-buffer buffer)
            (erase-buffer)
            (insert source)
            (setq restore-start start)
            (setq restore-end end)
            (setq restore-buffer md-buffer)
            (make-local-variable 'restore-start)
            (make-local-variable 'restore-end)
            (make-local-variable 'restore-buffer)
            (funcall (intern (concat (downcase lang) "-mode")))))))
    (switch-to-buffer buffer)
    (plexus/restore-mode 1)))

(defun plexus/restore-md-source-block ()
  (interactive)
  (let ((contents (buffer-string))
        (edit-buffer (current-buffer)))
    (save-excursion
      (set-buffer restore-buffer)
      (delete-region restore-start restore-end)
      (goto-char restore-start)
      (insert contents))
    (switch-to-buffer restore-buffer)
    (kill-buffer edit-buffer)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; insert-link

(defun plexus/md-insert-link ()
  (interactive)
  (let ((link (read-string "Link: "))
        (desc (read-string "Description: ")))
    (when (string= "" desc)
      (setq desc (buffer-substring-no-properties (mark) (point)))
      (delete-region (mark) (point)))
    (insert (concat "[" desc "](" link ")"))))


(use-package markdown-mode
  :ensure t
  :config
  (define-key markdown-mode-map (kbd "C-c C-l") 'plexus/md-insert-link)
  (define-key markdown-mode-map (kbd "C-c '") 'plexus/edit-md-source-block)
  (define-key plexus/restore-mode-map (kbd "C-c '") 'plexus/restore-md-source-block)
  (add-hook 'markdown-mode-hook 'yas-minor-mode))

(provide 'setup-markdown)
