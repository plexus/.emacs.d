
(setq inhibit-splash-screen t)                  ; no splash screen

(menu-bar-mode -1)                              ; no menu bar
(tool-bar-mode -1)                              ; no tool bar
(scroll-bar-mode -1)                            ; no scroll bar

(setq initial-scratch-message nil)              ; empty *scratch* buffer

(setq x-select-enable-clipboard t)

(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward)

(fset 'yes-or-no-p 'y-or-n-p)
