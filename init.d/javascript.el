(defun plexus-ticketsolve-js-test-runner ()
  (interactive)
  (compile (concat "/home/arne/ticketsolve/repo/spec/javascripts/support/runner.coffee "
                   "/home/arne/ticketsolve/repo/spec/javascripts/unit/runner.html")
           t))

(defun plexus-javascript-init ()
  (toggle-mode)
  (electric-pair-mode)
  (yas-minor-mode)
  (define-key js-mode-map (kbd "H-s") 'plexus-ticketsolve-js-test-runner))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; flymake + jslint

;; (require 'flymake)
;; (require 'flymake-cursor)


;; (setq jslint-globals '(jQuery
;;                        Ticketsolve
;;                        document
;;                        describe
;;                        expect
;;                        it
;;                        spyOn
;;                        setFixtures
;;                        beforeEach
;;                        mock_ajax_request
;;                        mock_jsonp_timeout
;;                        expect_message
;;                        mock_jsonp_exception))

;; (defun plexus-flymake-jslint-init ()
;;   (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                      'flymake-create-temp-inplace))
;;          (local-file (file-relative-name
;;                       temp-file
;;                       (file-name-directory buffer-file-name)))
;;          (predef-args (mapconcat
;;                        (lambda(global)
;;                          (concat "--predef " (symbol-name global)))
;;                        jslint-globals " ")))
;;     (list "jslint"
;;           (list (mapconcat 'identity
;;                            (list "--terse" "--sloppy" "--vars" predef-args)
;;                            " ")
;;                 local-file))))

;; (add-to-list 'flymake-allowed-file-name-masks
;;              '("\\.js\\'" plexus-flymake-jslint-init))

;; (defun plexus-flymake-jslint-activate ()
;;   (setq flymake-err-line-patterns
;;         (cons '("^\\(.*\\)(\\([[:digit:]]+\\)):\\(.*\\)$"
;;                 1 2 nil 3)
;;               flymake-err-line-patterns))
;;       (flymake-mode 1)
;;       (define-key js-mode-map "\C-c\C-n" 'flymake-goto-next-error))

;; ;; (add-hook 'js-mode-hook 'plexus-javascript-init)
;; ;; (add-hook 'js-mode-hook 'plexus-flymake-jslint-activate)
