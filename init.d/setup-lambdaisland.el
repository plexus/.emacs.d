;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; record-controller

(setq plexus/record-counter "**")
(setq plexus/record-video nil)
(setq plexus/record-audio nil)
(setq plexus/record-state nil)

(defun plexus/enable-recording-modeline ()
  (interactive)
  (add-to-list #'mode-line-format '(:eval (plexus/recording-modeline))))

(defun plexus/minimal-decorations ()
  (interactive)
  (linum-mode)
  (set-face-attribute 'fringe (selected-frame) :foreground "#228024802780" )
  (setq mode-line-format '("%e"
                           mode-line-front-space
                           mode-line-frame-identification
                           mode-line-buffer-identification
                           "   "
                           mode-line-position)))

;;(setq mode-line-format '("%e" (:propertize "    Lambda Island | 37. Transducers" font-lock-face (:foreground "#b294bb"))))

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

;; lambda island

(defun plexus/lambdaisland-recording-setup ()
  (interactive)
  (set-frame-font "Inconsolata-17" t
                  (list (make-frame '((name . "islandmacs"))))))

(defun plexus/resize-for-lambda-island ()
  (setq frame-resize-pixelwise t)
  (set-frame-width (selected-frame) 1265 nil t)
  (set-frame-height (selected-frame) 720 nil t))

(defun plexus/ffmpeg-position ()
  (let* ((f (frame-position))
         (x (car f))
         (y (cdr f)))
    ;; these offsets have been carefully, experimentally verified. They
    ;; compensate for the drop shadow and title bar that is somehow considered
    ;; part of the frame
    (format "%d,%d" (mod (+ x 10) 1920) (+ y 35))))

;; from https://www.emacswiki.org/emacs/SqlMode
;; PostgreSQL databases with underscores in their names trip up the prompt specified in sql.el. I work around this with the following. Warning, this sets the prompt globally, which is fine by me since I only ever use Postgres.


;; Avoid third person in screencast scripts
(defface plexus/third-person-face
  '((((supports :underline (:style wave)))
     :underline (:style wave :color "DarkOrange"))
    (((class color) (background light))
     (:inherit font-lock-warning-face :background "moccasin"))
    (((class color) (background dark))
     (:inherit font-lock-warning-face :background "DarkOrange")))
  "Face for highlighting use of the third person")

(defun plexus/third-person-font-lock-keywords ()
  (list (list (rx word-start
                  (or "we" "We" "us" "let's" "Let's" "we'll" "We'll")
                  word-end)
	      0 (quote 'plexus/third-person-face) 'prepend)))

(defun plexus/third-person-turn-on ()
  "Turn on syntax highlighting for third person"
  (interactive)
  (font-lock-add-keywords
   nil
   (plexus/third-person-font-lock-keywords) t))


(defun plexus/set-record-counter (i)
  (setq plexus/record-counter (number-to-string i))
  (force-mode-line-update t))

(make-face 'plexus/writing-face)

(set-face-font 'plexus/writing-face "Lato")

(defun plexus/screencast-mode ()
  (interactive)
  (blink-cursor-mode 0)
  (setq indicate-empty-lines nil)
  (set-frame-parameter nil 'left-fringe 18))

(use-package centered-cursor-mode :ensure t)

(provide 'setup-lambdaisland)
