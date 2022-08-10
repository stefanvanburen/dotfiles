(module dotfiles.plugin.null-ls
  {autoload {: null-ls
             lsp "dotfiles.lsp"}})

(null-ls.setup
  {:sources [null-ls.builtins.diagnostics.buf
             null-ls.builtins.formatting.buf]
   :on_attach lsp.on-attach})
