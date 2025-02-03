;; main emacs config file.

;; set package save location
(setq package-user-dir "~/.config/emacs-pak/")

;; some basic modes

(menu-bar-mode 1)
(scroll-bar-mode 1)
(tool-bar-mode -1)
(save-place-mode 1) ; remember / restore cursor position of opened files
(recentf-mode 1) ; tell emacs to remember recently edited files

;; line numbering
(setq display-line-numbers-type 'relative) 
(global-display-line-numbers-mode 1)

;; Save what you enter into minibuffer prompts
(setq history-length 25)
(savehist-mode 1)

;; Don't pop up UI dialogs when prompting
(setq use-dialog-box nil)

;; Revert buffers when the underlying file has changed
(global-auto-revert-mode 1)

;; Revert Dired and other buffers
(setq global-auto-revert-non-file-buffers t)

;; font size
(set-face-attribute 'default nil :height 145)

;; some basic variables

(setq inhibit-startup-message t) ; remove startup message
(setq visible-bell nil) ; add highlighted line with bell sound
(setq ring-bell-function 'ignore)
(setq package-check-signature 'allow-unsigned) ; set variable to defalut

;; initialize package sources
(require 'package) ; brings into the env the package management functions

;; set up package archives
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                       ("gnu" . "https://elpa.gnu.org/packages/")
                       ("nongnu" . "https://elpa.nongnu.org/nongnu/")))

(package-initialize) ; initializes the package system and prepares it for use
(unless package-archive-contents ; check for pkg list / unless pkg list exists
  (package-refresh-contents)) ; then refresh the package list

;; Initialize use-package
(unless (package-installed-p 'use-package) ; check if package is installed
   (package-install 'use-package)) ; if not, install it

(require 'use-package) ;; load use-package
(setq use-package-always-ensure t) ;; ensures use-package will try to download current pkg

;;; vim bindings

(use-package evil
  :demand t
  :bind (("<escape>" . keyboard-escape-quit))
  :init
  ;; allows for using cgn
  ;; (setq evil-search-module 'evil-search)
  (setq evil-want-keybinding nil)
  ;; no vim insert bindings
  (setq evil-undo-system 'undo-fu)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :config
  (setq evil-want-integration t)
  (evil-collection-init))

;; erc settings for irc
(setq erc-server "irc.libera.chat"
      erc-nick "dldev"
      erc-user-full-name "Dave Long"
      erc-track-shorten-start 8
      ; erc-autojoin-channels-alist '(("irc.libera.chat" "#systemcrafters"))
      erc-kill-buffer-on-part t
      erc-auto-query 'bury
      ; erc-default-server '("irc.libera.chat" :port 6667 :channels '("#emacs")))
(setq erc-autojoin-channels-alist
      '(("Libera.Chat" "#emacs" "#erc" "#systemcrafters")))

;; themes
(use-package gruvbox-theme)
(use-package catppuccin-theme)
(load-theme 'catppuccin t)

;; Move customization variables to a separate file and load it
(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)

;; which key

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 2))

;; set up command logging
;; (use-package command-log-mode)

;; rainbow delimiters for matching color parens

(use-package rainbow-delimiter
  :hook (prog-mode . rainbow-delimiters-mode))
