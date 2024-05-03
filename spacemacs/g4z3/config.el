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

;; tramp config to be compatible with defautl ssh config
(setq tramp-default-method "ssh")
(setq tramp-ssh-controlmaster-options
      "-o ControlMaster=auto -o ControlPath='~/.ssh/sockets/%%r@%%h:%%p' -o ControlPersist=3600")

;; (with-eval-after-load 'lsp-mode
;;   (setq lsp-enabled-clients '(pylsp-tramp pylsp))
;;   (setq lsp-client-packages '(pylsp-tramp pylsp))
;; )
;; (defun g4z3/setup-python-lsp ()
;;   "Configure LSP clients for Python, enabling only `pylsp` and `pylsp-tramp`."
;;   (setq lsp-enabled-clients '(pylsp pylsp-tramp))
;;   (setq lsp-client-packages '(pylsp pylsp-tramp))
;;   )  ; Enable `pylsp` and `pylsp-tramp` only.

;; (add-hook 'python-mode-hook #'g4z3/setup-python-lsp)

;; (with-eval-after-load 'lsp-mode
;;   (defun lsp-projectile-workspace-root ()
;;     "Get the root of the project from projectile."
;;     (when (and (fboundp 'projectile-project-root) (projectile-project-root))
;;       (projectile-project-root)))

;;   (setq lsp-workspace-folders-functions '(lsp-projectile-workspace-root)))

;; completely disable emacs' own version control
(setq vc-handled-backends nil)

;; org config
(require 'org)
(setq org-directory "~/Documents/org")
(setq org-log-into-drawer t)
(setq org-hide-drawer-startup t)
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
        ("m" "memo" entry
         (file (lambda () (capture-report-date-file  "~/Documents/org/memos")))
         (file "~/Documents/org/templates/template.capture.org"))
        ("a" "alphaith" entry
         (file (lambda () (capture-report-date-file  "~/Documents/org/alphaith/memos")))
         (file "~/Documents/org/templates/template.capture.org"))
        )
)

(setq org-icalendar-timezone "Asia/Shanghai")
(setq org-log-done 'time)
(setq org-todo-keywords
      '((sequence "TODO(t@/!)" "PROGRESS(p@/!)" "BLOCKED(b@/!)" "|" "DONE(d@/!)" "CANCELED(c@/!)")))

(setq org-outline-path-complete-in-steps nil)
(setq org-lowest-priority 68)
(setq org-startup-truncated nil)

(setq org-agenda-files "~/Documents/org/agenda_files")
(defun org-agenda-contemplations()
  (interactive)
  (org-tags-view nil "+DEADLINE=\"\"+SCHEDULED=\"\"/!")
  )
(defun org-agenda-now()
  (interactive)
  (org-agenda-list)
  )
(setq org-agenda-prefix-format
      '((agenda . " %i %-12:c%?-12t% s%b") ;; Include breadcrumbs in the agenda view
        (todo   . " %i %-12:c %b")          ;; Include breadcrumbs in the todo view
        (tags   . " %i %-12:c %b")
        (search . " %i %-12:c %b")))
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

;; export org with priority cookies
(setq org-export-with-priority 1)

;; latex preview scale
(setq org-format-latex-options (plist-put org-format-latex-options :scale 1.5))

;; babel settings
;; org-babel-load-languages’s value is ((emacs-lisp . t))
(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (emacs-lisp . t)
   (python . t)
   ))

;; auto remove trailing whitespaces on saving
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; treemacs: fixed window width. DAP mode sometimes changes treemacs window width
(setq treemacs-lock-width t)

;; dap mode configs, remove 'breakpoints' for better performance over trampa
;; (setq dap-auto-configure-features '(locals))
(setq dap-auto-configure-features '(sessions locals controls tooltip))

(with-eval-after-load 'dap-hydra
 (defhydra+ dap-hydra (:color pink :hint nil :foreign-keys run)
  ("sr" dap-ui-repl "repl" :exit (dap-hydra/nil))))

;; copilot settings
(with-eval-after-load 'company
  ;; disable inline previews
  (delq 'company-preview-if-just-one-frontend company-frontends))
(with-eval-after-load 'copilot
  (define-key copilot-completion-map (kbd "<tab>") 'copilot-accept-completion)
  (define-key copilot-completion-map (kbd "TAB") 'copilot-accept-completion)
  (define-key copilot-completion-map (kbd "C-TAB") 'copilot-accept-completion-by-word)
  (define-key copilot-completion-map (kbd "C-<tab>") 'copilot-accept-completion-by-word))
;; default copilot-enable-predicates includes evil-insert-state-p which does not work when i am not in evil mode
;; so i disable it and only enable copilot--buffer-changed

;; copilot needs proxy on server idc-server66, so set proxy by host name
;; (defun hostname-based-config ()
;;   (cond ((string= (system-name) "idc-server66") (setq copilot-network-proxy '(:host "127.0.0.1" :port 17890))))
;;   )
;; (hostname-based-config)
(setq copilot-enable-predicates '(copilot--buffer-changed))
(setq copilot-idle-delay 1)
(add-hook 'prog-mode-hook 'copilot-mode)

;; custom functions
(defun my-print-lsp-workspace-root ()
  "Print the root directory of the current lsp workspace."
  (interactive)
  (message "LSP Workspace Root: %s" (lsp-workspace-root)))

(setq user-mail-address "ph@alphaith.com")

;; gnus mail config
;; Get email, and store in nnml
(setq gnus-secondary-select-methods
      '(
        (nnimap "feishu"
                (nnimap-address
                 "imap.feishu.cn")
                (nnimap-server-port 993)
                (nnimap-stream ssl))
        ))

;; Send email via Gmail:
(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-default-smtp-server "smtp.feishu.cn")

;; Store email in ~/gmail directory
(setq nnml-directory "~/Documents/mail/alphaith")
(setq message-directory "~/Documents/mail/alphaith")

;; it's said this improve performance over tramp
;; ref https://sideshowcoder.com/2017/10/24/projectile-and-tramp/
(defadvice projectile-on (around exlude-tramp activate)
  "This should disable projectile when visiting a remote file"
  (unless  (--any? (and it (file-remote-p it))
                   (list
                    (buffer-file-name)
                    list-buffers-directory
                    default-directory
                    dired-directory))
    ad-do-it))
(setq projectile-mode-line "Projectile")

(setq pytest-cmd-flags "-x -s -v")

(push "~/src/env/spacemacs/g4z3" load-path)
(require 'thing-edit)

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
(global-set-key (kbd "M-s") 'thing-copy-symbol)
(global-set-key (kbd "M-y") 'thing-replace-symbol)
(global-set-key (kbd "C-s-n") 'origami-recursively-toggle-node)
