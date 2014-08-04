;; -*- lexical-binding: t; -*-

;; Copy-pasted snippets from the web or other 'expirements' that haven't yet made
;; into my 'official' emacs configuration.

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

(global-set-key (kbd "M-p") 'move-line-up)
(global-set-key (kbd "M-n") 'move-line-down)

;; (defun copy-file-name-to-clipboard ()
;;   "Copy the current buffer file name to the clipboard."
;;   (interactive)
;;   (let ((filename (if (equal major-mode 'dired-mode)
;;                       default-directory
;;                     (buffer-file-name))))
;;     (when filename
;;       (kill-new filename)
;;       (message "Copied buffer file name '%s' to the clipboard." filename))))

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
    ))

(global-set-key (kbd "H-j") 'plexus-jump-to-clipboard)

(yas-global-mode 1)

;; (defun plexus-spec-summary ()
;;   (interactive)
;;   (occur "^[ \t]*\\(describe\\|it\\|context\\|specify\\|shared_examples\\|include_examples\\|shared_context\\|include_context\\)"))


(defvar hexcolour-keywords
  '(("#[abcdef[:digit:]]\\{6\\}"
     (0 (put-text-property (match-beginning 0)
                           (match-end 0)
                           'face (list :background
                                       (match-string-no-properties 0)))))))

(defun hexcolour-add-to-font-lock ()
  (font-lock-add-keywords nil hexcolour-keywords))

(add-hook 'scss-mode-hook 'hexcolour-add-to-font-lock)

