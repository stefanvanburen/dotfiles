(module dotfiles.plugin.fzf
  {autoload {: fzf-lua}})

;; https://github.com/ibhagwan/fzf-lua#neovim-api
(fzf-lua.register_ui_select)
;; https://github.com/ibhagwan/fzf-lua#default-options
(fzf-lua.setup {:winopts {:border :single}})
