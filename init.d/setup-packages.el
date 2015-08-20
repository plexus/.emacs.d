;; * SETUP PACKAGES *

;; This file contains configuration of the package system itself,
;; and installs and configures a set of base packages that no
;; Emacser should be without.

(require 'package)

;; Add melpa to package repos
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)

(package-initialize)

(unless (file-exists-p "~/.emacs.d/elpa/archives/melpa")
  (package-refresh-contents))

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
     magit
     fill-column-indicator
     yasnippet
     smartparens
     ido-vertical-mode
     elisp-slime-nav
     guide-key
     highlight-escape-sequences
     smex
     multiple-cursors
     popwin
     color-theme-sanityinc-solarized
     color-theme-sanityinc-tomorrow
     expand-region
     rainbow-delimiters
     wgrep
     undo-tree
     eval-sexp-fu
     smooth-scrolling
     duplicate-thing
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
     

;; = magit =
;; magical interface to git


;; = fill-column-indicator =
;; Make fill column visible

(require 'fill-column-indicator)
(setq fci-rule-color "#111122")


;; = yasnippet =
;; Expand snippets


;; = smartparens =
;; Intelligent sexp editing. M-x customize-group smartparens

(require 'smartparens-config)


;; = ido-vertical-mode =
;; Interactively do things - vertically

(require 'ido)
(ido-mode t)


;; = elisp-slime-nav =
;; Navigate in elisp with M-. and M-,


;; = guide-key =
;; Make prefix keys easier to use

(require 'guide-key)
(setq guide-key/guide-key-sequence '("C-x r" "C-x 4" "C-x v" "C-x 8" "C-x +" "C-h"))
(guide-key-mode 1)
(setq guide-key/recursive-key-sequence-flag t)
(setq guide-key/popup-window-position 'bottom)


;; = highlight-escape-sequences =
;; Highlight escape sequences in strings

(require 'highlight-escape-sequences)
(hes-mode)
(put 'font-lock-regexp-grouping-backslash 'face-alias 'font-lock-builtin-face)


;; = smex =
;; Smarter M-x

(require 'smex)
(smex-initialize)


;; = multiple-cursors =
;; What is says

(require 'multiple-cursors)


;; = popwin =
;; Better behaviour for popup windows


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

(require 'smooth-scrolling)


;; = duplicate-thing =
;; Duplicate line or region 


(provide 'setup-packages)
