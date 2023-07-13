(local lazypath (.. (vim.fn.stdpath "data") "/lazy/lazy.nvim"))
;; TODO: Add download
(vim.opt.rtp:prepend lazypath)

;; Leader is space key
(set vim.g.mapleader " ")
;; LocalLeader is the comma key
(set vim.g.maplocalleader ",")

;; Show the menu even if only one option is available, and don't select
;; anything by default.
(set vim.o.completeopt "menuone,noselect")

;; colors
(set vim.o.background :light)
(set vim.o.termguicolors true)

;; if wrap is set, break on characters in 'breakat' rather than the last
;; character that will fit on the screen.
;; This _should_ mean that lines generally break on words
(set vim.o.linebreak true)
;; on lines that will wrap, they instead 'break' and be visually indented by
;; the showbreak character, followed by the indent.
(set vim.o.breakindent true)
(set vim.o.breakindentopt "shift:2,sbr")
(set vim.o.showbreak "↳")

;; when using > and <, round the indent to a multiple of shiftwidth
(set vim.o.shiftround true)

;; defaults, other than end of buffer ' ', rather than the default '~'
(set vim.o.fillchars "eob: ,")

;; Global substitutions by default.
(set vim.o.gdefault true)

;; Ignore case while searching
(set vim.o.ignorecase true)
;; ... except when capitals are used
(set vim.o.smartcase true)

;; Copy the indent of existing lines when autoindenting
(set vim.o.copyindent true)

;; Set lower for the CursorHold autocmd, so that LSP's document highlighting is useful.
(set vim.o.updatetime 100)

;; Helps when doing insert-mode completion
(set vim.o.infercase true)

;; Invisible characters
(set vim.o.list true)
(set vim.o.listchars "tab:→ ,eol:¬,trail:⣿")

;; Don't show the mode on the command line - it's redundant with the status line.
(set vim.o.showmode false)

;; maintain an undofile for undoing actions through neovim loads
(set vim.o.undofile true)

;; On horizontal split, open the split below.
(set vim.o.splitbelow true)
;; On vertical split, open the split to the right.
(set vim.o.splitright true)

;; always use the system clipboard for operations
(set vim.o.clipboard "unnamedplus")

;; turn off swapfiles - for now, I find these more of a headache than a benefit
(set vim.o.swapfile false)

;; Convenience for automatic formatting.
;;   t - auto-wrap text using textwidth
;;   c - auto-wrap comments using textwidth, inserting the current comment leader automatically.
;;   q - allow formatting of comments with `gq`
;;   j - where it makes sense, remove a comment leader when joining lines
;;   r - auto-insert comment leading after <cr> in insert mode
;;   o - auto-insert comment leading after O in normal mode
;;   n - recognize numbered lists in text
;;   p - don't break lines at single spaces that follow periods
(set vim.o.formatoptions "tcqjronp")

;; ignore case when completing files / directories in wildmenu
(set vim.o.wildignorecase true)

;; %f: relative path to current file
;; %m: modified flag
;; %{FugitiveHead()}: git head branch
;; %=: separation
;; %l: line number
;; %c: column number
;; %{&filetype}: filetype
(set vim.o.statusline "%f%m %{FugitiveHead()}%=%l,%c %{&filetype}")
(local lazy (require :lazy))

