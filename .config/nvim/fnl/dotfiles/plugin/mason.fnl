(module dotfiles.plugin.mason)

(let [(ok? mason) (pcall require :mason)]
  (when ok?
    (mason.setup)))
