;; org-mode: Don't ruin S-arrow to switch windows please (use M-+ and M-- instead to toggle)
(setq org-replace-disputed-keys t)

;; Fontify org-mode code blocks
(setq org-src-fontify-natively t)


(use-package org
  :ensure t
  :pin org
  :config
  (use-package org-bullets :ensure t)
  (use-package org-present
    :ensure t
    :bind (:map org-present-mode-keymap
                (("<next>" . org-present-next)
                 ("<prior>" . org-present-prev))))
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


(defun lambdaisland/export-guides ()
  (interactive)
  (with-current-buffer (find-file-noselect "/home/arne/github/lambdaisland-guides/repls.org")
    (org-html-export-to-html)
    (org-latex-export-to-pdf)
    (shell-command-to-string "ebook-convert /home/arne/github/lambdaisland-guides/repls.html /home/arne/github/lambdaisland-guides/repls.mobi")
    (shell-command-to-string "ebook-convert /home/arne/github/lambdaisland-guides/repls.html /home/arne/github/lambdaisland-guides/repls.epub")
    (shell-command-to-string "cp /home/arne/github/lambdaisland-guides/repls.{html,pdf,epub,mobi} /home/arne/LambdaIsland/app/resources/guides")))

(provide 'setup-org-mode)
