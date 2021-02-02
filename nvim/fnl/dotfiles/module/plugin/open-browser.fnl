(module dotfiles.module.plugin.open-browser
  {require {nvim aniseed.nvim}})

(set nvim.g.netrw_nogx 1)

(nvim.ex.command_
  "-nargs=1 Browse"
  "OpenBrowser <args>")

(nvim.set_keymap :n :gx "<plug>(openbrowser-smart-search)" {})
(nvim.set_keymap :v :gx "<plug>(openbrowser-smart-search)" {})
