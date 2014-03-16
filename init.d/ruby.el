(require 'ruby-mode)

(add-auto-mode-patterns 'ruby-mode
                        "\\.rb$"
                        "\\.rake$"
                        "\\.ru$"
                        "\\.xml.builder$"
                        "\\.rhtml$"
                        "\\.gemspec$"
                        "Rakefile$"
                        "Gemfile$"
                        "Gemfile.*"
                        "Procfile$"
                        "Vagrantfile$"
                        "Guardfile$"
                        "Berksfile$"
                        "Bowerfile$"
                        "Assetfile$")

(setq ruby-indent-level 2)
(setq ruby-deep-indent-paren nil)       ; inside parameter lists, just indent two spaces rather than up to paren

(defun plexus-load-rspec ()
  (require 'rspec-mode)
  (setq rspec-use-rake-flag nil)
  (setq rspec-spec-command "rspec")
  (custom-set-variables '(rspec-key-command-prefix (kbd "H-s")))
  (define-key rspec-mode-keymap (kbd "H-s") 'rspec-verify-single))

(defun plexus-set-rct-elisp-path ()
  (let ((path (concat user-emacs-directory "vendor/rcodetools")))
    (if (not (-contains? load-path path))
        (setq load-path
              (append (list path)
                      load-path)))))

(setq plexus-rct-rcodetools-path (file-truename
                                  (concat user-emacs-directory
                                          "vendor/rcodetools/bin")))

(defun plexus-prepend-env-path (env-var path)
  (if (not (-contains? (s-split ":" (getenv env-var)) path))
      (setenv env-var (concat path ":" (getenv env-var)))))

(defun plexus-set-rct-env ()
  (plexus-prepend-env-path "PATH" plexus-rct-rcodetools-path)
  (plexus-prepend-env-path "RUBYLIB" plexus-rct-rcodetools-path))

(defun plexus-activate-rcodetools ()
  (progn
    (plexus-set-rct-elisp-path)
    (plexus-set-rct-env)
    (require 'rcodetools)
    (define-key ruby-mode-map (kbd "C-c C-c") 'xmp)))

(add-hook 'ruby-mode-hook 'plexus-activate-rcodetools)
(add-hook 'ruby-mode-hook 'coxit-mode)
(add-hook 'ruby-mode-hook 'abbrev-mode)
            ;(plexus-load-rspec)
            ;(robe-mode)


;; "Fix" Ruby indentation, for example.
;; f(
;;   :bar => :baz
;; )
(setq ruby-deep-indent-paren nil)
(defadvice ruby-indent-line (after unindent-closing-paren activate)
  (let ((column (current-column))
        indent offset)
    (save-excursion
      (back-to-indentation)
      (let ((state (syntax-ppss)))
        (setq offset (- column (current-column)))
        (when (and (eq (char-after) ?\))
                   (not (zerop (car state))))
          (goto-char (cadr state))
          (setq indent (current-indentation)))))
    (when indent
         (indent-line-to indent)
      (when (> offset 0) (forward-char offset)))))

(require 'chruby)
(chruby "1.9.3")