(defun plexus-greek (char)
  (interactive "c")
  (insert-char
   (decode-char 'ucs
                (+ (encode-char char 'ucs) 848))))

(global-set-key (kbd "H-k") 'plexus-greek)

;; (eval-after-load 'outline
;;   '(progn
;;      (require 'outline-magic)
;;      (define-key outline-minor-mode-map (kbd "H-m") 'outline-cycle)))

;; (add-hook 'ruby-mode-hook
;;           (lambda ()
;;             (outline-minor-mode)
;;             (setq outline-regexp " *\\(def \\|class\\|module\\)")))

;;                                         ;(add-hook 'ruby-mode-hook 'outline-minor-mode)


(global-set-key (kbd "H-e") (lambda () (interactive) (find-file (concat (getenv "HOME") "/.emacs.d/init.d/incubate.el"))))
(global-set-key (kbd "H-x") 'er/expand-region)
;; (global-set-key (kbd "H-q") 'hide/show-comments-toggle)

;; (defmacro coxit-env-let (bindings body &rest rest)
;;   "Like `let' but sets environment variables rather than (Emacs) variables.
;; The return value is the result of the last expression, after returning the
;; environment variables are reset to their previous value."
;;   `(let ((orig-bindings (list ,@(mapcar (lambda (env)
;;                                           (list 'list env (list 'getenv env)))
;;                                         (mapcar 'symbol-name (mapcar 'car bindings))))))
;;      ,@(mapcar (lambda (binding)
;;                  (list 'setenv (symbol-name (car binding)) (cadr binding)))
;;                bindings)
;;      (let ((result (progn ,body ,@rest)))
;;        (mapcar (lambda (binding)
;;                  (setenv (car binding) (cadr binding)))
;;                orig-bindings)
;;        result)))



(require 'popwin)
(popwin-mode 1)
;; (push '("*coxit-rspec-client*" :height 20) popwin:special-display-config)

(setq bookmark-save-flag 1) ; save bookmarks immediately

;; (defun plexus-hashrocket-to-keyword ()
;;   (interactive)
;;   (kmacro-exec-ring-item
;;    '([19 61 62 13 18 58 13 right backspace 19 61 62 13 backspace backspace 134217760 left 58] 0 "%d") nil))

;; (defun plexus-find-next-filename-linum ()
;;   (let* ((chars "a-zA-Z0-9\._/-")
;;          (c (concat "[" chars "]"))
;;          (not-c (concat "[^" chars "]"))
;;          (filename-linum-pattern (concat not-c "\\(/?\\(" c "+/\\)+" c "+\\):\\([0-9]+\\)")))
;;     (re-search-forward filename-linum-pattern)
;;     `(,(match-beginning 1)
;;       ,(match-end 0)
;;       ,(buffer-substring (match-beginning 1) (match-end 1))
;;       ,(string-to-number (buffer-substring (match-beginning 3) (match-end 3)))
;;       ,(match-end 2))))



;; (defun plexus-goto-filename-linum-at-point (file line)
;;   (interactive)
;;   (if (s-starts-with? "." file)
;;       (find-file (concat (plv-project-root) (substring file 1 (length file))))
;;     (find-file file))
;;   (goto-line line))

;; (defun plexus-generate-next-filenum-linum-link ()
;;   (let* ((filename-linum-range (plexus-find-next-filename-linum))
;;          (link-start (car filename-linum-range))
;;          (link-end   (cadr filename-linum-range))
;;          (file       (caddr filename-linum-range))
;;          (line       (cadddr filename-linum-range))
;;          (map (make-sparse-keymap))
;;          (action (lambda () (interactive) (plexus-goto-filename-linum-at-point file line)))
;;          )
;;     (define-key map [mouse-1] action)
;;     (define-key map (kbd "RET") action)
;;     (put-text-property link-start link-end 'face 'link)
;;     (put-text-property link-start link-end 'local-map map)))

;; (defun plexus-mark-all-filename-linum-links ()
;;   (interactive)
;;   (save-excursion
;;     (goto-char (point-min))
;;     (while t (plexus-generate-next-filenum-linum-link))))

;; (defadvice ido-find-file (after find-file-sudo activate)
;;   "Find file as root if necessary."
;;   (unless (and buffer-file-name
;;                (file-writable-p buffer-file-name))
;;     (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))


(defun transform-word (transformation)
  (save-excursion
    (set-mark (point))
    (right-word)
    (let ((str (buffer-substring-no-properties (region-beginning) (region-end))))
      (delete-region (region-beginning) (region-end))
      (insert (apply transformation (list str)))))
  (right-word))

(defun camelize-word ()
  (interactive)
  (transform-word 's-lower-camel-case))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; el4r

;; (setq el4r-root-path (expand-file-name "~/github/trogdoro-el4r/"))

;; (plexus-prepend-env-path "PATH"    (concat el4r-root-path "bin"))
;; (plexus-prepend-env-path "RUBYLIB" (concat el4r-root-path "lib"))
;; (plexus-prepend-env-path "RUBYLIB" (concat el4r-root-path "lib/el4r/emacsruby"))
;; (add-to-list 'exec-path (concat el4r-root-path "bin"))
;; (add-to-list 'load-path (concat el4r-root-path "/data/emacs/site-lisp"))

;; (require 'el4r)
;; (setq el4r-instance-program  "el4r-instance")
;; (el4r-boot)


(setq ffip-patterns '("*.html" "*.org" "*.txt" "*.md" "*.el" "*.clj" "*.py" "*.rb" "*.js" "*.pl" "*.sh" "*.erl" "*.hs" "*.ml" "*.coffee" "*.c" "*.css" "*.scss" "*.sass" "*.rake"))
(setq ffip-limit most-positive-fixnum)

(setq erc-server-reconnect-attempts 10)

(require 'ido)
(ido-mode t)

(global-set-key (kbd "<f8>") 'evil-mode)
(global-set-key (kbd "<f9>") 'evil-mode)

(setq send-mail-function 'smtpmail-send-it)
(setq smtpmail-smtp-server "smtp.gmail.com")
(setq smtpmail-smtp-service 25)
(setq smtpmail-starttls-credentials '(("smtp.gmail.com" 25 nil nil)))
