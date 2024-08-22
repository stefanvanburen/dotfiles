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

(let [opts {;; setup folding
            :foldmethod :indent
            ;; on lines that will wrap, they instead 'break' and be visually indented by
            ;; the showbreak character, followed by the indent.
            :breakindentopt {:shift 2 :sbr true}
            :showbreak "↳"
            ;; when using > and <, round the indent to a multiple of shiftwidth
            :shiftround true
            ;; Global substitutions by defualt.
            :gdefault true
            ;; Copy the indent of existing lines when autoindenting.
            :copyindent true
            ;; Invisible characters.
            :list true
            :listchars {:tab "⇥ " :eol "¬" :trail "⣿"}
            ;; Override default grepprg to use default ripgrep settings
            :grepprg "rg --vimgrep"
            ;; always use the system clipboard for operations
            :clipboard :unnamedplus
            ;; turn off swapfiles - for now, I find these more of a headache than a benefit
            :swapfile false
            ;; Enable exrc to load .nvim.lua files.
            :exrc true
            ;; Convenience for automatic formatting.
            ;;   t - auto-wrap text using textwidth
            ;;   c - auto-wrap comments using textwidth, inserting the current comment leader automatically.
            ;;   q - allow formatting of comments with `gq`
            ;;   j - where it makes sense, remove a comment leader when joining lines
            ;;   r - auto-insert comment leading after <cr> in insert mode
            ;;   o - auto-insert comment leading after O in normal mode
            ;;   n - recognize numbered lists in text
            ;;   p - don't break lines at single spaces that follow periods
            :formatoptions :tcqjronp
            ;; Set the title of the window.
            :title true
            ;; Tied to CursorHold, which makes LSP document highlighting reasonable.
            :updatetime 300
            ;; ignore case when completing files / directories in wildmenu
            :wildignorecase true}]
  (each [opt val (pairs opts)]
    (case (type val)
      ;; vim.opt for table values, vim.o for everything else.
      :table
      (tset vim.opt opt val)
      _
      (tset vim.o opt val))))

;;; Plugins

(deps.add :echasnovski/mini.nvim)

;; mini-basics should be first, to set up mappings like <Leader>
(let [mini-basics (require :mini.basics)]
  (mini-basics.setup))

;; <leader> mappings shouldn't be set up until now.
(local map vim.keymap.set)

(let [mini-pairs (require :mini.pairs)]
  (mini-pairs.setup))

(let [mini-splitjoin (require :mini.splitjoin)]
  (mini-splitjoin.setup))

(let [mini-trailspace (require :mini.trailspace)]
  (mini-trailspace.setup)
  (map :n :<leader>sw mini-trailspace.trim))

(let [mini-surround (require :mini.surround)]
  ;; vim-surround mappings - :help MiniSurround-vim-surround-config
  (mini-surround.setup {:mappings {:add :ys
                                   :delete :ds
                                   :find ""
                                   :find_left ""
                                   :highlight ""
                                   :replace :cs
                                   :update_n_lines ""
                                   :suffix_last ""
                                   :suffix_next ""}
                        :search_method :cover_or_next})
  (vim.keymap.del :x :ys)
  (map :x :S ":<C-U>lua MiniSurround.add('visual')<CR>" {:silent true})
  (map :n :yss :ys_ {:remap true}))

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

(let [mini-diff (require :mini.diff)]
  (mini-diff.setup {:view {:signs {:add "┃" :change "┃" :delete "▁"}
                           :style :sign}}))

(let [mini-icons (require :mini.icons)]
  (mini-icons.setup {:style :ascii}))

(deps.add :tpope/vim-eunuch)
(deps.add :andymass/vim-matchup)
(set vim.g.matchup_matchparen_offscreen {:method :popup})
(deps.add :tpope/vim-abolish)
(deps.add :rktjmp/paperplanes.nvim)
(deps.add :rktjmp/lush.nvim)

