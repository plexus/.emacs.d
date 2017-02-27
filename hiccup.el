;; threading macros copied from https://github.com/sroccaserra/emacs/blob/master/tools.el

(defmacro -> (x &optional form &rest more)
  (cond ((not (null more))
         `(-> (-> ,x ,form) ,@more))
        ((not (null form))
         (if (sequencep form)
             `(,(first form) ,x ,@(rest form))
           (list form x)))
        (t x)))

(defmacro ->> (x form &rest more)
  (cond ((not (null more)) `(->> (->> ,x ,form) ,@more))
        (t (if (sequencep form)
               `(,(first form) ,@(rest form) ,x)
             (list form x)))))

(defun plexus/sexp-to-hiccup-tag (attrs)
  (let ((tag (symbol-name (car attrs)))
        (attrs (cadr s)))
    (if-let ((id (cdr (assoc 'id attrs))))
        (setq tag (concat tag "#" id)))
    (if-let ((class (cdr (assoc 'class attrs))))
        (setq tag (concat tag "." (s-replace " " "." (s-trim class)))))
    tag))


(defun plexus/sexp-to-hiccup-attrs (attrs)
  (let ((attrs (->> attrs
                    copy-alist
                    (assq-delete-all 'id)
                    (assq-delete-all 'class))))
    (if (and attrs (car attrs))
        (concat " {"
                (s-join " "
                        (loop for attr in attrs
                              collect (if (or (eq 'id (car attr)) (eq 'class (car attr)))
                                          ""
                                        (concat
                                         ":"
                                         (symbol-name (car attr))
                                         " "
                                         (format "%S" (cdr attr)))))) "}"))))


(defun plexus/all-whitespace? (str)
  "Because Elisp regexes are terrible"
  (-all? (lambda (x) (-contains? '(9 10 13 32) x)) (append str nil)))

(defun plexus/sexp-to-hiccup-children (cs)
  (if cs
      (loop for ch in cs
            concat (concat " " (if (stringp ch)
                                   (if (plexus/all-whitespace? ch)
                                       ""
                                     (format "%S" ch))
                                 (plexus/sexp-to-hiccup ch))))))


(defun plexus/sexp-to-hiccup (s)
  (concat "[:"
          (plexus/sexp-to-hiccup-tag s)
          (plexus/sexp-to-hiccup-attrs (cadr s))
          (plexus/sexp-to-hiccup-children (cddr s))
          "]"))

(defun plexus/region-to-hiccup ()
  (let* ((html (libxml-parse-html-region (point) (mark)))
         (inner (caddr (caddr html))))
    (plexus/sexp-to-hiccup inner)))

(defun plexus/convert-region-to-hiccup ()
  (interactive)
  (let ((hiccup (plexus/region-to-hiccup)))
    (delete-region (point) (mark))
    (insert hiccup)))
