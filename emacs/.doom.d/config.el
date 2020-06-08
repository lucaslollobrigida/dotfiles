;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Lucas Lollobrigida"
      user-mail-address "lucas.lollobrigida@nubank.com.br")

(add-to-list 'default-frame-alist '(fullscreen . maximized))
(setq org-directory "~/org/")

(setq display-line-numbers-type 'relative)

(load-theme 'doom-vibrant t)

(setq confirm-kill-emacs nil)

(setq frame-title-format
      (setq icon-title-format
            '(""
              (:eval
               (format "[%s] " (projectile-project-name)))
              "%b")))

(setq doom-font (font-spec :family "monospace" :size 18)
      doom-big-font-increment 4
      doom-unicode-font (font-spec :family "DejaVu Sans"))

(add-hook! 'after-make-frame-functions
  (set-fontset-font t 'unicode
                    (font-spec :family "Font Awesome 5 Free")
                    nil 'append)
  (set-fontset-font t 'unicode
                    (font-spec :family "Font Awesome 5 Brands")
                    nil 'append))

(setq doom-localleader-key ",")

(setq evil-collection-setup-minibuffer t)

(map!
 (:prefix ("C-w")
   :n "s" (lambda () (interactive) (evil-window-split) (evil-window-down 1))
   :n "v" (lambda () (interactive) (evil-window-vsplit) (evil-window-right 1)))
 ; misc
 :n "-" #'dired-jump
 :nv ";" #'evil-ex
 :nv "C-a" #'evil-numbers/inc-at-pt
 :nv "C-S-a" #'evil-numbers/dec-at-pt
 :nv "C-SPC" #'+fold/toggle
 ; workspaces
 (:prefix ("`" . "workspace")
   :n "n" #'+workspace/new
   :n "]" #'+workspace/switch-right
   :n "[" #'+workspace/switch-left
   :n "d" #'+workspace/display
   :n "x" #'+workspace/delete
   :n "s" #'+workspace/save
   :n "l" #'+workspace/load
   :n "r" #'+workspace/rename)
 (:leader
   (:prefix "o"
     :desc "Visualize Undo Tree"
     "u" #'undo-tree-visualize)))

(after! ivy
  (set-face-attribute
   'ivy-minibuffer-match-face-1 nil :foreground nil)
  (set-face-attribute
   'ivy-minibuffer-match-face-2 nil :background nil))

(setq which-key-idle-delay 0.4)

(set-company-backend! :derived 'prog-mode
  #'company-files
  #'company-keywords)

(setq company-selection-wrap-around t)

(add-hook! dired-mode
  ;; Compress/Uncompress tar files
  (auto-compression-mode t)

  ;; Auto refresh buffers
  (global-auto-revert-mode t)

  ;; Also auto refresh dired, but be quiet about it
  (setq global-auto-revert-non-file-buffers t)
  (setq auto-revert-verbose nil)

  (setq dired-omit-verbose nil)
  (setq dired-hide-details-hide-symlink-targets nil)
  (make-local-variable 'dired-hide-symlink-targets)
  (dired-hide-details-mode t))

(after! doom-modeline
  (remove-hook 'doom-modeline-mode-hook #'size-indication-mode)
  (setq doom-modeline-major-mode-icon t))

(add-hook! hl-fill-column-mode
  (set-face-attribute 'hl-fill-column-face nil
                      :background (doom-color 'red)
                      :foreground (doom-color 'fg)))

(add-hook! projectile-mode
  (when (eq projectile-indexing-method 'alien)
    (setq projectile-enable-caching nil))
  (map!
   (:leader
     (:map projectile-mode-map
       (:prefix ("p" . "project")
         :desc "Find implementation or test in other window"
         "A" #'projectile-find-implementation-or-test-other-window
         :desc "Replace literal"
         "R" #'projectile-replace
         :desc "Replace using regexp"
         "X" #'projectile-replace-regexp)))))

(add-to-list 'auto-mode-alist '("\\.adoc\\'" . adoc-mode))
(add-to-list 'auto-mode-alist '("\\.repl\\'" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.joker\\'" . clojure-mode))

(add-hook! clojure-mode
  (setq cljr-warn-on-eval nil
        cljr-eagerly-build-asts-on-startup nil
        cider-show-error-buffer 'only-in-repl)
  (require #'flycheck-clj-kondo)
  (map!
   (:map clojure-mode-map
     (:n "R" #'hydra-cljr-help-menu/body)
     (:localleader
       ("a" #'clojure-align)
       (:prefix ("h" . "help")
         "D" #'cider-clojuredocs)
       (:prefix ("e" . "eval")
         "b" #'cider-load-buffer
         "p" #'cider-pprint-eval-last-sexp
         "P" #'cider-pprint-eval-last-sexp-to-repl
         "f" #'cider-eval-sexp-at-point
         "n" #'cider-eval-ns-form
         "c" #'cider-read-and-eval-defun-at-point
         "C" #'user/cider-read-eval-and-call-defun-at-point)
       (:prefix ("n" . "namespace")
         "r" #'cider-ns-refresh
         "R" #'cider-ns-reload)
       (:prefix ("t" . "test")
         "c" #'cider-test-clear-highlights
         "f" #'cider-test-rerun-failed-tests
         "n" #'cider-test-run-ns-tests
         "p" #'cider-test-run-project-tests
         "r" #'cider-test-show-report
         "t" #'cider-test-run-test
         "l" #'cider-test-run-loaded-tests
         "N" #'user/cider-eval-and-run-ns-tests
         "T" #'user/cider-eval-and-run-test)
       (:prefix ("r" . "repl")
         "'" #'cider-connect
         "i" #'cider-interrupt
         "\"" #'cider-connect-cljs)))))

(add-hook! emacs-lisp-mode
  (map!
   (:map emacs-lisp-mode-map
     (:localleader
       "e" nil ; Unmap macrostep-expand
       "x" #'macrostep-expand
       :desc "REPL"
       "r" #'+emacs-lisp/open-repl
       (:prefix ("e" . "eval")
         "b" #'eval-buffer
         "d" #'eval-defun
         "r" #'eval-region)))))

(add-hook! markdown-mode
  (map!
   (:map markdown-mode-map
     (:localleader
       ("f" #'flymd-flyit)))))

(use-package! color-identifiers-mode
  :config
  (add-hook #'after-init-hook #'global-color-identifiers-mode))

(use-package! lispyville
  :hook ((common-lisp-mode . lispyville-mode)
         (emacs-lisp-mode . lispyville-mode)
         (scheme-mode . lispyville-mode)
         (racket-mode . lispyville-mode)
         (hy-mode . lispyville-mode)
         (lfe-mode . lispyville-mode)
         (clojure-mode . lispyville-mode))
  :config
  (lispyville-set-key-theme
   `(additional
     additional-insert
     (additional-movement normal visual motion)
     (additional-wrap normal insert)
     (atom-movement t)
     c-w
     (commentary normal visual)
     (escape insert emacs)
     (operators normal)
     prettify
     text-objects
     slurp/barf-cp)))

;; lsp-mode
; (use-package! lsp-mode
;   :hook ((clojure-mode . lsp))
;   :commands lsp
;   :init
;   (setq lsp-enable-indentation nil
;         lsp-prefer-flymake nil)

;   :config
;   (dolist (m '(clojure-mode
;                clojurec-mode
;                clojurescript-mode
;                clojurex-mode))
;     (add-to-list 'lsp-language-id-configuration `(,m . "clojure"))))

(use-package! sort-words
  :config
  (require 'sort-words))

(use-package! uuidgen
  :config
  (require 'uuidgen)
  (map!
   (:leader
     (:prefix ("i" . "insert")
       :desc "Insert UUIDv4"
       "u" #'uuidgen))))

(use-package! vlf
  :config
  (require 'vlf-setup))

;; load local configuration file if exists
(load! "local.el" "~/.doom.d" t)