(deps.add :justinmk/vim-gtfo)
(set vim.g.gtfo#terminals {:mac :kitty})

(deps.add :lewis6991/fileline.nvim)

(deps.add :tpope/vim-fugitive)
;; Remove legacy fugitive commands (which only result in warnings, rather than something useful)
(set vim.g.fugitive_legacy_commands 0)
(deps.add :tpope/vim-rhubarb)
(deps.add "https://git.sr.ht/~willdurand/srht.vim")

(deps.add :tpope/vim-dadbod)
;; vim-dispatch is a dependency of vim-dadbod.
(deps.add :tpope/vim-dispatch)

;; Filetype-specific plugins
(deps.add :mattn/vim-gotmpl)
(deps.add :fladson/vim-kitty)
(deps.add :NoahTheDuke/vim-just)
(deps.add :janet-lang/janet.vim)
(deps.add :towolf/vim-helm)

(deps.add :Olical/nfnl)

(deps.add :Olical/conjure)
(set vim.g.conjure#highlight#enabled true)
(set vim.g.conjure#filetypes [:clojure :fennel :janet :python :rust])
(set vim.g.conjure#client#clojure#nrepl#connection#auto_repl#hidden true)
(set vim.g.conjure#filetype#janet :conjure.client.janet.stdio)
(set vim.g.conjure#mapping#doc_word false)

(deps.add :gpanders/nvim-parinfer)

(deps.add :vim-test/vim-test)
(set vim.g.test#strategy :neovim_sticky)
(map :n :<leader>tt #(vim.cmd {:cmd :TestNearest}))
(map :n :<leader>tf #(vim.cmd {:cmd :TestFile}))

(deps.add :neovim/nvim-lspconfig)

(deps.add :b0o/SchemaStore.nvim)

(deps.add :stevearc/conform.nvim)
(let [conform (require :conform)]
  ;; https://github.com/stevearc/conform.nvim?tab=readme-ov-file#formatters
  (conform.setup {:formatters_by_ft {:fennel [:fnlfmt]
                                     :fish [:fish_indent]
                                     :go [:goimports]
                                     :just [:just]
                                     :proto [:buf]}
                  :format_on_save {:timeout_ms 2000 :lsp_format :fallback}}))

(deps.add :mfussenegger/nvim-lint)
(let [nvim-lint (require :lint)]
  ;; https://github.com/mfussenegger/nvim-lint#available-linters
  (set nvim-lint.linters_by_ft
       {:proto [:buf_lint] :fish [:fish] :janet [:janet] :fennel [:fennel]})
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
  (set vim.o.foldexpr "nvim_treesitter#foldexpr()")
  (set vim.o.foldmethod :expr)
  (treesitter.setup {:highlight {:enable true}
                     ;; https://github.com/andymass/vim-matchup#tree-sitter-integration
                     :matchup {:enable true}
                     :ensure_installed [:c
                                        :lua
                                        :vim
                                        :vimdoc
                                        :query
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
                                        :gosum
                                        :gotmpl
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
                                        :xml
                                        :yaml
                                        :zig]}))

;; Colorschemes
(deps.add :stefanvanburen/rams)
(deps.add :mcchrish/zenbones.nvim)
(deps.add :rose-pine/neovim)
(deps.add :lunacookies/vim-plan9)
(deps.add :miikanissi/modus-themes.nvim)
(vim.cmd.colorscheme :modus_operandi)

;;; Autocommands and FileType settings

(vim.api.nvim_create_autocmd :VimResized {:command ":wincmd ="})

(local filetype-settings {:go {:expandtab false :textwidth 120}
                          :javascript {:expandtab true :shiftwidth 2}
                          :javascriptreact {:expandtab true :shiftwidth 2}
                          :typescript {:expandtab true :shiftwidth 2}
                          :typescriptreact {:expandtab true :shiftwidth 2}
                          :html {:expandtab true :shiftwidth 2}
                          :css {:expandtab true :shiftwidth 2}
                          ;; C#
                          :cs {:commentstring "// %s"}
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
                          :fennel {:commentstring ";; %s"}
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
                                                                              {:scope :local}))})))

(vim.filetype.add {:extension {:mdx :markdown
                               :star :starlark
                               :tpl :gotexttmpl
                               :gotext :gotexttmpl}
                   :filename {:.ignore :gitignore}})

;; Skeleton files.
;; :h skeleton
(each [pattern skeleton-file (pairs {:buf.yaml :buf.yaml
                                     :buf.gen.yaml :buf.gen.yaml
                                     :Makefile :Makefile
                                     :.nfnl.fnl :.nfnl.fnl
                                     :*.proto :proto.proto})]
  (vim.api.nvim_create_autocmd [:BufNewFile]
                               {: pattern
                                :command (.. "0r ~/.config/nvim/skeletons/"
                                             skeleton-file)}))

;;; Mappings

;; ; -> :
(map :n ";" ":")

;; Fugitive
(map :n :<leader>gs #(vim.cmd {:cmd :Git :mods {:vertical true}}))
(map :n :<leader>gw #(vim.cmd {:cmd :Gwrite}))
(map :n :<leader>gc #(vim.cmd {:cmd :Git :args [:commit]}))
(map :n :<leader>gp #(vim.cmd {:cmd :Git :args [:push]}))
(map :n :<leader>gb #(vim.cmd {:cmd :Git :args [:blame]}))

;; move by visual lines instead of real lines, except when a count is provided,
;; which helps when targeting a specific line with `relativenumber`.
(map [:n :v] :j #(if (not= vim.v.count 0) :j :gj) {:expr true})
(map [:n :v] :k #(if (not= vim.v.count 0) :k :gk) {:expr true})

;; Navigate between matching brackets
;; These specifically `remap` because we want to be bound to whatever % is
;; (currently vim-matchup).
(map [:n :v] :<tab> "%" {:remap true})

;; edit config files
(each [keymap file (pairs {:<leader>ef :$HOME/.config/fish/config.fish
                           :<leader>eg :$HOME/.config/git/config
                           :<leader>ek :$HOME/.config/kitty/kitty.conf
                           :<leader>ev :$HOME/.config/nvim/init.fnl})]
  (map :n keymap #(vim.cmd {:cmd :edit :args [file]})))

(map :n :<leader>w #(vim.cmd {:cmd :write}))
(map :n :<leader>cl #(vim.cmd {:cmd :close}))
(map :n :<leader>ss #(vim.cmd {:cmd :split}))
(map :n :<leader>vs #(vim.cmd {:cmd :vsplit}))

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

;; tab commands.
(map :n :<leader>tn #(vim.cmd {:cmd :tabnew}))
(map :n "]r" #(vim.cmd {:cmd :tabnext}))
(map :n "[r" #(vim.cmd {:cmd :tabprev}))

(map :n :<C-l> ":nohlsearch<cr>")

;;; Diagnostics

(each [sign text (pairs {:DiagnosticSignError "×"
                         :DiagnosticSignWarn "!"
                         :DiagnosticSignInfo "✳︎"
                         :DiagnosticSignHint "?"})]
  (vim.fn.sign_define sign {: text :texthl sign}))

(vim.diagnostic.config {:virtual_text {:severity {:min vim.diagnostic.severity.WARN}}
                        :underline true
                        :float {:border :single
                                :focusable false
                                :source :always}})

;;; LSP

(fn lsp-attach [{: buf :data {: client_id}}]
  (local client (vim.lsp.get_client_by_id client_id))
  (when (and client.server_capabilities.inlayHintProvider vim.lsp.inlay_hint)
    (vim.lsp.inlay_hint.enable true {:bufnr buf}))
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

  (fn buffer-map [from to]
    (map :n from to {:buffer buf}))

  (buffer-map :gD vim.lsp.buf.declaration)
  (buffer-map :gd vim.lsp.buf.definition)
  (buffer-map :gi vim.lsp.buf.implementation)
  (buffer-map :grr vim.lsp.buf.references)
  (buffer-map :grt vim.lsp.buf.type_definition)
  (buffer-map :grn vim.lsp.buf.rename)
  (map [:n :x] :gra vim.lsp.buf.code_action {:buffer buf})
  (map :i :<C-s> vim.lsp.buf.signature_help {:buffer buf}))

(vim.api.nvim_create_autocmd :LspAttach {:callback lsp-attach})

(local lspconfig (require :lspconfig))
(local schemastore (require :schemastore))

(local server-settings {;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#gopls
                        lspconfig.gopls {;; https://github.com/golang/tools/blob/master/gopls/doc/daemon.md
                                         :cmd [:gopls :-remote=auto]
                                         ;; The default, plus gohtmltmpl and gotexttmpl.
                                         :filetypes [:go
                                                     :gomod
                                                     :gowork
                                                     :gotmpl
                                                     :gohtmltmpl
                                                     :gotexttmpl]
                                         ;; https://github.com/golang/tools/blob/master/gopls/doc/settings.md
                                         :settings {:gopls {;; https://github.com/golang/tools/blob/master/gopls/doc/settings.md#staticcheck-bool
                                                            :staticcheck true
                                                            ;; https://github.com/golang/tools/blob/master/gopls/doc/settings.md#linktarget-string
                                                            :linkTarget :godocs.io
                                                            ;; See https://github.com/golang/tools/blob/master/gopls/doc/features.md#template-files
                                                            ;; https://github.com/golang/tools/blob/master/gopls/doc/settings.md#templateextensions-string
                                                            :templateExtensions [:tpl
                                                                                 :tmpl]
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
                        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#janet_lsp
                        lspconfig.janet_lsp {}
                        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#cssls
                        lspconfig.cssls {}
                        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#ruff
                        lspconfig.ruff {}
                        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tsserver
                        lspconfig.tsserver {}
                        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#eslint
                        lspconfig.eslint {}
                        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#helm_ls
                        lspconfig.helm_ls {}
                        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#bashls
                        lspconfig.bashls {}
                        ;; LSP for TOML.
                        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#taplo
                        lspconfig.taplo {}
                        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#omnisharp
                        ;; NOTE: Download omnisharp with mason.
                        lspconfig.omnisharp {:cmd [:omnisharp]}
                        ;; Dockerfiles
                        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#dockerls
                        lspconfig.dockerls {:settings {:docker {:languageserver {:formatter {:ignoreMultilineInstructions true}}}}}
                        ;; https://sr.ht/~xerool/fennel-ls/
                        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#fennel_ls
                        lspconfig.fennel_ls {:settings {:fennel-ls {:extra-globals :vim}}}
                        ;; LSP for Lua.
                        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls
                        lspconfig.lua_ls {:settings {:Lua {:runtime {:version :LuaJIT}
                                                           :workspace {:library (vim.api.nvim_list_runtime_paths)}}}}
                        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
                        lspconfig.rust_analyzer {}})

(each [server settings (pairs server-settings)]
  (server.setup settings))

