(add-to-list 'load-path (concat user-emacs-directory "vendor/nrepl.el"))

(require 'nrepl)

(add-hook 'clojure-mode-hook
          'nrepl-interaction-mode)
