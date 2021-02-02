(module dotfiles.module.mapping
  {require {nvim aniseed.nvim
            nu aniseed.nvim.util
            core aniseed.core}})

(defn- noremap [mode from to]
  "Sets a mapping with {:noremap true}."
  (nvim.set_keymap mode from to {:noremap true}))

;; Generic mapping configuration.
(nvim.set_keymap :n :<space> :<nop> {:noremap true})
;; Leader is space key
(set nvim.g.mapleader " ")
;; LocalLeader is the comma key
(set nvim.g.maplocalleader ",")

(noremap :n :<leader>pc ":PlugClean<cr>")
(noremap :n :<leader>pg ":PlugUpgrade<cr>")
(noremap :n :<leader>ps ":PlugStatus<cr>")
(noremap :n :<leader>pu ":PlugUpdate<cr>")
(noremap :n :<leader>pi ":PlugInstall<cr>")

;; always move by visual lines, rather than real lines
;; this is useful when 'wrap' is set.
(noremap :n :j :gj {:silent true})
(noremap :n :k :gk {:silent true})
(noremap :v :j :gj {:silent true})
(noremap :v :k :gk {:silent true})

;; Navigate between matching brackets
;; These are specifically not `noremap`s because we want to be bound to
;; whatever % is (usually a plugin, matchit / matchup).
(nvim.set_keymap :n :<tab> :% {})
(nvim.set_keymap :v :<tab> :% {})

;; edit config files
(noremap :n :<leader>ev ":e $MYVIMRC<cr>")
(noremap :n :<leader>ef ":e $HOME/.config/fish/config.fish<cr>")
(noremap :n :<leader>eg ":e $HOME/.config/git/config<cr>")

(noremap :n :<leader>w ":w<cr>")
(noremap :n :<leader>q ":q<cr>")
(noremap :n :<leader>so ":source $MYVIMRC<cr>")
(noremap :n :<leader>cl ":close<cr>")
(noremap :n :<leader>ss ":split<cr>")
(noremap :n :<leader>vs ":vsplit<cr>")

;; tab mappings
; (noremap :n :\]r ":tabn<cr>")
; (noremap :n :\[r ":tabp<cr>")
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

(noremap :n :<leader>/ ":nohlsearch<cr>")

;; Keep the cursor in place while joining lines
(noremap :n :J "mzJ`z")

;; similar to vmap but only for visual mode - NOT select mode
;; maintains the currently visual selection between invocations of '<' and '>'
(noremap :x :< "<gv")
(noremap :x :> ">gv")

;;; Taken from Olical's config

;; jk escape sequences.
(noremap :i :jk :<esc>)
(noremap :c :jk :<c-c>)
(noremap :t :jk :<c-\><c-n>)

;; Correct to first spelling suggestion.
(noremap :n :<leader>zz ":normal! 1z=<cr>")
