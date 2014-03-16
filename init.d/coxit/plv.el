;; Project local variables `plv' is a minor mode for maintaining state that is scoped
;; per project. Upon enable `plv-mode' it will determine the project root for the
;; buffer, e.g. the first directory in the hierarchy with a ".git" directory, and
;; store it in the buffer-local `plv-project-root' variable.

;; Afterwards use `plv-set' or `plv-get' to store and retrieve values. The values
;; are stored in association lists with the project root being the key.

;; e.g.

;; (defvar unit-test-results nil)
;; (plv-mode)
;; (plv-set unit-tests-results "7 examples, 0 failures")
;; (plv-get unit-tests-results) ; => "7 examples, 0 failures
;; unit-test-results ; => ("/home/foo/my_project" . "7 examples, 0 failures")
;; (plv-unset unit-tests-results)
(require 'dash)

(defvar plv-project-root-markers '(".git" ".svn" "Rakefile" "Gemfile" "Makefile")
  "A directory where one of these files is found is considered a project root")

(defun plv-assoc (alist value &optional project-root)
  "Associate a new value with the current project root in the given list,
non-destructive, returns a new list."
  (cons (cons (or project-root plv-project-root) value)
        (plv-unassoc alist)))

(defun plv-unassoc (alist &optional project-root)
  "Remove the association with the current project root from the association list"
  (--remove (equal (car it) (or project-root plv-project-root)) alist))

(defmacro plv-set (variable value &optional project-root)
  "Like setq, but scoped to the project root"
  (if (not (boundp variable))
      (set variable nil))
  `(setq ,variable (plv-assoc ,variable ,value ,project-root)))

(defmacro plv-get (variable &optional project-root)
  "Retrieves a value set with plv-set. Will fall back to the value set for
'default if no value for the project is set."
  `(if (--any? (equal (car it) ,(or project-root 'plv-project-root)) ,variable)
       (assoc-default ,(or project-root 'plv-project-root) ,variable)
     (assoc-default 'default ,variable)))

(defmacro plv-unset (variable &optional project-root)
  `(setq ,variable (plv-unassoc ,variable ,project-root)))

(defmacro plv-update (variable form)
  "Short form for updating a project-local variable, binds `it' in the form to the old value."
  `(let ((it (plv-get ,variable)))
     (plv-set ,variable ,form)))


(defun plv-parent-directory (a-directory)
  "Returns the directory of which a-directory is a child"
  (file-name-directory (directory-file-name a-directory)))

(defun plv-root-directory-p (a-directory)
  "Returns t if a-directory is the root"
  (equal a-directory (plv-parent-directory a-directory)))

(defun plv-project-root (&optional directory)
  "Finds the root directory of the project by walking the directory tree until it finds a rake file.

When called without arguments, starts in `default-directory'.
"
  (let ((directory (file-name-as-directory (or directory default-directory))))
    (cond ((plv-root-directory-p directory) (error "Could not determine the project root."))
          ((plv-project-root-p directory) directory)
          (t (plv-project-root (file-name-directory (directory-file-name directory)))))))

(defun plv-project-root-p (directory)
  "Is the given directory a valid project root, i.e. does it contain any of the `plv-project-root-markers'"
  (--any? (file-exists-p (expand-file-name it directory)) plv-project-root-markers))

(defun plv-minor-turn-on ()
  (set (make-local-variable 'plv-project-root) (plv-project-root)))

(defun plv-minor-turn-off ()
  (makunbound 'plv-project-root))

;;;###autoload
(define-minor-mode plv-mode
  "Project local variables. Upon enabling determine the project root directory.
successive calls to `plv-set', `plv-get' will be scoped to that directory, and
hence shared between all buffers with the same project root."
  :lighter " plv"
  (progn
    (if plv-mode
        (plv-minor-turn-on)
      (plv-minor-turn-off))))
