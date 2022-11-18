(module dotfiles.plugin.null-ls
  {autoload {: null-ls
             lsp :dotfiles.lsp}})

(null-ls.setup
  {:sources [null-ls.builtins.diagnostics.buf
             null-ls.builtins.formatting.buf
             null-ls.builtins.diagnostics.stylelint
             null-ls.builtins.diagnostics.shellcheck
             null-ls.builtins.formatting.shfmt]})
