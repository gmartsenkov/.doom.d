;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Georgi Martsenkov"
      user-mail-address "g.martsenkov@gmail.com")

(setq lsp-enable-file-watchers nil)
(setq lsp-clients-elixir-server-executable "~/elixir-ls/release/language_server.sh")
(setq rustic-lsp-server 'rust-analyzer)
(setq ruby-insert-encoding-magic-comment nil)
(setq rspec-primary-source-dirs '("app"))
(setq company-idle-delay .5)
(setq doom-modeline-buffer-encoding nil)
(setq doom-modeline-percent-position nil)
(global-visual-line-mode t)
(setq word-wrap 1)

(global-set-key (kbd "C-c a r") 'anzu-query-replace-regexp)
(global-set-key (kbd "s-d") 'duplicate-thing)
(global-set-key (kbd "M-o") 'ace-window)

(map! "s-b" 'xref-find-definitions)
(map! :map ruby-mode-map
       "s-." 'rspec-toggle-spec-and-target)
(map! :map elixir-mode-map
       "s-." 'projectile-toggle-between-implementation-and-test)
(map! :map ruby-mode-map
       "C-c ." 'rspec-toggle-spec-and-target)
(map! :map elixir-mode-map
       "C-c ." 'projectile-toggle-between-implementation-and-test)
(map! :map clojure-mode-map
       "C-c ." 'projectile-toggle-between-implementation-and-test)
;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:

(setq doom-gruvbox-dark-variant "soft")
(setq doom-theme 'doom-gruvbox)
(setq doom-font (font-spec :family "JetbrainsMono Nerd Font Mono" :size 15))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;;

(after! circe
  (set-irc-server! "localhost"
    `(:port 6667
      :sasl-username "gogo"
      :nick "gogo")))
