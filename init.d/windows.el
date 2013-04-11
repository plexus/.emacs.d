(windmove-default-keybindings)
;; <S-left> <S-right> <S-up> <S-down>

(global-set-key (kbd "H-<left>")  'shrink-window-horizontally)
(global-set-key (kbd "H-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "H-<down>")  'shrink-window)
(global-set-key (kbd "H-<up>")    'enlarge-window)

;; C-x - : Shrink to buffer size (for small buffers)
