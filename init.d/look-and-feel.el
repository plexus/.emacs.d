;; Startup and UI

(setq inhibit-splash-screen t)                  ; no splash screen

(menu-bar-mode -1)                              ; no menu bar
(tool-bar-mode -1)                              ; no tool bar
(scroll-bar-mode -1)                            ; no scroll bar

(setq initial-scratch-message nil)              ; empty *scratch* buffer

;; Mode line

(setq eol-mnemonic-dos  "(\\DOS)")              ; Readable end-of-line identifiers for the modeline
(setq eol-mnemonic-unix "(:UNIX)")              ; the default one-char is still in there, maybe I'll learn some day
(setq eol-mnemonic-mac  "(/MAC)")
(setq eol-mnemonic-undecided "(-UNDECIDED)")

(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward) ; uniquify.el buffer names :  name|its/dir   <->   name<2>

;; Color theme

(setq load-path
      (cons
       (concat user-emacs-directory "vendor/color-theme-6.6.0")
       load-path))

;;(set-face-attribute 'default nil :font "Inconsolata-16")
(set-default-font "Inconsolata-16")

;(setq calendar-location-name "Berlin, Germany")
(setq calendar-location-name "Buenos Aires, Argentina")
(setq calendar-latitude -34.6033)
(setq calendar-longitude -52.30)

(require 'color-theme)
(color-theme-initialize)

(require 'color-theme-sanityinc-tomorrow)
(require 'sanityinc-tomorrow-day-theme)
(require 'sanityinc-tomorrow-night-theme)
(require 'theme-changer)
(setq theme-changer-mode "color-theme")
(change-theme 'color-theme-sanityinc-tomorrow-day 'color-theme-sanityinc-tomorrow-night)
