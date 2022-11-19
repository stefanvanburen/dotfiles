(module dotfiles.plugin.null-ls)

(let [(ok? null-ls) (pcall require :null-ls)]
  (when ok?
    (null-ls.setup
      {:sources [null-ls.builtins.diagnostics.buf
                 null-ls.builtins.formatting.buf
                 null-ls.builtins.diagnostics.stylelint
                 null-ls.builtins.diagnostics.shellcheck
                 null-ls.builtins.formatting.shfmt]})))
