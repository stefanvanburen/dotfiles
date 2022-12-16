(module dotfiles.plugin.mini)

(let [(ok? pairs) (pcall require :mini.pairs)]
  (when ok?
    (pairs.setup)))

(let [(ok? statusline) (pcall require :mini.statusline)]
  (when ok?
    (statusline.setup {:use_icons false})))

(let [(ok? trailspace) (pcall require :mini.trailspace)]
  (when ok?
    (trailspace.setup)))
