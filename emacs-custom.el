;; Settings configured through emacs Customize interface
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cider-docview-javadoc-path
   (quote
    ("/home/arne/opt/javadoc/api" "/home/arne/opt/javadoc/docs/api")))
 '(cider-javadoc-path
   (quote
    ("/home/arne/opt/javadoc/api" "/home/arne/opt/javadoc/docs/api")))
 '(custom-enabled-themes (quote (sanityinc-tomorrow-day)))
 '(custom-safe-themes
   (quote
    ("4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" default)))
 '(doc-view-resolution 100)
 '(elfeed-feeds
   (quote
    ("https://pragtob.wordpress.com/feed/" "http://devblog.avdi.org/feed/" "https://blog.eventgonegood.com/feed.xml" "http://devblog.arnebrasseur.net/feed.xml" "http://www.plantseedstoday.com/see-all-posts?format=RSS" "http://endlessparentheses.com/atom.xml")))
 '(fci-rule-color "#eee8d5")
 '(flymake-coffee-coffeelint-configuration-file "/home/arne/.coffeelint.json")
 '(gnus-posting-styles
   (quote
    ((".*clojure.*"
      (address "clojure@arnebrasseur.net")
      ("To" "clojure@googlegroups.com")))))
 '(helm-ag-insert-at-point (quote symbol))
 '(helm-ag-use-agignore t)
 '(js-indent-level 2)
 '(js2-basic-offset 2)
 '(js2-indent-level 2)
 '(magit-completing-read-function (quote magit-ido-completing-read))
 '(org-babel-clojure-backend (quote cider))
 '(org-babel-load-languages
   (quote
    ((perl . t)
     (ruby . t)
     (sh . t)
     (python . t)
     (emacs-lisp . t)
     (clojure . t)
     (dot . t)
     (ditaa . t))))
 '(org-confirm-babel-evaluate nil)
 '(org-ditaa-jar-path "/usr/share/ditaa/ditaa.jar")
 '(org-src-fontify-natively t)
 '(package-selected-packages
   (quote
    (:rainbow-mode rainbow-delimiters-mode haskell-mode htmlize db-pg sql-indent org which-key ac-cider eval-sexp-fu multiple-cursors yasnippet s dash clj-refactor clj-refac1tor visual-fill-column visual-fill-column-mode elfeed elfeed-org darkroom use-package clojure-mode outline-magic cider rainbow-mode helm-ag helm-projectile heml-projectile helm ruby-hash-syntax inf-ruby chruby wgrep web-mode undo-tree smooth-scrolling smartparens rainbow-delimiters projectile move-text markdown-mode magit js2-mode highlight-escape-sequences guide-key flymake-coffee fill-column-indicator f expand-region elisp-slime-nav duplicate-thing color-theme-sanityinc-tomorrow color-theme-sanityinc-solarized coffee-mode clojure-mode-extra-font-locking cider-eval-sexp-fu)))
 '(popwin-mode t)
 '(popwin:popup-window-height 15)
 '(safe-local-variable-values
   (quote
    ((eval font-lock-add-keywords nil
           (\`
            (((\,
               (concat "("
                       (regexp-opt
                        (quote
                         ("sp-do-move-op" "sp-do-move-cl" "sp-do-put-op" "sp-do-put-cl" "sp-do-del-op" "sp-do-del-cl"))
                        t)
                       "\\_>"))
              1
              (quote font-lock-variable-name-face)))))
     (checkdoc-package-keywords-flag)
     (bug-reference-bug-regexp . "#\\(?2:[[:digit:]]+\\)")
     (rainbow-mode . t)
     (encoding . utf-8))))
 '(send-mail-function (quote smtpmail-send-it))
 '(sp-base-key-bindings (quote paredit))
 '(sql-indent-offset 2)
 '(tls-checktrust t)
 '(wdired-allow-to-change-permissions (quote advanced)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
