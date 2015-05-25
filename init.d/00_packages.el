(require 'package)

(setq package-archives
  '(("gnu"         . "http://elpa.gnu.org/packages/")
    ("melpa"       . "http://melpa.milkbox.net/packages/")))

;; (package-refresh-contents)
(package-initialize)

(defun package-require (pkg)
  "Install a package only if it's not already installed."
  (when (not (package-installed-p pkg))
    (package-install pkg)))

;; (package-require 'imagex)

;; general purpose
(package-require 'magit)
(package-require 'git-timemachine)
(package-require 'multiple-cursors)
(package-require 'popwin)
(package-require 'paredit)
(package-require 'smartparens)
(package-require 'yasnippet)
(package-require 'wgrep)

;; major modes
;; (package-require 'arduino-mode)
(package-require 'coffee-mode)
(package-require 'gitconfig-mode)
(package-require 'haml-mode)
(package-require 'handlebars-mode)
;; (package-require 'haskell-mode)
(package-require 'js2-mode)
(package-require 'json-mode)
(package-require 'markdown-mode)
(package-require 'org)
(package-require 'sass-mode)
(package-require 'scss-mode)
;; (package-require 'slim-mode)
(package-require 'web-mode)
(package-require 'yaml-mode)
;; (package-require 'elixir-mode)
(package-require 'rust-mode)
(package-require 'toml-mode)

;; minor modes
(package-require 'rainbow-mode)
(package-require 'rspec-mode)
(package-require 'yard-mode)
(package-require 'evil)
(package-require 'flycheck)
(package-require 'flymake-jslint)
(package-require 'flymake-ruby)
(package-require 'auto-complete)
(package-require 'find-file-in-project)

;; themes
(package-require 'color-theme-sanityinc-solarized)
(package-require 'color-theme-sanityinc-tomorrow)
(package-require 'solarized-theme)
(package-require 'theme-changer)

;; elisp utility
(package-require 'dash)
(package-require 'dash-functional)
(package-require 'f)
(package-require 's)

;; additional language-specific support stuff
(package-require 'inf-ruby)
(package-require 'ruby-additional)
(package-require 'chruby)
(package-require 'ruby-hash-syntax)

;; other
(package-require 'expand-region)
(package-require 'fm)
(package-require 'hide-comnt)
(package-require 'outline-magic)
(package-require 'rainbow-delimiters)
(package-require 'notmuch)
(package-require 'highlight)
(package-require 'eval-sexp-fu)


;(package-require 'bison-wisent)
;(package-require 'dired-fixups)
;(package-require 'gimme-cat)
;(package-require 'ox-reveal)
