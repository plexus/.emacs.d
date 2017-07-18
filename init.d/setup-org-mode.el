(use-package org
  :ensure t
  :pin org
  :config
  (use-package org-bullets :ensure t)
  (use-package ob-restclient :ensure t)
  (use-package ox-gfm :ensure t)
  (use-package org-present
    :ensure t
    :bind (:map org-present-mode-keymap
                (("<next>" . org-present-next)
                 ("<prior>" . org-present-prev))))

  ;; org-mode: Don't ruin S-arrow to switch windows please (use M-+ and M-- instead to toggle)
  (setq org-replace-disputed-keys t)

  ;; Fontify org-mode code blocks
  (setq org-src-fontify-natively t)

  (setq org-directory "~/Doku/org/")

  (setq org-capture-templates `(("p"
                                 "Protocol"
                                 entry
                                 (file+headline "/home/arne/LambdaIsland/notes/learnings.org"
                                                "Inbox"
                                                ;(lambda () (shell-command-to-string "echo -n $(date +%Y-%m-%d)"))
                                                )
                                 "* %(shell-command-to-string \"echo -n $(date +%Y-%m-%d)\")\n** %^{Title}\nSource: %u, %c\n #+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n")
                                ("L"
                                 "Protocol Link"
                                 entry
                                 (file+headline "/home/arne/LambdaIsland/notes/learnings.org"
                                                "Inbox"
                                                ;(lambda () (shell-command-to-string "echo -n $(date +%Y-%m-%d)"))
                                                )
                                 "* %(shell-command-to-string \"echo -n $(date +%Y-%m-%d)\")\n** [[%:link][%:description]] \n")))

  (require 'org-capture)
  (require 'org-protocol)

  (defun plexus/org-find-olp+resolve-lambdas (old-fn &rest args)
    (prin1 args)
    (apply old-fn
           (mapcar (lambda (arg)
                     (if (functionp arg)
                         (apply arg ())
                       arg))
                   args)))

  (advice-add 'org-find-olp :around #'plexus/org-find-olp+resolve-lambdas)

  :init
  (add-hook 'org-mode-hook 'org-bullets-mode)
  :bind (:map org-mode-map
              (("C-c M-j" . cider-jack-in))))

(package-install 'org)


;; (add-to-list 'org-latex-classes
;;              '("scrbook" "\\documentclass{scrbook}"
;;                ("\\part{%s}" . "\\part*{%s}")
;;                ("\\chapter{%s}" . "\\chapter*{%s}")
;;                ("\\section{%s}" . "\\section*{%s}")
;;                ("\\subsection{%s}" . "\\subsection*{%s}")
;;                ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))

;; (add-to-list 'org-latex-classes
;;           '("koma-article"
;;              "\\documentclass{scrartcl}"
;;              ("\\section{%s}" . "\\section*{%s}")
;;              ("\\subsection{%s}" . "\\subsection*{%s}")
;;              ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
;;              ("\\paragraph{%s}" . "\\paragraph*{%s}")
;;              ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))


(setq
 org-latex-classes
 '(("koma-article"
   "\\documentclass{scrartcl}"
   ("\\section{%s}" . "\\section*{%s}")
   ("\\subsection{%s}" . "\\subsection*{%s}")
   ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
   ("\\paragraph{%s}" . "\\paragraph*{%s}")
   ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
  ("scrbook"
   "\\documentclass{scrbook}"
   ("\\part{%s}" . "\\part*{%s}")
   ("\\chapter{%s}" . "\\chapter*{%s}")
   ("\\section{%s}" . "\\section*{%s}")
   ("\\subsection{%s}" . "\\subsection*{%s}")
   ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
  ("article"
   "\\documentclass[11pt]{article}"
   ("\\section{%s}" . "\\section*{%s}")
   ("\\subsection{%s}" . "\\subsection*{%s}")
   ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
   ("\\paragraph{%s}" . "\\paragraph*{%s}")
   ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
  ("report"
   "\\documentclass[11pt,a4paper,notitlepage]{report}"
   ("\\chapter{%s}" . "\\chapter*{%s}")
   ("\\section{%s}" . "\\section*{%s}")
   ("\\subsection{%s}" . "\\subsection*{%s}")
   ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
  ("book"
   "\\documentclass[11pt]{book}"
   ("\\part{%s}" . "\\part*{%s}")
   ("\\chapter{%s}" . "\\chapter*{%s}")
   ("\\section{%s}" . "\\section*{%s}")
   ("\\subsection{%s}" . "\\subsection*{%s}")
   ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))))


(setq
 org-latex-pdf-process
 '("pdflatex --shell-escape -interaction nonstopmode -output-directory %o %f"
   "pdflatex --shell-escape -interaction nonstopmode -output-directory %o %f"
   "pdflatex --shell-escape -interaction nonstopmode -output-directory %o %f"))


(setq org-latex-listings 'minted)
(setq org-latex-custom-lang-environments
      '((emacs-lisp "common-lispcode")
        (clojure "common-lispcode")))
(setq org-latex-minted-options
      '(("frame" "lines")
        ("fontsize" "\\scriptsize")
        ("linenos" "")))


;; don't sum 24 hours to a day, just total hours
(setq org-time-clocksum-format '(:hours "%d" :require-hours t :minutes ":%02d" :require-minutes t))

(defun lambdaisland/export-guides ()
  (interactive)
  (with-current-buffer (find-file-noselect "/home/arne/github/lambdaisland-guides/repls.org")
    (org-html-export-to-html)
    (org-latex-export-to-pdf)
    (shell-command-to-string "ebook-convert /home/arne/github/lambdaisland-guides/repls.html /home/arne/github/lambdaisland-guides/repls.mobi")
    (shell-command-to-string "ebook-convert /home/arne/github/lambdaisland-guides/repls.html /home/arne/github/lambdaisland-guides/repls.epub")
    (shell-command-to-string "cp /home/arne/github/lambdaisland-guides/repls.{html,pdf,epub,mobi} /home/arne/LambdaIsland/App/resources/guides")))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((shell . t)
   (js . t)
   (clojure . t)
   (ruby . t)
   (emacs-lisp . t)
   (restclient . t)))


(provide 'setup-org-mode)
