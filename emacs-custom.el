;; Settings configured through emacs Customize interface
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cider-cljs-lein-repl
   "(do (require 'figwheel-sidecar.repl-api) (figwheel-sidecar.repl-api/start-figwheel!) (figwheel-sidecar.repl-api/cljs-repl))")
 '(cider-docview-javadoc-path
   (quote
    ("/home/arne/opt/javadoc/api" "/home/arne/opt/javadoc/docs/api")))
 '(cider-javadoc-path
   (quote
    ("/home/arne/opt/javadoc/api" "/home/arne/opt/javadoc/docs/api")))
 '(cljr-cljc-clojure-test-declaration "[clojure.test :refer [deftest testing is are]]")
 '(cljr-cljs-clojure-test-declaration "[clojure.test :refer [deftest testing is are async]]")
 '(cljr-clojure-test-declaration "[clojure.test :refer :all]")
 '(custom-enabled-themes (quote (sanityinc-tomorrow-night)))
 '(custom-safe-themes
   (quote
    ("3380a2766cf0590d50d6366c5a91e976bdc3c413df963a0ab9952314b4577299" "eae831de756bb480240479794e85f1da0789c6f2f7746e5cc999370bbc8d9c8a" "4bf5c18667c48f2979ead0f0bdaaa12c2b52014a6abaa38558a207a65caeb8ad" "df21cdadd3f0648e3106338649d9fea510121807c907e2fd15565dde6409d6e9" "5a7830712d709a4fc128a7998b7fa963f37e960fd2e8aa75c76f692b36e6cf3c" "78c1c89192e172436dbf892bd90562bc89e2cc3811b5f9506226e735a953a9c6" "d96587ec2c7bf278269b8ec2b800c7d9af9e22d816827639b332b0e613314dfd" "aeb698d431751b18153e89b5f838fc3992433780a39a082740db216c7202a1c9" "aea30125ef2e48831f46695418677b9d676c3babf43959c8e978c0ad672a7329" "73ad471d5ae9355a7fa28675014ae45a0589c14492f52c32a4e9b393fcc333fd" "9be1d34d961a40d94ef94d0d08a364c3d27201f3c98c9d38e36f10588469ea57" "16dd114a84d0aeccc5ad6fd64752a11ea2e841e3853234f19dc02a7b91f5d661" "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" default)))
 '(debug-on-error t)
 '(doc-view-resolution 100)
 '(elfeed-feeds
   (quote
    ("https://pragtob.wordpress.com/feed/" "http://devblog.avdi.org/feed/" "https://blog.eventgonegood.com/feed.xml" "http://devblog.arnebrasseur.net/feed.xml" "http://www.plantseedstoday.com/see-all-posts?format=RSS" "http://endlessparentheses.com/atom.xml")))
 '(emojify-emoji-styles (quote (unicode)))
 '(fci-rule-color "#eee8d5")
 '(flymake-coffee-coffeelint-configuration-file "/home/arne/.coffeelint.json")
 '(global-emojify-mode t)
 '(gnus-posting-styles
   (quote
    ((".*clojure.*"
      (address "clojure@arnebrasseur.net")
      ("To" "clojure@googlegroups.com")))))
 '(helm-ag-insert-at-point (quote symbol))
 '(helm-ag-use-agignore t)
 '(http-twiddle-show-request t)
 '(http-twiddle-tls nil)
 '(inhibit-eol-conversion t)
 '(js-indent-level 2)
 '(js2-basic-offset 2)
 '(js2-indent-level 2)
 '(magit-completing-read-function (quote magit-ido-completing-read))
 '(org-babel-clojure-backend (quote cider))
 '(org-confirm-babel-evaluate nil)
 '(org-ditaa-jar-path "/usr/share/ditaa/ditaa.jar")
 '(org-src-fontify-natively t)
 '(package-selected-packages
   (quote
    (some-nonsense "a" ruby-rubocop flycheck avy avy-mode elixir-mode :ido clojure-mode paredit a 4clojure slime lua-mode ob-restclient dired+ dired-plus company json-mode pug-mode html-to-hiccup emojify mastodon ace-jump-mode nvm slim-mode php-mode web-mode clj-refactor cider sass-mode aggressive-indent rest-client
                   (dash "2.12.0")
                   (dash "2.13.0")
                   package-lint projectile-rails highlight-symbol feature-mode yaml-mode haml-mode elm-mode jsx-mode matrix-client base16-theme org monroe restclient "inf-clojure" inf-clojure ranger org-present string-edit edn nginx-mode org-mode org-bullets :rainbow-mode rainbow-delimiters-mode haskell-mode htmlize db-pg sql-indent which-key ac-cider eval-sexp-fu multiple-cursors yasnippet s dash clj-refac1tor visual-fill-column visual-fill-column-mode elfeed elfeed-org darkroom use-package outline-magic rainbow-mode helm-ag helm-projectile heml-projectile helm ruby-hash-syntax inf-ruby chruby wgrep undo-tree smooth-scrolling smartparens rainbow-delimiters projectile move-text markdown-mode magit js2-mode highlight-escape-sequences guide-key flymake-coffee fill-column-indicator f expand-region elisp-slime-nav duplicate-thing color-theme-sanityinc-tomorrow color-theme-sanityinc-solarized coffee-mode clojure-mode-extra-font-locking cider-eval-sexp-fu)))
 '(popwin-mode t)
 '(popwin:popup-window-height 15)
 '(projectile-create-missing-test-files t)
 '(safe-local-variable-values
   (quote
    ((plexus/keep-trailing-whitespace . t)
     (projectile-project-type rails-rspec)
     (projectile-project-type
      (quote rails-rspec))
     (projectile-project-type "rails-rspec")
     (projectile-project-type "rspec-rails")
     (inf-clojure-repl-type . clojure)
     (inf-clojure-program . "lein figwheel")
     (inf-clojure-lein-cmd . "lein figwheel")
     (inf-clojure-repl-type quote clojure)
     (inf-clojure-lein-cmd . "nc localhost 5555")
     (dired-actual-switches . "-AlhrG --color=always")
     (dired-listing-switches . "-alr")
     (helm-ag-command-option . "--clojure")
     (buffer-save-without-query . t)
     (cider-boot-parameters . "editor-dev")
     (eval define-clojure-indent
           (assert 1)
           (assoc 1)
           (ex-info 1)
           (match 1)
           (merge-with 1)
           (with-redefs-fn 1))
     (cider-refresh-after-fn . "reloaded.repl/go")
     (cider-refresh-before-fn . "reloaded.repl/stop")
     (cider-cljs-lein-repl . "(do (reloaded.repl/go) (user/cljs-repl))")
     (cider-cljs-lein-repl . "(do (reloaded-repl/go) (user/cljs-repl))")
     (cider-cljs-lein-repl . "(do (user/go) (user/cljs-repl))")
     (cider-cljs-lein-repl . "(user/cljs-repl)")
     (cider-cljs-lein-repl . "(do (user/run) (user/browser-repl))")
     (cider-cljs-lein-repl . "(do (dev) (go) (cljs-repl))")
     (cider-refresh-after-fn . "reloaded.repl/resume")
     (cider-refresh-before-fn . "reloaded.repl/suspend")
     (eval when
           (and
            (buffer-file-name)
            (file-regular-p
             (buffer-file-name))
            (string-match-p "^[^.]"
                            (buffer-file-name)))
           (unless
               (featurep
                (quote package-build))
             (let
                 ((load-path
                   (cons "../package-build" load-path)))
               (require
                (quote package-build))))
           (package-build-minor-mode)
           (set
            (make-local-variable
             (quote package-build-working-dir))
            (expand-file-name "../working/"))
           (set
            (make-local-variable
             (quote package-build-archive-dir))
            (expand-file-name "../packages/"))
           (set
            (make-local-variable
             (quote package-build-recipes-dir))
            default-directory))
     (org-html-table-align-individual-fields)
     (eval font-lock-add-keywords nil
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
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#cc6666")
     (40 . "#de935f")
     (60 . "#f0c674")
     (80 . "#b5bd68")
     (100 . "#8abeb7")
     (120 . "#81a2be")
     (140 . "#b294bb")
     (160 . "#cc6666")
     (180 . "#de935f")
     (200 . "#f0c674")
     (220 . "#b5bd68")
     (240 . "#8abeb7")
     (260 . "#81a2be")
     (280 . "#b294bb")
     (300 . "#cc6666")
     (320 . "#de935f")
     (340 . "#f0c674")
     (360 . "#b5bd68"))))
 '(vc-annotate-very-old-color nil)
 '(wdired-allow-to-change-permissions (quote advanced)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-constant-face ((((class color) (min-colors 89)) (:foreground "#81a2be"))))
 '(header-line ((t (:inherit mode-line-inactive :background "#1D1F21" :foreground "#8abeb7"))))
 '(linum ((t (:background "#1d1f21" :foreground "#454545" :underline nil :slant normal :height 160 :width normal :family "Inconsolata"))))
 '(markdown-pre-face ((t (:inherit font-lock-constant-face :height 1.1))))
 '(plexus/third-person-face ((t (:background "orange" :foreground "black" :underline (:color "DarkOrange" :style wave)))))
 '(writegood-weasels-face ((t (:background "orange" :foreground "black" :underline (:color "DarkOrange" :style wave))))))
