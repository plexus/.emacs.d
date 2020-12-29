(push (concat user-emacs-directory "lisp") load-path)
(mapc #'load-file (directory-files (concat user-emacs-directory "lisp") t "[0-9]*.el$"))

(use-package magit
  :defer 1)

(use-package evil-magit
  :defer 1
  :after (magit))

(use-package org
  :defer 1
  :config
  (require 'org-tempo))

(use-package markdown-mode)
(use-package yaml-mode)
