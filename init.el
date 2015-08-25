(package-initialize)

;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

(setq inhibit-startup-message t)

(add-to-list 'load-path (expand-file-name "init.d" user-emacs-directory))

(require 'sane-defaults)

(require 'setup-emacs)
(require 'setup-packages)

(require 'setup-elisp)
(require 'setup-clojure)
(require 'setup-coffeescript)
(require 'setup-javascript)
(require 'setup-web)
(require 'setup-ruby)

(require 'look-and-feel)
(require 'key-bindings)

;; Waiting to become MELPA packages

(defadvice self-insert-command (around automagic-sudo activate)
  "Ask to re-open a file with sudo if it's read-only and you try to edit it."
  (condition-case nil
      ad-do-it
    (buffer-read-only 
      (let ((path (buffer-file-name))
            (buff (current-buffer)))
        (when (and path (y-or-n-p "File is read-only, reopen with sudo?"))
          (find-file (concat "/sudo:root@localhost:" path))
          (kill-buffer buff))))))
