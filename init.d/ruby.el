(require 'ruby-mode)

(setq auto-mode-alist 
      (append '(("\\.rb$" . ruby-mode)
                ("\\.rake$" . ruby-mode)
                ("rakefile$" . ruby-mode)
                ("Rakefile$" . ruby-mode)
                ("\\.gemspec$" . ruby-mode) 
                ("Gemfile" . ruby-mode) 
                ("Gemfile.lock" . ruby-mode) 
                ("Procfile" . ruby-mode) 
                ("Vagrantfile" . ruby-mode) 
                ("Guardfile" . ruby-mode) 
                )
              auto-mode-alist))

(setq ruby-indent-level 2)
(setq ruby-deep-indent-paren nil)       ; inside parameter lists, just indent two spaces rather than up to paren

(require 'rspec-mode)
(require 'rvm)
(setq rspec-use-rake-flag nil)
(setq rspec-spec-command "rspec")
(custom-set-variables '(rspec-key-command-prefix (kbd "s-s")))
