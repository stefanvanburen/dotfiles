(module dotfiles.plugin.mini)

(let [(ok? mini-pairs) (pcall require :mini.pairs)]
  (when ok?
    (mini-pairs.setup)))

(let [(ok? mini-trailspace) (pcall require :mini.trailspace)]
  (when ok?
    (mini-trailspace.setup)))