(lazy.setup
  [
   ; {:url "https://github.com/justinmk/vim-dirvish"}
   {:url "https://github.com/zbirenbaum/copilot.lua"
    :config #(let [copilot (require "copilot")]
               (copilot.setup {:suggestion {:auto_trigger false}}))
    :enabled false}
   ;; required by vim-fugitive
   {:url "https://github.com/tyru/open-browser.vim"}
   {:url "https://github.com/lewis6991/fileline.nvim"}
   {:url "https://github.com/lewis6991/gitsigns.nvim"
    :config
    #(let [gitsigns (require :gitsigns)]
       (gitsigns.setup
         {:attach_to_untracked false
          :on_attach
          ;; https://github.com/lewis6991/gitsigns.nvim#keymaps
          (fn [bufnr]
           (fn map [mode l r ?opts]
              (let [opts (or ?opts {})]
                (set opts.buffer bufnr)
                (vim.keymap.set mode l r opts)))
           ;; Navigation
           (map :n "]c" #(gitsigns.next_hunk))
           (map :n "[c" #(gitsigns.prev_hunk))
           ;; Actions
           (map [:n :v] :<leader>hs gitsigns.stage_hunk)
           (map [:n :v] :<leader>hr gitsigns.reset_hunk)
           (map :n :<leader>hS gitsigns.stage_buffer)
           (map :n :<leader>hR gitsigns.reset_buffer)
           (map :n :<leader>hu gitsigns.undo_stage_hunk)
           (map :n :<leader>hp gitsigns.preview_hunk)
           (map :n :<leader>hb #(gitsigns.blame_line {:full true}))
           (map :n :<leader>tb gitsigns.toggle_current_line_blame)
           (map :n :<leader>hd gitsigns.diffthis)
           (map :n :<leader>hD #(gitsigns.diffthis "~"))
           (map :n :<leader>td gitsigns.toggle_deleted)
           ;; Text object
           (map [:o :x] :ih ":<C-U>Gitsigns select_hunk<CR>"))}))}
   {:url "https://github.com/tpope/vim-fugitive"
    ;; Remove legacy fugitive commands (which only result in warnings, rather than something useful)
    :config #(set vim.g.fugitive_legacy_commands 0)}
   {:url "https://github.com/tpope/vim-rhubarb"}
   {:url "https://github.com/mattn/vim-gotmpl"}
   {:url "https://github.com/fladson/vim-kitty"}
   {:url "https://github.com/janet-lang/janet.vim"}
   {:url "https://github.com/Olical/nfnl"
    :ft :fennel}
   {:url "https://github.com/Olical/conjure"
    :config #(do (set vim.g.conjure#highlight#enabled true)
                 (set vim.g.conjure#client#clojure#nrepl#connection#auto_repl#hidden true))}
   {:url "https://github.com/gpanders/nvim-parinfer"}
   {:url "https://github.com/vim-test/vim-test"
    :dependencies [{:url "https://github.com/tpope/vim-dispatch"}]
    :config #(do
               (set vim.g.test#strategy :dispatch)
               (vim.keymap.set :n :<C-t>n ":TestNearest<cr>")
               (vim.keymap.set :n :<C-t>f ":TestFile<cr>")
               (vim.keymap.set :n :<C-t>s ":TestSuite<cr>")
               (vim.keymap.set :n :<C-t>l ":TestLast<cr>")
               (vim.keymap.set :n :<C-t>v ":TestVisit<cr>"))}
   {:url "https://github.com/nvim-lua/plenary.nvim"}
   {:url "https://github.com/neovim/nvim-lspconfig"}
   {:url "https://github.com/b0o/SchemaStore.nvim"}
   {:url "https://github.com/williamboman/mason.nvim" :config true}
   {:url "https://github.com/williamboman/mason-lspconfig.nvim" :config true}
   {:url "https://github.com/nvim-treesitter/nvim-treesitter"
    :build ":TSUpdate"
    :config #(let [treesitter (require "nvim-treesitter.configs")]
              (treesitter.setup
                {;; https://github.com/nvim-treesitter/nvim-treesitter#highlight
                 :highlight {:enable true}
                 ;; https://github.com/andymass/vim-matchup#tree-sitter-integration
                 :matchup {:enable true}
                 :ensure_installed
                 [;;; These four are required to be installed.
                  ;;; See https://github.com/nvim-treesitter/nvim-treesitter/issues/3970#issuecomment-1377126359
                  ;; https://github.com/tree-sitter/tree-sitter-c
                  :c
                  ;; https://github.com/MunifTanjim/tree-sitter-lua
                  :lua
                  ;; https://github.com/vigoux/tree-sitter-viml
                  :vim
                  ;; https://github.com/neovim/tree-sitter-vimdoc
                  :vimdoc

                  ;; https://github.com/sogaiu/tree-sitter-clojure
                  :clojure
                  ;; https://github.com/stsewd/tree-sitter-comment
                  ;; parses comments
                  :comment
                  ;; https://github.com/tree-sitter/tree-sitter-css
                  :css
                  ;; https://github.com/the-mikedavis/tree-sitter-diff
                  :diff
                  ;; https://github.com/travonted/tree-sitter-fennel
                  :fennel
                  ;; https://github.com/ram02z/tree-sitter-fish
                  :fish
                  ;; https://github.com/tree-sitter/tree-sitter-html
                  :html
                  ;; https://github.com/gbprod/tree-sitter-gitcommit
                  ; Seems unsupported in alabaster.nvim
                  ; :gitcommit
                  ;; https://github.com/the-mikedavis/tree-sitter-git-rebase
                  :git_rebase
                  ;; https://github.com/ObserverOfTime/tree-sitter-gitattributes
                  :gitattributes
                  ;; https://github.com/tree-sitter/tree-sitter-go
                  :go
                  ;; https://github.com/camdencheek/tree-sitter-go-mod
                  :gomod
                  ;; https://github.com/tree-sitter/tree-sitter-javascript
                  :javascript
                  ;; https://github.com/tree-sitter/tree-sitter-json
                  :json
                  ;; https://github.com/alemuller/tree-sitter-make
                  :make
                  ;; https://github.com/MDeiml/tree-sitter-markdown
                  :markdown
                  :markdown_inline
                  ;; https://github.com/mitchellh/tree-sitter-proto
                  ;; Not very well maintained - regular highlighting looks fine for now, disabling.
                  ; :proto
                  ;; https://github.com/tree-sitter/tree-sitter-python
                  :python
                  ;; https://github.com/derekstride/tree-sitter-sql
                  :sql
                  ;; https://github.com/ikatyang/tree-sitter-toml
                  :toml
                  ;; https://github.com/ikatyang/tree-sitter-yaml
                  :yaml
                  ;; https://github.com/maxxnino/tree-sitter-zig
                  :zig]}))}
   {:url "https://github.com/jose-elias-alvarez/null-ls.nvim"
    :config #(let [null-ls (require :null-ls)]
               (null-ls.setup {:debug false
                               :sources [null-ls.builtins.diagnostics.buf
                                         null-ls.builtins.formatting.buf
                                         null-ls.builtins.diagnostics.fish
                                         null-ls.builtins.formatting.fish_indent
                                         null_ls.builtins.formatting.prettier
                                         null-ls.builtins.formatting.shfmt]}))}
   {:url "https://github.com/echasnovski/mini.nvim"
    :config #(let [;; https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-pairs.md
                   mini-pairs (require :mini.pairs)
                   ;; https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-trailspace.md
                   mini-trailspace (require :mini.trailspace)
                   ;; https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-comment.md
                   mini-comment (require :mini.comment)
                   ;; https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-surround.md
                   mini-surround (require :mini.surround)
                   ;; https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-files.md
                   mini-files (require :mini.files)
                   ;; https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-hues.md
                   mini-hues (require :mini.hues)]
                (mini-pairs.setup)
                (mini-trailspace.setup)
                (mini-files.setup {})
                ;; open in the directory of the current file
                (vim.keymap.set :n :- #(mini-files.open (vim.api.nvim_buf_get_name 0) false))
                (vim.keymap.set :n :<leader>sw mini-trailspace.trim)
                (mini-comment.setup {:options {:ignore_blank_line true}})
                ; (vim.cmd.colorscheme :randomhue)
                (mini-surround.setup
                  {:mappings {:add            :gza
                              :delete         :gzd
                              :find           :gzf
                              :find_left      :gzF
                              :highlight      :gzh
                              :replace        :gzr
                              :update_n_lines :gzn}}))}
   {:url "https://github.com/ibhagwan/fzf-lua"
    :config #(let [fzf-lua (require :fzf-lua)]
               (fzf-lua.setup {:winopts {:border :single}
                               :global_git_icons false
                               :global_file_icons false
                               :fzf_colors {:fg [:fg :CursorLine]
                                            :bg [:bg :Normal]
                                            :hl [:fg :Comment]
                                            "fg+" [:fg :Normal]
                                            "bg+" [:bg :CursorLine]
                                            "hl+" [:fg :Statement]
                                            :info [:fg :PreProc]
                                            :prompt [:fg :Conditional]
                                            :pointer [:fg :Exception]
                                            :marker [:fg :Keyword]
                                            :spinner [:fg :Label]
                                            :header [:fg :Comment]
                                            :gutter [:bg :Normal]}})
               (vim.keymap.set :n :<leader>ff fzf-lua.files)
               (vim.keymap.set :n :<leader>fg fzf-lua.git_files)
               (vim.keymap.set :n :<leader>fb fzf-lua.buffers)
               (vim.keymap.set :n :<leader>fl fzf-lua.grep_project)
               (vim.keymap.set :n :<leader>fh fzf-lua.help_tags)
               (vim.keymap.set :n :<leader>fr fzf-lua.lsp_references)
               (vim.keymap.set :n :<leader>fs fzf-lua.git_stash)
               (vim.keymap.set :n :<leader>ed #(fzf-lua.git_files {:cwd "~"}))
               (vim.keymap.set :n :<leader>ev #(fzf-lua.files     {:cwd "~/.config/nvim"})))}
   {:url "https://github.com/tpope/vim-eunuch"}
   {:url "https://github.com/andymass/vim-matchup"
    :config #(set vim.g.matchup_matchparen_offscreen {})}
   {:url "https://github.com/ggandor/leap.nvim"
    ;; https://github.com/ggandor/leap.nvim#dependencies
    :dependencies [{:url "https://github.com/tpope/vim-repeat"}]
    :config #(let [leap (require :leap)]
               (leap.add_default_mappings))}
   {:url "https://github.com/tpope/vim-abolish"}
   {:url "https://github.com/tpope/vim-repeat"}
   {:url "https://github.com/rktjmp/lush.nvim"}
   {:url "https://git.sr.ht/~p00f/alabaster.nvim"
    :lazy true
    :priority 1000
    :config #(vim.cmd.colorscheme :alabaster)}
   {:url "https://github.com/stefanvanburen/rams"
    :lazy true
    :priority 1000
    :config #(vim.cmd.colorscheme :rams)}
   {:url "https://github.com/mcchrish/zenbones.nvim"
    :lazy true
    :priority 1000
    :config #(vim.cmd.colorscheme :zenwritten)}
   {:url "https://github.com/rose-pine/neovim"
    :name "rose-pine"
    :lazy false
    :priority 1000
    :config #(vim.cmd.colorscheme :rose-pine)}]
 ;; on startup, if doing installation, try to load colorschemes
 {:install {:colorscheme [:randomhue :zenwritten :rams :alabaster :rose-pine]}})
(local create-autocmd vim.api.nvim_create_autocmd)
(local create-augroup vim.api.nvim_create_augroup)

(create-autocmd :VimResized {:command ":wincmd ="})

(create-autocmd :TextYankPost {:callback #(vim.highlight.on_yank)})

(local filetype-settings
  {:go              {:expandtab false :shiftwidth 4 :tabstop 4}
   :javascript      {:expandtab true  :shiftwidth 2 :tabstop 2}
   :javascriptreact {:expandtab true  :shiftwidth 2 :tabstop 2}
   :typescript      {:expandtab true  :shiftwidth 2 :tabstop 2}
   :typescriptreact {:expandtab true  :shiftwidth 2 :tabstop 2}
   :html            {:expandtab true  :shiftwidth 2 :tabstop 2}
   :css             {:expandtab true  :shiftwidth 2 :tabstop 2}
   :gohtmltmpl      {:expandtab true  :shiftwidth 2 :tabstop 2 :commentstring "{{/* %s */}}"}
   :gotexttmpl      {:expandtab true  :shiftwidth 2 :tabstop 2 :commentstring "{{/* %s */}}"}
   :fish            {:expandtab true  :shiftwidth 4 :tabstop 4 :commentstring "# %s"}
   :yaml            {:expandtab true  :shiftwidth 2 :tabstop 2}
   :svg             {:expandtab true  :shiftwidth 2 :tabstop 2}
   :json            {:expandtab true  :shiftwidth 2 :tabstop 2}
   :bash            {:expandtab true  :shiftwidth 2 :tabstop 2}
   :python          {:expandtab true  :shiftwidth 4 :tabstop 4}
   :xml             {:expandtab true  :shiftwidth 4 :tabstop 4}
   :starlark        {:expandtab true  :shiftwidth 4 :tabstop 4 :commentstring "# %s"}
   :gitcommit       {:spell true}
   :sql             {:wrap true :commentstring "-- %s"}
   :clojure         {:expandtab true :textwidth 80}
   :proto           {:commentstring "// %s"}
   :kotlin          {:commentstring "// %s"}
   :markdown        {:spell true :wrap true :conceallevel 0 :shiftwidth 2}})

(let [aufiletypes (create-augroup "filetypes" {})]
  (each [filetype settings (pairs filetype-settings)]
    (create-autocmd :FileType {:group aufiletypes
                               :pattern filetype
                               :callback #(each [name value (pairs settings)]
                                            (vim.api.nvim_set_option_value name value {:scope "local"}))}))

  ;; treat `justfile`s as makefiles
  ;; This helps with setting up correct commentstring, etc
  (create-autocmd [:BufNewFile :BufRead] {:group aufiletypes
                                          :pattern "justfile"
                                          :callback #(vim.api.nvim_set_option_value "filetype" "make" {:scope "local"})})
  ;; treat mdx files as markdown
  (create-autocmd [:BufNewFile :BufRead] {:group aufiletypes
                                          :pattern "*.mdx"
                                          :callback #(vim.api.nvim_set_option_value "filetype" "markdown" {:scope "local"})})
  (create-autocmd [:BufNewFile :BufRead] {:group aufiletypes
                                          :pattern "*.star"
                                          :callback #(vim.api.nvim_set_option_value "filetype" "starlark" {:scope "local"})})
  (create-autocmd :FileType {:group aufiletypes
                             :pattern :fennel
                             ;; For fennel files, remove ':' and '.' from 'iskeyword'
                             ;; Original from: https://github.com/Olical/aniseed/blob/master/ftplugin/fennel.vim#L14
                             ;; See: https://github.com/bakpakin/fennel.vim/issues/9
                             :callback #(vim.api.nvim_set_option_value "iskeyword" "!,$,%,#,*,+,-,/,<,=,>,?,_,a-z,A-Z,48-57,128-247,124,94" {:scope "local"})}))
;; alias function
(local map vim.keymap.set)

;; ; -> :
(map :n ";" ":")

;; See `:help vim.diagnostic.*` for documentation on any of the below functions
(map :n :<leader>? vim.diagnostic.open_float)
(map :n "[w"       vim.diagnostic.goto_prev)
(map :n "]w"       vim.diagnostic.goto_next)
(map :n :<leader>q vim.diagnostic.setloclist)

;; Fugitive
(map :n :<leader>gs #(vim.cmd {:cmd "Git" :mods {:vertical true}}))
(map :n :<leader>gw #(vim.cmd {:cmd "Gwrite"}))
(map :n :<leader>gc #(vim.cmd {:cmd "Git" :args ["commit"]}))
(map :n :<leader>gp #(vim.cmd {:cmd "Git" :args ["push"]}))
(map :n :<leader>gb #(vim.cmd {:cmd "Git" :args ["blame"]}))

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
(local lspconfig (require :lspconfig))
(local schemastore (require :schemastore))

(local create-autocmd vim.api.nvim_create_autocmd)
(local create-augroup vim.api.nvim_create_augroup)

(fn organize-imports []
  (vim.lsp.buf.code_action {:context {:only ["source.organizeImports"]}
                            :apply true}))

(fn format [client]
  (do
    (vim.lsp.buf.format {:timeout_ms 2000})
    (when (= client.name "gopls")
      (organize-imports))))

(fn on-attach [{: buf
                :data {: client_id}}]
  (local client (vim.lsp.get_client_by_id client_id))

  (fn buffer-map [from to]
    (vim.keymap.set :n from to {:buffer buf :silent true}))

  (when client.server_capabilities.documentFormattingProvider
    (buffer-map :<leader>af #(format client))
    ;; Don't auto-format with null-ls
    ;; TODO: Disable tsserver's formatting overall.
    ;; TODO: Determine why null-ls needs to be disabled.
    (when (and (not= client.name "tsserver") (not= client.name "null-ls"))
      (create-autocmd :BufWritePre {:buffer buf
                                    :callback #(format client)})))

  ;; requires neovim nightly
  (when client.server_capabilities.inlayHintProvider
    (vim.lsp.inlay_hint buf true))

  (when client.server_capabilities.hoverProvider
    (buffer-map :K vim.lsp.buf.hover))

  (when client.server_capabilities.documentHighlightProvider
    (let [augroup-id (create-augroup "lsp-document-highlight" {:clear false})]
      (create-autocmd :CursorHold  {:group augroup-id
                                    :buffer buf
                                    :callback vim.lsp.buf.document_highlight})
      (create-autocmd :CursorMoved {:group augroup-id
                                    :buffer buf
                                    :callback vim.lsp.buf.clear_references})))

  ;; setup mappings
  ;; See `:help vim.lsp.*` for documentation on any of the below functions
  (buffer-map :gD         vim.lsp.buf.declaration)
  (buffer-map :gd         vim.lsp.buf.definition)
  (buffer-map :gi         vim.lsp.buf.implementation)
  (buffer-map :gr         vim.lsp.buf.references)
  (buffer-map :<C-k>      vim.lsp.buf.signature_help)
  (buffer-map :<leader>D  vim.lsp.buf.type_definition)
  (buffer-map :<leader>rn vim.lsp.buf.rename)
  (buffer-map :<leader>ca vim.lsp.buf.code_action))

(create-autocmd :LspAttach {:callback on-attach})

;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#gopls
(lspconfig.gopls.setup {:cmd ["gopls" "-remote=auto"]
                        ;; https://github.com/golang/tools/blob/master/gopls/doc/settings.md
                        :settings {:gopls {;; https://github.com/golang/tools/blob/master/gopls/doc/settings.md#staticcheck-bool
                                           :staticcheck true
                                           ;; https://github.com/golang/tools/blob/master/gopls/doc/analyzers.md
                                           ;; Most of these analyzers are enabled by default.
                                           :analyses {;; https://github.com/golang/tools/blob/master/gopls/doc/analyzers.md#unusedparams
                                                      :unusedparams true
                                                      ;; https://github.com/golang/tools/blob/master/gopls/doc/analyzers.md#unusedwrite
                                                      :unusedwrite true
                                                      ;; https://github.com/golang/tools/blob/master/gopls/doc/analyzers.md#nilness
                                                      :nilness true}
                                           ;; https://github.com/golang/tools/blob/master/gopls/doc/inlayHints.md
                                           :hints {:parameterNames true
                                                   :assignVariableTypes false
                                                   :compositeLiteralFields false
                                                   :compositeLiteralTypes false
                                                   :constantValues false
                                                   :functionTypeParameters false
                                                   :rangeVariableTypes false}}}})

(lspconfig.jsonls.setup {:settings {:json {:schemas (schemastore.json.schemas)
                                           :validate {:enable true}}}})

(lspconfig.yamlls.setup {:settings {:yaml {:schemas (schemastore.yaml.schemas)}}})

(local servers [;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#clojure_lsp
                lspconfig.clojure_lsp
                ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#bufls
                lspconfig.bufls
                ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#ruff_lsp
                lspconfig.ruff_lsp
                ;; pipx install python-lsp-server ; https://github.com/python-lsp/python-lsp-server
                ;; pipx inject python-lsp-server pylsp-mypy ; https://github.com/python-lsp/pylsp-mypy
                ;; pipx inject python-lsp-server python-lsp-black ; https://github.com/python-lsp/python-lsp-black
                lspconfig.pylsp
                ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tsserver
                lspconfig.tsserver
                ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#eslint
                lspconfig.eslint
                ;; Swift LSP: https://github.com/apple/sourcekit-lsp
                ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sourcekit
                lspconfig.sourcekit
                ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#bashls
                lspconfig.bashls])

(each [_ lsp-server (ipairs servers)]
  (lsp-server.setup {}))
