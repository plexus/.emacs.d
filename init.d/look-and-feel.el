;; Startup and UI

(setq inhibit-splash-screen t)                  ; no splash screen
;(menu-bar-mode -1)                             ; no menu bar
(tool-bar-mode -1)                              ; no tool bar
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
       (concat user-emacs-directory "elisp/color-theme-6.6.0")
       load-path))

(require 'color-theme)
(color-theme-initialize)

; Loading both gives a light theme with a nice red mode line
(color-theme-arjen)
(color-theme-scintilla)

;(color-theme-charcoal-black)   ;dark
;(color-theme-feng-shui)        ;light
;(color-theme-sitaramv-nt)      ;light
;(color-theme-arjen)
;(plexus-color-theme-light)
