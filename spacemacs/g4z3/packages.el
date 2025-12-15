;;; packages.el --- g4z3 layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2023 Sylvain Benner & Contributors
;;
;; Author: ph <ph@ph-work>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `g4z3-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `g4z3/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `g4z3/pre-init-PACKAGE' and/or
;;   `g4z3/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst g4z3-packages
  '(
    pyim
    pyim-basedict
    copilot
    copilot-chat
    git-auto-commit-mode
    move-text
    crux
    sqlite3
    ag
    org-mime
    texfrag
    ;; treesit-fold
    ;; undo-tree
    )
  "The list of Lisp packages required by the g4z3 layer.

Each entry is either:

1. A symbol, which is interpreted as a package to be installed, or

2. A list of the form (PACKAGE KEYS...), where PACKAGE is the
    name of the package to be installed or loaded, and KEYS are
    any number of keyword-value-pairs.

    The following keys are accepted:

    - :excluded (t or nil): Prevent the package from being loaded
      if value is non-nil

    - :location: Specify a custom installation location.
      The following values are legal:

      - The symbol `elpa' (default) means PACKAGE will be
        installed using the Emacs package manager.

      - The symbol `local' directs Spacemacs to load the file at
        `./local/PACKAGE/PACKAGE.el'

      - A list beginning with the symbol `recipe' is a melpa
        recipe.  See: https://github.com/milkypostman/melpa#recipe-format")

;; (defun g4z3/init-quelpa ()
;;   (use-package quelpa
;;     :ensure t)
;;   )

;; (defun g4z3/init-quelpa-use-package ()
;;   (use-package quelpa-use-package
;;     :ensure t)
;;   )

(defun g4z3/init-pyim ()
  ;; pyim settings
  (use-package pyim
    :config
    (setq default-input-method "pyim")
    ;; 显示5个候选词。
    (setq pyim-page-length 5)
    (require 'pyim-basedict)
    (pyim-basedict-enable)
    (pyim-default-scheme 'quanpin)
    ;; no fuzzy pinyin
    (setq pyim-pinyin-fuzzy-alist nil)
    ;; 半角标点符号
    (setq-default pyim-punctuation-translate-p '(no))
    ;; 设定默认输入法和切换热键
    ;; C-\\ already set to toggle-input-method by spacemacs
    ;; (global-set-key (kbd "C-\\") 'toggle-input-method)
    )
  )

(defun g4z3/init-pyim-basedict ()
  (use-package pyim-basedict
    :config
    (pyim-basedict-enable)
    )
  )

(defun g4z3/init-copilot ()
  (use-package copilot)
  )

(defun g4z3/init-copilot-chat ()
  (use-package copilot-chat)
  )

(defun g4z3/init-git-auto-commit-mode ()
  (use-package git-auto-commit-mode)
  )

(defun g4z3/init-move-text ()
  (use-package move-text)
  )

(defun g4z3/init-crux ()
  (use-package crux)
  )

(defun g4z3/init-sqlite3 ()
  (use-package sqlite3)
  )

(defun g4z3/init-ag ()
  (use-package ag)
  )

(defun g4z3/init-org-mime ()
  (use-package org-mime)
  )

(defun g4z3/init-texfrag ()
  ;; the following line setting variable is required
  ;; to fix a bug in auctex
  (setq TeX-active-tempdir "/tmp/texfrag")
  (use-package texfrag)
  )

;; (defun g4z3/init-undo-tree ()
;;   (use-package undo-tree)
;;   )

;; (defun g4z3/init-treesit-fold ()
;;   (use-package treesit-fold)
;;   )
