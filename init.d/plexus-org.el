(define-skeleton org-skeleton
  "Header info for a emacs-org file."
  "Title: "
  "#+TITLE:" str " \n"
  "#+AUTHOR: Arne Brasseur\n"
  "#+email: arne@arnebrasseur.net\n"
  "#+INFOJS_OPT: \n"
  "#+BABEL: :session *ruby* :cache yes :results output graphics :exports both :tangle yes \n"
  "")

(global-set-key (kbd "H-o") 'org-skeleton)

(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c b") 'org-iswitchb)

(setq org-directory "~/Doku/org")
(setq org-agenda-files `(,org-directory))

(setq org-default-notes-file "~/Doku/org/notes.org")

;; Make windmove work in org-mode:
(add-hook 'org-shiftup-final-hook 'windmove-up)
(add-hook 'org-shiftleft-final-hook 'windmove-left)
(add-hook 'org-shiftdown-final-hook 'windmove-down)
(add-hook 'org-shiftright-final-hook 'windmove-right)
