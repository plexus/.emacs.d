(require 'dash)
(require 'dash-functional)
(require 'f)

(defconst *coxit-base* (file-name-directory load-file-name))
(defconst *coxit-server-port* 10042)

(defconst coxit-mode-line '(:eval (propertize (coxit-format-result)
                                      'face (if (coxit-result-success) 'coxit-line-covered 'coxit-line-not-covered)
                                      'help-echo (coxit-format-result t))))

(make-variable-buffer-local 'coxit-project-root)
(make-variable-buffer-local 'coxit-show-coverage)
(make-variable-buffer-local 'coxit-rspec-files)

(setq-default coxit-rspec-files '("spec"))

;; Scoped per project

(defvar coxit-process-buffers nil)
(defvar coxit-timer nil)
(defvar coxit-buffers nil)

;; global  :(

(defvar coxit-results nil)

(defface coxit-line-covered
  '((((class color) (background light))
     :background "light green"
     :foreground "dark olive green")
    (((class color) (background dark))
     :background "light green"
     :foreground "dark olive green"))
  "Face shown when a line is covered by tests."
  :group 'coxit-faces)

(defface coxit-line-not-covered
  '((((class color) (background light))
     :background "IndianRed1")
    (((class color) (background dark))
     :background "IndianRed1"))
  "Face shown when a line is not covered by tests"
  :group 'coxit-faces)

;; UTIL

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

(defun coxit-parent-directory (a-directory)
  "Returns the directory of which a-directory is a child"
  (file-name-directory (directory-file-name a-directory)))

(defun coxit-root-directory-p (a-directory)
  "Returns t if a-directory is the root"
  (equal a-directory (coxit-parent-directory a-directory)))

(defun coxit-project-root (&optional directory)
  "Finds the root directory of the project by walking the directory tree until it finds a rake file."
  (let ((directory (file-name-as-directory (or directory default-directory))))
    (cond ((coxit-root-directory-p directory)
           (error "Could not determine the project root."))
          ((file-exists-p (expand-file-name "Rakefile" directory)) directory)
          ((file-exists-p (expand-file-name "Gemfile" directory)) directory)
          ((file-exists-p (expand-file-name ".git" directory)) directory)
          (t (coxit-project-root (file-name-directory (directory-file-name directory)))))))

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

(defun coxit-project-root-for-current-buffer ()
  (coxit-project-root (buffer-file-name)))

(defun coxit-rspec-wrapper-path ()
  "Full path to the RSpec wrapper that returns a SEXP of coverage results"
  (f-join *coxit-base* "rspec-runner.rb"))

(defun coxit-bundler-path ()
  "Path to bundler"
  (executable-find "bundle"))

(defun coxit-rspec-runner ()
  (coxit-bundler-path))

(defun coxit-rspec-runner-arguments ()
  `("exec" ,(coxit-rspec-wrapper-path) ,@coxit-rspec-files "--no-color"))

(defun coxit-spec-file-for (target)
  "Tries to find a corresponding spec file for the given ruby file name path."
  (let* ((project-root  (coxit-project-root target))
         (spec-unit-dir (f-join project-root "spec" "unit"))
         (spec-dir      (f-join project-root "spec"))
         (test-dir
          (cond ((f-directory? spec-unit-dir) spec-unit-dir)
                ((f-directory? spec-dir) spec-dir)))
         (spec-file-parts
          (-> target
            (f-relative project-root)
            (f-no-ext)
            (concat "_spec.rb")
            (f-split)
            )))
    (-first 'f-file?
      (-map (lambda (n)
              (apply 'f-join (cons test-dir (-drop n spec-file-parts)))) '(0 1)))))


;; PROCESS

(defun coxit-parse-results (rspec-output)
  "The RSpec wrapper will return a sexp as the last line of the output. Pull that
line out of the result and parse it with the Elisp reader."
  (read (car (reverse (split-string rspec-output "\n")))))

(defun coxit-dispatch-message (result-assoc)
  "Dispatch message coming back from RSpec depending on the type of info they contain"
  (pp result-assoc)
  (-each result-assoc
         (lambda (ass)
           (let ((key (car ass))
                 (value (cdr ass)))
             (when (equal key (quote coverage))
               (message "%s" key)
               (coxit-process-coverage value))
             (when (equal key 'result)
               (message "%s" key)
               (coxit-process-result value))))))

(defun coxit-process-coverage (result-assoc)
  "Given an association list of coverage data like ((\"/path\" . (nil nil 1 0 3))),
find all open buffers for which we have received data, and add coverage overlays."
  (pp result-assoc)
  (-each result-assoc
         (lambda (kv)
           (let ((file-name (car kv)) (coverage (cdr kv)))
             (message file-name)
             (-if-let (buffer (--first (equal (buffer-file-name it) file-name) (buffer-list)))
               (coxit-display-coverage-data coverage buffer))))))

(defun coxit-process-result (result-assoc)
  "Called when a 'results message is received from rspec, stored for display in the mode line"
  (setq coxit-results result-assoc))

(defun coxit-display-coverage-data (coverage buffer)
  "Overlay the buffer with coverage data, marking uncovered lines in red, covered lines with a green fringe"
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

(defun coxit-coverage-delete-overlays ()
  (interactive)
  (-each
   (--filter (overlay-get it 'coxit-coverage) (overlays-in 1 (point-max))) #'delete-overlay))

;; Mode line

(defun coxit-format-result (&optional for-help)
  (let* ((failure-count (or (cdr (assoc 'failure_count coxit-results)) 0))
         (example-count (or (cdr (assoc 'example_count coxit-results)) 0))
         (duration      (or (cdr (assoc 'duration coxit-results)) 0))
         (result-fmt (format "%d / %d (%.2fs)" failure-count example-count duration))
         (status (coxit-process-status)))
    (cond ((eq status 'run) " ⌛ ")
          ((and (eq status 'exit) (eq (coxit-exit-code) 0))
             (format "%d OK (%.2fs)" example-count duration))
          ((and (eq status 'exit) (> failure-count 0))
             (format "%d / %d (%.2fs)" failure-count example-count duration))
          (t (format "%s ⚡ %d" (coxit-process-status) (coxit-exit-code))))))

(defun coxit-exit-code ()
  (and coxit-rspec-process (process-exit-status coxit-rspec-process)))

(defun coxit-process-status ()
  (and coxit-rspec-process (process-status coxit-rspec-process)))

(defun coxit-result-success ()
  (let* ((failure-count (or (cdr (assoc 'failure_count coxit-results)) 0))
         (example-count (or (cdr (assoc 'example_count coxit-results)) 0)))
    (and (eq (coxit-exit-code) 0) (> example-count 0) (= failure-count 0))))

;; Server

(defun coxit-server-start ()
  (interactive)
  (make-network-process :name "coxit-server"
                        :buffer "*coxit-server*"
                        :family 'ipv4
                        :service *coxit-server-port*
                        :sentinel 'coxit-server-sentinel
                        :filter 'coxit-server-filter :server 't))

(defun coxit-server-filter (proc string)
  ;(message string)
  (let ((buffer (-> (plist-get coxit-process-buffers proc) (or "") (concat string))))
    (setq coxit-process-buffers (plist-put coxit-process-buffers proc buffer))))

(defun coxit-server-sentinel (proc msg)
  (when (string= msg "connection broken by remote peer\n")
    (-if-let (input (plist-get coxit-process-buffers proc))
      (coxit-dispatch-message (coxit-parse-results input)))
    ;(message "sentinel: %s" msg)
    ))

;; Interactive commands

(defun coxit-run-client (&optional project-dir)
  (interactive)
  (or (process-status "coxit-server") (coxit-server-start))
  (setq coxit-results nil)
  (when (get-buffer "*coxit-rspec-client*")
    (save-excursion
      (set-buffer "*coxit-rspec-client*")
      (narrow-to-region (point-max) (point-max))))
  (let* ((project-dir (or project-dir (coxit-project-root-for-current-buffer)))
         (default-directory project-dir))
    (setq coxit-rspec-process
          (eval `(start-process "rspec-client" "*coxit-rspec-client*" ,(coxit-rspec-runner) ,@(coxit-rspec-runner-arguments))))))

(defun coxit-continuous (&optional repeat-seconds project-dir)
  (interactive)
  (coxit-run-client project-dir)
  (run-at-time (or repeat-seconds 4) nil 'coxit-continous repeat-seconds (or project-dir (coxit-project-root-for-current-buffer))))

(defun coxit-run-matching-spec ()
  (interactive)
  (setq coxit-rspec-files (list (coxit-spec-file-for (buffer-file-name))))
  (coxit-run-client))

(defun coxit-run-suite ()
  (interactive)
  (setq coxit-rspec-files '("spec"))
  (coxit-run-client))


;; minor mode

(defun coxit-minor-turn-on ()
  (setq coxit-project-root (coxit-project-root-for-current-buffer))
  (setq coxit-show-coverage t)
  (coxit-update coxit-buffers (cons (current-buffer) it))
  (add-to-list 'mode-line-format coxit-mode-line t))
  ;; (if (not (coxit-get coxit-timer))
  ;;     (coxit-setq coxit-timer (coxit-continuous))))

(defun coxit-minor-turn-off ()
  (setq coxit-show-coverage nil)
  (coxit-coverage-delete-overlays)
  (coxit-update coxit-buffers (-remove (lambda (buf) (eq buf (current-buffer))) it))
  (setq mode-line-format
	    (delq coxit-mode-line mode-line-format)))
  ;; (when (not (coxit-get coxit-buffers))
  ;;     (cancel-timer (coxit-get coxit-timer))
  ;;     (coxit-unset coxit-timer)))

;;;###autoload
(define-minor-mode coxit-mode
  ""
  :lighter " coxit"
  (progn
    (if coxit-mode
        (coxit-minor-turn-on)
      (coxit-minor-turn-off))))
