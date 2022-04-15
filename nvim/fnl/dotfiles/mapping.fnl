(module dotfiles.mapping)

;; alias function
(def map vim.keymap.set)

(defn- leader-map [from to]
  "Helper function to add a mapping prefixed with leader to execute a command,
  typically from a plugin."
  (map
    :n
    (.. "<leader>" from)
    (.. ":" to "<cr>")
    {:noremap true}))

;; ; -> :
(map :n ";" ":")

;; Leader is space key
(set vim.g.mapleader " ")
;; LocalLeader is the comma key
(set vim.g.maplocalleader ",")

;; packer
;; Clean, update and install plugins, then regenerate compiled loader file.
;; PackerUpdate -> PackerCompile
;; This is essentially always what we want to run.
(leader-map :pu "PackerSync")

;; Fugitive
(leader-map :gs "vertical Git")
(leader-map :gw "Gwrite")
(leader-map :gc "G commit")
(leader-map :gp "G push")
(leader-map :gb "G blame")

;; vim-better-whitespace
(leader-map :sw "StripWhitespace")

;; fzf - https://github.com/junegunn/fzf.vim
(leader-map :f "Files")
(leader-map :<enter> "GitFiles")
(leader-map :<leader> "Buffers")
(leader-map :se "Rg")

(map :n :<leader><tab> "<plug>(fzf-maps-n)" {})
(map :x :<leader><tab> "<plug>(fzf-maps-x)" {})
(map :o :<leader><tab> "<plug>(fzf-maps-o)" {})

;; open-browser.vim
(map :n :gx "<plug>(openbrowser-smart-search)" {})
(map :v :gx "<plug>(openbrowser-smart-search)" {})

;; always move by visual lines, rather than real lines
;; this is useful when 'wrap' is set.
(map :n :j :gj)
(map :n :k :gk)
(map :v :j :gj)
(map :v :k :gk)

;; Navigate between matching brackets
;; These are specifically not `noremap`s because we want to be bound to
;; whatever % is (usually a plugin, matchit / matchup).
(map :n :<tab> :% {})
(map :v :<tab> :% {})

;; edit config files
(leader-map :ev "e $HOME/.config/nvim/fnl/dotfiles/core.fnl")
(leader-map :ef "e $HOME/.config/fish/config.fish")
(leader-map :eg "e $HOME/.config/git/config")

(leader-map :w "w")
(leader-map :cl "close")
(leader-map :ss "split")
(leader-map :vs "vsplit")

;; tab mappings
(map :n "]r" ":tabnext<cr>")
(map :n "[r" ":tabprev<cr>")
(map :n :<leader>tn ":tabnew<cr>")

;; Use Q to repeat last macro, rather than going into ex mode
(map :n :Q "@@")

;; Swap the behavior of the ^ and 0 operators
;; ^ Usually goes to the first non-whitespace character, while 0 goes to the
;; first column in the line. ^ is more useful, but harder to hit, so swap it
;; with 0
(map :n :0 "^")
(map :n :^ "0")

;; always center the screen after any movement command
(map :n :<C-d> "<C-d>zz")
(map :n :<C-f> "<C-f>zz")
(map :n :<C-b> "<C-b>zz")
(map :n :<C-u> "<C-u>zz")

; Redirect changes to the "black hole" register
; leader-map c "_c
; leader-map C "_C
(map :n :c "\"_c")
(map :n :C "\"_C")

;; Keep the cursor in place while joining lines
(map :n :J "mzJ`z")

;; similar to vmap but only for visual mode - NOT select mode
;; maintains the currently visual selection between invocations of '<' and '>'
(map :x :< "<gv")
(map :x :> ">gv")

;; <c-k> escape sequences.
(map :i :<c-k> :<esc>)
(map :c :<c-k> :<c-c>)
(map :t :<c-k> :<c-\><c-n>)

;; vim-test mappings
(map :n :t<C-n> ":TestNearest<cr>" {:silent true})
(map :n :t<C-f> ":TestFile<cr>" {:silent true})
(map :n :t<C-s> ":TestSuite<cr>" {:silent true})
(map :n :t<C-l> ":TestLast<cr>" {:silent true})
(map :n :t<C-g> ":TestVisit<cr>" {:silent true})

(map :n "<C-l>" ":nohlsearch<cr>" {})

;; vim-surround mappings to work with lightspeed.nvim
(map :n :ds  "<Plug>Dsurround" {})
(map :n :cs  "<Plug>Csurround" {})
(map :n :cS  "<Plug>CSurround" {})
(map :n :ys  "<Plug>Ysurround" {})
(map :n :yS  "<Plug>YSurround" {})
(map :n :yss "<Plug>Yssurround" {})
(map :n :ySs "<Plug>YSsurround" {})
(map :n :ySS "<Plug>YSsurround" {})
(map :x :gs  "<Plug>VSurround" {})
(map :x :gS  "<Plug>VgSurround" {})

;; See: https://github.com/Olical/aniseed/issues/96
(defn aniseed-reload []
  (each [k _ (pairs package.loaded)]
    (when (string.match k "^dotfiles%..+")
      (tset package.loaded k nil)))
  ((. (require :aniseed.env) :init) {:module :dotfiles.init :compile true}))
(map :n :<leader>so aniseed-reload)

;; gitsigns.nvim
(map :n "]c" "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'" {:expr true})
(map :n "[c" "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'" {:expr true})
