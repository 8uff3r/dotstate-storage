;;; config.el -*- lexical-binding: t; -*-
(setq doom-theme 'catppuccin)
(setq catppuccin-flavor 'mocha) ;; or 'latte, 'macchiato, or 'frappe
(after! 'catppuccin
(require 'catppuccin)
(catppuccin-reload))
(setq font-lock-maximum-decoration 4)
(setq display-line-numbers-type 'relative)
(setq scroll-margin 8)
(setq maximum-scroll-margin 8)
(map! :map +dashboard-mode-map
      :ne "f" #'find-file
      :ne "n j" #'org-journal-new-entry
      :ne "f j" (cmd! (doom-project-find-file "/home/rylan/Documents/journal"))
      :ne "r" #'consult-recent-file
      :ne "a" #'org-agenda
      :ne "p" #'projectile-switch-project
      :ne "." (cmd! (doom-project-find-file "~/.config/")) ; . for dotfiles
      :ne "B" #'consult-buffer
      :ne "h" #'doom/help
      :ne "e" #'emms-run
      :ne "b" #'bookmark-jump
      :ne "q" #'save-buffers-kill-terminal
      :ne "l" #'doom/quickload-session
      :ne "c" #'doom/open-private-config
      (:leader
       :nme "e" #'eval-last-sexp
       :nme "r" 'nil
       :nme "l" 'nil
       :nme "p p" 'nil
       :nme "h d h" 'nil
       :nm "w f" (cmd! (run-in-background "~/Desktop/WIFI-fix"))))
(add-hook! '+doom-dashboard-mode-hook (hide-mode-line-mode 1) (hl-line-mode -1))
(setq-hook! '+doom-dashboard-mode-hook evil-normal-state-cursor (list nil))
;; (add-hook! 'doom-switch-buffer-hook (+nav-flash-blink-cursor-maybe)) ; ponytail: nav-flash not installed
(tool-bar-mode -1)
(menu-bar-mode -1)
(savehist-mode -1)

(setq scroll-step 1)
(setq confirm-kill-processes nil)

(setq display-line-numbers-type t)

(setq org-directory "~/org/")

(setq doom-font (font-spec :family "JetBrainsMono Nerd Font Mono" :size 17)
      doom-big-font (font-spec :family "JetBrainsMono Nerd Font Mono" :size 20)
      doom-variable-pitch-font (font-spec :family "JetBrainsMono Nerd Font Mono" :size 19)
      doom-unicode-font (font-spec :family "JetBrainsMono Nerd Font Mono")
      doom-serif-font (font-spec :family "JetBrainsMono Nerd Font Mono" :weight 'light))

(after! treesit
  (setq treesit-language-source-alist
        '((vue "https://github.com/ikatyang/tree-sitter-vue")
          (css "https://github.com/tree-sitter/tree-sitter-css")
          (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
          (odin "https://github.com/tree-sitter-grammars/tree-sitter-odin")
          (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")))
  )


;; (set-face-foreground 'font-lock-variable-name-face "violet")
;; (set-face-foreground 'font-lock-property-name-face "dark orange")
;; (set-face-foreground 'font-lock-operator-face "dodger blue")
;; (set-face-foreground 'font-lock-punctuation-face "deep sky blue")
(setq treesit-font-lock-level 4)
(require 'vue-ts-mode)

(use-package! odin-ts-mode
  :mode "\\.odin\\'")

(defun set-bidi-env ()
  (interactive)
  (setq bidi-paragraph-direction 'nil))
(defun set-bidi-right()
  (interactive)
  (setq bidi-paragraph-direction 'right-to-left))
(defun set-bidi-left()
  (interactive)
  (setq bidi-paragraph-direction 'left-to-right))
(defun zz/org-reformat-buffer ()
  (interactive)
  (when (y-or-n-p "Really format current buffer? ")
    (let ((document (org-element-interpret-data (org-element-parse-buffer))))
      (erase-buffer)
      (insert document)
      (goto-char (point-min)))))

(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                treemacs-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))
(use-package! org
  :mode ("\\.org\\'" . org-mode)
  :hook ((org-mode . visual-line-mode)
         (org-mode . org-indent-mode)
         (org-mode . show-smartparens-mode)
         ;; (org-mode . org-auto-tangle-mode)
         (org-mode . variable-pitch-mode))
  :custom
  (org-directory "~/Documents/org/")
  (org-hide-emphasis-markers t)
  (bidi-paragraph-direction nil)
  (org-support-shift-select t)
  (org-auto-tangle-default t)
  :config
  (map! :map org-mode-map
        :niem "C-s-p" #'org-shiftup
        :niem "C-s-n" #'org-shiftdown)
  (defface org-level-1 '((t :inherit outline-1 :height 1.75 :family "Vazir" :weight bold))
    "Face used for level 1 headlines."
    :group 'org-faces)
  (defface org-level-2 '((t :inherit outline-2 :height 1.5))
    "Face used for level 2 headlines."
    :group 'org-faces)
  (defface org-level-3 '((t :inherit outline-3 :height 1.25))
    "Face used for level 3 headlines."
    :group 'org-faces)
  (defface org-level-4 '((t :inherit outline-4 :height 1.1))
    "Face used for level 4 headlines."
    :group 'org-faces)
  (set-face-attribute
   'org-level-1 nil
   :height 1.3)
  (set-face-attribute
   'org-level-2 nil
   :height 1.2)
  (set-face-attribute
   'org-level-3 nil
   :height 1.1)

  (deftheme org)
  (custom-theme-set-faces
   'org
   '(variable-pitch ((t (:family "JetBrainsMono Nerd Font Mono" :height 180 :weight regular))))
   '(fixed-pitch ((t ( :family "JetBrainsMono Nerd Font Mono" :height 160)))))
  (custom-theme-set-faces
   'org
   '(org-block ((t (:inherit fixed-pitch :height 0.9))))
   '(org-code ((t (:inherit (shadow fixed-pitch)))))
   '(org-document-info ((t (:foreground "dark orange"))))
   '(org-document-info-keyword ((t (:inherit (shadow fixed-pitch)))))
   '(org-indent ((t (:inherit (org-hide fixed-pitch)))))
   '(org-link ((t (:foreground "royal blue" :underline t))))
   '(org-meta-line ((t (:inherit (font-lock-comment-face fixed-pitch)))))
   '(org-property-value ((t (:inherit fixed-pitch))) t)
   '(org-special-keyword ((t (:inherit (font-lock-comment-face fixed-pitch)))))
   '(org-table ((t (:inherit fixed-pitch :foreground "#83a598"))))
   '(org-tag ((t (:inherit (shadow fixed-pitch) :weight bold :height 0.8))))
   '(org-verbatim ((t (:inherit (shadow fixed-pitch))))))
  (add-hook 'org-mode-hook (lambda () (eldoc-mode -1)))
  (defun ts-no-hook-mode ()
    (let ((typescript-ts-mode-hook nil))
      (message typescript-ts-mode-hook)
      (typescript-ts-mode)))
  (define-derived-mode org-ts-mode ts-no-hook-mode "org-ts")
  (add-to-list 'org-src-lang-modes (cons "tsc" 'org-ts)))

(defun kill-buffer-and-window()
  "Kill both buffer and its window"
  (interactive)
  (kill-current-buffer)
  (delete-window))
(setq mouse-autoselect-window t
      focus-follows-mouse t)
(define-key evil-normal-state-map "\C-h" nil)
(define-key evil-normal-state-map "\C-l" nil)
(define-key evil-normal-state-map "H" nil)
(define-key evil-normal-state-map "L" nil)
(map! :map org-mode-map
      ("M-S-RET" nil)
      ("M-S-<return>" nil)
      (:n "M-<return>" nil)
      ("M-RET" nil)
      ("C-'" nil))
(map!
 "M-p" #'forward-char
 "M-n" #'backward-char
 "s-v" #'consult-yank-from-kill-ring
 "C-'" #'+vterm/toggle
 "M-RET" 'nil
 "M-RET" #'my/ghostel-sidebar
 (:map vterm-mode-map
  :nmi "C-M-l" #'vterm-clear
  :nm "C-g" #'+vterm/toggle)
 (:map equake-mode-map
  :nm "C-g" #'quit-window
  :nm "<escape>" (cmd! (delete-frame nil t)))
 (:map term-mode-map
  :nm "<escape>" (cmd! (delete-window))
  :nm "C-g" (cmd! (delete-window)))
 "C-:" #'comment-region
 "C-:" #'uncomment-region
 (:leader
  :nm "f ." (cmd! (let ((default-directory "~/"))
                    (call-interactively #'find-file)))
  :nmi "z z" #'zoom-window-zoom
  :nmi "z n" #'zoom-window-next
  :nm "l" #'evil-delete-whole-line
  :nm "b v" (cmd! (switch-to-buffer "► Doom"))
  :nm "k" #'kill-buffer-and-window
  :nm "m" #'consult-buffer
  :nm "C-," #'centaur-tabs-switch-group
  ;; "s f" 'nil
  "e" 'nil
  :nm "s f" #'+vertico/project-search
  :nm "e" #'+treemacs/toggle
  :nm "r" #'consult-recent-file
  :nm "o e" (cmd!
             (multi-term-dedicated-toggle)
             (multi-term-dedicated-select))
  :nm "f g" #'consult-ripgrep
  :nm "v" #'+default/yank-pop
  :nm "c n" (cmd! (run-in-background "dcnnt start")))
 :ne "C-n" #'evil-next-visual-line
 :ne "C-p" #'evil-previous-visual-line
 :i "C-a" #'move-beginning-of-line
 :i "C-e" #'end-of-line
 :nm "C-h" #'evil-window-left
 :nm "C-l" #'evil-window-right
 :nm "C-j" #'evil-window-down
 :nm "C-k" #'evil-window-up
 :nm "L" #'centaur-tabs-forward
 :nm "H" #'centaur-tabs-backward
 :map Info-mode-map
 :ne "k" #'Info-next-preorder
 :ne "j"
 #'Info-last-preorder)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(global-set-key (kbd "M-<return>") 'nil)
;; (define-key key-translation-map (kbd "<escape>") (kbd "C-g"))
(use-package! evil
  :custom
  (evil-disable-insert-state-bindings t))

(use-package! rainbow-delimiters
  :hook ((typescript-ts-mode . rainbow-delimiters-mode)
         (vue-ts-mode . rainbow-delimiters-mode)))

(set-formatter!
  'oxfmt
  `(,(expand-file-name "~/.bun/bin/oxfmt")
    (format "--stdin-filepath=%s" (or buffer-file-name mode-result "")))
  :modes
  '(typescript-ts-mode vue-ts-mode js-json-mode))

(set-formatter! 'odinfmt
  `("odinfmt" "-stdin")
  :modes '(odin-ts-mode))
(setq-hook! 'typescript-ts-mode +format-with 'oxfmt)
(setq-hook! 'js-json-mode +format-with 'oxfmt)
(setq-hook! 'vue-ts-mode +format-with 'oxfmt)
(setq-hook! 'odin-ts-mode +format-with 'odinfmt)

;; ponytail: eglot-typescript-preset wires Vue/TS/TSX/CSS eglot clients + hooks
;; automatically on Eglot load, including vue-ts-mode and hybridmode TSDK setup.
(use-package! eglot-typescript-preset
  :after eglot
  :config
  (eglot-typescript-preset-setup)
  (setopt eglot-typescript-preset-vue-lsp-server 'rass)
  (setopt eglot-typescript-preset-vue-rass-tools
          '(vue-language-server typescript-language-server
            tailwindcss-language-server))
  )

(use-package! ghostel
  :custom
  (ghostel-shell "/usr/bin/fish")
  (ghostel-max-scrollback 524288000)
  :config
  (set-face-attribute 'ghostel-default nil
                    :foreground "#cdd6f4"
                    :background "#1e1e2e"
                    :family "JetBrains Mono Nerd Font"))
(defun my/ghostel-sidebar ()
  "Open a window on the right (25% of frame width) and run +ghostel/here."
  (interactive)
  (let* ((target-width (truncate (* 0.30 (frame-width))))
         ;; Passing a negative number to split-window-right assigns
         ;; that exact column width to the NEW window.
         (new-window (split-window-right (- target-width))))

    ;; Move focus to the newly created window
    (select-window new-window)

    ;; Run the command (using call-interactively is best practice
    ;; just in case the function expects interactive arguments)
    (call-interactively #'+ghostel/here)))

(use-package! vterm
  :custom
  (vterm-shell "/usr/bin/fish"))

(setq
 gptel-model 'nanogpt/zai-org/glm-5.2
 gptel-backend (gptel-make-openai "Omniroute"
                 :protocol "http"
                 :host "localhost:20128"
                 :key 'nil
                 :stream t ;; optionally enable streaming
                 :models '(Super nanogpt/zai-org/glm-5.2)))

(setq gptel-use-curl 'nil)

;; (gptel-make-preset 'glmcoding                       ;preset name, a symbol
;;   :description "A preset optimized for coding tasks" ;for your reference
;;   :backend "ChatGPT"
;;   :model 'nanogpt/zai-org/glm-5.2
;;   :system "You are an expert coding assistant. Your role is to provide high-quality code solutions, refactorings, and explanations."
;;   :tools '("read_buffer" "modify_buffer"))
(setq gptel-model "nanogpt/zai-org/glm-5.2")

(add-to-list 'load-path "/home/rylan/GitClones/superchat")
(load-file "/home/rylan/.config/doom/universal-launcher.el")
(require 'universal-launcher)
(require 'superchat)

;; (setq superchat-llm-backend
;;       (make-llm-openai
;;        :key (getenv "OPENAI_API_KEY")
;;        :chat-model "nanogpt/zai-org/glm-5.2"))

(require 'acp)
(require 'agent-shell)

(use-package! claude-code-ide
  :bind ("C-c C-'" . claude-code-ide-menu) ; Set your favorite keybinding
  :custom
  (claude-code-ide-terminal-backend 'ghostel)
  (claude-code-ide-window-width 50)
  :config
  (claude-code-ide-emacs-tools-setup) ; Optionally enable Emacs MCP tools
  (map! :niem "C-," #'claude-code-ide-toggle))

(use-package! centaur-tabs
  :custom
  (centaur-tabs-enable-ido-completion 'nil))

(use-package! projectile
  :bind
  ("M-[" . #'+workspace/switch-left)
  ("M-]" . #'+workspace/switch-right))

(after! centaur-tabs
  (setq centaur-tabs-set-bar 'right))

(setq sly-lisp-implementations
      '((sbcl ("sbcl") :coding-system utf-8-unix)
        (qlot ("qlot" "exec" "sbcl") :coding-system utf-8-unix)))

(connection-local-set-profile-variables
 'remote-direct-async-process
 '((tramp-direct-async-process . t)))

(connection-local-set-profiles
 '(:application tramp :protocol "scp")
 'remote-direct-async-process)

(setq magit-tramp-pipe-stty-settings 'pty)

(use-package! treemacs
  :custom
  (treemacs-follow-mode 't))
