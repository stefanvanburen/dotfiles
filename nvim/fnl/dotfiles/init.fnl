(module dotfiles.init
  {autoload {nvim aniseed.nvim}})

(nvim.set_option :termguicolors true)

;; require plugins first
(require :dotfiles.plugin)

(require :dotfiles.autocmd)
(require :dotfiles.core)
(require :dotfiles.mapping)
(require :dotfiles.lsp)
(require :dotfiles.statusline)
