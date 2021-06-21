;;; $DOOMDIR/init.el -*- lexical-binding: t; -*-

(doom! :input

       :completion
       (company +tng)           ; the ultimate code completion backend
       (ivy +fuzzy)               ; a search engine for love and life

       :ui
       doom              ; what makes DOOM look the way it does
       (modeline +light)          ; snazzy, Atom-inspired modeline, plus API
       (window-select +switch-window +numbers)     ; visually switch windows
       (popup +defaults)   ; tame sudden yet inevitable temporary windows
       ;;doom-dashboard    ; a nifty splash screen for Emacs
       ;;treemacs          ; a project drawer, like neotree but cooler
       ;;tabs              ; an tab bar for Emacs
       ;;workspaces        ; tab emulation, persistence & separate workspaces
       ;;ligatures       ; ligatures or substitute text with pretty symbols
       ;;unicode           ; extended unicode support for various languages

       :editor
       multiple-cursors  ; editing in many places at once
       ;;(format +onsave)  ; automated prettiness
       ;;snippets          ; my elves. They type so I don't have to
       ;;file-templates    ; auto-snippets for empty files
       ;;fold              ; (nigh) universal code folding
       ;;(evil +everywhere); come to the dark side, we have cookies

       :emacs
       dired ;(dired +icons) ; making dired pretty [functional]
       (undo +tree)             ; persistent, smarter undo for your inevitable mistakes
       ;;(ibuffer +icons)         ; interactive buffer management

       :term
       eshell            ; the elisp shell that works everywhere
       term              ; basic terminal emulator for Emacs
       vterm             ; the best terminal emulation in Emacs

       :checkers
       syntax              ; tasing you for every semicolon you forget
       (spell +everywhere +aspell)             ; tasing you for misspelling mispelling
       ;;grammar           ; tasing grammar mistake every you make

       :tools
       (debugger +lsp)          ; FIXME stepping through code, to help you add bugs
       (lsp +peek)
       (magit +forge)             ; a git porcelain for Emacs
       lookup ;(lookup +dictionary +offine +docsets +xwidget) ;ripgrep, sqlite3, wordnet ; navigate your code and its documentation
       (pass +auth)              ; password manager for nerds
       ;;(docker +lsp)
       ;;pdf               ; pdf enhancements
       ;;ansible
       ;;make              ; run make tasks from Emacs
       ;;upload            ; map local to remote projects via ssh/ftp

       :lang
       emacs-lisp        ; drown in parentheses
       (org +gnuplot)               ; organize your plain life in plain text
       (scheme +guile)            ; a fully conniving family of lisps
       (cc +lsp)               ; C/C++/Obj-C madness
       (zig +lsp)
       ;;(clojure +lsp)           ; java with a lisp
       ;;(julia +lsp)             ; a better, faster MATLAB
       ;;(sh +lsp)                ; she sells {ba,z,fi}sh shells on the C xor
       ;;(rust +lsp)              ; Fe2O3.unwrap().unwrap().unwrap().unwrap()
       ;;(python +lsp)            ; beautiful is better than ugly
       ;;(web +lsp)               ; the tubes
       ;;(json +lsp)              ; At least it ain't XML
       ;;(yaml +lsp)              ; JSON, but readable
       ;;markdown          ; writing docs for people to ignore
       ;;ledger            ; an accounting system in Emacs
       ;;(javascript +lsp)       ; all(hope(abandon(ye(who(enter(here))))))
       ;;data              ; config/data formats
       ;;(java +meghanada +lsp) ; the poster child for carpal tunnel syndrome
       ;;(kotlin +lsp)            ; a better, slicker Java(Script)
       ;;(go +lsp)         ; the hipster dialect
       ;;latex             ; writing papers in Emacs has never been so fun

       :email

       :os
       ;;tty

       :app
       (rss +org)        ; emacs as an RSS reader

       :config
       (default +bindings)
       )
