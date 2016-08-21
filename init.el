(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")
        ("melpa-stable" . "https://stable.melpa.org/packages/")
        ("org" . "http://orgmode.org/elpa/"))) ;; no https :(

(package-initialize)
(unless (file-exists-p "~/.emacs.d/elpa/archives/melpa") (package-refresh-contents))
(package-install 'use-package)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path (expand-file-name "init.d" user-emacs-directory))

(require 'better-defaults)

(require 'setup-emacs)
(require 'setup-packages)
(require 'setup-mode-packages)

(require 'setup-elisp)
(require 'setup-clojure)
(require 'setup-coffeescript)
(require 'setup-javascript)
(require 'setup-web)
(require 'setup-ruby)
(require 'setup-code-editing)
(require 'setup-markdown)
(require 'setup-org-mode)

(require 'look-and-feel)
(require 'key-bindings)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Random stuff below this line
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; (defun autosudo--edit-command-wrapper (orig-fun &rest args)
;;   "Ask to re-open a file with sudo if it's read-only and you try to edit it.
;; Will maintain the position of point, and insert the typed character after
;; switching to the sudo version."
;;   (if buffer-read-only
;;       (let ((path (buffer-file-name))
;;             (buff (current-buffer))
;;             (point (point))
;;             (event last-command-event))
;;         (when (and path (y-or-n-p "File is read-only, reopen with sudo?"))
;;           (find-file (concat "/sudo:root@localhost:" path))
;;           (goto-char point)
;;           (kill-buffer buff)
;;           (setq last-command-event event)))))

;; (advice-add 'self-insert-command :before #'autosudo--edit-command-wrapper)
;; (advice-add 'newline :before #'autosudo--edit-command-wrapper)
;; (advice-add 'yank :before #'autosudo--edit-command-wrapper)
;; (advice-add 'indent-for-tab-command :before #'autosudo--edit-command-wrapper)

(defun make-temp-ruby-buffer-name ()
  (let* ((dir (concat (getenv "HOME") "/projects/ruby-tmp"))
         (last-buffer (car (last (directory-files dir nil "^[0-9]+\.rb")))))
    (or (file-directory-p dir) (mkdir dir))
    (format "%s/%05d.rb"
            dir
            (+ 1 (string-to-number
                  (first (split-string
                          (if last-buffer last-buffer "00000.rb")
                          "\\.")))))))

(defun temp-ruby-buffer ()
  (interactive)
  (let ((buffer (make-temp-ruby-buffer-name)))
    (write-region "" nil buffer)
    (find-file buffer)
    (ruby-mode)))

(global-set-key (kbd "H-r") 'temp-ruby-buffer)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GNUS

(setq gnus-select-method
      '(nnimap "emacs"
              (nnimap-address "homie.mail.dreamhost.com")
              (nnimap-server-port 143)
              (nnimap-stream starttls)
              (nnir-search-engine imap)
              ))

(setq gnus-secondary-select-methods
      '((nnimap "clojure"
                (nnimap-address "homie.mail.dreamhost.com")
                (nnimap-server-port 143)
                (nnimap-stream starttls)
                (nnir-search-engine imap)
                )
        (nnimap "lambdaisland"
                (nnimap-address "homie.mail.dreamhost.com")
                (nnimap-server-port 143)
                (nnimap-stream starttls)
                (nnir-search-engine imap)
                )))

(setq send-mail-function    'smtpmail-send-it
      smtpmail-smtp-server  "homie.mail.dreamhost.com"
      smtpmail-stream-type  'starttls
      smtpmail-smtp-service 587
      smtpmail-local-domain "arnebrasseur.net")

(load-library "smtpmail")

(desktop-save-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Make sure TLS certificates are checked

;; https://glyph.twistedmatrix.com/2015/11/editor-malware.html

(let ((trustfile (expand-file-name "cacert.pem" user-emacs-directory)))
  (setq tls-program
        (list
         (format "gnutls-cli%s --x509cafile %s -p %%p %%h"
                 (if (eq window-system 'w32) ".exe" "") trustfile)))
  (setq gnutls-verify-error t)
  (setq gnutls-trustfiles (list trustfile)))


;; test if it's checked
'(let ((bad-hosts
       (loop for bad
             in `("https://wrong.host.badssl.com/"
                  "https://self-signed.badssl.com/")
             if (condition-case e
                    (url-retrieve
                     bad (lambda (retrieved) t))
                  (error nil))
             collect bad)))
  (if bad-hosts
      (error (format "tls misconfigured; retrieved %s ok"
                     bad-hosts))
    (url-retrieve "https://badssl.com"
                  (lambda (retrieved) t))))


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

(defun plexus/cider-current-ns-file-name ()
  (let* ((ns (cider-current-ns))
         (ns-path (replace-regexp-in-string "\\." "/" ns))
         (clj-file (concat "/" ns-path ".clj"))
         (cljs-file (concat "/" ns-path ".cljs"))
         (classpath (cider-sync-request:classpath))
         (files (-reduce-r-from (lambda (path l)
                                  (list*
                                   (concat path cljs-file)
                                   (concat path clj-file)
                                   l))
                                '()
                                classpath)))
    (-find 'file-exists-p files)))

(defun plexus/cider-current-ns-find-file ()
  (interactive)
  (if-let ((f (plexus/cider-current-ns-file-name)))
      (find-file f)))

(defun plexus/cider-goto-test-file ()
  (interactive)
  (let* ((ns (cider-current-ns))
         (src-file (plexus/cider-current-ns-file-name))
         (ns-path (replace-regexp-in-string "\\." "/" ns))
         (ext (f-ext src-file)))
    (find-file (concat (projectile-project-root) "test/" ns-path "_test." ext))))

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


;; Syntax highlighting for systemd config files
(add-to-list 'auto-mode-alist '("\\.service\\'" . conf-unix-mode))
(add-to-list 'auto-mode-alist '("\\.timer\\'" . conf-unix-mode))
(add-to-list 'auto-mode-alist '("\\.target\\'" . conf-unix-mode))
(add-to-list 'auto-mode-alist '("\\.mount\\'" . conf-unix-mode))
(add-to-list 'auto-mode-alist '("\\.automount\\'" . conf-unix-mode))
(add-to-list 'auto-mode-alist '("\\.slice\\'" . conf-unix-mode))
(add-to-list 'auto-mode-alist '("\\.socket\\'" . conf-unix-mode))
(add-to-list 'auto-mode-alist '("\\.path\\'" . conf-unix-mode))
(add-to-list 'auto-mode-alist '("\\.netdev\\'" . conf-unix-mode))
(add-to-list 'auto-mode-alist '("\\.network\\'" . conf-unix-mode))
(add-to-list 'auto-mode-alist '("\\.link\\'" . conf-unix-mode))
(add-to-list 'auto-mode-alist '("\\.automount\\'" . conf-unix-mode))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Hiccup

(defun plexus/sexp-to-hiccup-attrs (attrs)
  (if attrs
      (concat " {"
              (s-join " "
                      (loop for attr in attrs
                            collect (concat
                                     ":"
                                     (symbol-name (car attr))
                                     " "
                                     (format "%S" (cdr attr)))))
              "}")))


(defun plexus/sexp-to-hiccup-children (cs)
  (if cs
      (loop for ch in cs
            concat (concat " " (if (stringp ch)
                                   (if (string-match-p "^\s*$" ch)
                                       ""
                                     (format "%S" ch))
                                 (plexus/sexp-to-hiccup ch))))))


(defun plexus/sexp-to-hiccup (s)
  (concat "[:"
          (symbol-name (car s))
          (plexus/sexp-to-hiccup-attrs (cadr s))
          (plexus/sexp-to-hiccup-children (cddr s))
          "]"))

(defun plexus/region-to-hiccup ()
  (let* ((html (libxml-parse-html-region (point) (mark)))
         (inner (caddr (caddr html))))
    (plexus/sexp-to-hiccup inner)))

(defun plexus/convert-region-to-hiccup ()
  (interactive)
  (let ((hiccup (plexus/region-to-hiccup)))
    (delete-region (point) (mark))
    (insert hiccup)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; record-controller

(setq plexus/record-counter (propertize "**" 'face 'bold))

(defun plexus/show-record-counter-in-modeline ()
  (interactive)
  (setq mode-line-format
        (append mode-line-format '(">>>" (:eval plexus/record-counter) "<<<"))))

(defun plexus/set-record-counter (i)
  (setq plexus/record-counter (propertize (number-to-string i) 'face 'bold)))

(make-face 'plexus/writing-face)

(set-face-font 'plexus/writing-face "Lato")
