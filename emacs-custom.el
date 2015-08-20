;; Settings configured through emacs Customize interface
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#657b83" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#fdf6e3"))
 '(custom-enabled-themes (quote (sanityinc-tomorrow-day)))
 '(custom-safe-themes
   (quote
    ("4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" default)))
 '(doc-view-resolution 100)
 '(fci-rule-color "#eee8d5")
 '(fill-column 70)
 '(js-indent-level 2)
 '(js2-basic-offset 2)
 '(js2-indent-level 2)
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
    (duplicate-thing smooth-scrolling cider-eval-sexp-fu clj-refactor clojure-mode-extra-font-locking clojure-mode undo-tree highlight-escape-sequences guide-key elisp-slime-nav ido-vertical-mode fill-column-indicator move-text dash yasnippet yard-mode yaml-mode wgrep web-mode web toml-mode theme-changer textmate solarized-theme smex smartparens slim-mode scss-mode sass-mode rust-mode ruby-refactor ruby-hash-syntax ruby-additional rspec-mode rainbow-mode rainbow-delimiters projectile popwin paredit outline-magic org notmuch multiple-cursors markdown-mode magit json-mode js2-mode inf-ruby image+ hide-comnt haskell-mode handlebars-mode gitconfig-mode git-timemachine fm flymake-ruby flymake-jslint flycheck find-file-in-project f expand-region evil eval-sexp-fu epresent elixir-mode dash-functional csv-mode command-log-mode color-theme-sanityinc-tomorrow color-theme-sanityinc-solarized coffee-mode cider chruby auto-complete arduino-mode android-mode)))
 '(rspec-key-command-prefix (kbd "H-s"))
 '(safe-local-variable-values (quote ((rainbow-mode . t) (encoding . utf-8))))
 '(smartparens-global-mode t)
 '(sp-base-key-bindings (quote paredit))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#dc322f")
     (40 . "#cb4b16")
     (60 . "#b58900")
     (80 . "#859900")
     (100 . "#2aa198")
     (120 . "#268bd2")
     (140 . "#d33682")
     (160 . "#6c71c4")
     (180 . "#dc322f")
     (200 . "#cb4b16")
     (220 . "#b58900")
     (240 . "#859900")
     (260 . "#2aa198")
     (280 . "#268bd2")
     (300 . "#d33682")
     (320 . "#6c71c4")
     (340 . "#dc322f")
     (360 . "#cb4b16"))))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-comment-face ((((class color) (min-colors 89)) (:foreground "#93a1a1"))))
 '(font-lock-constant-face ((((class color) (min-colors 89)) (:foreground "#268bd2" :weight bold))))
 '(font-lock-keyword-face ((((class color) (min-colors 89)) (:foreground "#859900" :weight bold))))
 '(font-lock-string-face ((((class color) (min-colors 89)) (:foreground "#3e999f"))))
 '(font-lock-type-face ((((class color) (min-colors 89)) (:foreground "#b58900"))))
 '(markdown-header-face ((t (:inherit font-lock-function-name-face :weight bold))))
 '(markdown-header-face-1 ((t (:inherit markdown-header-face :height 2.0 :family "FreeSerif"))))
 '(markdown-header-face-2 ((t (:inherit markdown-header-face :weight semi-bold :height 1.1 :family "FreeSerif"))))
 '(markdown-italic-face ((t (:inherit font-lock-variable-name-face :slant italic :family "Ubuntu Mono"))))
 '(org-level-2 ((t (:inherit outline-2))))
 '(org-level-3 ((t (:inherit outline-3 :foreground "orange red"))))
 '(smerge-base ((t (:background "pale goldenrod"))))
 '(smerge-refined-added ((t (:inherit smerge-refined-change :background "PaleGreen1"))))
 '(web-mode-html-tag-face ((t (:foreground "#f5871f")))))
