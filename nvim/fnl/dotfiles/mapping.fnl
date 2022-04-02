(module dotfiles.mapping
  {autoload {nvim aniseed.nvim}})

;; alias function
(def map nvim.set_keymap)

(defn- noremap [mode from to]
  "Sets a mapping with {:noremap true}."
  (map mode from to {:noremap true}))

(defn- nnoremap [from to]
  "Helper function to add a mapping prefixed with leader to execute a command,
  typically from a plugin."
  (map
    :n
    (.. "<leader>" from)
    (.. ":" to "<cr>")
    {:noremap true}))

;; ; -> :
(noremap :n ";" ":")

;; Leader is space key
(set nvim.g.mapleader " ")
;; LocalLeader is the comma key
(set nvim.g.maplocalleader ",")

;; packer
;; Clean, update and install plugins, then regenerate compiled loader file.
;; PackerUpdate -> PackerCompile
;; This is essentially always what we want to run.
(nnoremap :pu "PackerSync")

;; Fugitive
(nnoremap :gs "vertical Git")
(nnoremap :gw "Gwrite")
(nnoremap :gc "G commit")
(nnoremap :gp "G push")
(nnoremap :gb "G blame")

;; vim-better-whitespace
(nnoremap :sw "StripWhitespace")

;; fzf - https://github.com/junegunn/fzf.vim
(nnoremap :f "Files")
(nnoremap :<enter> "GitFiles")
(nnoremap :<leader> "Buffers")
(nnoremap :se "Rg")

(map :n :<leader><tab> "<plug>(fzf-maps-n)" {})
(map :x :<leader><tab> "<plug>(fzf-maps-x)" {})
(map :o :<leader><tab> "<plug>(fzf-maps-o)" {})

;; open-browser.vim
(map :n :gx "<plug>(openbrowser-smart-search)" {})
(map :v :gx "<plug>(openbrowser-smart-search)" {})

;; always move by visual lines, rather than real lines
;; this is useful when 'wrap' is set.
(noremap :n :j :gj)
(noremap :n :k :gk)
(noremap :v :j :gj)
(noremap :v :k :gk)

;; Navigate between matching brackets
;; These are specifically not `noremap`s because we want to be bound to
;; whatever % is (usually a plugin, matchit / matchup).
(map :n :<tab> :% {})
(map :v :<tab> :% {})

;; edit config files
(nnoremap :ev "e $HOME/.config/nvim/fnl/dotfiles/core.fnl")
(nnoremap :ef "e $HOME/.config/fish/config.fish")
(nnoremap :eg "e $HOME/.config/git/config")

(nnoremap :w "w")
(nnoremap :cl "close")
(nnoremap :ss "split")
(nnoremap :vs "vsplit")

;; tab mappings
(noremap :n "]r" ":tabnext<cr>")
(noremap :n "[r" ":tabprev<cr>")
(noremap :n :<leader>tn ":tabnew<cr>")

;; Use Q to repeat last macro, rather than going into ex mode
(noremap :n :Q "@@")

;; Swap the behavior of the ^ and 0 operators
;; ^ Usually goes to the first non-whitespace character, while 0 goes to the
;; first column in the line. ^ is more useful, but harder to hit, so swap it
;; with 0
(noremap :n :0 "^")
(noremap :n :^ "0")

;; always center the screen after any movement command
(noremap :n :<C-d> "<C-d>zz")
(noremap :n :<C-f> "<C-f>zz")
(noremap :n :<C-b> "<C-b>zz")
(noremap :n :<C-u> "<C-u>zz")

; Redirect changes to the "black hole" register
; nnoremap c "_c
; nnoremap C "_C
(noremap :n :c "\"_c")
(noremap :n :C "\"_C")

;; Keep the cursor in place while joining lines
(noremap :n :J "mzJ`z")

;; similar to vmap but only for visual mode - NOT select mode
;; maintains the currently visual selection between invocations of '<' and '>'
(noremap :x :< "<gv")
(noremap :x :> ">gv")

;; <c-k> escape sequences.
(noremap :i :<c-k> :<esc>)
(noremap :c :<c-k> :<c-c>)
(noremap :t :<c-k> :<c-\><c-n>)

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

(defn aniseed-reload []
  (each [k _ (pairs package.loaded)]
    (when (string.match k "^dotfiles%..+")
      (tset package.loaded k nil)))
  ((. (require :aniseed.env) :init) {:module :dotfiles.init :compile true}))

;; TODO: swap this call for the following in newer versions of neovim:
;; (vim.keymap.set :n :<leader>so aniseed-reload)
;; See: https://github.com/Olical/aniseed/issues/96

(global map_functions {:aniseed_reload aniseed-reload})
(vim.api.nvim_set_keymap :n :<leader>so "<cmd>lua map_functions.aniseed_reload()<cr>" {})

;; gitsigns.nvim
(map :n "]c" "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'" {:expr true})
(map :n "[c" "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'" {:expr true})
