(module dotfiles.init
  {require [dotfiles.plugin ; must require first
            dotfiles.autocmd
            dotfiles.core
            dotfiles.mapping
            dotfiles.lsp]})
