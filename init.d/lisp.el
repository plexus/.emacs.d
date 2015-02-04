;; -*- lexical-binding: t; -*-

(add-to-list 'load-path "/home/arne/github/cider")
(add-to-list 'load-path "/home/arne/github/ac-cider")
(add-to-list 'load-path "/home/arne/github/clojure-mode")

(require 'clojure-mode)
(require 'cider)
(require 'cider-macroexpansion)
(require 'cider-eldoc)
(require 'ac-cider)
(require 'highlight-flash-conf)

;; (define-key cider-mode-map (kbd "C-c d") 'cider-doc)
;; (define-key cider-mode-map (kbd "C-c C-d d") 'cider-doc)

(defun plexus-lisp-init (cider)
  (lambda ()
    (paredit-mode)
    (rainbow-delimiters-mode)
    (auto-complete-mode)
    (if cider
        (cider-turn-on-eldoc-mode)
      (turn-on-eldoc-mode))))

(add-hook 'emacs-lisp-mode-hook  (plexus-lisp-init nil))
(add-hook 'ielm-mode-hook        (plexus-lisp-init nil))
(add-hook 'cider-mode-hook       (plexus-lisp-init t))
(add-hook 'cider-repl-mode-hook  (plexus-lisp-init t))
(add-hook 'minibuffer-setup-hook (lambda ()
                                   (if (eq this-command 'eval-expression)
                                       (plexus-lisp-init nil))))

(add-hook 'clojure-mode-hook 'cider-mode)

;; (eval-after-load 'clojure-mode
;;   '(font-lock-add-keywords
;;     'clojure-mode `(("(\\(fn\\)[\[[:space:]]"
;;                      (0 (progn (compose-region (match-beginning 1)
;;                                                (match-end 1) "λ")
;;                                nil))))))

;; (eval-after-load 'clojure-mode
;;   '(font-lock-add-keywords
;;     'clojure-mode `(("\\(#\\)("
;;                      (0 (progn (compose-region (match-beginning 1)
;;                                                (match-end 1) "ƒ")
;;                                nil))))))

;; (eval-after-load 'clojure-mode
;;   '(font-lock-add-keywords
;;     'clojure-mode `(("\\(#\\){"
;;                      (0 (progn (compose-region (match-beginning 1)
;;                                                (match-end 1) "Σ")
;;                                nil))))))

;; (add-hook 'cider-mode-hook
;;           (lambda ()
;;             (define-key cider-mode-map (kbd "C-c C-e")
;;               'cider-eval-print-last-sexp)))

(global-set-key (kbd "<C-M-backspace>") 'backward-kill-sexp)


;; (define-key clojure-mode-map (kbd "C-x <up>") 'cider-repl-backward-input)
;; (define-key clojure-mode-map (kbd "C-x <down>") 'cider-repl-forward-input)

;; C-x C-e  eval-last-sexp
;; C-M-x    eval-defun

(define-clojure-indent
  (describe 1)
  (it 1))
