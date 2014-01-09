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
    ))

(global-set-key (kbd "H-j") 'plexus-jump-to-clipboard)

(yas-global-mode 1)

(defun make-temp-ruby-buffer-name ()
  (let* ((dir (concat (getenv "HOME") "/projects/ruby-tmp"))
        (last-buffer (car (last (directory-files dir nil "[0-9]+\.rb")))))
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

(defun plexus-spec-summary ()
  (interactive)
  (occur "^[ \t]*\\(describe\\|it\\|context\\|specify\\|shared_examples\\|include_examples\\|shared_context\\|include_context\\)"))


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

(eval-after-load 'outline
  '(progn
     (require 'outline-magic)
    (define-key outline-minor-mode-map (kbd "H-m") 'outline-cycle)))

(add-hook 'ruby-mode-hook
          (lambda ()
            (outline-minor-mode)
            (setq outline-regexp " *\\(def \\|class\\|module\\)")))

;(add-hook 'ruby-mode-hook 'outline-minor-mode)


(global-set-key (kbd "H-e") (lambda () (interactive) (find-file (concat (getenv "HOME") "/.emacs.d/init.d/incubate.el"))))
(global-set-key (kbd "H-x") 'er/expand-region)


(defmacro coxit-env-let (bindings body &rest rest)
"Like `let' but sets environment variables rather than (Emacs) variables.
The return value is the result of the last expression, after returning the
environment variables are reset to their previous value."
  `(let ((orig-bindings (list ,@(mapcar (lambda (env)
                                   (list 'list env (list 'getenv env)))
                                 (mapcar 'symbol-name (mapcar 'car bindings))))))
     ,@(mapcar (lambda (binding)
                 (list 'setenv (symbol-name (car binding)) (cadr binding)))
               bindings)
     (let ((result (progn ,body ,@rest)))
       (mapcar (lambda (binding)
                 (setenv (car binding) (cadr binding)))
               orig-bindings)
       result)))
