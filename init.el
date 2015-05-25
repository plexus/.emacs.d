(autoload 'ruby-mode "~/github/ruby/misc/ruby-mode" "Ruby Mode." t)

(setq *hostname* (substring (shell-command-to-string "hostname") 0 -1))
(setq *auto-init-files-path* (concat user-emacs-directory "init.d"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Load path

(add-to-list 'load-path (concat user-emacs-directory "vendor"))
(add-to-list 'load-path (concat user-emacs-directory "init.d"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Custom Init

(defun function-put (a b c) (put a b c))

(add-to-list 'load-path *auto-init-files-path*)
(load "00_packages.el")

(require 'f)
(require 'org)
(require 'ob)
(require 'org-install)
(require 'ob-tangle)

(defun plexus-require-tree (path)
  (f--entries path
              (cond ((and (f-file? it) (f-ext? it "el"))
                     (load it))
                    ((and (f-file? it) (f-ext? it "org"))
                     (org-babel-load-file it))
                    ((f-directory? it)
                     (plexus-require-tree it)))))

(add-hook 'after-init-hook
	  (lambda ()
	    (plexus-require-tree *auto-init-files-path*)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; customize-*

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
 '(debug-on-error t)
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
 '(rspec-key-command-prefix (kbd "H-s"))
 '(safe-local-variable-values (quote ((rainbow-mode . t) (encoding . utf-8))))
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
