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
