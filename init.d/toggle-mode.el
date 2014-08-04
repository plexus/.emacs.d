;; (setq toggle-mode-spec-file-pattern "\\(_\\|-\\)spec\\.js$")

;; (defun toggle-mode-toggle-spec-and-target ()
;;   "Switches to the spec for the current buffer if it is a
;;    non-spec file, or switch to the target of the current buffer
;;    if the current is a spec"
;;   (interactive)
;;   (find-file
;;    (if (toggle-mode-buffer-is-spec-p)
;;        (toggle-mode-target-file-for (buffer-file-name))
;;      (toggle-mode-spec-file-for (buffer-file-name)))))

;; (defun toggle-mode-buffer-is-spec-p ()
;;   "Returns true if the current buffer is a spec"
;;   (and (buffer-file-name)
;;        (toggle-mode-spec-file-p (buffer-file-name))))

;; (defun toggle-mode-spec-file-p (a-file-name)
;;   "Returns true if the specified file is a spec"
;;   (numberp (string-match toggle-mode-spec-file-pattern a-file-name)))

;; (defun toggle-mode-target-file-for (a-spec-file-name)
;;   "Find the target for a-spec-file-name"
;;   (first
;;    (file-expand-wildcards
;;         (replace-regexp-in-string
;;          "/spec/javascripts/unit"
;;          "/public/javascripts"
;;          (toggle-mode-targetize-file-name a-spec-file-name)))))

;; (defun toggle-mode-spec-file-for (a-file-name)
;;   "Find spec for the specified file"
;;   (if (toggle-mode-spec-file-p a-file-name)
;;       a-file-name
;;       (toggle-mode-specize-file-name
;;        (expand-file-name (replace-regexp-in-string "^\\.\\./[^/]+/[^/]+/" ""
;;                                                    (file-relative-name a-file-name (toggle-mode-spec-directory a-file-name)))
;;                          (concat (toggle-mode-spec-directory a-file-name) "/javascripts/unit")))))

;; (defun toggle-mode-specize-file-name (a-file-name)
;;   "Returns a-file-name but converted in to a spec file name"
;;   (concat
;;    (file-name-directory a-file-name)
;;    (replace-regexp-in-string "\\(\\.js\\)?$" "_spec.js" (file-name-nondirectory a-file-name))))

;; (defun toggle-mode-targetize-file-name (a-file-name)
;;   "Returns a-file-name but converted into a non-spec file name"
;;      (concat (file-name-directory a-file-name)
;;               (replace-regexp-in-string "_spec\\.js" ".js" (file-name-nondirectory a-file-name))))

;; (defun toggle-mode-spec-directory (a-file)
;;   "Returns the nearest spec directory that could contain specs for a-file"
;;   (if (file-directory-p a-file)
;;       (or
;;        (first (directory-files a-file t "^spec$"))
;;        (if (toggle-mode-root-directory-p a-file)
;;            nil
;;          (toggle-mode-spec-directory (toggle-mode-parent-directory a-file))))

;;     (toggle-mode-spec-directory (toggle-mode-parent-directory a-file))))

;; (defun toggle-mode-parent-directory (a-directory)
;;   "Returns the directory of which a-directory is a child"
;;   (file-name-directory (directory-file-name a-directory)))

;; (defun toggle-mode-root-directory-p (a-directory)
;;   "Returns t if a-directory is the root"
;;   (equal a-directory (toggle-mode-parent-directory a-directory)))

;; (defvar toggle-mode-map
;;   (let ((map (make-sparse-keymap)))
;;     (define-key map (kbd "H-M-t") 'toggle-mode-toggle-spec-and-target)
;;     map)
;;   "Keymap for toggle-mode")

;; (define-minor-mode toggle-mode
;;   "A mode to toggle between spec and source file"
;;   ;; initial value.
;;   nil
;;   ;;indicator for the mode line.
;;   " toggle"
;;   ;;keymap
;;   toggle-mode-map)
