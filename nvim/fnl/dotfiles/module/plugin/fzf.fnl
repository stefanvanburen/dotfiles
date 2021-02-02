(module dotfiles.module.plugin.fzf
  {require {nvim aniseed.nvim
            util dotfiles.util}})

(nvim.ex.command_
  "-bang -nargs=* Rg"
  "call fzf#vim#grep(\""
  "rg --column --line-number --no-heading --color=always --smart-case --hidden --follow -g '!.git/'"
  "-- \".shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)")

(defn- map [from to]
  (util.nnoremap
    from
    (.. ":" to)))

(map :f "Files")
(map :<enter> "GitFiles")
(map :<leader> "Buffers")
(map :se "Rg")

(set nvim.g.fzf_layout {:window {:width 1.0 :height 0.5 :yoffset 1.0 :border :top} })

(nvim.set_keymap :n :<leader><tab> "<plug>(fzf-maps-n)" {})
(nvim.set_keymap :x :<leader><tab> "<plug>(fzf-maps-x)" {})
(nvim.set_keymap :o :<leader><tab> "<plug>(fzf-maps-o)" {})
