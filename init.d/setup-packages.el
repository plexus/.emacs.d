;; * SETUP PACKAGES *

;; General packages that pertain to Emacs in General, not to any specific
;; language or mode.

;; Functional macros a la underscore.js
(use-package dash
  :ensure t
  :config (dash-enable-font-lock))

;; Better string manipulation functions
(use-package s :ensure t)

;; better file path manipulation functions
(use-package f :ensure t)

;; Make fill column visible
(use-package fill-column-indicator
  :ensure t
  :config
  (setq fci-rule-color "#111122"))

;; Expand snippets
(use-package yasnippet
  :ensure t
  :config
  (yas-reload-all))

;; Intelligent sexp editing. M-x customize-group smartparens
(use-package smartparens
  :ensure t
  :config (require 'smartparens-config))

;; Project-aware operations
;; All projectile mappings are under C-c p
(use-package projectile
  :ensure t
  :config
  (projectile-global-mode))

;; IDO-like navigation
(use-package helm :ensure t
  :config
  (helm-mode 1)
  (use-package helm-ag :ensure t)
  (use-package helm-projectile :ensure t))

;; Pop up an overview of possible combinations when using a prefix key
;; and waiting a bit
(use-package guide-key
  :ensure t
  :config
  (setq guide-key/guide-key-sequence '("C-x r"   ; register functions
                                       "C-x 4"   ; window functions
                                       "C-x v"   ; vc-*
                                       "C-x 8"   ; insert special characters
                                       "C-h"     ; help
                                       "C-c p"   ; projectile (default)
                                       "H-p"     ; projectile (custom)
                                       "C-c C-m" ; clj-refactor
                                       "C-x w"   ; highlight
                                       "M-m"
                                       "H-m" ; clj-refactor
                                       ))
  (guide-key-mode t)
  (setq guide-key/recursive-key-sequence-flag t)
  (setq guide-key/popup-window-position 'bottom))

;; Highlight escape sequences in strings
(use-package highlight-escape-sequences
  :ensure t
  :config
  (hes-mode)
  (put 'font-lock-regexp-grouping-backslash 'face-alias 'font-lock-builtin-face))

;; Better behaviour for popup windows
(use-package popwin
  :ensure t
  :config
  (setq display-buffer-function 'popwin:display-buffer)
  (push '("^\*helm .+\*$" :regexp t) popwin:special-display-config)
  (push '("^\*helm-.+\*$" :regexp t) popwin:special-display-config))


;; Smart region expansion
(use-package expand-region
  :ensure t
  :config
  ;; Show expand-region command used
  (setq er--show-expansion-message t))

;; Writable grep buffers
(use-package wgrep :ensure t)

;; Represent undo-history as an actual tree (visualize with C-x u)
(use-package undo-tree
  :ensure t
  :config
  (setq undo-tree-mode-lighter "")
  (global-undo-tree-mode))

;; Duplicate line or region
(use-package duplicate-thing :ensure t)

(use-package which-key :ensure t)

(use-package multiple-cursors
  :ensure t
  :bind (("C-S-c C-S-c" . mc/edit-lines)
         ("C->"         . mc/mark-next-like-this)
         ("C-<"         . mc/mark-previous-like-this)
         ("C-c C-<"     . mc/mark-all-like-this)))

(use-package magit
  :ensure t
  :bind (("H-g" . magit-status)))


(use-package string-edit :ensure t)

;; Highlight Symbol
;; (use-package highlight-symbol
;;   :ensure t
;;   :init
;;   (progn
;;     (remove-hook 'prog-mode-hook
;; 	      (lambda ()
;; 		(highlight-symbol-mode)
;; 		(highlight-symbol-nav-mode)))
;;     (setq highlight-symbol-idle-delay 0.25)))

(use-package ace-jump-mode :ensure t
  :bind (("H-'" . ace-jump-mode)
         ("H-," . ace-jump-mode-pop-mark))
  :config (ace-jump-mode-enable-mark-sync))

(use-package mastodon :ensure t
  :init
  (setq mastodon-instance-url
        "https://toot.cat"
        ;;"https://mastodon.social"
        ))

(use-package emojify :ensure t
  :config
  (global-emojify-mode))

(use-package edn :ensure t)

(use-package dired+ :ensure t)

(provide 'setup-packages)
