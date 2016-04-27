(packages-install
 '(clojure-mode
   clojure-mode-extra-font-locking
   cider
   cider-eval-sexp-fu
   clj-refactor
   ac-cider))

(require 'clj-refactor)

(defun plexus/clojure-mode-hook ()
    (clj-refactor-mode 1)
    (yas-minor-mode 1) ; for adding require/use/import
    (cljr-add-keybindings-with-prefix "C-c C-m")
    (rainbow-delimiters-mode)
    (paredit-mode)
    (cider-mode))

(add-hook 'clojure-mode-hook #'plexus/clojure-mode-hook)

(add-hook 'nrepl-connected-hook
          (lambda ()
            (cider-nrepl-request:eval
             "(alter-var-root #'refactor-nrepl.ns.slam.hound.regrow/*cache* (constantly nil))"
             (lambda (x)))))

'(remove-hook 'nrepl-connected-hook
          (lambda ()
            (cider-nrepl-request:eval
             "(alter-var-root #'refactor-nrepl.ns.slam.hound.regrow/*cache* (constantly nil))"
             (lambda (x)))))


(provide 'setup-clojure)

;; ac-cider

;; (require 'ac-cider)
;; (add-hook 'cider-mode-hook 'ac-flyspell-workaround)
;; (add-hook 'cider-mode-hook 'ac-cider-setup)
;; (add-hook 'cider-repl-mode-hook 'ac-cider-setup)
;; (eval-after-load "auto-complete"
;;   '(progn
;;      (add-to-list 'ac-modes 'cider-mode)
;;      (add-to-list 'ac-modes 'cider-repl-mode)))

(put-clojure-indent 'GET 2)
(put-clojure-indent 'POST 2)
(put-clojure-indent 'PUT 2)
(put-clojure-indent 'DELETE 2)

(setq cljr-favor-private-functions nil)


(defun plexus/cider-eval-and-insert (&optional prefix)
  (interactive "P")
  (if prefix
      (let ((pos (point)))
        (cider-eval-last-sexp t)
        (goto-char pos)
        (insert ";;=> "))

    (let* ((lbp (line-beginning-position))
           (comment-pos (search-backward ";;=>" lbp t)))
      (if comment-pos
          (progn
            (goto-char comment-pos)
            (delete-region comment-pos (line-end-position))
            (cider-eval-last-sexp t)
            (goto-char comment-pos)
            (insert ";;=> "))
        (cider-eval-last-sexp)))))

(define-key cider-mode-map (kbd "C-x C-e") 'plexus/cider-eval-and-insert)

(define-key cider-test-report-mode-map (kbd "g") 'cider-test-rerun-tests)

(setq cider-cljs-lein-repl
      "(do (require 'figwheel-sidecar.repl-api)
 (figwheel-sidecar.repl-api/start-figwheel!)
 (figwheel-sidecar.repl-api/cljs-repl))")
