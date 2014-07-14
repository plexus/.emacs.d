(require 'dash)
(require 'dash-functional)
(require 'f)

(defcustom coxit-key-command-prefix (kbd "H-s")
  "The prefix for all coxit key commands"
  :type 'string
  :group 'coxit-mode)

(defcustom coxit-rspec-process-buffer-name "*coxit-rspec-client*"
  "How to name the buffer where RSpec runs"
  :type 'string
  :group 'coxit-mode)


(defconst *coxit-base* (file-name-directory load-file-name))
(defconst *coxit-server-port* 10042)

(defconst coxit-mode-line '(:eval (propertize (coxit-format-result)
                                      'face (if (coxit-result-success) 'coxit-line-covered 'coxit-line-not-covered)
                                      'help-echo (coxit-format-result t))))

;; buffer local variables

(defvar coxit-show-coverage t
  "Display coverage markers in the fringe")

(defvar coxit-process-buffers nil
  "Keep a tab on the running rspec processes, maps from the process object to the associated buffer")

;; project-local-variables
;;
;; Use with `plv-get' and `plv-set'

(defvar coxit-rspec-files '((default . "spec"))
  "Arguments to rspec to determine which tests will be run. Defaults to the
`spec' directory")

(defvar coxit-buffers nil
  "A list of all buffers in the current project that have coxit-mode enabled")

(defvar coxit-rspec-summary nil
  "Project-local results of latest rspec run.")

(defvar coxit-rspec-process nil
  "The last rpsec process that got started.")

(defvar coxit-rspec-last-args nil
  "The arguments that were passed to rspec on its last run")

(defvar coxit-use-bundler '((default . t))
  "Run RSpec with `bundle exec' or not.")


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

(defun coxit-rspec-wrapper-path ()
  "Full path to the RSpec wrapper that returns a SEXP of coverage results"
  (f-join *coxit-base* "rspec-runner.rb"))

(defun coxit-bundler-path ()
  "Path to bundler"
  (executable-find "bundle"))

(defun coxit-rspec-runner ()
  (if (plv-get coxit-use-bundler)
      (coxit-bundler-path)
    (coxit-rspec-wrapper-path)))

(defun coxit-rspec-runner-arguments ()
  (append
   (if (plv-get coxit-use-bundler)
       (list "exec" (coxit-rspec-wrapper-path)))
   `(,(concat "project-root:" plv-project-root)
     "--"
     ,@(plv-get coxit-rspec-files)
     "--no-color")))

(defun coxit-spec-file-for (target)
  "Tries to find a corresponding spec file for the given ruby file name path."
  (let* ((project-root  (plv-project-root target))
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
            ))
         (spec-file-1 (apply 'f-join (cons test-dir (-drop 1 spec-file-parts)))) ; drop lib, app
         (spec-file-2 (apply 'f-join (cons test-dir spec-file-parts))))
    (cond ((f-file? spec-file-1) spec-file-1)
          ((f-file? spec-file-2) spec-file-2)
          ((f-directory? (f-dirname spec-file-2)) spec-file-2)
          (t spec-file-1))))

;; PROCESS

(defun coxit-parse-results (rspec-output)
  "The RSpec wrapper will return a sexp as the last line of the output. Pull that
line out of the result and parse it with the Elisp reader."
  (read (car (reverse (split-string rspec-output "\n")))))

(defun coxit-dispatch-message (result-assoc)
  "Dispatch message coming back from RSpec depending on the type of info they contain"
  (let ((type         (assoc-default 'type         result-assoc))
        (results      (assoc-default 'results      result-assoc))
        (project-root (assoc-default 'project-root result-assoc)))
    (when (equal type 'coverage)
      (coxit-process-coverage results))
    (when (equal type 'spec_summary)
      (coxit-process-result results project-root))))

(defun coxit-process-coverage (result-assoc)
  "Given an association list of coverage data like ((\"/path\" . (nil nil 1 0 3))),
find all open buffers for which we have received data, and add coverage overlays."
  (-each result-assoc
         (lambda (kv)
           (let ((file-name (car kv)) (coverage (cdr kv)))
             ;(message file-name)
             (-if-let (buffer (--first (equal (buffer-file-name it) file-name) (buffer-list)))
               (coxit-display-coverage-data coverage buffer))))))

(defun coxit-process-result (result-assoc project-root)
  "Called when a 'results message is received from rspec, stored for display in the mode line"
  (plv-set coxit-rspec-summary result-assoc project-root))

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
                ;(overlay-put overlay 'face 'coxit-line-not-covered)
                  (overlay-put overlay 'before-string (propertize "!" 'display '(left-fringe empty-line coxit-line-not-covered)))
              (if line-coverage
                  (overlay-put overlay 'before-string (propertize "!" 'display '(left-fringe empty-line coxit-line-covered))))
              )))))))

(defun coxit-coverage-delete-overlays ()
  (interactive)
  (-each
   (--filter (overlay-get it 'coxit-coverage) (overlays-in 1 (point-max))) #'delete-overlay))

;; Mode line

(defun coxit-format-result (&optional for-help)
  (let* ((rspec-summary (plv-get coxit-rspec-summary))
         (failure-count (or (cdr (assoc 'failure_count rspec-summary)) 0))
         (example-count (or (cdr (assoc 'example_count rspec-summary)) 0))
         (duration      (or (cdr (assoc 'duration      rspec-summary)) 0))
         (result-fmt (format "%d / %d (%.2fs)" failure-count example-count duration))
         (status (coxit-process-status)))
    (cond ((eq (plv-get coxit-rspec-process) nil) "?")
          ((eq status 'run) " ⌛ ")
          ((and (eq status 'exit) (eq (coxit-exit-code) 0))
             (format "%d OK (%.2fs)" example-count duration))
          ((and (eq status 'exit) (> failure-count 0))
             (format "%d / %d (%.2fs)" failure-count example-count duration))
          (t (format "%s ⚡ %d" (coxit-process-status) (coxit-exit-code))))))

(defun coxit-rspec-running-p ()
  (eq (coxit-process-status) 'run))

(defun coxit-exit-code ()
  (and (plv-get coxit-rspec-process) (process-exit-status (plv-get coxit-rspec-process))))

(defun coxit-process-status ()
  (and (plv-get coxit-rspec-process) (process-status (plv-get coxit-rspec-process))))

(defun coxit-result-success ()
  (let* ((rspec-summary (plv-get coxit-rspec-summary))
         (failure-count (or (cdr (assoc 'failure_count rspec-summary)) 0))
         (example-count (or (cdr (assoc 'example_count rspec-summary)) 0)))
    (and (eq (coxit-exit-code) 0) (> example-count 0) (= failure-count 0))))

;; Server

(defun coxit-server-start ()
  (interactive)
  (make-network-process :name "coxit-server"
                        :buffer "*coxit-server*"
                        :family 'ipv4
                        :service *coxit-server-port*
                        :sentinel 'coxit-server-sentinel
                        :filter 'coxit-server-filter :server 't)
  (set-process-query-on-exit-flag (get-process "coxit-server") nil))

(defun coxit-server-filter (proc string)
  ;(message string)
  (let ((buffer (-> (plist-get coxit-process-buffers proc) (or "") (concat string))))
    (setq coxit-process-buffers (plist-put coxit-process-buffers proc buffer))))

(defun coxit-server-sentinel (proc msg)
  ;(message "sentinel: %s" msg)
  (when (string= msg "connection broken by remote peer\n")
    (-if-let (input (plist-get coxit-process-buffers proc))
      (coxit-dispatch-message (coxit-parse-results input)))))

(defun coxit-client-sentinel (proc msg)
  ;(message "sentinel: %s" msg)
  (if (s-match "exited abnormally" msg)
      (display-buffer "*coxit-rspec-client*" 'display-buffer-pop-up-window)))

;; Interactive commands

(defun coxit-rspec-run-client (&optional rspec-args project-dir)
  (interactive)
  (if (and (coxit-rspec-running-p) (y-or-n-p "There's an rspec process running, kill it?"))
      (kill-process (plv-get coxit-rspec-process)))
  (or (process-status "coxit-server") (coxit-server-start))
  (plv-unset coxit-rspec-summary project-dir)
  (save-excursion
    (set-buffer (get-buffer-create coxit-rspec-process-buffer-name))
    (coxit-mode)
    (narrow-to-region (point-max) (point-max)))
  (let* ((project-dir (or project-dir (plv-project-root)))
         (rspec-args  (or rspec-args (coxit-rspec-runner-arguments)))
         (default-directory project-dir))
    ;; TODO check for running process and kill it
    (plv-set coxit-rspec-last-args rspec-args)
    (let ((process (eval `(start-process "rspec-client" coxit-rspec-process-buffer-name ,(coxit-rspec-runner) ,@rspec-args))))
      (set-process-sentinel process 'coxit-client-sentinel)
      (plv-set coxit-rspec-process process project-dir))))

(defun coxit-run-matching-spec ()
  (interactive)
  (plv-set coxit-rspec-files (list (coxit-spec-file-for (buffer-file-name))))
  (coxit-rspec-run-client))

(defun coxit-run-current-buffer ()
  (interactive)
  (plv-set coxit-rspec-files (list (buffer-file-name)))
  (coxit-rspec-run-client))

(defun coxit-run-current-line ()
  (interactive)
  (plv-set coxit-rspec-files (list (concat buffer-file-name ":" (number-to-string (line-number-at-pos (point))))))
  (coxit-rspec-run-client))

(defun coxit-run-repeat-last ()
  (interactive)
  (coxit-rspec-run-client (plv-get coxit-rspec-last-args)))

(defun coxit-run-suite ()
  (interactive)
  (plv-set coxit-rspec-files '("spec"))
  (coxit-rspec-run-client))

(defun coxit-edit-files-and-run (filename)
  (interactive (list (read-file-name "Run rspec on: "
                                     (car (plv-get coxit-rspec-files)))))
  (plv-set coxit-rspec-files (list (f-relative filename (plv-project-root))))
  (coxit-rspec-run-client))

(defun coxit-goto-matching-spec ()
  (interactive)
  (find-file (coxit-spec-file-for (buffer-file-name))))

(defun coxit-switch-to-output-buffer ()
  (interactive)
  (switch-to-buffer coxit-rspec-process-buffer-name))

;; minor mode

(defun coxit-minor-turn-on ()
  (plv-mode)
  (set (make-local-variable 'coxit-show-coverage) t)
  (plv-update coxit-buffers (cons (current-buffer) it))
  (add-to-list 'mode-line-format coxit-mode-line)
  (local-set-key coxit-key-command-prefix coxit-mode-keymap))

(defun coxit-minor-turn-off ()
  (setq coxit-show-coverage nil)
  (coxit-coverage-delete-overlays)
  (plv-update coxit-buffers (-remove (lambda (buf) (eq buf (current-buffer))) it))
  (plv-mode -1)
  (setq mode-line-format
	    (delq coxit-mode-line mode-line-format)))

;;;###autoload
(define-minor-mode coxit-mode
  ""
  :lighter " coxit"
  (progn
    (if coxit-mode
        (coxit-minor-turn-on)
      (coxit-minor-turn-off))))

(define-prefix-command 'coxit-mode-keymap)

(define-key coxit-mode-keymap (kbd "s") 'coxit-run-suite)
(define-key coxit-mode-keymap (kbd "r") 'coxit-run-repeat-last)
(define-key coxit-mode-keymap (kbd "b") 'coxit-run-current-buffer)
(define-key coxit-mode-keymap (kbd "l") 'coxit-run-current-line)
(define-key coxit-mode-keymap (kbd "m") 'coxit-run-matching-spec)
(define-key coxit-mode-keymap (kbd "o") 'coxit-switch-to-output-buffer)
(define-key coxit-mode-keymap (kbd "g") 'coxit-goto-matching-spec)
(define-key coxit-mode-keymap (kbd "e") 'coxit-edit-files-and-run)

(global-set-key (kbd "H-/") 'coxit-run-repeat-last)

;; (define-key coxit-mode-keymap (kbd "v") 'coxit-rspec-run-client)

;; Notes on bundler error codes
;; 7  missing Gem
;; 10 missing Gemfile
;; 11 git source not checked out

(provide 'coxit)
