(module dotfiles.module.plugin.vim-sneak
  {require {util dotfiles.util
            nvim aniseed.nvim}})

(set nvim.g.sneak#s_next 1)

(nvim.ex.map :f "<plug>Sneak_f")
(nvim.ex.map :F "<plug>Sneak_F")
(nvim.ex.map :t "<plug>Sneak_t")
(nvim.ex.map :T "<plug>Sneak_T")
