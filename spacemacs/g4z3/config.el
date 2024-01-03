;; g4z3's custom configs

;; always show line numbers
(setq dotspacemacs-line-numbers t)
;; yank will replace marked region, and C-d will delete region
(delete-selection-mode 1)
;; scratch default lisp mode
(setq dotspacemacs-scratch-mode 'lisp-mode)
(setq dotspacemacs-scratch-buffer-unkillable 1)

;; for remote lsp to work...
(with-eval-after-load 'tramp
;;  (add-to-list 'tramp-remote-path "/home/ph/.local/bin")
  (add-to-list 'tramp-remote-path 'tramp-own-remote-path)
  )

(defun g4z3/setup-python-lsp ()
  "Configure LSP clients for Python, enabling only `pylsp` and `pylsp-tramp`."
  (setq lsp-enabled-clients '(pylsp pylsp-tramp)))  ; Enable `pylsp` and `pylsp-tramp` only.

(add-hook 'python-mode-hook #'g4z3/setup-python-lsp)

;; lsp already ships with remote client lsp-tramp, just need to specify correct tramp path like above
;; (add-to-list 'lsp-disabled-clients "pylsp-tramp")
;; (with-eval-after-load 'lsp-mode
;;   (lsp-register-client
;;    (make-lsp-client :new-connection (lsp-tramp-connection "/home/ph/.local/bin/pylsp")
;;                     :major-modes '(python-mode)
;;                     :remote? t
;;                     :server-id 'pylsp-remote-g4z3
;;                     :priority ))
;;   )
;; completely disable emacs' own version control
(setq vc-handled-backends nil)


;; quelpa-use-package should be ready now
;; (require 'quelpa-use-package)
;; (use-package copilot
;;   :quelpa (copilot :fetcher github
;;                    :repo "zerolfx/copilot.el"
;;                    :branch "main"
;;                    :files ("dist" "*.el")))
;; (define-key copilot-completion-map (kbd "<tab>") 'copilot-accept-completion)
;; (global-copilot-mode)

;; tramp config to be compatible with defautl ssh config
(setq tramp-default-method "ssh")
(setq tramp-ssh-controlmaster-options
      "-o ControlMaster=auto -o ControlPath='~/.ssh/sockets/%%r@%%h:%%p' -o ControlPersist=3600")

;; org config
(require 'org)
(defun capture-report-date-file (path)
  (let ((name (read-string "Name: ")))
    (expand-file-name (format "%s-%s.org"
                              name
                              (format-time-string "%Y-%m-%d"))
                      path)))

(setq org-capture-templates
      '(("c" "g4z3's default capture template" entry
         (file "~/Documents/org/capture.org")
         (file "~/Documents/org/templates/template.capture.org"))
        ("j" "journal template" entry
         (file "~/Documents/org/journal.org")
         (file "~/Documents/org/templates/template.journal.org")
         :empty-lines-before 1)
        ("m" "memo" entry
         (file (lambda () (capture-report-date-file  "~/Documents/org/memos")))
         (file "~/Documents/org/templates/template.capture.org"))
        )
)

(setq org-icalendar-timezone "Asia/Shanghai")
(setq org-log-done 'time)
(setq org-todo-keywords
      '((sequence "TODO(t@/!)" "PROGRESS(p@/!)" "BLOCKED(b@/!)" "|" "DONE(d@/!)" "CANCELED(c@/!)")))

(setq org-outline-path-complete-in-steps nil)
(setq org-lowest-priority 68)

(defun org-agenda-contemplations()
  (interactive)
  (org-tags-view nil "+DEADLINE=\"\"+SCHEDULED=\"\"/!")
  )
(defun org-agenda-now()
  (interactive)
  (org-agenda-list)
  )
(setq org-src-window-setup (quote other-window))
(setq g4z3-org-refile-exclude '("journal.org"))
(setq g4z3-org-refile-exclude-regex "journal")
(defun g4z3-org-refile-filter(s)
  (and (string-match "^[^#]*\.org$" s) (not (string-match g4z3-org-refile-exclude-regex s)))
  )
(defun g4z3-expand-path-by-project (p)
  (let ((prj-root (projectile-project-root)))
    (expand-file-name p prj-root)
    )
  )
(defun g4z3-org-refile-targets ()
  (seq-filter 'g4z3-org-refile-filter
    (mapcar 'g4z3-expand-path-by-project (projectile-current-project-files)))
  )
;; navigation key bindings
(global-set-key (kbd "C-S-p") 'scroll-down-line)
(global-set-key (kbd "C-S-n") 'scroll-up-line)
(setq scroll-preserve-screen-position nil)
(global-set-key (kbd "C-x o") 'ace-window)
(global-set-key (kbd "M-S-<up>") 'move-text-up)
(global-set-key (kbd "M-S-<down>") 'move-text-down)
(global-set-key [remap move-beginning-of-line] #'crux-move-beginning-of-line)
(global-set-key (kbd "C-+") 'spacemacs/scale-up-font)
(global-set-key (kbd "C--") 'spacemacs/scale-down-font)
