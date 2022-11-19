(module dotfiles.plugin.flit)

(let [(ok? flit) (pcall require :flit)]
  (when ok?
    (flit.setup)))
