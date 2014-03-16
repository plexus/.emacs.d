(defun add-auto-mode-patterns (mode &rest patterns)
  "Shorthand form for quickly setting up file name patterns linked to specific modes"
  (setq auto-mode-alist
        (-uniq (append (--map (cons it mode) patterns)
                       auto-mode-alist))))

(defun file-string (file)
  "Read the contents of a file and return as a string."
  (with-temp-buffer
    (insert-file-contents file)
    (buffer-string)))
