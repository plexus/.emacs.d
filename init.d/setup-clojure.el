(packages-install
 '(clojure-mode
   clojure-mode-extra-font-locking
   cider
   cider-eval-sexp-fu
   clj-refactor
   ac-cider))

(require 'clj-refactor)

(defun plexus/clojure-mode-hook ()
    (clj-refactor-mode 1)
    (yas-minor-mode 1) ; for adding require/use/import
    (cljr-add-keybindings-with-prefix "C-c C-m")
    (rainbow-delimiters-mode)
    (smartparens-strict-mode)
    (cider-mode)
    (auto-complete-mode))

(add-hook 'clojure-mode-hook #'plexus/clojure-mode-hook)

(provide 'setup-clojure)

;; ac-cider

(require 'ac-cider)
(add-hook 'cider-mode-hook 'ac-flyspell-workaround)
(add-hook 'cider-mode-hook 'ac-cider-setup)
(add-hook 'cider-repl-mode-hook 'ac-cider-setup)
(eval-after-load "auto-complete"
  '(progn
     (add-to-list 'ac-modes 'cider-mode)
     (add-to-list 'ac-modes 'cider-repl-mode)))
