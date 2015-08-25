(packages-install
 '(coffee-mode
   flymake-coffee))

(require 'coffee-mode)
(require 'flymake-coffee)

(add-hook 'coffee-mode-hook 'flymake-coffee-load)

(provide 'setup-coffeescript)
