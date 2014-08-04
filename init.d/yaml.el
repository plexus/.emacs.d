(require 'yaml-mode)

(setq auto-mode-alist
      (append '(("\\.yml$" . yaml-mode)
                ("\\.yaml$" . yaml-mode)
                )
              auto-mode-alist))
