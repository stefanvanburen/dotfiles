(module dotfiles.plugin.zk
  {autoload {: zk
             lsp dotfiles.lsp}})

(zk.setup {:picker "select"
           :lsp {:config {:on_attach lsp.on-attach}}})
