(local path-package (.. (vim.fn.stdpath :data) :/site/))
(local mini-path (.. path-package :pack/deps/start/mini.nvim))
(when (not (vim.loop.fs_stat mini-path))
  (vim.fn.system [:git
                  :clone
                  "--filter=blob:none"
                  "https://github.com/echasnovski/mini.nvim"
                  mini-path])
  (vim.cmd "packadd mini.nvim | helptags ALL"))

(local deps (require :mini.deps))
(deps.setup {:path {:package path-package}})

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
(set vim.o.clipboard :unnamedplus)

;; turn off swapfiles - for now, I find these more of a headache than a benefit
(set vim.o.swapfile false)

;; Convenience for automatic formatting.
;;   t - auto-wrap text ussdfing textwidth
;;   c - auto-wrap comments using textwidth, inserting the current comment leader automatically.
;;   q - allow formatting of comments with `gq`
;;   j - where it makes sense, remove a comment leader when joining lines
;;   r - auto-insert comment leading after <cr> in insert mode
;;   o - auto-insert comment leading after O in normal mode
;;   n - recognize numbered lists in text
;;   p - don't break lines at single spaces that follow periods
(set vim.o.formatoptions :tcqjronp)

;; ignore case when completing files / directories in wildmenu
(set vim.o.wildignorecase true)

;;; Plugins

