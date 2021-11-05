(module dotfiles.plugin.telescope
  {autoload {telescope telescope}})

(telescope.setup)
(telescope.load_extension "fzf")
