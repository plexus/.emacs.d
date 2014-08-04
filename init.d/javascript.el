(setq auto-mode-alist
      (append '(("\\.js$" . js2-mode))
              auto-mode-alist))

(custom-set-variables
 '(js2-indent-level 2)
 '(js2-basic-offset 2))
