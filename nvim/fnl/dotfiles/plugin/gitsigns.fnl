(module dotfiles.plugin.gitsigns
  {autoload {gitsigns gitsigns}})

(gitsigns.setup
  {:attach_to_untracked false})
