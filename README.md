# act-mode
*Author: Lev Livnev*

*License: AGPLv3*

Simple emacs major mode for editing `.act` specifications. It provides syntax highlighting and comment integration.

## installation
Place `act-mode.el` into `~/.emacs.d/packages`, and then add the following to your prelude file:

```
(load-library "act-mode/act-mode")
(add-to-list 'auto-mode-alist '("\\.act" . act-mode))
```

This makes `.act` files open with `act-mode`. It's recommended to use this together with the `poly-markdown-mode` package, which enables `act-mode` within the tagged code blocks of a literature markdown specification. All you need to do is install `poly-markdown-mode` and add the following to your prelude file:

```
;; polymode for .md files
(add-to-list 'auto-mode-alist '("\\.md" . poly-markdown-mode))
```
