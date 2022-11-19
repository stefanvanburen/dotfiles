(module dotfiles.plugin.mason-lspconfig)

(let [(ok? mason-lspconfig) (pcall require :mason-lspconfig)]
  (when ok?
    (mason-lspconfig.setup)))
