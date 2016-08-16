;; org-mode: Don't ruin S-arrow to switch windows please (use M-+ and M-- instead to toggle)
(setq org-replace-disputed-keys t)

;; Fontify org-mode code blocks
(setq org-src-fontify-natively t)

(provide 'setup-org-mode)


(add-to-list 'org-latex-classes
             '("scrbook" "\\documentclass{scrbook}"
               ("\\part{%s}" . "\\part*{%s}")
               ("\\chapter{%s}" . "\\chapter*{%s}")
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))

(add-to-list 'org-latex-classes
          '("koma-article"
             "\\documentclass{scrartcl}"
             ("\\section{%s}" . "\\section*{%s}")
             ("\\subsection{%s}" . "\\subsection*{%s}")
             ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
             ("\\paragraph{%s}" . "\\paragraph*{%s}")
             ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))


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
