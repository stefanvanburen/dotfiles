(module dotfiles.init
  {require [;; must require first, to setup <leader> and <localleader>
            dotfiles.core
            dotfiles.autocmd
            dotfiles.plugin
            dotfiles.mapping
            dotfiles.diagnostic
            dotfiles.lsp]})
