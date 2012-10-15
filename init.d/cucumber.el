(add-to-list 'load-path (concat user-emacs-directory "elisp/cucumber.el"))

(require 'feature-mode)

(add-to-list 'auto-mode-alist '("\.feature$" . feature-mode))


