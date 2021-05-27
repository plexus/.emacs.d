(defvar plexus/gimp-proc nil
  "Gimp Client Process Object")

(defvar plexus/gimp-repl-buffer-name "*gimp-repl*")

(defun plexus/gimp-connect ()
  "Connect to the Script-Fu server.

The Script-Fu server is started in the GIMP via Xtns > Script FU
> Start Server."
  (interactive)
  (let ((host "127.0.0.1") ;;(read-from-minibuffer "Host: " "127.0.0.1")
        (port 10008)) ;;(read-number "Port: " 10008))
    (setq plexus/gimp-proc
          (open-network-stream "gimp-client"
                               plexus/gimp-repl-buffer-name
                               host
                               port))
    ;; (set-process-filter
    ;;  'plexus/gimp-process-filter)
    (switch-to-buffer plexus/gimp-repl-buffer-name)
    (inferior-scheme-mode)
    ;; (inferior-gimp-mode)
    (insert "Client mode for the GIMP script-fu server\n"
            (make-string 42 61)
            "\n")
    (set-marker (process-mark plexus/gimp-proc) (point))))

(defun plexus/gimp-process-filter (p s))

(defun plexus/gimp-send-string (string)
  (when (eq (process-status plexus/gimp-proc) 'open)
    (let* ((pre "G")
           (len (length string))
           (high (/ len 256))
           (low (mod len 256)))
      (if (> len 65535)
          (error "GIMP send-string: String to long: %d" len))
      (if (> low 0)
          ;; arghh Problems with multibyte and send string. Assert low
          ;; length of 0
          (setq string (concat string (make-string (- 256 low) ? ))
                low 0
                high (1+ high)))
      (setq pre (concat pre
                        (char-to-string high)
                        (char-to-string low)))
      (setq pre (string-as-unibyte pre))
      (process-send-string plexus/gimp-proc pre)
      (process-send-string plexus/gimp-proc string))))

(defun plexus/gimp-eval-last-sexp ()
  (interactive)
  (plexus/gimp-send-string (sexp-at-point)))

(define-derived-mode plexus/gimp-scheme-mode scheme-mode "GIMP mode"
  "Mode for editing script-fu and interacting with an inferior gimp process."
  (setq indent-line-function 'lisp-indent-line))
