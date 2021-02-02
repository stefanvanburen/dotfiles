(module dotfiles.module.plugin.pear-tree
  {require {nvim aniseed.nvim}})

;; dispatch will open up a tmux window by default to do certain things - I
;; don't want this to occur by default since it'll 'un-zoom' tmux if I'm
;; zoomed on a pane.
(set nvim.g.dispatch_no_tmux_make 1)
