;; * SETUP PACKAGES *

;; This file contains configuration of the package system itself,
;; and installs and configures a set of base packages that no
;; Emacser should be without.

(defun packages-install (packages)
  (dolist (it packages)
    (when (not (package-installed-p it))
      (package-install it)))
  (delete-other-windows))


;;; On-demand installation of packages

(defun require-package (package &optional min-version no-refresh)
  "Install given PACKAGE, optionally requiring MIN-VERSION.
If NO-REFRESH is non-nil, the available package lists will not be
re-downloaded in order to locate PACKAGE."
  (if (package-installed-p package min-version)
      t
    (if (or (assoc package package-archive-contents) no-refresh)
        (package-install package)
      (progn
        (package-refresh-contents)
        (require-package package min-version t))))
  (require package))

;; Install extensions if they're missing
(defun init--install-packages ()
  (packages-install
   '(
     dash
     s
     f
     fill-column-indicator
     yasnippet
     smartparens
     helm
     helm-ag
     helm-projectile
     elisp-slime-nav
     guide-key
     highlight-escape-sequences
     popwin
     color-theme-sanityinc-solarized
     color-theme-sanityinc-tomorrow
     expand-region
     wgrep
     undo-tree
     eval-sexp-fu
                                        ;smooth-scrolling
     duplicate-thing
     projectile
     rainbow-mode
     which-key
     markdown-mode
     sql-indent
     )))

(condition-case nil
    (init--install-packages)
  (error
   (package-refresh-contents)
   (init--install-packages)))


;; = dash =
;; Functional macros a la underscore.js

;; Font lock dash.el
(eval-after-load "dash" '(dash-enable-font-lock))


;; = s =
;; Better string manipulation functions


;; = f =
;; better file path manipulation functions


;; = fill-column-indicator =
;; Make fill column visible

(require 'fill-column-indicator)
(setq fci-rule-color "#111122")


;; = yasnippet =
;; Expand snippets


;; = smartparens =
;; Intelligent sexp editing. M-x customize-group smartparens

(require 'smartparens-config)

;; = helm + helm-projectile =

(require 'helm-config)
(require 'helm-projectile)
(helm-mode 1)

;; = elisp-slime-nav =
;; Navigate in elisp with M-. and M-,


;; = guide-key =
;; Pop up an overview of possible combinations when using a prefix key
;; and waiting a bit

(require 'guide-key)
(setq guide-key/guide-key-sequence '("C-x r"   ; register functions
                                     "C-x 4"   ; window functions
                                     "C-x v"   ; vc-*
                                     "C-x 8"   ; insert special characters
                                     "C-h"     ; help
                                     "C-c p"   ; projectile (default)
                                     "H-p"     ; projectile (custom)
                                     "C-c C-m" ; clj-refactor
                                     ))
(guide-key-mode 1)
(setq guide-key/recursive-key-sequence-flag t)
(setq guide-key/popup-window-position 'bottom)


;; = highlight-escape-sequences =
;; Highlight escape sequences in strings

(require 'highlight-escape-sequences)
(hes-mode)
(put 'font-lock-regexp-grouping-backslash 'face-alias 'font-lock-builtin-face)



;; = popwin =
;; Better behaviour for popup windows

(require 'popwin)

(setq display-buffer-function 'popwin:display-buffer)
(push '("^\*helm .+\*$" :regexp t) popwin:special-display-config)
(push '("^\*helm-.+\*$" :regexp t) popwin:special-display-config)

;; = expand-region =
;; Smart region expansion

(require 'expand-region)
;; Show expand-region command used
(setq er--show-expansion-message t)


;; = rainbow-delimiters =
;; Colorful parentheses

(require 'rainbow-delimiters)


;; = wgrep =
;; Writable grep buffers

(require 'wgrep)


;; = undo-tree =
;; Represent undo-history as an actual tree (visualize with C-x u)

(setq undo-tree-mode-lighter "")
(require 'undo-tree)
(global-undo-tree-mode)


;; = eval-sexp-fu =
;; Flash sexps when evaluating them


;; = smooth-scrolling =
;; Keep cursor away from edges when scrolling up/down

                                        ;(require 'smooth-scrolling)


;; = duplicate-thing =
;; Duplicate line or region


;; = projectile =
;; Project-aware operations
;;
;; This is mostly here as a replacement for find-file-at-point, but
;; has other niceties like switching between a source file and its
;; tests, or closing all buffers relating to a project.
;;
;; All projectile mappings are under C-c p

(require 'projectile)
(projectile-global-mode)



(provide 'setup-packages)
