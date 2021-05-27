(mapc #'load-file
      (directory-files
       (concat user-emacs-directory "lisp")
       t
       "^[0-9]+.*\\.el$"))

(use-package magit)
(use-package org
  :config
  (require 'org-tempo))
(use-package markdown-mode)
(use-package yaml-mode)

(straight-freeze-versions)

(server-start)

;; FIXME: should we even be doing this? and if so should it go into corkey
;; bindings?
;; Support Home/End in terminals
(global-set-key (kbd "M-[ 1 ~") 'beginning-of-line)
(global-set-key (kbd "M-[ 4 ~") 'end-of-line)
(global-set-key (kbd "<select>") 'end-of-line)

(global-set-key (kbd "TAB")
                (lambda ()
                  (let ((cmd (key-binding (kbd "<tab>"))))
                    (when (commandp cmd)
                      (call-interactively cmd)))))

(define-key evil-motion-state-map (kbd "TAB") nil)

(set-register ?k "#_clj (do (require 'kaocha.repl) (kaocha.repl/run))")
(set-register ?K "#_clj (do (require 'kaocha.repl) (kaocha.repl/run-all))")
(set-register ?r "#_clj (do (require 'user :reload) (user/reset))")
(set-register ?g "#_clj (user/go)")
(set-register ?b "#_clj (user/browse)")
(set-register ?p "#_clj (user/portal)")
(set-register ?P "#_cljs (cljs.user/portal)")

(use-package inf-clojure)
(use-package hcl-mode)
(use-package typescript-mode)
(use-package dockerfile-mode)

(setq inf-clojure-custom-startup "ssh sysadmin@10.20.9.22 rlwrap nc localhost 50505")

(define-key clojure-mode-map (kbd "M-RET") #'cider-eval-defun-at-point)

(require 'org-table)

(defun cleanup-org-tables ()
  (save-excursion
    (goto-char (point-min))
    (while (search-forward "-+-" nil t) (replace-match "-|-"))))

(add-hook 'markdown-mode-hook 'orgtbl-mode)
(add-hook 'markdown-mode-hook
          (lambda()
            (add-hook 'after-save-hook 'cleanup-org-tables  nil 'make-it-local)))


;; https://github.com/clojure-emacs/clojure-mode/issues/589#issuecomment-821817702
(defun clojure-string-start (&optional regex)
  "Return the position of the \" that begins the string at point.
If REGEX is non-nil, return the position of the # that begins the
regex at point.  If point is not inside a string or regex, return
nil."
  (when (nth 3 (syntax-ppss)) ;; Are we really in a string?
    (let* ((beg (nth 8 (syntax-ppss)))
           (hash (eq ?# (char-before beg))))
      (if regex
          (and hash (1- beg))
        (and (not hash) beg)))))
