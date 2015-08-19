;; Color theme

;; (setq load-path
;;       (cons
;;        (concat user-emacs-directory "vendor/color-theme-6.6.0")
;;        load-path))

;; (set-face-attribute 'default nil :font "Inconsolata-16")
(set-frame-font "Inconsolata-14")
;(set-frame-font "Monospace-15")

;; Emoji!
;; (set-fontset-font t 'unicode "Symbola" nil 'prepend)

(defun 💩-do-stuff () 'just-for-andy)
(💩-do-stuff)

(setq calendar-location-name "Berlin, Germany")
(setq calendar-latitude 13.3833)
(setq calendar-longitude 52.5167)

;; (setq calendar-location-name "Buenos Aires, Argentina")
;; (setq calendar-latitude -34.6033)
;; (setq calendar-longitude -52.30)

;; (require 'color-theme)
;; (color-theme-initialize)

(require 'color-theme-sanityinc-tomorrow)
(require 'sanityinc-tomorrow-day-theme)
;(require 'sanityinc-tomorrow-night-theme)
;(require 'theme-changer)
;(setq theme-changer-mode "color-theme")
;(change-theme 'color-theme-sanityinc-tomorrow-day 'color-theme-sanityinc-tomorrow-night)

;; set through customize

;(color-theme-sanityinc-solarized-dark)
;(color-theme-sanityinc-solarized-light)
;(color-theme-sanityinc-tomorrow-blue)
;(color-theme-sanityinc-tomorrow-bright)
(color-theme-sanityinc-tomorrow-day)
;(color-theme-sanityinc-tomorrow-eighties)
;(color-theme-sanityinc-tomorrow-night)
