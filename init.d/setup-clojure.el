(use-package clojure-mode
  :ensure t

  :config
  ;;;; Optional: add structural editing
  (use-package paredit
    :ensure t
    :config
    (add-hook 'clojure-mode-hook 'paredit-mode)
    (add-hook 'clojure-mode-hook 'yas-minor-mode)
    (define-key paredit-mode-map (kbd "C-M-w") 'sp-copy-sexp)
    (define-key paredit-mode-map (kbd "C-M-{") 'paredit-wrap-curly)
    (define-key paredit-mode-map (kbd "C-M-<") 'paredit-wrap-square)
    (define-key paredit-mode-map (kbd "C-M-(") 'paredit-wrap-round))

    ;;; Give matching parentheses matching colors
  (use-package rainbow-delimiters
    :ensure t
    :config
    (add-hook 'clojure-mode-hook 'rainbow-delimiters-mode))

    ;;; Integrated REPL environment
  (use-package cider
    :ensure t
    :config
    (add-hook 'clojure-mode-hook 'cider-mode)
    (use-package cider-eval-sexp-fu :ensure t)
    (use-package clj-refactor
      :ensure t
      :config
      (add-hook 'clojure-mode-hook 'clj-refactor-mode)
      (add-hook 'cider-repl-mode-hook 'clj-refactor-mode)
      (cljr-add-keybindings-with-prefix "H-m")
      (setq cljr-warn-on-eval nil)))

  (put-clojure-indent 'GET 2)
  (put-clojure-indent 'POST 2)
  (put-clojure-indent 'PUT 2)
  (put-clojure-indent 'DELETE 2)
  (put-clojure-indent 'context 2)

  (put-clojure-indent 'js/React.createElement 2)
  (put-clojure-indent 'element 2)
  (put-clojure-indent 's/fdef 1)
  (put-clojure-indent 'filter-routes 1)
  (put-clojure-indent 'catch-pg-key-error 1)
  (put-clojure-indent 'handle-pg-key-error 2)

  (put-clojure-indent 'component 1)

  (setq plexus/clojure-fill-column 20)

  (defun plexus/cider-eval-and-insert (&optional prefix)
    (interactive "P")
    (if t ;;prefix
        (let ((pos (point)))
          (cider-eval-last-sexp t)
          (goto-char pos)
          (insert (format (format "%%%ds ;;=> " (- plexus/clojure-fill-column (current-column))) "")))

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

  (define-key cider-mode-map (kbd "C-x C-e") 'cider-eval-last-sexp)
  (define-key cider-mode-map (kbd "C-x C-w") 'plexus/cider-eval-and-insert)
  (define-key cider-mode-map (kbd "H-SPC") 'cider-eval-defun-at-point)
  (define-key cider-mode-map (kbd "M-TAB") 'cider-eval-last-sexp)
  (define-key cider-mode-map (kbd "C-M-i") 'completion-at-point))

;; (setq cider-cljs-lein-repl
;;       "(do (require 'figwheel-sidecar.repl-api)
;;            (figwheel-sidecar.repl-api/start-figwheel!)
;;            (figwheel-sidecar.repl-api/cljs-repl))")

(sp-local-pair 'clojure-mode "#(" ")")
(sp-local-pair 'clojure-mode "#{" "}")

(setq cider-cljs-lein-repl
      "(cond
  (resolve 'user/run) ;; Chestnut projects
  (eval '(do (user/run)
             (user/browser-repl)))

  (try
    (require 'figwheel-sidecar.repl-api)
    (resolve 'figwheel-sidecar.repl-api/start-figwheel!)
    (catch Throwable _))
  (eval '(do (figwheel-sidecar.repl-api/start-figwheel!)
             (figwheel-sidecar.repl-api/cljs-repl)))

  (try
    (require 'cemerick.piggieback)
    (resolve 'cemerick.piggieback/cljs-repl)
    (catch Throwable _))
  (eval '(cemerick.piggieback/cljs-repl (cljs.repl.rhino/repl-env)))

  :else
  (throw (ex-info \"Failed to initialize CLJS repl. Add com.cemerick/piggieback and optionally figwheel-sidecar to your project.\" {})))")

(provide 'setup-clojure)
