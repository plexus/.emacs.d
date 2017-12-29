(use-package clojure-mode
  :ensure t

  :config
  (add-hook 'clojure-mode-hook 'yas-minor-mode)
  (diminish 'yas-minor-mode)
  (add-hook 'clojure-mode-hook 'subword-mode)

  ;;;; Optional: add structural editing
  (use-package paredit
    :ensure t
    :config
    (add-hook 'clojure-mode-hook 'paredit-mode)
    (define-key paredit-mode-map (kbd "C-M-w") 'sp-copy-sexp)
    (define-key paredit-mode-map (kbd "C-M-{") 'paredit-wrap-curly)
    (define-key paredit-mode-map (kbd "C-M-<") 'paredit-wrap-square)
    (define-key paredit-mode-map (kbd "C-M-(") 'paredit-wrap-round)
    (define-key paredit-mode-map (kbd "C-M-f") 'clojure-forward-logical-sexp)
    (define-key paredit-mode-map (kbd "C-M-b") 'clojure-backward-logical-sexp))

    ;;; Give matching parentheses matching colors
  (use-package rainbow-delimiters
    :ensure t
    :config
    (add-hook 'clojure-mode-hook 'rainbow-delimiters-mode))

  (use-package aggressive-indent
    :ensure t
    :diminish aggressive-indent-mode
    :config
    (add-hook 'clojure-mode-hook 'aggressive-indent-mode))

  (use-package html-to-hiccup :ensure t)

  (use-package cider
    :ensure t
    :config
    (add-hook 'clojure-mode-hook 'cider-mode)
    (setq nrepl-prompt-to-kill-server-buffer-on-quit nil)

    (use-package cider-eval-sexp-fu :ensure t)

    (use-package company :ensure t
      :diminish company-mode
      :config
      (add-hook 'cider-repl-mode-hook #'company-mode)
      (add-hook 'cider-mode-hook #'company-mode)
      (setq company-idle-delay nil))

    (use-package clj-refactor
      :ensure t
      :config
      (add-hook 'clojure-mode-hook 'clj-refactor-mode)
      (add-hook 'cider-repl-mode-hook 'clj-refactor-mode)
      (cljr-add-keybindings-with-prefix "H-m")
      (setq cljr-warn-on-eval nil)
      (setq cljr-favor-prefix-notation nil))
    )

  (define-clojure-indent
    (GET 2)
    (POST 2)
    (PUT 2)
    (DELETE 2)
    (context 2)
    (case-of 2)
    (js/React.createElement 2)
    (element 2)
    (s/fdef 1)
    (filter-routes 1)
    (catch-pg-key-error 1)
    (handle-pg-key-error 2)
    (prop/for-all 1)
    (at 1)
    (promise 1)
    (await 1)
    (async 0))

  (put-clojure-indent 'component 1)

  (setq plexus/clojure-fill-column 45)

  (defun plexus/cider-eval-and-insert ()
    (interactive)
    (let* ((lbp (line-beginning-position))
           (comment-pos (search-backward ";;=>" lbp t)))
      (if comment-pos
          (progn
            (goto-char comment-pos)
            (delete-region comment-pos (line-end-position))
            (cider-eval-last-sexp t)
            (goto-char comment-pos)
            (insert ";;=> "))
        (progn
          (delete-horizontal-space)
          (let ((pos (point)))
            (cider-eval-last-sexp t)
            (goto-char pos)
            (insert
             (format
              (format "%%%ds;;=> " (if (= (current-column) 0)
                                       0
                                     (max 0 (+ (- plexus/clojure-fill-column (current-column)) 2))))
              "")))))))


  (define-key cider-mode-map (kbd "C-x C-e") 'cider-eval-last-sexp)
  (define-key cider-mode-map (kbd "C-x C-w") 'plexus/cider-eval-and-insert)
  (define-key cider-mode-map (kbd "H-SPC") 'cider-eval-defun-at-point)
  ;;(define-key cider-mode-map (kbd "M-TAB") 'cider-eval-last-sexp)
  ;;(define-key cider-mode-map (kbd "C-M-i") 'completion-at-point)

  (define-key cider-mode-map (kbd "M-TAB") 'company-complete)
  (define-key cider-mode-map (kbd "C-M-i") 'company-complete)

  (use-package inf-clojure :ensure t))

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

(defun cider-quit-all ()
  (interactive)
  (progn
    (dolist (connection cider-connections)
      (cider--quit-connection connection))
    (message "All active nREPL connections were closed")))

;; override this to use interrupt-process (SIGINT) instead of kill-process
;; (SIGKILL) so process can clean up
(defun nrepl--maybe-kill-server-buffer (server-buf)
  "Kill SERVER-BUF and its process, subject to user confirmation.
Do nothing if there is a REPL connected to that server."
  (with-current-buffer server-buf
    ;; Don't kill the server if there is a REPL connected to it.
    (when (and (not nrepl-client-buffers)
               (or (not nrepl-prompt-to-kill-server-buffer-on-quit)
                   (y-or-n-p "Also kill server process and buffer? ")))

      (let ((proc (get-buffer-process server-buf)))
        (when (process-live-p proc)
          (set-process-query-on-exit-flag proc nil)
          (interrupt-process proc)) ;; <-- s/kill/interrupt/
        (kill-buffer server-buf)))))


(defun cider--select-zombie-buffer (repl-buffers)
  "Return a zombie buffer from REPL-BUFFERS, or nil if none exists."
  (when-let ((zombie-buffs (seq-remove #'get-buffer-process repl-buffers)))
    (when (y-or-n-p
           (format "Zombie REPL buffers exist (%s).  Reuse? "
                   (mapconcat #'buffer-name zombie-buffs ", ")))
      (if (= (length zombie-buffs) 1)
          (car zombie-buffs)
        (completing-read "Choose REPL buffer: "
                         (mapcar #'buffer-name zombie-buffs)
nil t)))))

(defun cider-find-reusable-repl-buffer (endpoint project-directory)
  "Check whether a reusable connection buffer already exists.
Looks for buffers where `nrepl-endpoint' matches ENDPOINT, or
`nrepl-project-dir' matches PROJECT-DIRECTORY.  If such a buffer was found,
and has no process, return it.  If the process is alive, ask the user for
confirmation and return 'new/nil for y/n answer respectively.  If other
REPL buffers with dead process exist, ask the user if any of those should
be reused."
  (if-let ((repl-buffers (cider-repl-buffers))
           (exact-buff (seq-find
                        (lambda (buff)
                          (with-current-buffer buff
                            (or (and endpoint
                                     (equal endpoint nrepl-endpoint))
                                (and project-directory
                                     (equal project-directory nrepl-project-dir)))))
                        repl-buffers)))
      (progn
        (when (get-buffer-process exact-buff)
          (message "CIDER: Reusing existing buffer, %s" exact-buff))
        exact-buff)
    (or (cider--select-zombie-buffer repl-buffers) 'new)))

;; (defun cljr--add-test-declarations ()
;;   (save-excursion
;;     (let* ((ns (clojure-find-ns))
;;            (source-ns (cljr--find-source-ns-of-test-ns ns (buffer-file-name))))
;;       (cljr--insert-in-ns ":require")
;;       (when source-ns
;;         (cond ((cljr--cljs-file-p)
;;                (insert "[" source-ns " :refer []]"))
;;               ((cljr--cljc-file-p)
;;                (insert "[" source-ns " :refer []]"))
;;               (t
;;                (insert "[" source-ns " :refer :all]"))))
;;       (cljr--insert-in-ns ":require")
;;       (insert (cond
;;                ((cljr--project-depends-on-p "midje")
;;                 cljr-midje-test-declaration)
;;                ((cljr--project-depends-on-p "expectations")
;;                 cljr-expectations-test-declaration)
;;                ((cljr--cljs-file-p)
;;                 cljr-cljs-clojure-test-declaration)
;;                ((cljr--cljc-file-p)
;;                 cljr-cljc-clojure-test-declaration)
;;                (t cljr-clojure-test-declaration))))
;;     (indent-region (point-min) (point-max))))

(provide 'setup-clojure)
