(module dotfiles.plugin.null-ls
  {autoload {: null-ls
             lsp "dotfiles.lsp"}})

(null-ls.setup
  {:sources [null-ls.builtins.diagnostics.buf
             null-ls.builtins.formatting.buf
             null-ls.builtins.diagnostics.eslint
             null-ls.builtins.formatting.prettier]
   :on_attach lsp.on-attach})
