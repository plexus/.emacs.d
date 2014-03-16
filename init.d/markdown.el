;;http://css-tricks.com/words-avoid-educational-writing/

(require 'markdown-mode)

(add-hook 'markdown-mode-hook
          (lambda ()
            (flyspell-mode)
            (longlines-mode)
            (font-lock-add-keywords
             nil
             '(("\\<\\(\\(O\\|o\\)bviously\\|\\(B\\|b\\)asically\\|\\(S\\|s\\)imply\\|\\(O\\|o\\)f course\\|\\(C\\|c\\)learly\\|\\(J\\|j\\)ust\\|\\(E\\|e\\)veryone knows\\|\\(H\\|h\\)owever\\|\\(S\\|s\\)o\\|\\(E\\|e\\)asy\\)\\>"
                1
                font-lock-warning-face t)))))


(add-auto-mode-patterns 'markdown-mode
                        "\\.markdown$"
                        "\\.md$")
