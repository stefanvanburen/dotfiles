(module dotfiles.module.plugin.vim-fugitive
  {require {util dotfiles.util
            nvim aniseed.nvim}})

(util.nnoremap :gs "vertical Git")
(util.nnoremap :gw "Gwrite")
(util.nnoremap :gc "Gcommit")
(util.nnoremap :gb "GBrowse")
(util.nnoremap :gy ".GBrowse!")

; (nvim.set_keymap :x :<leader>gb ":'<'>GBrowse<cr>" {})
; (nvim.set_keymap :x :<leader>gy ":'<'>GBrowse!<cr>" {})
