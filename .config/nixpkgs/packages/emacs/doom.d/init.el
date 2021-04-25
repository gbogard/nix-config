(doom!
       :config (default +bindings +smartparens)
       :tools
       (lsp +peek)
       lookup
       :editor
       (format +onsave)
       (evil +everywhere)
       snippets
       :os macos
       :completion
       (company +childframe)
       (ivy +fuzzy +icons)
       :ui 
       doom
       doom-dashboard
       (ligatures +fira)
       fill-column
       modeline
       (popup +defaults) 
       vc-gutter
       workspaces
       (treemacs +lsp)
       :lang
       emacs-lisp
       markdown
       yaml
       nix
       (rust +lsp)
       (web +lsp)
       (haskell +lsp))
