;; Copy-pasted snippets from the web or other 'expirements' that haven't yet made
;; into my 'official' emacs configuration.

;; http://emacswiki.org/emacs/MoveLine



(defun move-line-up ()
  "Move the current line up by N lines."
  (interactive)
  (transpose-lines 1)
  (forward-line -2))

(defun move-line-down ()
  "Move the current line down by N lines."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1))


(global-set-key (kbd "M-<up>") 'move-line-up)
(global-set-key (kbd "M-<down>") 'move-line-down)

(global-set-key (kbd "M-p") 'move-line-up)
(global-set-key (kbd "M-n") 'move-line-down)

(defun copy-file-name-to-clipboard ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (kill-new filename)
      (message "Copied buffer file name '%s' to the clipboard." filename))))

;; (defun plexus-find-file(filename &optional wildcards)
;;   "finds a file, and then creates the folder if it doesn't exist"

;;   (interactive (find-file-read-args "Find file: " nil))
;;   (let ((value (find-file-noselect filename nil nil wildcards)))
;;     (if (listp value)
;;     (mapcar 'switch-to-buffer (nreverse value))
;;       (switch-to-buffer value)))
;;   (when (not (file-exists-p default-directory))
;;        (message (format "Creating  %s" default-directory))
;;        (make-directory default-directory t)))

;; (global-set-key (kbd


;; Mon Apr  8 09:47:38 CEST 2013

(defun plexus-jump-to-clipboard ()
  (interactive)
  (let ((selection (split-string
                    (x-get-selection 'PRIMARY 'TEXT)
                    ":")))
    (find-file
     (concat "/home/arne/ticketsolve/repo/"
             (car selection) ))
    (goto-line (string-to-number (cadr selection)))
    )
)

(global-set-key (kbd "H-j") 'plexus-jump-to-clipboard)


(yas-global-mode 1)

(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank)
)

(global-set-key (kbd "C-c d") 'duplicate-line)

(defun temp-ruby-buffer ()
  (interactive)
  (switch-to-buffer (make-temp-name "*ruby*"))
  (ruby-mode))

(global-set-key (kbd "H-r") 'temp-ruby-buffer)

(defun plexus-spec-summary ()
  (interactive)
  (occur "^[ \t]*\\(describe\\|it\\|context\\|specify\\|shared_examples\\|include_examples\\|shared_context\\|include_context\\)"))


(defvar hexcolour-keywords
  '(("#[abcdef[:digit:]]\\{6\\}"
     (0 (put-text-property (match-beginning 0)
                           (match-end 0)
                           'face (list :background
                                       (match-string-no-properties 0)))))))

(defun hexcolour-add-to-font-lock ()
  (font-lock-add-keywords nil hexcolour-keywords))

(add-hook 'scss-mode-hook 'hexcolour-add-to-font-lock)
