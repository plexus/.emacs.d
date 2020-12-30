(mapc #'load-file
      (directory-files
       (concat user-emacs-directory "lisp")
       t
       "[0-9]*.el$"))

(use-package magit)
(use-package org
  :config
  (require 'org-tempo))
(use-package markdown-mode)
(use-package yaml-mode)

(straight-freeze-versions)


;; FIXME: should we even be doing this? and if so should it go into corkey
;; bindings?
;; Support Home/End in terminals
(global-set-key (kbd "M-[ 1 ~") 'beginning-of-line)
(global-set-key (kbd "M-[ 4 ~") 'end-of-line)
(global-set-key (kbd "<select>") 'end-of-line)
