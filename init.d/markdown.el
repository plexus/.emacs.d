;;http://css-tricks.com/words-avoid-educational-writing/

(require 'markdown-mode)

(defun plexus-highlight-weasel-words ()
  (font-lock-add-keywords
   nil
   '(("\\<\\(\\(O\\|o\\)bviously\\|\\(B\\|b\\)asically\\|\\(S\\|s\\)imply\\|\\(O\\|o\\)f course\\|\\(C\\|c\\)learly\\|\\(J\\|j\\)ust\\|\\(E\\|e\\)veryone knows\\|\\(H\\|h\\)owever\\|\\(S\\|s\\)o\\|\\(E\\|e\\)asy\\)\\>"
      1
      font-lock-warning-face t))))


(add-hook 'markdown-mode-hook 'flyspell-mode)
(add-hook 'markdown-mode-hook 'plexus-highlight-weasel-words)


(add-auto-mode-patterns 'markdown-mode
                        "\\.markdown$"
                        "\\.md$")
