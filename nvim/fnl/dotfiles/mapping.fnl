(module dotfiles.mapping
  {autoload {nvim aniseed.nvim
             util dotfiles.util}})

;; alias function
(def map nvim.set_keymap)

(defn- noremap [mode from to]
  "Sets a mapping with {:noremap true}."
  (map mode from to {:noremap true}))

(map :n ";" ":" {:noremap true})

;; Leader is space key
(set nvim.g.mapleader " ")
;; LocalLeader is the comma key
(set nvim.g.maplocalleader ",")

;; packer
;; Clean, update and install plugins, then regenerate compiled loader file.
;; PackerUpdate -> PackerCompile
;; This is essentially always what we want to run.
(util.nnoremap :pu "PackerSync")

;; Fugitive
(util.nnoremap :gs "vertical Git")
(util.nnoremap :gw "Gwrite")
(util.nnoremap :gc "G commit")
(util.nnoremap :gp "G push")
(util.nnoremap :gb "G blame")

;; vim-better-whitespace
(util.nnoremap :sw "StripWhitespace")

;; fzf - https://github.com/junegunn/fzf.vim
(util.nnoremap :f "Files")
(util.nnoremap :<enter> "GitFiles")
(util.nnoremap :<leader> "Buffers")
(util.nnoremap :se "Rg")

(map :n :<leader><tab> "<plug>(fzf-maps-n)" {})
(map :x :<leader><tab> "<plug>(fzf-maps-x)" {})
(map :o :<leader><tab> "<plug>(fzf-maps-o)" {})

;; open-browser.vim
(map :n :gx "<plug>(openbrowser-smart-search)" {})
(map :v :gx "<plug>(openbrowser-smart-search)" {})

;; always move by visual lines, rather than real lines
;; this is useful when 'wrap' is set.
(noremap :n :j :gj {:silent true})
(noremap :n :k :gk {:silent true})
(noremap :v :j :gj {:silent true})
(noremap :v :k :gk {:silent true})

;; Navigate between matching brackets
;; These are specifically not `noremap`s because we want to be bound to
;; whatever % is (usually a plugin, matchit / matchup).
(map :n :<tab> :% {})
(map :v :<tab> :% {})

;; edit config files
(util.nnoremap :ev "e $HOME/.config/nvim/fnl/dotfiles/core.fnl")
(util.nnoremap :ef "e $HOME/.config/fish/config.fish")
(util.nnoremap :eg "e $HOME/.config/git/config")

(util.nnoremap :w "w")
(util.nnoremap :cl "close")
(util.nnoremap :ss "split")
(util.nnoremap :vs "vsplit")

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

;; jk escape sequences.
(noremap :i :jk :<esc>)
(noremap :c :jk :<c-c>)
(noremap :t :jk :<c-\><c-n>)

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
