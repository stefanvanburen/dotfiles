(module dotfiles.module.plugin.vim-better-whitespace
  {require {util dotfiles.util}})

(util.nnoremap :sw "StripWhitespace")
