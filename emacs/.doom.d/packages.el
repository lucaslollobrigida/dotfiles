;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

;; This is where you install packages, by declaring them with the `package!'
;; macro, then running 'doom refresh' on the command line. You'll need to
;; restart Emacs for your changes to take effect! Or at least, run M-x
;; `doom/reload'.
;;
;; WARNING: Don't disable core packages listed in ~/.emacs.d/core/packages.el.
;; Doom requires these, and disabling them may have terrible side effects.
;;
;; Here are a couple examples:


;; All of Doom's packages are pinned to a specific commit, and updated from
;; release to release. To un-pin all packages and live on the edge, do:
;(setq doom-pinned-packages nil)

;; ...but to unpin a single package:
;(package! pinned-package :pin nil)

(package! adoc-mode)
(package! color-identifiers-mode)
(package! evil-escape :disable t)
(package! evil-snipe :disable t)
(package! flycheck-clj-kondo)
(package! flymd)
(package! lispyville)
(package! sort-words)
(package! uuidgen)
(package! vlf)
