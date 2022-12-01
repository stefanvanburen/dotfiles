(module dotfiles.mapping
  {autoload {: fzf-lua}})

;; alias function
(local map vim.keymap.set)

(fn leader-map [from to]
  "Helper function to add a mapping prefixed with leader to execute a command"
  (map :n (.. "<leader>" from) (.. ":" to "<cr>")))

;; ; -> :
(map :n ";" ":")

;; Leader is space key
(set vim.g.mapleader " ")
;; LocalLeader is the comma key
(set vim.g.maplocalleader ",")

;; See `:help vim.diagnostic.*` for documentation on any of the below functions
(map :n :<leader>? vim.diagnostic.open_float)
(map :n "[w"       vim.diagnostic.goto_prev)
(map :n "]w"       vim.diagnostic.goto_next)
(map :n :<leader>q vim.diagnostic.setloclist)

(fn trim-trailing-whitespace []
  (let [view (vim.fn.winsaveview)]
    (vim.api.nvim_command "silent! undojoin")
    (vim.api.nvim_command "silent keepjumps keeppatterns %s/\\s\\+$//e")
    (vim.fn.winrestview view)))

(map :n :<leader>sw trim-trailing-whitespace)

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

;; fzf-lua - https://github.com/ibhagwan/fzf-lua
(map :n :<leader>ff fzf-lua.files)
(map :n :<leader>fg fzf-lua.git_files)
(map :n :<leader>fb fzf-lua.buffers)
(map :n :<leader>fl fzf-lua.grep_project)
(map :n :<leader>fh fzf-lua.help_tags)
(map :n :<leader>fr fzf-lua.lsp_references)
(map :n :<leader>fs fzf-lua.git_stash)

;; open-browser.vim
(map :n :gx "<plug>(openbrowser-smart-search)" {})
(map :v :gx "<plug>(openbrowser-smart-search)" {})

;; move by visual lines instead of real lines, except when a count is provided,
;; which helps when targetting a specific line with `relativenumber`.
(map [:n :v] :j #(if (not= vim.v.count 0) :j :gj) {:expr true})
(map [:n :v] :k #(if (not= vim.v.count 0) :k :gk) {:expr true})

;; Navigate between matching brackets
;; These specifically `remap` because we want to be bound to whatever % is.
(map :n :<tab> :% {:remap true})
(map :v :<tab> :% {:remap true})

;; edit config files
(map :n :<leader>ed #(fzf-lua.git_files {:cwd "~"}))
(map :n :<leader>ev #(fzf-lua.files     {:cwd "~/.config/nvim"}))
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

;; vim-surround mappings to work with leap.nvim
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
