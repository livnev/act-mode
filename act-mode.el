(defvar act-types
  '("uint256"
    "uint48"
    "int256"
    "address"
    "bytes32"))

(defvar act-keywords
  '("behaviour" "interface" "types" "storage" "iff" "if" "returns" "balance"))

(defvar act-font-lock-defaults
  `((
     ;; stuff between double quotes
     ("\"\\.\\*\\?" . font-lock-string-face)
     ;; : => + - * / == > < >= <= |-> are all special elements
     (":\\|=>\\|+\\|-\\|*\\|/\\|==\\|>\\|<\\|>=\\|<=\\||->" . font-lock-keyword-face)
     ( ,(regexp-opt act-keywords 'words) . font-lock-builtin-face)
     ( ,(regexp-opt act-types 'words) . font-lock-type-face)
     )))

(defvar act-mode-syntax-table nil "Syntax table for `act-mode'.")

(setq act-mode-syntax-table
      (let ( (synTable (make-syntax-table)))
        ;; C++ style comment “// …”
        (modify-syntax-entry ?\/ ". 12b" synTable)
        (modify-syntax-entry ?\n "> b" synTable)
        synTable))

(define-derived-mode act-mode fundamental-mode "Act specification"
  "act-mode is a major mode for edting .act specifications."
  (setq font-lock-defaults act-font-lock-defaults)

  (set-syntax-table act-mode-syntax-table)
  ;; for comments
  (setq comment-start "//")
  (setq comment-end "")
)

(provide 'act-mode)
