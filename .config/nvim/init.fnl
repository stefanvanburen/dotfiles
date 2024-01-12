(local lazypath (.. (vim.fn.stdpath "data") "/lazy/lazy.nvim"))
(when (not (vim.loop.fs_stat lazypath))
  (vim.fn.system ["git"
                  "clone"
                  "--filter=blob:none"
                  "https://github.com/folke/lazy.nvim.git"
                  "--branch=stable"
                  lazypath]))
(vim.opt.rtp:prepend lazypath)

(local map vim.keymap.set)

;;; Settings

;; Don't load netrw - using mini.files instead.
;; :h netrw-noload
(set vim.g.loaded_netrw 1)
(set vim.g.loaded_netrwPlugin 1)

;; Disable providers - unused.
(set vim.g.loaded_python3_provider 0)
(set vim.g.loaded_ruby_provider 0)
(set vim.g.loaded_node_provider 0)
(set vim.g.loaded_perl_provider 0)

;; LocalLeader is the comma key
(set vim.g.maplocalleader ",")

;; on lines that will wrap, they instead 'break' and be visually indented by
;; the showbreak character, followed by the indent.
(set vim.o.breakindentopt "shift:2,sbr")
(set vim.o.showbreak "↳")

;; when using > and <, round the indent to a multiple of shiftwidth
(set vim.o.shiftround true)

;; Global substitutions by default.
(set vim.o.gdefault true)

;; Copy the indent of existing lines when autoindenting
(set vim.o.copyindent true)

;; Set lower for the CursorHold autocmd, so that LSP's document highlighting is useful.
(set vim.o.updatetime 100)

;; Invisible characters
(set vim.o.list true)
(set vim.o.listchars "tab:⇥ ,eol:¬,trail:⣿")

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

;;; Plugins

(local lazy (require :lazy))

