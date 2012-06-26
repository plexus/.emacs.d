(require 'slim-mode)

(setq auto-mode-alist 
      (append '(("\\.slim$" . slim-mode)
                )
              auto-mode-alist))