(deps.add :justinmk/vim-gtfo)
(set vim.g.gtfo#terminals {:mac :kitty})

(deps.add :tyru/open-browser.vim)

(deps.add :lewis6991/fileline.nvim)

(deps.add :lewis6991/gitsigns.nvim)
(let [gitsigns (require :gitsigns)
      on-attach (fn [bufnr]
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
                  (buffer-map :n :<leader>hb
                              #(gitsigns.blame_line {:full true}))
                  (buffer-map :n :<leader>tb gitsigns.toggle_current_line_blame)
                  (buffer-map :n :<leader>hd gitsigns.diffthis)
                  (buffer-map :n :<leader>hD #(gitsigns.diffthis "~"))
                  (buffer-map :n :<leader>td gitsigns.toggle_deleted)
                  ;; Text object
                  (buffer-map [:o :x] :ih ":<C-U>Gitsigns select_hunk<CR>"))]
  (gitsigns.setup {:on_attach on-attach}))

(deps.add :tpope/vim-fugitive)
;; Remove legacy fugitive commands (which only result in warnings, rather than something useful)
(set vim.g.fugitive_legacy_commands 0)

(deps.add :tpope/vim-rhubarb)

;; Filetype-specific plugins
(deps.add :mattn/vim-gotmpl)
(deps.add :fladson/vim-kitty)
(deps.add :NoahTheDuke/vim-just)
(deps.add :raimon49/requirements.txt.vim)
(deps.add :jaawerth/fennel.vim)
(deps.add :janet-lang/janet.vim)

(deps.add :Olical/nfnl)

(deps.add :Olical/conjure)
(set vim.g.conjure#highlight#enabled true)
(set vim.g.conjure#filetypes [:clojure :fennel :janet :python])
(set vim.g.conjure#client#clojure#nrepl#connection#auto_repl#hidden true)
(set vim.g.conjure#filetype#janet :conjure.client.janet.stdio)

(deps.add :gpanders/nvim-parinfer)

;; Dependency of vim-test
(deps.add :tpope/vim-dispatch)
(deps.add :vim-test/vim-test)
(set vim.g.test#strategy :dispatch)
(map :n :<C-t>n ":TestNearest<cr>")
(map :n :<C-t>f ":TestFile<cr>")
(map :n :<C-t>s ":TestSuite<cr>")
(map :n :<C-t>l ":TestLast<cr>")
(map :n :<C-t>v ":TestVisit<cr>")

(deps.add :neovim/nvim-lspconfig)

(deps.add :b0o/SchemaStore.nvim)

(deps.add :stevearc/conform.nvim)
(let [conform (require :conform)]
  (conform.setup {:formatters_by_ft {:proto [:buf]
                                     :just [:just]
                                     :fennel [:fnlfmt]
                                     :fish [:fish_indent]
                                     :json [:prettier]
                                     :typescriptreact [:prettier]}
                  :format_on_save {:timeout_ms 500 :lsp_fallback true}}))

(deps.add :mfussenegger/nvim-lint)
(let [nvim-lint (require :lint)]
  ;; https://github.com/mfussenegger/nvim-lint#available-linters
  (set nvim-lint.linters_by_ft
       {:proto [:buf_lint]
        :fish [:fish]
        :go [:golangcilint]
        :janet [:janet]
        :fennel [:fennel]})
  (vim.api.nvim_create_autocmd :BufWritePost {:callback #(nvim-lint.try_lint)}))

(deps.add {:source :williamboman/mason.nvim
           :hooks {:post_checkout (fn [] (vim.cmd ":MasonUpdate"))}})

(let [mason (require :mason)]
  (mason.setup))

(deps.add :williamboman/mason-lspconfig.nvim)
(let [mason-lspconfig (require :mason-lspconfig)]
  (mason-lspconfig.setup))

(deps.add {:source :nvim-treesitter/nvim-treesitter
           :hooks {:post_checkout (fn [] (vim.cmd ":TSUpdate"))}})

(let [treesitter (require :nvim-treesitter.configs)]
  (treesitter.setup {:highlight {:enable true :disable [:fennel]}
                     ;; https://github.com/andymass/vim-matchup#tree-sitter-integration
                     :matchup {:enable true :disable [:fennel]}
                     :ensure_installed [:c
                                        :lua
                                        :vim
                                        :vimdoc
                                        :clojure
                                        :comment
                                        :css
                                        :diff
                                        :djot
                                        :dockerfile
                                        :fennel
                                        :fish
                                        :git_rebase
                                        :gitattributes
                                        :gitcommit
                                        :go
                                        :gomod
                                        :html
                                        :javascript
                                        :json
                                        :just
                                        :make
                                        :markdown
                                        :markdown_inline
                                        :proto
                                        :python
                                        :requirements
                                        :sql
                                        :ssh_config
                                        :textproto
                                        :toml
                                        :yaml
                                        :zig]}))

(deps.add :echasnovski/mini.nvim)

;; mini-basics should be first, to set up mappings like <Leader>
(let [mini-basics (require :mini.basics)]
  (mini-basics.setup))

(let [mini-pairs (require :mini.pairs)]
  (mini-pairs.setup))

(let [mini-trailspace (require :mini.trailspace)]
  (mini-trailspace.setup)
  (map :n :<leader>sw mini-trailspace.trim))

(let [mini-comment (require :mini.comment)]
  (mini-comment.setup {:options {:ignore_blank_line true}}))

(let [mini-surround (require :mini.surround)]
  (mini-surround.setup {:mappings {:add :gza
                                   :delete :gzd
                                   :find :gzf
                                   :find_left :gzF
                                   :highlight :gzh
                                   :replace :gzr
                                   :update_n_lines :gzn}}))

(let [mini-hues (require :mini.hues)]
  (vim.cmd.colorscheme :randomhue))

(let [mini-indentscope (require :mini.indentscope)]
  (mini-indentscope.setup))

(let [mini-pick (require :mini.pick)]
  (mini-pick.setup)
  (map :n :<leader>ff mini-pick.builtin.files)
  (map :n :<leader>fg #(mini-pick.builtin.files {:tool :git}))
  (map :n :<leader>fb mini-pick.builtin.buffers)
  (map :n :<leader>fl mini-pick.builtin.grep_live)
  (map :n :<leader>fh mini-pick.builtin.help))

(let [mini-extra (require :mini.extra)]
  (map :n :<leader>fs #(mini-extra.pickers.lsp {:scope :document_symbol}))
  (map :n :<leader>fr #(mini-extra.pickers.lsp {:scope :references})))

(let [mini-statusline (require :mini.statusline)]
  (mini-statusline.setup))

(let [mini-completion (require :mini.completion)]
  (mini-completion.setup))

(let [mini-bracketed (require :mini.bracketed)]
  (mini-bracketed.setup))

(let [mini-files (require :mini.files)]
  (mini-files.setup {:mappings {:go_in_plus :<CR>}})
  (map :n "-" #(mini-files.open (vim.api.nvim_buf_get_name 0))))

(let [mini-notify (require :mini.notify)]
  (mini-notify.setup))

(deps.add :tpope/vim-eunuch)
(deps.add :andymass/vim-matchup)
(set vim.g.matchup_matchparen_offscreen {})
(deps.add :tpope/vim-abolish)
(deps.add :rktjmp/paperplanes.nvim)
(deps.add :rktjmp/lush.nvim)

;; Colorschemes
(deps.add :stefanvanburen/rams)
(deps.add :mcchrish/zenbones.nvim)
(deps.add :rose-pine/neovim)

;;; Autocommands and FileType settings

(vim.api.nvim_create_autocmd :VimResized {:command ":wincmd ="})

(local filetype-settings {:go {:expandtab false}
                          :javascript {:expandtab true :shiftwidth 2}
                          :javascriptreact {:expandtab true :shiftwidth 2}
                          :typescript {:expandtab true :shiftwidth 2}
                          :typescriptreact {:expandtab true :shiftwidth 2}
                          :html {:expandtab true :shiftwidth 2}
                          :css {:expandtab true :shiftwidth 2}
                          :gohtmltmpl {:expandtab true
                                       :shiftwidth 2
                                       :commentstring "{{/* %s */}}"}
                          :gotexttmpl {:expandtab true
                                       :shiftwidth 2
                                       :commentstring "{{/* %s */}}"}
                          :fish {:expandtab true
                                 :shiftwidth 4
                                 :commentstring "# %s"}
                          :yaml {:expandtab true :shiftwidth 2}
                          :svg {:expandtab true :shiftwidth 2}
                          :json {:expandtab true :shiftwidth 2}
                          :bash {:expandtab true :shiftwidth 2}
                          :python {:expandtab true :shiftwidth 4}
                          :xml {:expandtab true :shiftwidth 4}
                          :starlark {:expandtab true
                                     :shiftwidth 4
                                     :commentstring "# %s"}
                          :proto {:expandtab true
                                  :shiftwidth 2
                                  :commentstring "// %s"
                                  :cindent true}
                          :gitcommit {:spell true}
                          :sql {:wrap true :commentstring "-- %s"}
                          :clojure {:expandtab true :textwidth 80}
                          :kotlin {:commentstring "// %s"}
                          :markdown {:spell true
                                     :wrap true
                                     :conceallevel 0
                                     :shiftwidth 2}})

(let [aufiletypes (vim.api.nvim_create_augroup :filetypes {})]
  (each [filetype settings (pairs filetype-settings)]
    (vim.api.nvim_create_autocmd :FileType
                                 {:group aufiletypes
                                  :pattern filetype
                                  :callback #(each [name value (pairs settings)]
                                               (vim.api.nvim_set_option_value name
                                                                              value
                                                                              {:scope :local}))}))

  (fn extension->filetype [extension filetype]
    (vim.api.nvim_create_autocmd [:BufNewFile :BufRead]
                                 {:group aufiletypes
                                  :pattern (.. "*." (tostring extension))
                                  :callback #(vim.api.nvim_set_option_value :filetype
                                                                            filetype
                                                                            {:scope :local})}))

  (each [extension filetype {:mdx :markdown
                             :star :starlark
                             :tpl :gotmpl
                             :txtpb :textproto}]
    (extension->filetype extension filetype)))

;;; Mappings

;; ; -> :
(map :n ";" ":")

(map :n :<leader>? vim.diagnostic.open_float)

;; Fugitive
(map :n :<leader>gs #(vim.cmd {:cmd :Git :mods {:vertical true}}))
(map :n :<leader>gw #(vim.cmd {:cmd :Gwrite}))
(map :n :<leader>gc #(vim.cmd {:cmd :Git :args [:commit]}))
(map :n :<leader>gp #(vim.cmd {:cmd :Git :args [:push]}))
(map :n :<leader>gb #(vim.cmd {:cmd :Git :args [:blame]}))

;; open-browser.vim
(map [:n :v] :gx "<plug>(openbrowser-smart-search)" {})

;; move by visual lines instead of real lines, except when a count is provided,
;; which helps when targeting a specific line with `relativenumber`.
(map [:n :v] :j #(if (not= vim.v.count 0) :j :gj) {:expr true})
(map [:n :v] :k #(if (not= vim.v.count 0) :k :gk) {:expr true})

;; Navigate between matching brackets
;; These specifically `remap` because we want to be bound to whatever % is
;; (currently vim-matchup).
(map [:n :v] :<tab> "%" {:remap true})

;; edit config files
(each [keymap file (pairs {:<leader>ef :$HOME/.config/fish/config
                           :<leader>eg :$HOME/.config/git/config
                           :<leader>ek :$HOME/.config/kitty/kitty.conf
                           :<leader>ev :$HOME/.config/nvim/init.fnl})]
  (map :n keymap #(vim.cmd {:cmd :edit :args [file]})))

(map :n :<leader>w #(vim.cmd {:cmd :write}))
(map :n :<leader>cl #(vim.cmd {:cmd :close}))
(map :n :<leader>ss #(vim.cmd {:cmd :split}))
(map :n :<leader>vs #(vim.cmd {:cmd :vsplit}))
(map :n :<leader>tn #(vim.cmd {:cmd :tabnew}))

;; Use Q to repeat last macro, rather than going into ex mode
(map :n :Q "@@")

;; Swap the behavior of the ^ and 0 operators
;; ^ Usually goes to the first non-whitespace character, while 0 goes to the
;; first column in the line. ^ is more useful, but harder to hit, so swap it
;; with 0
(map :n :0 "^")
(map :n "^" :0)

;; always center the screen after any movement command
(map :n :<C-d> :<C-d>zz)
(map :n :<C-f> :<C-f>zz)
(map :n :<C-b> :<C-b>zz)
(map :n :<C-u> :<C-u>zz)

;; Redirect changes to the "black hole" register
(map :n :c "\"_c")
(map :n :C "\"_C")

;; Keep the cursor in place while joining lines
(map :n :J "mzJ`z")

;; similar to vmap but only for visual mode - NOT select mode
;; maintains the currently visual selection between invocations of '<' and '>'
(map :x "<" :<gv)
(map :x ">" :>gv)

;; <c-k> escape sequences.
(map :i :<c-k> :<esc>)
(map :c :<c-k> :<c-c>)
(map :t :<c-k> "<c-\\><c-n>")

(map :n :<C-l> ":nohlsearch<cr>")

;;; Diagnostics

(each [sign text (pairs {:DiagnosticSignError "×"
                         :DiagnosticSignWarn "!"
                         :DiagnosticSignInfo "✳︎"
                         :DiagnosticSignHint "?"})]
  (vim.fn.sign_define sign {: text :texthl sign}))

(vim.diagnostic.config {:virtual_text {:prefix "▪"}
                        :float {:border :single
                                :focusable false
                                :source :always}})

;;; LSP

(fn lsp-attach [{: buf :data {: client_id}}]
  (local client (vim.lsp.get_client_by_id client_id))

  (fn format []
    (vim.lsp.buf.format {:timeout_ms 2000})
    (when (= client.name :gopls)
      (vim.lsp.buf.code_action {:context {:only [:source.organizeImports]}
                                :apply true})))

  (fn buffer-map [from to]
    (vim.keymap.set :n from to {:buffer buf :silent true}))

  (when client.server_capabilities.documentFormattingProvider
    (buffer-map :<leader>af #(format))
    ;; TODO: Disable tsserver's formatting overall.
    (when (not= client.name :tsserver)
      (vim.api.nvim_create_autocmd :BufWritePre
                                   {:buffer buf :callback #(format)})))
  ;; requires neovim nightly
  (when (and client.server_capabilities.inlayHintProvider vim.lsp.inlay_hint)
    (vim.lsp.inlay_hint.enable buf true))
  (when client.server_capabilities.hoverProvider
    (buffer-map :K vim.lsp.buf.hover))
  (when client.server_capabilities.documentHighlightProvider
    (let [augroup-id (vim.api.nvim_create_augroup :lsp-document-highlight
                                                  {:clear false})]
      (vim.api.nvim_create_autocmd [:CursorHold :InsertLeave]
                                   {:group augroup-id
                                    :buffer buf
                                    :callback vim.lsp.buf.document_highlight})
      (vim.api.nvim_create_autocmd [:CursorMoved :InsertEnter]
                                   {:group augroup-id
                                    :buffer buf
                                    :callback vim.lsp.buf.clear_references})))
  ;; setup mappings
  ;; See `:help vim.lsp.*` for documentation on any of the below functions
  (buffer-map :gD vim.lsp.buf.declaration)
  (buffer-map :gd vim.lsp.buf.definition)
  (buffer-map :gi vim.lsp.buf.implementation)
  (buffer-map :gr vim.lsp.buf.references)
  (buffer-map :<C-k> vim.lsp.buf.signature_help)
  (buffer-map :<leader>D vim.lsp.buf.type_definition)
  (buffer-map :<leader>rn vim.lsp.buf.rename)
  (buffer-map :<leader>ca vim.lsp.buf.code_action))

(vim.api.nvim_create_autocmd :LspAttach {:callback lsp-attach})

(local lspconfig (require :lspconfig))
(local schemastore (require :schemastore))

(local server-settings {;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#gopls
                        lspconfig.gopls {;; https://github.com/golang/tools/blob/master/gopls/doc/daemon.md
                                         :cmd [:gopls :-remote=auto]
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
                                                                       ;; https://github.com/golang/tools/blob/master/gopls/doc/analyzers.md#useany
                                                                       :useany true}}}}
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
                        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#ruff
                        lspconfig.ruff {}
                        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pylsp
                        ;; pipx install python-lsp-server ; https://github.com/python-lsp/python-lsp-server
                        ;; pipx inject python-lsp-server pylsp-mypy ; https://github.com/python-lsp/pylsp-mypy
                        ;; https://github.com/python-lsp/python-lsp-server/blob/develop/CONFIGURATION.md
                        lspconfig.pylsp {:settings {:pylsp {:plugins {:pycodestyle {:enabled false}
                                                                      :pyflakes {:enabled false}}}}}
                        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tsserver
                        lspconfig.tsserver {}
                        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#eslint
                        lspconfig.eslint {}
                        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#bashls
                        lspconfig.bashls {}
                        ;; LSP for TOML.
                        lspconfig.taplo {}
                        ;; Dockerfiles
                        lspconfig.dockerls {}
                        ;; LSP for Lua.
                        lspconfig.lua_ls {:settings {:Lua {:runtime {:version :LuaJIT}
                                                           :workspace {:library (vim.api.nvim_list_runtime_paths)}}}}
                        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
                        lspconfig.rust_analyzer {}})

(each [server settings (pairs server-settings)]
  (server.setup settings))

