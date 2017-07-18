;;; mastodon-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "mastodon" "mastodon.el" (22784 38262 692603
;;;;;;  554000))
;;; Generated autoloads from mastodon.el

(autoload 'mastodon "mastodon" "\
Connect Mastodon client to `mastodon-instance-url' instance.

\(fn)" t nil)

(autoload 'mastodon-toot "mastodon" "\
Update instance with new toot. Content is captured in a new buffer.

If USER is non-nil, insert after @ symbol to begin new toot.
If REPLY-TO-ID is non-nil, attach new toot to a conversation.

\(fn &optional USER REPLY-TO-ID)" t nil)

(add-hook 'mastodon-mode-hook (lambda nil (when (require 'emojify nil :noerror) (emojify-mode t))))

;;;***

;;;### (autoloads nil nil ("mastodon-auth.el" "mastodon-client.el"
;;;;;;  "mastodon-http.el" "mastodon-media.el" "mastodon-pkg.el"
;;;;;;  "mastodon-tl.el" "mastodon-toot.el") (22784 38262 688603
;;;;;;  574000))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; mastodon-autoloads.el ends here
