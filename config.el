;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


(setq user-full-name "Georgi Martsenkov"
;; Some functionality uses this to identify you, e.g. GPG configuration, email clients, file templates and snippets. (setq user-full-name "Georgi Martsenkov"
      user-mail-address "g.martsenkov@gmail.com")

(setq eglot-events-buffer-size 0)
(setq doom-font (font-spec :family "JetbrainsMono Nerd Font" :size 14 :weight 'medium))
(add-to-list 'safe-local-eval-forms '(set
                                      (make-local-variable 'lsp-disabled-clients)
                                      (setq lsp-disabled-clients '(ruby-ls))))
(add-to-list 'safe-local-eval-forms '(set
                                      (make-local-variable 'rspec-primary-source-dirs)
                                      (setq rspec-primary-source-dirs '("app" "apps" "lib"))))

(after! eglot
  (add-to-list 'eglot-server-programs '(elixir-mode "~/elixir-ls/release/language_server.sh")))

(setq doom-gruvbox-dark-variant "soft")
(setq lsp-enable-snippet nil)
(setq-default line-spacing 2)
(setq menu-bar-mode -1)
;(setq lsp-disabled-clients '())
;(setq lsp-disabled-clients '(ruby-ls))
(setq lsp-lens-enable nil)
;(setq lsp-sorbet-use-bundler t)
(setq lsp-enable-file-watchers nil)
(setq ruby-insert-encoding-magic-comment nil)
(setq rspec-primary-source-dirs '("app"))
;(setq rspec-primary-source-dirs '("app" "apps" "lib"))
(setq company-idle-delay .1)
(setq doom-modeline-buffer-encoding nil)
(setq doom-modeline-percent-position nil)
(global-visual-line-mode t)
(setq word-wrap 1)

(map! :leader :nv "t c" nil)
(map! :leader :nv "t l" nil)
(map! :leader :nv "t v" nil)
(map! :g "C-h" 'evil-window-left)
(map! :g "C-l" 'evil-window-right)
(map! :g "C-j" 'evil-window-down)
(map! :g "C-k" 'evil-window-up)

(setq projectile-per-project-compilation-buffer t)

(defun crystal-spec-project ()
  (interactive)
  (let ((compilation-read-command nil))
    (projectile-test-project nil)))

(map! :map crystal-mode-map
      :nv "SPC t t" #'crystal-spec-switch
      :nv "SPC t v" #'crystal-spec-buffer
      :nv "SPC t a" #'crystal-spec-project)

(map! :map ruby-mode-map
      :nv "SPC t t" #'rspec-toggle-spec-and-target
      :nv "SPC t v" #'rspec-verify
      :nv "SPC t l" #'rspec-run-last-failed
      :nv "SPC t c" #'rspec-verify-single
      :nv "SPC t a" #'rspec-verify-all
      :nv "SPC m b i" #'bundle-install
      :nv "SPC m p" #'rubocop-check-project)

(map! :map elixir-mode-map
      :nv "SPC t a" #'alchemist-mix-test
      :nv "SPC t v" #'alchemist-mix-test-this-buffer
      :nv "SPC t t" #'alchemist-project-toggle-file-and-tests)

(map! :map go-mode-map
      :nv "SPC t v" #'+go/test-single
      :nv "SPC t a" #'+go/test-all
      :nv "SPC t f" #'+go/test-rerun)

(after! popup
  (set-popup-rules!
    '(("^\\*rspec-compilation"
       :vslot -2 :size 0.5  :autosave t :quit t :ttl nil)
      ("^\\*Crystal-spec\\*$"
       :vslot -2 :size 0.4  :autosave t :quit t :ttl nil)
      ("^\\*compilation"
       :vslot -2 :size 0.4  :autosave t :quit t :ttl nil)
      ("^\\*Bundler"
       :vslot -2 :size 0.4  :autosave t :quit t :ttl nil)
      ("^\\*RuboCop"
       :vslot -2 :size 0.4  :autosave t :quit t :ttl nil)
      ("^\\*alchemist test report\\*$"
       :vslot -2 :size 0.5  :autosave t :quit t :ttl nil))))

(after! ivy
  (add-to-list 'all-the-icons-data/file-icon-alist '("crystal" . "\xE902"))
  (add-to-list 'all-the-icons-extension-icon-alist '("cr"      all-the-icons-fileicon "crystal"            :face all-the-icons-dsilver))
  (add-to-list 'all-the-icons-regexp-icon-alist '("_?spec\\.cr$"        all-the-icons-fileicon "crystal"   :face all-the-icons-dred)))

(after! polymode
  ;;(add-to-list 'web-mode-engines-alist '("phoenix" . "\\.ex\\'"))
  (define-hostmode poly-elixir-hostmode :mode 'elixir-mode)
  (define-innermode poly-liveview-expr-elixir-innermode
    :mode 'web-mode
    :head-matcher (rx line-start (* space) "~F" (= 3 (char "\"'")) line-end)
    :tail-matcher (rx line-start (* space) (= 3 (char "\"'")) line-end)
    :head-mode 'host
    :tail-mode 'host
    :allow-nested nil
    :keep-in-mode 'host
    :fallback-mode 'host)
  (define-polymode poly-elixir-web-mode
    :hostmode 'poly-elixir-hostmode
    :innermodes '(poly-liveview-expr-elixir-innermode))
  (setq auto-mode-alist (append '(("\\.ex$" . poly-elixir-web-mode)) auto-mode-alist)))

(add-to-list 'auto-mode-alist '("\\.\\(em\\|emblem\\)" . slim-mode))
(add-to-list 'auto-mode-alist '("\\.rbi" . ruby-mode))

(setq gofmt-command "goimports")
(add-hook 'before-save-hook 'gofmt-before-save)
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
(setq doom-theme 'doom-one)

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
