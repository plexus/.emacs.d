(use-package clojure-mode
  :ensure t
  :config
  (add-hook 'clojure-mode-hook 'cider-mode)

  ;;;; Optional: add structural editing
  (use-package paredit
    :ensure t
    :config
    (add-hook 'clojure-mode-hook 'paredit-mode))

    ;;; Give matching parentheses matching colors
  (use-package rainbow-delimiters
    :ensure t
    :config
    (add-hook 'clojure-mode-hook 'rainbow-delimiters-mode))

    ;;; Integrated REPL environment
  (use-package cider
    :ensure t
    :config
    (use-package cider-eval-sexp-fu :ensure t)
    (use-package clj-refactor
      :ensure t
      :config
      (add-hook 'clojure-mode-hook 'clj-refactor-mode)
      (cljr-add-keybindings-with-prefix "H-m")))

  (put-clojure-indent 'GET 2)
  (put-clojure-indent 'POST 2)
  (put-clojure-indent 'PUT 2)
  (put-clojure-indent 'DELETE 2)

  (defun plexus/cider-eval-and-insert (&optional prefix)
    (interactive "P")
    (if prefix
        (let ((pos (point)))
          (cider-eval-last-sexp t)
          (goto-char pos)
          (insert ";;=> "))

      (let* ((lbp (line-beginning-position))
             (comment-pos (search-backward ";;=>" lbp t)))
        (if comment-pos
            (progn
              (goto-char comment-pos)
              (delete-region comment-pos (line-end-position))
              (cider-eval-last-sexp t)
              (goto-char comment-pos)
              (insert ";;=> "))
          (cider-eval-last-sexp)))))

  (define-key cider-mode-map (kbd "C-x C-e") 'plexus/cider-eval-and-insert))

(provide 'setup-clojure)