(lazy.setup
  [
   {:url "https://github.com/justinmk/vim-gtfo"
    :config #(set vim.g.gtfo#terminals {:mac :kitty})}
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
           (fn buffer-map [mode l r ?opts]
              (let [opts (or ?opts {})]
                (set opts.buffer bufnr)
                (map mode l r opts)))
           ;; Navigation
           (buffer-map :n "]c" #(gitsigns.next_hunk))
           (buffer-map :n "[c" #(gitsigns.prev_hunk))
           ;; Actions
           (buffer-map [:n :v] :<leader>hs gitsigns.stage_hunk)
           (buffer-map [:n :v] :<leader>hr gitsigns.reset_hunk)
           (buffer-map :n :<leader>hS gitsigns.stage_buffer)
           (buffer-map :n :<leader>hR gitsigns.reset_buffer)
           (buffer-map :n :<leader>hu gitsigns.undo_stage_hunk)
           (buffer-map :n :<leader>hp gitsigns.preview_hunk)
           (buffer-map :n :<leader>hb #(gitsigns.blame_line {:full true}))
           (buffer-map :n :<leader>tb gitsigns.toggle_current_line_blame)
           (buffer-map :n :<leader>hd gitsigns.diffthis)
           (buffer-map :n :<leader>hD #(gitsigns.diffthis "~"))
           (buffer-map :n :<leader>td gitsigns.toggle_deleted)
           ;; Text object
           (buffer-map [:o :x] :ih ":<C-U>Gitsigns select_hunk<CR>"))}))}
   {:url "https://github.com/tpope/vim-fugitive"
    ;; Remove legacy fugitive commands (which only result in warnings, rather than something useful)
    :config #(set vim.g.fugitive_legacy_commands 0)}
   {:url "https://github.com/tpope/vim-rhubarb"}
   {:url "https://github.com/mattn/vim-gotmpl"}
   {:url "https://github.com/fladson/vim-kitty"}
   {:url "https://github.com/NoahTheDuke/vim-just"}
   {:url "https://github.com/raimon49/requirements.txt.vim"}
   {:url "https://github.com/jaawerth/fennel.vim"}
   {:url "https://github.com/janet-lang/janet.vim"}
   {:url "https://github.com/Olical/nfnl"}
   {:url "https://github.com/Olical/conjure"
    :branch :develop
    :config #(do (set vim.g.conjure#highlight#enabled true)
                 (set vim.g.conjure#client#clojure#nrepl#connection#auto_repl#hidden true)
                 (set vim.g.conjure#filetype#janet :conjure.client.janet.stdio))}
   {:url "https://github.com/gpanders/nvim-parinfer"}
   {:url "https://github.com/vim-test/vim-test"
    :dependencies [{:url "https://github.com/tpope/vim-dispatch"}]
    :config #(do
               (set vim.g.test#strategy :dispatch)
               (map :n :<C-t>n ":TestNearest<cr>")
               (map :n :<C-t>f ":TestFile<cr>")
               (map :n :<C-t>s ":TestSuite<cr>")
               (map :n :<C-t>l ":TestLast<cr>")
               (map :n :<C-t>v ":TestVisit<cr>"))}
   {:url "https://github.com/neovim/nvim-lspconfig"}
   {:url "https://github.com/b0o/SchemaStore.nvim"}
   {:url "https://github.com/stevearc/conform.nvim"
    :opts {:formatters_by_ft {:proto [:buf]
                              :just [:just]
                              :fish [:fish_indent]
                              :json [:prettier]
                              :typescriptreact [:prettier]}
           :format_on_save {:timeout_ms 500
                            :lsp_fallback true}}}
   {:url "https://github.com/mfussenegger/nvim-lint"
    :config #(let [lint (require :lint)]
               ;; https://github.com/mfussenegger/nvim-lint#available-linters
               (set lint.linters_by_ft {:proto [:buf_lint]
                                        :fish [:fish]})
               (vim.api.nvim_create_autocmd :BufWritePost {:callback #(lint.try_lint)}))}
   {:url "https://github.com/williamboman/mason.nvim"
    :config true
    :build ":MasonUpdate"}
   {:url "https://github.com/williamboman/mason-lspconfig.nvim"
    :config true}
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
                  ;; https://github.com/camdencheek/tree-sitter-dockerfile
                  :dockerfile
                  ;; https://github.com/travonted/tree-sitter-fennel
                  :fennel
                  ;; https://github.com/ram02z/tree-sitter-fish
                  :fish
                  ;; https://github.com/tree-sitter/tree-sitter-html
                  :html
                  ;; https://github.com/gbprod/tree-sitter-gitcommit
                  :gitcommit
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
                  ;; https://github.com/treywood/tree-sitter-proto
                  :proto
                  ;; https://github.com/tree-sitter/tree-sitter-python
                  :python
                  ;; https://github.com/ObserverOfTime/tree-sitter-requirements
                  :requirements
                  ;; https://github.com/ObserverOfTime/tree-sitter-ssh-config
                  :ssh_config
                  ;; https://github.com/derekstride/tree-sitter-sql
                  :sql
                  ;; https://github.com/ikatyang/tree-sitter-toml
                  :toml
                  ;; https://github.com/ikatyang/tree-sitter-yaml
                  :yaml
                  ;; https://github.com/maxxnino/tree-sitter-zig
                  :zig]}))}
   {:url "https://github.com/echasnovski/mini.nvim"
    :config #(let [;; https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-basics.md
                   mini-basics (require :mini.basics)
                   ;; https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-pairs.md
                   mini-pairs (require :mini.pairs)
                   ;; https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-trailspace.md
                   mini-trailspace (require :mini.trailspace)
                   ;; https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-comment.md
                   mini-comment (require :mini.comment)
                   ;; https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-surround.md
                   mini-surround (require :mini.surround)
                   ;; https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-hues.md
                   mini-hues (require :mini.hues)
                   ;; https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-pick.md
                   mini-pick (require :mini.pick)
                   ;; https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-extra.md
                   mini-extra (require :mini.extra)
                   ;; https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-statusline.md
                   mini-statusline (require :mini.statusline)
                   ;; https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-completion.md
                   mini-completion (require :mini.completion)
                   ;; https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-bracketed.md
                   mini-bracketed (require :mini.bracketed)
                   ;; https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-files.md
                   mini-files (require :mini.files)
                   ;; https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-notify.md
                   mini-notify (require :mini.notify)]
                ;; mini-basics should be first, to set up mappings like <Leader>
                (mini-basics.setup)
                (mini-pairs.setup)
                (mini-trailspace.setup)
                (map :n :<leader>sw mini-trailspace.trim)
                (mini-comment.setup {:options {:ignore_blank_line true}})
                (mini-surround.setup
                  {:mappings {:add            :gza
                              :delete         :gzd
                              :find           :gzf
                              :find_left      :gzF
                              :highlight      :gzh
                              :replace        :gzr
                              :update_n_lines :gzn}})
                (vim.cmd.colorscheme :randomhue)
                (mini-pick.setup)
                (map :n :<leader>ff mini-pick.builtin.files)
                (map :n :<leader>fg #(mini-pick.builtin.files {:tool :git}))
                (map :n :<leader>fb mini-pick.builtin.buffers)
                (map :n :<leader>fl mini-pick.builtin.grep_live)
                (map :n :<leader>fh mini-pick.builtin.help)
                (map :n :<leader>fs #(mini-extra.pickers.lsp {:scope :document_symbol}))
                (map :n :<leader>fr #(mini-extra.pickers.lsp {:scope :references}))
                (mini-statusline.setup)
                (mini-completion.setup)
                (mini-bracketed.setup)
                (mini-files.setup {:mappings {:go_in_plus :<CR>}})
                (map :n "-" #(mini-files.open (vim.api.nvim_buf_get_name 0)))
                (mini-notify.setup))}
   {:url "https://github.com/tpope/vim-eunuch"}
   {:url "https://github.com/andymass/vim-matchup"
    :config #(set vim.g.matchup_matchparen_offscreen {})}
   {:url "https://github.com/tpope/vim-abolish"}
   {:url "https://github.com/rktjmp/paperplanes.nvim"}
   {:url "https://github.com/rktjmp/lush.nvim"}
   {:url "https://git.sr.ht/~p00f/alabaster.nvim"
    :lazy true
    :priority 1000
    :config #(vim.cmd.colorscheme :alabaster)}
   {:url "https://github.com/stefanvanburen/rams"
    :lazy true
    :priority 1000
    :dependencies [{:url "https://github.com/stefanvanburen/rams"}]
    :config #(vim.cmd.colorscheme :rams)}
   {:url "https://github.com/mcchrish/zenbones.nvim"
    :lazy true
    :priority 1000
    :config #(vim.cmd.colorscheme :zenwritten)}
   {:url "https://github.com/rose-pine/neovim"
    :name :rose-pine
    :lazy true
    :priority 1000
    :config #(vim.cmd.colorscheme :rose-pine)}]
 ;; on startup, if doing installation, try to load colorschemes
 {:install {:colorscheme [:randomhue :zenwritten :rams :alabaster :rose-pine]}})

;;; Autocommands and FileType settings

(vim.api.nvim_create_autocmd :VimResized {:command ":wincmd ="})

(vim.api.nvim_create_autocmd :TextYankPost {:callback #(vim.highlight.on_yank)})

(local filetype-settings
  {:go              {:expandtab false}
   :javascript      {:expandtab true  :shiftwidth 2}
   :javascriptreact {:expandtab true  :shiftwidth 2}
   :typescript      {:expandtab true  :shiftwidth 2}
   :typescriptreact {:expandtab true  :shiftwidth 2}
   :html            {:expandtab true  :shiftwidth 2}
   :css             {:expandtab true  :shiftwidth 2}
   :gohtmltmpl      {:expandtab true  :shiftwidth 2 :commentstring "{{/* %s */}}"}
   :gotexttmpl      {:expandtab true  :shiftwidth 2 :commentstring "{{/* %s */}}"}
   :fish            {:expandtab true  :shiftwidth 4 :commentstring "# %s"}
   :yaml            {:expandtab true  :shiftwidth 2}
   :svg             {:expandtab true  :shiftwidth 2}
   :json            {:expandtab true  :shiftwidth 2}
   :bash            {:expandtab true  :shiftwidth 2}
   :python          {:expandtab true  :shiftwidth 4}
   :xml             {:expandtab true  :shiftwidth 4}
   :starlark        {:expandtab true  :shiftwidth 4 :commentstring "# %s"}
   :proto           {:expandtab true  :shiftwidth 2 :commentstring "// %s" :cindent true}
   :gitcommit       {:spell true}
   :sql             {:wrap true :commentstring "-- %s"}
   :clojure         {:expandtab true :textwidth 80}
   :kotlin          {:commentstring "// %s"}
   :markdown        {:spell true :wrap true :conceallevel 0 :shiftwidth 2}})

(let [aufiletypes (vim.api.nvim_create_augroup "filetypes" {})]
  (each [filetype settings (pairs filetype-settings)]
    (vim.api.nvim_create_autocmd :FileType {:group aufiletypes
                                            :pattern filetype
                                            :callback #(each [name value (pairs settings)]
                                                         (vim.api.nvim_set_option_value name value {:scope "local"}))}))

  ;; treat mdx files as markdown
  (vim.api.nvim_create_autocmd [:BufNewFile :BufRead] {:group aufiletypes
                                                       :pattern "*.mdx"
                                                       :callback #(vim.api.nvim_set_option_value "filetype" "markdown" {:scope "local"})})
  (vim.api.nvim_create_autocmd [:BufNewFile :BufRead] {:group aufiletypes
                                                       :pattern "*.star"
                                                       :callback #(vim.api.nvim_set_option_value "filetype" "starlark" {:scope "local"})})
  (vim.api.nvim_create_autocmd [:BufNewFile :BufRead] {:group aufiletypes
                                                       :pattern "*.tpl"
                                                       :callback #(vim.api.nvim_set_option_value "filetype" "gotmpl" {:scope "local"})}))

;;; Mappings

;; ; -> :
(map :n ";" ":")

(map :n :<leader>? vim.diagnostic.open_float)

;; Fugitive
(map :n :<leader>gs #(vim.cmd {:cmd "Git" :mods {:vertical true}}))
(map :n :<leader>gw #(vim.cmd {:cmd "Gwrite"}))
(map :n :<leader>gc #(vim.cmd {:cmd "Git" :args ["commit"]}))
(map :n :<leader>gp #(vim.cmd {:cmd "Git" :args ["push"]}))
(map :n :<leader>gb #(vim.cmd {:cmd "Git" :args ["blame"]}))

;; open-browser.vim
(map [:n :v] :gx "<plug>(openbrowser-smart-search)" {})

;; move by visual lines instead of real lines, except when a count is provided,
;; which helps when targeting a specific line with `relativenumber`.
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
(map :n :<leader>ev #(vim.cmd {:cmd "edit" :args ["~/.config/nvim/init.fnl"]}))

(map :n :<leader>w  #(vim.cmd {:cmd "write"}))
(map :n :<leader>cl #(vim.cmd {:cmd "close"}))
(map :n :<leader>ss #(vim.cmd {:cmd "split"}))
(map :n :<leader>vs #(vim.cmd {:cmd "vsplit"}))
(map :n :<leader>tn #(vim.cmd {:cmd "tabnew"}))

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

(map :n "<C-l>" ":nohlsearch<cr>")

;;; Diagnostics

(vim.fn.sign_define :DiagnosticSignError {:text :× :texthl :DiagnosticSignError})
(vim.fn.sign_define :DiagnosticSignWarn  {:text :! :texthl :DiagnosticSignWarn})
(vim.fn.sign_define :DiagnosticSignInfo  {:text :✳︎ :texthl :DiagnosticSignInfo})
(vim.fn.sign_define :DiagnosticSignHint  {:text :? :texthl :DiagnosticSignHint})

(vim.diagnostic.config {:virtual_text {:prefix :▪}
                        :float {:border :single
                                :focusable false
                                :source :always}})

;;; LSP

(vim.api.nvim_create_autocmd
  :LspAttach
  {:callback
   (fn [{: buf :data {: client_id}}]
     (local client (vim.lsp.get_client_by_id client_id))

     (fn format []
       (do
         (vim.lsp.buf.format {:timeout_ms 2000})
         (when (= client.name "gopls")
           (vim.lsp.buf.code_action {:context {:only ["source.organizeImports"]}
                                     :apply true}))))

     (fn buffer-map [from to]
       (vim.keymap.set :n from to {:buffer buf :silent true}))

     (when client.server_capabilities.documentFormattingProvider
       (buffer-map :<leader>af #(format client))
       ;; TODO: Disable tsserver's formatting overall.
       (when (not= client.name "tsserver")
         (vim.api.nvim_create_autocmd :BufWritePre {:buffer buf
                                                    :callback #(format client)})))

     ;; requires neovim nightly
     (when (and
             client.server_capabilities.inlayHintProvider
             vim.lsp.inlay_hint)
       (vim.lsp.inlay_hint.enable buf true))

     (when client.server_capabilities.hoverProvider
       (buffer-map :K vim.lsp.buf.hover))

     (when client.server_capabilities.documentHighlightProvider
       (let [augroup-id (vim.api.nvim_create_augroup "lsp-document-highlight" {:clear false})]
         (vim.api.nvim_create_autocmd
           [:CursorHold :InsertLeave]
           {:group augroup-id
            :buffer buf
            :callback vim.lsp.buf.document_highlight})
         (vim.api.nvim_create_autocmd
           [:CursorMoved :InsertEnter]
           {:group augroup-id
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
     (buffer-map :<leader>ca vim.lsp.buf.code_action))})

(local lspconfig   (require :lspconfig))
(local schemastore (require :schemastore))

(local server-settings {;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#gopls
                        lspconfig.gopls {;; https://github.com/golang/tools/blob/master/gopls/doc/daemon.md
                                         :cmd ["gopls" "-remote=auto"]
                                         ;; https://github.com/golang/tools/blob/master/gopls/doc/settings.md
                                         :settings {:gopls {;; https://github.com/golang/tools/blob/master/gopls/doc/settings.md#staticcheck-bool
                                                            :staticcheck true
                                                            ;; https://github.com/golang/tools/blob/master/gopls/doc/settings.md#linktarget-string
                                                            :linkTarget :godocs.io
                                                            ;; https://github.com/golang/tools/blob/master/gopls/doc/analyzers.md
                                                            ;; Most of these analyzers are enabled by default.
                                                            :analyses {;; https://github.com/golang/tools/blob/master/gopls/doc/analyzers.md#unusedparams
                                                                       :unusedparams true
                                                                       ;; https://github.com/golang/tools/blob/master/gopls/doc/analyzers.md#unusedwrite
                                                                       :unusedwrite true
                                                                       ;; https://github.com/golang/tools/blob/master/gopls/doc/analyzers.md#nilness
                                                                       :nilness true}}}}

                        ;;; https://github.com/b0o/SchemaStore.nvim#usage
                        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#jsonls
                        lspconfig.jsonls {:settings {:json {:schemas (schemastore.json.schemas)
                                                            :validate {:enable true}}}}
                        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#yamlls
                        lspconfig.yamlls {:settings {:yaml {:schemas (schemastore.yaml.schemas)
                                                            :schemaStore {:enable false
                                                                          :url ""}}}}

                        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#clojure_lsp
                        lspconfig.clojure_lsp {}
                        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#cssls
                        lspconfig.cssls {}
                        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#bufls
                        lspconfig.bufls {}
                        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#ruff_lsp
                        lspconfig.ruff_lsp {}
                        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pylsp
                        ;; pipx install python-lsp-server ; https://github.com/python-lsp/python-lsp-server
                        ;; pipx inject python-lsp-server pylsp-mypy ; https://github.com/python-lsp/pylsp-mypy
                        ;; https://github.com/python-lsp/python-lsp-server/blob/develop/CONFIGURATION.md
                        lspconfig.pylsp {:settings {:pylsp {:plugins {:pycodestyle {:enabled false}
                                                                      :pyflakes    {:enabled false}}}}}
                        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tsserver
                        lspconfig.tsserver {}
                        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#eslint
                        lspconfig.eslint {}
                        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#bashls
                        lspconfig.bashls {}
                        ;; LSP for TOML.
                        lspconfig.taplo {}
                        ;; LSP for Lua.
                        lspconfig.lua_ls {:settings {:Lua {:runtime {:version :LuaJIT}
                                                           :workspace {:library (vim.api.nvim_list_runtime_paths)}}}}
                        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
                        lspconfig.rust_analyzer {}})

(each [server settings (pairs server-settings)]
  (server.setup settings))
