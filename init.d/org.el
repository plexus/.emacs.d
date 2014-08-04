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

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(setq org-agenda-files '("~/Doku/org"))
