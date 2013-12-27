(defconst *coxit-base* (file-name-directory load-file-name))
(defconst *coxit-server-port* 10042)

(make-variable-buffer-local 'coxit-project-root)
(make-variable-buffer-local 'coxit-show-coverage)

(defvar coxit-process-buffers nil)
(defvar coxit-timer nil)
(defvar coxit-buffers nil)

(defface coxit-line-covered
'((((class color) (background light))
     :background "light green"
     :foreground "dark olive green")
    (((class color) (background dark))
     :background "light green"
     :foreground "dark olive green"))
  "Face shown when a line is covered by tests."
  :group 'coxit-coverage-faces)

(defface coxit-line-not-covered
  '((((class color) (background light))
     :background "IndianRed1")
    (((class color) (background dark))
     :background "IndianRed1"))
  "Face shown when a line is not covered by tests"
  :group 'coxit-coverage-faces)

(defmacro coxit-setq (variable value)
  "Coxit has a number of variables that 'project-local', i.e. they are global variables
holding a plist with project root directory path as its keys. coxit-setq looks like setq
but will store the value scoped to the current project root, as found in the buffer-local
coxit-project-root variable. So make sure to execute this in the scope of a buffer with
coxit-mode on."
  `(setq ,variable
         (cons (cons coxit-project-root ,value)
               (--remove (equal (car it) coxit-project-root) ,variable))))

(defmacro coxit-get (variable)
  "Retrieves a value set with coxit-setq."
  `(cdr (assoc-string coxit-project-root ,variable)))

(defmacro coxit-update (variable form)
  "Short form for updating a project-local variable, binds `it' in the form to the old value."
  `(let ((it (coxit-get ,variable)))
     (coxit-setq ,variable ,form)))

(defmacro coxit-unset (variable)
  `(setq ,variable
         (--remove (equal (car it) coxit-project-root) ,variable)))

(defun coxit-buffer-lines (buffer &rest start)
  "Map the lines in a buffer to (begin . end) pairs, being the
character index of the first and last character on that line"
  (save-excursion
    (set-buffer buffer)
    (goto-char (if start (car start) 1))
    (let ((begin (point-at-bol))
          (end   (point-at-eol))
          (done  (= (point) (point-max))))
      (forward-line 1)
      (cons (cons begin end) (if done nil (coxit-buffer-lines buffer (point)))))))

(defun coxit-rspec-wrapper-path ()
  "Full path to the RSpec wrapper that returns a SEXP of coverage results"
  (f-join *coxit-base* "rspec-runner.rb"))

(defun coxit-parse-results (rspec-output)
  "The RSpec wrapper will return a sexp as the last line of the output. Pull that
line out of the result and parse it with the Elisp reader."
  (read (car (reverse (split-string rspec-output "\n")))))

(defun coxit-gather-coverage-data (project-dir)
  (let* ((rspec-buffer      (get-buffer-create "*coxit-rspec*"))
         (default-directory project-dir)
         (start-pos         (save-excursion (set-buffer rspec-buffer) (point)))
         (exit-code         (call-process (coxit-rspec-wrapper-path) nil rspec-buffer nil "spec"))
         (stdout            (save-excursion (set-buffer rspec-buffer) (buffer-string))))
    (if (not (equal exit-code 0))
        (progn
          (switch-to-buffer rspec-buffer)
          (narrow-to-region start-pos (point-max))
          (goto-char (point-min))
          (grep-mode)
          )
      (coxit-success (coxit-parse-results stdout)))))

(defun coxit-success (result-assoc)
  "Given an association list of coverage data like ((\"/path\" . (nil nil 1 0 3))),
find all open buffers for which we have received data, and add coverage overlays."
  (-each result-assoc
         (lambda (kv)
           (let ((file-name (car kv)) (coverage (cdr kv)))
             (-if-let (buffer (--first (equal (buffer-file-name it) file-name) (buffer-list)))
               (coxit-display-coverage-data coverage buffer))))))

(defun coxit-display-coverage-data (coverage buffer)
  (save-excursion
    (set-buffer buffer)
    (coxit-coverage-delete-overlays)
    (if coxit-show-coverage
      (--each (coxit-buffer-lines buffer)
        (let* ((begin         (car it))
               (end           (cdr it))
               (line-idx      (- (line-number-at-pos begin) 1))
               (line-coverage (nth line-idx coverage)))

          (let ((overlay (make-overlay begin end)))
            (overlay-put overlay 'coxit-coverage t)
            (if (equal line-coverage 0)
                (overlay-put overlay 'face 'coxit-line-not-covered)
              (if line-coverage
                  (overlay-put overlay 'before-string (propertize "!" 'display '(left-fringe empty-line coxit-line-covered))))
              )))))))

(defun coxit-coverage ()
  (interactive)
  (coxit-coverage-delete-overlays)
  (coxit-gather-coverage-data (coxit-project-root-for-current-buffer)))

(defun coxit-project-root-for-current-buffer ()
  (rspec-project-root (buffer-file-name)))

(defun coxit-coverage-delete-overlays ()
  (interactive)
  (-each
   (--filter (overlay-get it 'coxit-coverage) (overlays-in 1 (point-max))) #'delete-overlay))

(defun coxit-server-filter (proc string)
  ;(message string)
  (let ((buffer (-> (plist-get coxit-process-buffers proc) (or "") (concat string))))
    (setq coxit-process-buffers (plist-put coxit-process-buffers proc buffer))))

(defun coxit-server-sentinel (proc msg)
  (when (string= msg "connection broken by remote peer\n")
    (coxit-success (coxit-parse-results (plist-get coxit-process-buffers proc))))
  ;(message "sentinel: %s" msg)
  )

(defun coxit-server-start ()
  (interactive)
  (make-network-process :name "coxit-server"
                        :buffer "*coxit-server*"
                        :family 'ipv4
                        :service *coxit-server-port*
                        :sentinel 'coxit-server-sentinel
                        :filter 'coxit-server-filter :server 't))

(defun coxit-run-client (&rest project-dir)
  (interactive)
  ;(message "Run client for %s" project-dir)
  (let* ((project-dir (or (car project-dir) (coxit-project-root-for-current-buffer)))
         (default-directory project-dir))
    (start-process "rspec-client" "*coxit-rspec-client*" (coxit-rspec-wrapper-path) "spec")))

(defun coxit-continuous ()
  (interactive)
  (run-at-time t 3 'coxit-run-client coxit-project-root))

(defun coxit-minor-turn-on ()
  (setq coxit-project-root (coxit-project-root-for-current-buffer))
  (setq coxit-show-coverage t)
  (coxit-update coxit-buffers (cons (current-buffer) it))
  (if (not (coxit-get coxit-timer))
      (coxit-setq coxit-timer (coxit-continuous))))

(defun coxit-minor-turn-off ()
  (setq coxit-show-coverage nil)
  (coxit-coverage-delete-overlays)
  (coxit-update coxit-buffers (-remove (lambda (buf) (eq buf (current-buffer))) it))
  (when (not (coxit-get coxit-buffers))
      (cancel-timer (coxit-get coxit-timer))
      (coxit-unset coxit-timer)))

;;;###autoload
(define-minor-mode coxit-mode
  ""
  :lighter " coxit"
  (progn
    (if coxit-mode
        (coxit-minor-turn-on)
      (coxit-minor-turn-off))))
