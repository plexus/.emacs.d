(defvar *sly-slides* nil)
(defvar *sly-idx* 0)

(defun sly-slides (&rest slide-defs)
  (setq *sly-idx* 0)
  (setq *sly-slides* slide-defs)
  (sly-display (car slide-defs)))

(defun sly-backward ()
  (interactive)
  (when (> *sly-idx* 0)
    (decf *sly-idx*)
    (sly-display (nth *sly-idx* *sly-slides*))))

(defun sly-forward ()
  (interactive)
  (when (< *sly-idx* (- (length *sly-slides*) 1))
    (incf *sly-idx*)
    (sly-display (nth *sly-idx* *sly-slides*))))

(defun sly-keyword-find (list keyword)
  (if list
      (let ((key (car list))
            (val (cadr list))
            (rest (cddr list)))
        (if (eq key keyword)
            val
          (sly-keyword-find rest keyword)))))

(defmacro let-keys (keyspec &rest body)
  (declare (indent defun))
  (let ((keynames (car keyspec))
        (listname (cadr keyspec)))
    `(let ,(mapcar (lambda (name)
                     `(,name (sly-keyword-find ,listname ',name))) keynames)
       ,@body)))

(defun sly-set-scale (scale)
  (when scale
    (setq text-scale-mode-amount scale)
    (text-scale-mode 1)))

(defun sly-display (filespec)
  (let-keys ((file scale) filespec)
    (find-file file)
    (sly-set-scale scale)
    (when (or (s-ends-with? "jpg" file) (s-ends-with? "png" file))
      (imagex-auto-adjust-mode)))
  (sly-mode 1))

(defvar sly-mode-keymap (let ((map (make-sparse-keymap)))
                          (define-key map (kbd "[") 'sly-backward)
                          (define-key map (kbd "]") 'sly-forward)
                          map))

(define-minor-mode sly-mode "slides!"
  :lighter " 🚀"
  :keymap sly-mode-keymap)
