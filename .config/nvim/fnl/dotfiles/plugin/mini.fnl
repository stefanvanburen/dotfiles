(module dotfiles.plugin.mini)

(let [(ok? pairs) (pcall require :mini.pairs)]
  (when ok?
    (pairs.setup)))

(let [(ok? trailspace) (pcall require :mini.trailspace)]
  (when ok?
    (trailspace.setup)))
