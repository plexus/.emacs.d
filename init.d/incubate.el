;; Snippets that I find but am not sure yet that I'll keep em

;; http://emacswiki.org/emacs/MoveLine

(defun move-line-up ()
  "Move the current line up by N lines."
  (interactive)
  (transpose-lines 1)
  (forward-line -2))

(defun move-line-down ()
  "Move the current line down by N lines."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1))


(global-set-key (kbd "M-<up>") 'move-line-up)
(global-set-key (kbd "M-<down>") 'move-line-down)

(defun copy-file-name-to-clipboard ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (kill-new filename)
      (message "Copied buffer file name '%s' to the clipboard." filename))))

;; (defun plexus-find-file(filename &optional wildcards)
;;   "finds a file, and then creates the folder if it doesn't exist"

;;   (interactive (find-file-read-args "Find file: " nil))
;;   (let ((value (find-file-noselect filename nil nil wildcards)))
;;     (if (listp value)
;;     (mapcar 'switch-to-buffer (nreverse value))
;;       (switch-to-buffer value)))
;;   (when (not (file-exists-p default-directory))
;;        (message (format "Creating  %s" default-directory))
;;        (make-directory default-directory t)))

;; (global-set-key (kbd


;; Mon Apr  8 09:47:38 CEST 2013

(defun plexus-jump-to-clipboard ()
  (interactive)
  (let ((selection (split-string
                    (x-get-selection 'PRIMARY 'TEXT)
                    ":")))
    (find-file
     (concat "/home/arne/ticketsolve/repo/"
             (car selection) ))
    (goto-line (string-to-number (cadr selection)))
    )
)

(global-set-key (kbd "H-j") 'plexus-jump-to-clipboard)


(require 'mmm-auto)
(require 'mmm-erb)

(setq mmm-global-mode 'maybe)
(mmm-add-mode-ext-class 'html-erb-mode "\\.html\\.erb\\'" 'erb)
(mmm-add-mode-ext-class 'html-erb-mode "\\.jst\\.ejs\\'" 'ejs)
(mmm-add-mode-ext-class 'html-erb-mode nil 'html-js)
(mmm-add-mode-ext-class 'html-erb-mode nil 'html-css)
(setq mmm-submode-decoration-level 2
      mmm-parse-when-idle t)


(setq jslint-globals '(jQuery
                       Ticketsolve
                       document
                       describe
                       expect
                       it
                       spyOn
                       setFixtures
                       beforeEach
                       mock_ajax_request
                       mock_jsonp_timeout
                       expect_message
                       mock_jsonp_exception))


(require 'flymake)
(require 'flymake-cursor)

(defun plexus-flymake-jslint-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name)))
         (predef-args (mapconcat
                       (lambda(global)
                         (concat "--predef " (symbol-name global)))
                       jslint-globals " ")))
    (list "jslint"
          (list (mapconcat 'identity
                           (list "--terse" "--sloppy" "--vars" predef-args)
                           " ")
                local-file))))

(add-to-list 'flymake-allowed-file-name-masks
             '("\\.js\\'" plexus-flymake-jslint-init))

(defun plexus-flymake-jslint-activate ()
  (setq flymake-err-line-patterns
        (cons '("^\\(.*\\)(\\([[:digit:]]+\\)):\\(.*\\)$"
                1 2 nil 3)
              flymake-err-line-patterns))
      (flymake-mode 1)
      (define-key js-mode-map "\C-c\C-n" 'flymake-goto-next-error))

(add-hook 'js-mode-hook 'plexus-flymake-jslint-activate)

(yas-global-mode 1)
