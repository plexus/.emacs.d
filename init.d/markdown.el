(require 'markdown-mode)
(add-hook 'markdown-mode-hook (lambda () (flyspell-mode)))


(setq auto-mode-alist
      (append '(("\\.markdown$" . markdown-mode)
                ("\\.md$" . markdown-mode)
                )
              auto-mode-alist))
