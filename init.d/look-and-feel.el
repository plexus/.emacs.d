(set-frame-font "Inconsolata-17")
;;(set-frame-font "Anonymous Pro-14")

;; Emoji! 💩
;; (set-fontset-font t 'unicode "Symbola" nil 'prepend)

(require-package 'color-theme-sanityinc-solarized)
(require-package 'color-theme-sanityinc-tomorrow)

(require 'color-theme-sanityinc-tomorrow)
(require 'sanityinc-tomorrow-day-theme)
(color-theme-sanityinc-tomorrow-day)

;(require 'sanityinc-tomorrow-night-theme)

;(color-theme-sanityinc-solarized-dark)
;(color-theme-sanityinc-solarized-light)
;(color-theme-sanityinc-tomorrow-blue)
;(color-theme-sanityinc-tomorrow-bright)
;(color-theme-sanityinc-tomorrow-eighties)
;(color-theme-sanityinc-tomorrow-night)

(provide 'look-and-feel)
