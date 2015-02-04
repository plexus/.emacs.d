(require 'elixir-mode)

(let ((elixir-bin "/home/arne/opt/elixir/bin"))
  (plexus-prepend-env-path "PATH" elixir-bin)
  (add-to-list 'exec-path elixir-bin))

(define-key elixir-mode-map (kbd "C-c M-j") 'elixir-mode-iex)
(define-key elixir-mode-map (kbd "C-c C-r") 'elixir-mode-eval-on-region)
;;       M-x elixir-mode-eval-on-region
;;
;;           Evaluates the Elixir code on the marked region.
;;           This is bound to "C-c ,r" while in `elixir-mode'.
;;
;;       M-x elixir-mode-eval-on-current-line
;;
;;           Evaluates the Elixir code on the current line.
;;           This is bound to "C-c ,c" while in `elixir-mode'.
;;
;;       M-x elixir-mode-eval-on-current-buffer
;;
;;           Evaluates the Elixir code on the current buffer.
;;           This is bound to "C-c ,b" while in `elixir-mode'.
;;
;;       M-x elixir-mode-string-to-quoted-on-region
;;
;;           Get the representation of the expression on the marked region.
;;           This is bound to "C-c ,a" while in `elixir-mode'.
;;
;;       M-x elixir-mode-string-to-quoted-on-current-line
;;
;;           Get the representation of the expression on the current line.
;;           This is bound to "C-c ,l" while in `elixir-mode'.
