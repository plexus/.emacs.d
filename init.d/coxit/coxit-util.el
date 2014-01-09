(defun coxit-buffer-lines (buffer)
  "Map the lines in a buffer to (begin . end) pairs, being the
character index of the first and last character on that line"
  (let ((result '(0)))
    (save-excursion
      (set-buffer buffer)
      (goto-char 1)
      (while (< (point) (point-max))
        (let ((begin (point-at-bol))
              (end   (point-at-eol)))
          (add-to-list 'result (cons begin end) t)
          (forward-line 1))))
    (-drop 1 result)))
