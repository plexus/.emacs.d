(defface plexus-line-covered
'((((class color) (background light))
     :background "light green"
     :foreground "dark olive green")
    (((class color) (background dark))
     :background "light green"
     :foreground "dark olive green"))
  "Face shown when a line is covered by tests."
  :group 'plexus-coverage-faces)


(defface plexus-line-not-covered
  '((((class color) (background light))
     :background "IndianRed1"
     :foreground "IndianRed5")
    (((class color) (background dark))
     :background "IndianRed1"
     :foreground "IndianRed5"))
  "Face shown when a line is not covered by tests"
  :group 'plexus-coverage-faces)

(defmacro plexus-env-let (bindings body &rest rest)
"Like `let' but sets environment variables rather than (Emacs) variables.
The return value is the result of the last expression, after returning the
environment variables are reset to their previous value."
  `(let ((orig-bindings (list ,@(mapcar (lambda (env)
                                   (list 'list env (list 'getenv env)))
                                 (mapcar 'symbol-name (mapcar 'car bindings))))))
     ,@(mapcar (lambda (binding)
                 (list 'setenv (symbol-name (car binding)) (cadr binding)))
               bindings)
     (let ((result (progn ,body ,@rest)))
       (mapcar (lambda (binding)
                 (setenv (car binding) (cadr binding)))
               orig-bindings)
       result)))

(defun plexus-gather-coverage-data (project-dir)
  (plexus-env-let ((COVERAGE "sexp"))
                  (let ((default-directory project-dir))
                    (read (car (reverse (split-string (shell-command-to-string "rspec") "\n")))))))

(defmacro plexus-each-line (body &rest rest)
  `(save-excursion
    (goto-char 1)
    (while (not (= (point) (point-max)))
      (let ((begin (point-at-bol)) (end (point-at-eol)) )
        ,body
        ,@rest)
      (forward-line 1))))

(defun plexus-display-coverage-data ()
  (interactive)
  (let* ((coverage-map (plexus-gather-coverage-data (rspec-project-root (buffer-file-name))))
         (coverage (cdr (assoc (buffer-file-name) coverage-map))))
    (plexus-each-line
     (let ((line-coverage (nth (+ (line-number-at-pos) -1) coverage)))
       (if (equal line-coverage 0)
           (let ((overlay (make-overlay begin end)))
             (overlay-put overlay 'face 'plexus-line-not-covered)
             (overlay-put overlay 'plexus-coverage t))
         ;(overlay-put (make-overlay begin end) 'face 'plexus-line-covered)
         )))))

(defun plexus-coverage-delete-overlays ()
  (interactive)
  (-each
   (--filter (overlay-get it 'plexus-coverage) (overlays-in 1 (point-max))) #'delete-overlay))
