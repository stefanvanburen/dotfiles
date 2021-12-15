(module dotfiles.plugin.gitsigns
  {autoload {gitsigns gitsigns}})

(gitsigns.setup
  {:attach_to_untracked false
   ;; The only thing changed here is the signs for :add and :change
   :signs {:add          {:hl  "GitSignsAdd"    :text  "+" :numhl "GitSignsAddNr"    :linehl "GitSignsAddLn"}
           :change       {:hl  "GitSignsChange" :text  "~" :numhl "GitSignsChangeNr" :linehl "GitSignsChangeLn"}
           :delete       {:hl  "GitSignsDelete" :text  "_" :numhl "GitSignsDeleteNr" :linehl "GitSignsDeleteLn"}
           :topdelete    {:hl  "GitSignsDelete" :text  "‾" :numhl "GitSignsDeleteNr" :linehl "GitSignsDeleteLn"}
           :changedelete {:hl  "GitSignsChange" :text  "~" :numhl "GitSignsChangeNr" :linehl "GitSignsChangeLn"}}})
