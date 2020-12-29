(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#2d2d2d" "#f2777a" "#99cc99" "#ffcc66" "#6699cc" "#cc99cc" "#66cccc" "#cccccc"))
 '(beacon-color "#f2777a")
 '(custom-enabled-themes '(sanityinc-tomorrow-blue))
 '(custom-safe-themes
   '("82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" default))
 '(fci-rule-color "#515151")
 '(flycheck-color-mode-line-face-to-color 'mode-line-buffer-id)
 '(frame-background-mode 'dark)
 '(safe-local-variable-values
   '((dired-actual-switches . "-AlhrG --color=always")
     (dired-listing-switches . "-alr")
     (eval progn
           (put 'defendpoint 'clojure-doc-string-elt 3)
           (put 'defendpoint-async 'clojure-doc-string-elt 3)
           (put 'api/defendpoint 'clojure-doc-string-elt 3)
           (put 'api/defendpoint-async 'clojure-doc-string-elt 3)
           (put 'defsetting 'clojure-doc-string-elt 2)
           (put 'setting/defsetting 'clojure-doc-string-elt 2)
           (put 's/defn 'clojure-doc-string-elt 2)
           (define-clojure-indent
             (assert 1)
             (assoc 1)
             (ex-info 1)
             (expect 0)
             (match 1)
             (merge-with 1)
             (with-redefs-fn 1)))
     (eval progn
           (setenv "MELVN__SERVER_PORT"
                   (or
                    (getenv "MELVN__SERVER_PORT")
                    "8078"))
           (setenv "MELVN__DATOMIC_URI"
                   (or
                    (getenv "MELVN__DATOMIC_URI")
                    "datomic:dev://localhost:4334/onze"))
           (setenv "MB_DB_FILE"
                   (or
                    (getenv "MB_DB_FILE")
                    "../metabase/metabase.db;AUTO_SERVER=TRUE")))
     (eval define-clojure-indent
           (assoc 0)
           (ex-info 0)
           (for! 1)
           (for* 1)
           (as-> 2)
           (nextjournal\.commands\.api/register! 1)
           (nextjournal\.commands\.api/register-context-fn! 1)
           (commands/register! 1))
     (eval define-clojure-indent
           (assoc 0)
           (ex-info 0))
     (cider-refresh-after-fn . "reloaded.repl/resume")
     (cider-refresh-before-fn . "reloaded.repl/suspend")
     (elisp-lint-indent-specs
      (if-let* . 2)
      (when-let* . 1)
      (let* . defun)
      (nrepl-dbind-response . 2)
      (cider-save-marker . 1)
      (cider-propertize-region . 1)
      (cider-map-repls . 1)
      (cider--jack-in . 1)
      (cider--make-result-overlay . 1)
      (insert-label . defun)
      (insert-align-label . defun)
      (insert-rect . defun)
      (cl-defun . 2)
      (with-parsed-tramp-file-name . 2)
      (thread-first . 1)
      (thread-last . 1))
     (checkdoc-package-keywords-flag)
     (eval
      (lambda nil
        (when
            (not
             (featurep 'nextjournal))
          (let
              ((init-file-path
                (expand-file-name "emacs.d/nextjournal.el" default-directory)))
            (when
                (file-exists-p init-file-path)
              (load init-file-path)
              (require 'nextjournal))))))
     (cider-refresh-after-fn . "com.nextjournal.journal.repl/post-refresh")
     (cider-refresh-before-fn . "com.nextjournal.journal.repl/pre-refresh")
     (eval define-clojure-indent
           (assoc 0)
           (ex-info 0)
           (for! 1)
           (for* 1)
           (as-> 2)
           (uix/context-provider 1)
           (nextjournal\.commands\.api/register! 1)
           (nextjournal\.commands\.api/register-context-fn! 1)
           (commands/register! 1))
     (eval define-clojure-indent
           (assoc 0)
           (ex-info 0)
           (for! 1)
           (for* 1)
           (as-> 2)
           (uix/context-provider 1)
           (ductile\.ui\.commands\.api/register! 1)
           (ductile\.ui\.commands\.api/register-context-fn! 1)
           (commands/register! 1))
     (eval progn
           (make-variable-buffer-local 'cider-jack-in-nrepl-middlewares)
           (add-to-list 'cider-jack-in-nrepl-middlewares "shadow.cljs.devtools.server.nrepl/middleware"))
     (web-mode-markup-indent-offset . default-indent)
     (web-mode-css-indent-offset . default-indent)
     (web-mode-code-indent-offset . default-indent)
     (javascript-indent-level . default-indent)
     (css-indent-offset . default-indent)
     (default-indent . 2)
     (js2-mode-show-strict-warnings)
     (magit-save-repository-buffers . dontask)
     (frame-resize-pixelwise . t)
     (display-line-numbers-width-start . t)
     (cljr-magic-requires)
     (cider-save-file-on-load)
     (cider-repl-display-help-banner)
     (cider-auto-track-ns-form-changes)))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   '((20 . "#f2777a")
     (40 . "#f99157")
     (60 . "#ffcc66")
     (80 . "#99cc99")
     (100 . "#66cccc")
     (120 . "#6699cc")
     (140 . "#cc99cc")
     (160 . "#f2777a")
     (180 . "#f99157")
     (200 . "#ffcc66")
     (220 . "#99cc99")
     (240 . "#66cccc")
     (260 . "#6699cc")
     (280 . "#cc99cc")
     (300 . "#f2777a")
     (320 . "#f99157")
     (340 . "#ffcc66")
     (360 . "#99cc99")))
 '(vc-annotate-very-old-color nil)
 '(window-divider-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
