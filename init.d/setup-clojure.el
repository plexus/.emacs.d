(packages-install
 '(clojure-mode
   clojure-mode-extra-font-locking
   cider
   cider-eval-sexp-fu
   clj-refactor))

(require 'clj-refactor)

(defun plexus/clojure-mode-hook ()
    (clj-refactor-mode 1)
    (yas-minor-mode 1) ; for adding require/use/import
    (cljr-add-keybindings-with-prefix "C-c C-m")
    (rainbow-delimiters-mode)
    (smartparens-strict-mode)
    (cider-mode))

(add-hook 'clojure-mode-hook #'plexus/clojure-mode-hook)

(provide 'setup-clojure)

