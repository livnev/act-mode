;;; act-mode.el --- Major mode for act -*- lexical-binding: t -*-

;; Copyright 2020 Lev Livnev and contributors
;; Author: Lev Livnev <lev@liv.nev.org.uk>
;; URL: https://github.com/livnev/act-mode
;; Version: 0.0.1

;;; Commentary:
;;
;; This package provides syntax highlighting for the act language.

;;; Code:

(defvar act-types '(
    "address"
    "bool"
    "bytes32"
    "int"
    "int256"
    "uint"
    "uint32"
    "uint48"
    "uint112"
    "uint256"
))

(defvar act-keywords
  '(
    "behaviour"
    "interface"
    "types"
    "storage"
    "iff"
    "if"
    "for all"
    "returns"
    "balance"
    "such that"
    "gas"
    "pc"
    "calls"
    "stack"
    ))

(defvar act-identifier-regexp
  "\\([a-zA-Z0-9]\\|-\\)+")

(defun match-regexp (re limit)
  "Generic regular expression matching wrapper for RE with a given LIMIT."
  (re-search-forward re
                     limit ; search bound
                     t     ; no error, return nil
                     nil   ; do not repeat
                     ))



(defun act-match-behaviour-decl (limit)
  "Search the buffer forward until LIMIT matching behaviour declarations.

First match should be a keyword and second an identifier."
  (match-regexp
   (concat
    " *\\(behaviour\\) +\\(" act-identifier-regexp "\\)")
   limit))

(defun act-match-interface-decl (limit)
  "Search the buffer forward until LIMIT matching behaviour declarations.

First match should be a keyword and second an identifier."
  (match-regexp
   (concat
    " *\\(interface\\) +\\(" act-identifier-regexp "\\)")
   limit))

(defvar act-identifier-regexp
  "\\([a-zA-z0-9]\\|_\\)+")


(defvar act-font-lock-defaults
  `((
     ;; stuff between double quotes
     ("\"\\.\\*\\?" . font-lock-string-face)
     ;; : => + - * / == > < >= <= |-> are all special elements
     (":\\|=>\\|+\\|-\\|*\\|/\\|==\\|<=\\|>=\\|>\\|<\\||->" . font-lock-builtin-face)
     ( ,(regexp-opt act-keywords 'words) . font-lock-keyword-face)
     ( ,(regexp-opt act-types 'words) . font-lock-type-face)
     (act-match-behaviour-decl (1 font-lock-keyword-face)
                                 (2 font-lock-variable-name-face))
     (act-match-interface-decl (1 font-lock-keyword-face)
                                 (2 font-lock-variable-name-face))

     )))

(defvar act-mode-syntax-table nil "Syntax table for `act-mode'.")

(setq act-mode-syntax-table
      (let ( (synTable (make-syntax-table)))
        ;; C++ style comment “// …”
        (modify-syntax-entry ?\/ ". 12b" synTable)
        (modify-syntax-entry ?\n "> b" synTable)
        synTable))

;;;###autoload
(define-derived-mode act-mode prog-mode "Act specification"
  "act-mode is a major mode for edting .act specifications."
  (setq font-lock-defaults act-font-lock-defaults)

  (set-syntax-table act-mode-syntax-table)
  ;; for comments
  (setq comment-start "//")
  (setq comment-end "")
)

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.act$" . act-mode))

(provide 'act-mode)

;;; act-mode.el ends here
