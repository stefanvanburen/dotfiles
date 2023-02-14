(module dotfiles.mapping
  {autoload {: fzf-lua}})

;; Leader is space key
(set vim.g.mapleader " ")
;; LocalLeader is the comma key
(set vim.g.maplocalleader ",")

;; alias function
(local map vim.keymap.set)

;; ; -> :
(map :n ";" ":")

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

;; Fugitive
(map :n :<leader>gs #(vim.cmd {:cmd "Git" :mods {:vertical true}}))
(map :n :<leader>gw #(vim.cmd {:cmd "Gwrite"}))
(map :n :<leader>gc #(vim.cmd {:cmd "Git" :args ["commit"]}))
(map :n :<leader>gp #(vim.cmd {:cmd "Git" :args ["push"]}))
(map :n :<leader>gb #(vim.cmd {:cmd "Git" :args ["blame"]}))

;; fzf-lua - https://github.com/ibhagwan/fzf-lua
(map :n :<leader>ff fzf-lua.files)
(map :n :<leader>fg fzf-lua.git_files)
(map :n :<leader>fb fzf-lua.buffers)
(map :n :<leader>fl fzf-lua.grep_project)
(map :n :<leader>fh fzf-lua.help_tags)
(map :n :<leader>fr fzf-lua.lsp_references)
(map :n :<leader>fs fzf-lua.git_stash)

;; open-browser.vim
(map [:n :v] :gx "<plug>(openbrowser-open)" {})

;; move by visual lines instead of real lines, except when a count is provided,
;; which helps when targetting a specific line with `relativenumber`.
(map [:n :v] :j #(if (not= vim.v.count 0) :j :gj) {:expr true})
(map [:n :v] :k #(if (not= vim.v.count 0) :k :gk) {:expr true})

;; Navigate between matching brackets
;; These specifically `remap` because we want to be bound to whatever % is
;; (currently vim-matchup).
(map [:n :v] :<tab> :% {:remap true})

;; edit config files
(map :n :<leader>ed #(fzf-lua.git_files {:cwd "~"}))
(map :n :<leader>ev #(fzf-lua.files     {:cwd "~/.config/nvim"}))
(map :n :<leader>ef #(vim.cmd {:cmd "edit" :args ["$HOME/.config/fish/config.fish"]}))
(map :n :<leader>eg #(vim.cmd {:cmd "edit" :args ["$HOME/.config/git/config"]}))
(map :n :<leader>ek #(vim.cmd {:cmd "edit" :args ["$HOME/.config/kitty/kitty.conf"]}))

(map :n :<leader>w  #(vim.cmd {:cmd "write"}))
(map :n :<leader>cl #(vim.cmd {:cmd "close"}))
(map :n :<leader>ss #(vim.cmd {:cmd "split"}))
(map :n :<leader>vs #(vim.cmd {:cmd "vsplit"}))

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

;; Redirect changes to the "black hole" register
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

(map :n "<C-l>" ":nohlsearch<cr>" {})
