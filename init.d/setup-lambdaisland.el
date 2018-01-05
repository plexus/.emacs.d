;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; record-controller

(setq plexus/record-counter "**")
(setq plexus/record-video nil)
(setq plexus/record-audio nil)
(setq plexus/record-state nil)

(defun plexus/enable-recording-modeline ()
  (interactive)
  (add-to-list #'mode-line-format '(:eval (plexus/recording-modeline))))

(defun plexus/recording-modeline ()
  `((:propertize " ⚫ " font-lock-face (:foreground ,(case plexus/record-state
                                                       ('recording "red")
                                                       (t "gray"))
                                                    :background "black"))
    (:propertize " 🎥 " font-lock-face (:background ,(if plexus/record-video "green" "black") :foreground "white"))
    (:propertize " 🔊 " font-lock-face (:background ,(if plexus/record-audio "red" "black") :foreground "white"))
    (:propertize " " font-lock-face (:background "white" :foreground "black"))
    (:propertize (:eval plexus/record-counter) font-lock-face (:background "white" :foreground "black"))
    (:propertize " " font-lock-face (:background "white" :foreground "black"))
    " "))

(defun plexus/set-record-counter (i)
  (setq plexus/record-counter (number-to-string i))
  (force-mode-line-update t))

(make-face 'plexus/writing-face)

(set-face-font 'plexus/writing-face "Lato")

(provide 'setup-lambdaisland)
