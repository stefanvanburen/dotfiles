(module dotfiles.plugin.null-ls
  {autoload {: null-ls}})

(null-ls.setup
  {:sources [null-ls.builtins.diagnostics.buf]})
