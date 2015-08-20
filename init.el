(package-initialize)

;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

(setq inhibit-startup-message t)

(add-to-list 'load-path (expand-file-name "init.d" user-emacs-directory))

(require 'sane-defaults)

(require 'setup-emacs)
(require 'setup-packages)

(require 'setup-elisp)
(require 'setup-clojure)

(require 'look-and-feel)
(require 'key-bindings)
