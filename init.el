(setq package-archives
      '(("lambdaisland" . "https://lambdaisland.github.io/elpa/")
        ("gnu" . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")
        ("melpa-stable" . "https://stable.melpa.org/packages/")
        ("org" . "http://orgmode.org/elpa/")  ;; no https :(
        ))

(require 'package-x)

(setq package-archive-upload-base "/home/arne/LambdaIsland/elpa")

(setq package-user-dir
      (expand-file-name (concat "elpa-" emacs-version) user-emacs-directory))

(package-initialize)
(unless (file-exists-p (expand-file-name "archives/melpa" package-user-dir)) (package-refresh-contents))

(package-install 'use-package)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path (expand-file-name "init.d" user-emacs-directory))
(add-to-list 'load-path "/home/arne/github/unrepl.el")
(add-to-list 'load-path "/home/arne/github/clj-parse")
(add-to-list 'load-path "/home/arne/github/a.el")

(require 'better-defaults)

(require 'setup-emacs)
(require 'setup-packages)
(require 'setup-mode-packages)

(require 'setup-elisp)
(require 'setup-common-lisp)
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; record-controller

(setq plexus/record-counter (propertize "**" 'face 'bold))

(defun plexus/show-record-counter-in-modeline ()
  (interactive)
  (setq mode-line-format
        (append '(">>>" (:eval plexus/record-counter) "<<<") mode-line-format)))

(defun plexus/set-record-counter (i)
  (setq plexus/record-counter (propertize (number-to-string i) 'face 'bold)))

(make-face 'plexus/writing-face)

(set-face-font 'plexus/writing-face "Lato")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; backup / autosave

(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.saves"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned backups

(expand-file-name "backups" user-emacs-directory)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ERT stuff


(defun plexus/ert-run-quietly (selector &optional output-buffer-name message-fn)
  "Run the tests specified by SELECTOR and display the results in a buffer.

SELECTOR works as described in `ert-select-tests'.
OUTPUT-BUFFER-NAME and MESSAGE-FN should normally be nil; they
are used for automated self-tests and specify which buffer to use
and how to display message."
  (interactive
   (list (let ((default (if ert--selector-history
                            ;; Can't use `first' here as this form is
                            ;; not compiled, and `first' is not
                            ;; defined without cl.
                            (car ert--selector-history)
                          "t")))
           (read
            (completing-read (if (null default)
                                 "Run tests: "
                               (format "Run tests (default %s): " default))
                             obarray #'ert-test-boundp nil nil
                             'ert--selector-history default nil)))
         nil))
  (unless message-fn (setq message-fn 'message))
  (let ((output-buffer-name output-buffer-name)
        buffer
        listener
        (message-fn message-fn))
    (setq listener
          (lambda (event-type &rest event-args)
            (cl-ecase event-type
              (run-started
               (cl-destructuring-bind (stats) event-args
                 (setq buffer (ert--setup-results-buffer stats
                                                         listener
                                                         output-buffer-name))
                 ;;(pop-to-buffer buffer)
                 ))
              (run-ended
               (cl-destructuring-bind (stats abortedp) event-args
                 (funcall message-fn
                          "%sRan %s tests, %s results were as expected%s%s"
                          (if (not abortedp)
                              ""
                            "Aborted: ")
                          (ert-stats-total stats)
                          (ert-stats-completed-expected stats)
                          (let ((unexpected
                                 (ert-stats-completed-unexpected stats)))
                            (if (zerop unexpected)
                                ""
                              (format ", %s unexpected" unexpected)))
                          (let ((skipped
                                 (ert-stats-skipped stats)))
                            (if (zerop skipped)
                                ""
                              (format ", %s skipped" skipped))))
                 (ert--results-update-stats-display (with-current-buffer buffer
                                                      ert--results-ewoc)
                                                    stats)
                 (when (not (zerop (ert-stats-completed-unexpected stats)))
                   (pop-to-buffer "*ert*"))))
              (test-started
               (cl-destructuring-bind (stats test) event-args
                 (with-current-buffer buffer
                   (let* ((ewoc ert--results-ewoc)
                          (pos (ert--stats-test-pos stats test))
                          (node (ewoc-nth ewoc pos)))
                     (cl-assert node)
                     (setf (ert--ewoc-entry-test (ewoc-data node)) test)
                     (aset ert--results-progress-bar-string pos
                           (ert-char-for-test-result nil t))
                     (ert--results-update-stats-display-maybe ewoc stats)
                     (ewoc-invalidate ewoc node)))))
              (test-ended
               (cl-destructuring-bind (stats test result) event-args
                 (with-current-buffer buffer
                   (let* ((ewoc ert--results-ewoc)
                          (pos (ert--stats-test-pos stats test))
                          (node (ewoc-nth ewoc pos)))
                     (when (ert--ewoc-entry-hidden-p (ewoc-data node))
                       (setf (ert--ewoc-entry-hidden-p (ewoc-data node))
                             (ert-test-result-expected-p test result)))
                     (aset ert--results-progress-bar-string pos
                           (ert-char-for-test-result result
                                                     (ert-test-result-expected-p
                                                      test result)))
                     (ert--results-update-stats-display-maybe ewoc stats)
                     (ewoc-invalidate ewoc node))))))))
    (with-current-buffer (get-buffer-create "*ert*")
      (ert-run-tests
       selector
       listener))))

(global-set-key (kbd "H-\\") (lambda ()
                               (interactive)
                               (require 'ert)
                               (save-some-buffers t (lambda () (equal default-directory "/home/arne/github/clj-parse/")))
                               (save-some-buffers t (lambda () (equal default-directory "/home/arne/github/a.el/")))
                               (save-some-buffers t (lambda () (equal default-directory "/home/arne/github/unrepl.el/")))
                               (ert-delete-all-tests)

                               (load "/home/arne/github/clj-parse/clj-lex.el")
                               (load "/home/arne/github/clj-parse/clj-parse.el")
                               (load "/home/arne/github/clj-parse/clj-edn.el")
                               (load "/home/arne/github/clj-parse/clj-ast.el")

                               (load "/home/arne/github/clj-parse/test/clj-parse-test.el")
                               (load "/home/arne/github/clj-parse/test/clj-lex-test.el")
                               (load "/home/arne/github/clj-parse/test/clj-unparse-test.el")
                               (load "/home/arne/github/clj-parse/test/clj-edn-el-parity-test.el")
                               (load "/home/arne/github/clj-parse/test/clj-edn-test.el")
                               (load "/home/arne/github/clj-parse/test/clj-ast-test.el")

                               (load "/home/arne/github/a.el/a.el")
                               (load "/home/arne/github/a.el/test/a-test.el")

                               (load "/home/arne/github/unrepl.el/unrepl.el")
                               (load "/home/arne/github/unrepl.el/unrepl-test.el")
                               (load "/home/arne/github/unrepl.el/unrepl-reader.el")
                               (load "/home/arne/github/unrepl.el/unrepl-writer.el")
                               (load "/home/arne/github/unrepl.el/unrepl-acceptance-test.el")

                               (plexus/ert-run-quietly t)))
