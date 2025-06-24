(local path-package (.. (vim.fn.stdpath :data) :/site/))
(local mini-path (.. path-package :pack/deps/start/mini.nvim))
(when (not (vim.uv.fs_stat mini-path))
  (vim.system [:git
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
            ;; Start with all folds open.
            :foldlevelstart 99
            ;; on lines that will wrap, they instead 'break' and be visually indented by
            ;; the showbreak character, followed by the indent.
            :breakindentopt {:shift 2 :sbr true}
            :showbreak "↳"
            ;; when using > and <, round the indent to a multiple of shiftwidth
            :shiftround true
            ;; Global substitutions by default.
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
            ;; Highlight only the number column when using cursorline.
            :cursorlineopt :number
            :completeopt "fuzzy,menu,menuone,popup,noselect"
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
            :wildignorecase true
            ;; Show partial off-screen results in a preview window.
            :inccommand :split
            ;; Use rounded borders for windows.
            :winborder :rounded}]
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

(let [mini-ai (require :mini.ai)]
  (mini-ai.setup))

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
  (map :n :<leader>fb mini-pick.builtin.buffers)
  (map :n :<leader>fl mini-pick.builtin.grep_live)
  (map :n :<leader>fh mini-pick.builtin.help))

(let [mini-extra (require :mini.extra)]
  (map :n :<leader>fs #(mini-extra.pickers.lsp {:scope :document_symbol}))
  (map :n :<leader>fr #(mini-extra.pickers.lsp {:scope :references}))
  (map :n :<leader>fd mini-extra.pickers.diagnostic)
  (map :n :<leader>fg mini-extra.pickers.git_files))

(let [mini-completion (require :mini.completion)]
  (mini-completion.setup))

(let [mini-bracketed (require :mini.bracketed)]
  (mini-bracketed.setup))

(let [mini-files (require :mini.files)]
  (mini-files.setup {:mappings {:go_in_plus :<CR>}})
  (map :n "-" #(mini-files.open (vim.api.nvim_buf_get_name 0) false)))

(let [mini-notify (require :mini.notify)]
  (mini-notify.setup {:lsp_progress {:enable false}}))

(let [mini-diff (require :mini.diff)]
  (mini-diff.setup {:view {:signs {:add "┃" :change "┃" :delete "▁"}
                           :style :sign}}))

(let [mini-git (require :mini.git)]
  (mini-git.setup))

;; Initialize below mini-git and mini-diff for integration.
(let [mini-statusline (require :mini.statusline)]
  (mini-statusline.setup))

(let [mini-icons (require :mini.icons)]
  (mini-icons.setup {:style :ascii}))

(deps.add :tpope/vim-eunuch)
(deps.add :andymass/vim-matchup)
(set vim.g.matchup_matchparen_offscreen {:method :popup})
(deps.add :tpope/vim-abolish)
(deps.add :rktjmp/paperplanes.nvim)
(deps.add :rktjmp/lush.nvim)

(deps.add :lewis6991/fileline.nvim)

(deps.add :tpope/vim-fugitive)
;; Remove legacy fugitive commands (which only result in warnings, rather than something useful)
(set vim.g.fugitive_legacy_commands 0)
(deps.add :tpope/vim-rhubarb)
(deps.add "https://git.sr.ht/~willdurand/srht.vim")

(deps.add :tpope/vim-dadbod)
;; vim-dispatch is a dependency of vim-dadbod.
(deps.add :tpope/vim-dispatch)
;; Set DATABASE_URL in the environment to access the configured database via dadbod.
(map :n :<leader>db #(vim.cmd {:cmd :DB :args [:$DATABASE_URL]}))

;; Filetype-specific plugins
(deps.add :fladson/vim-kitty)
(deps.add :NoahTheDuke/vim-just)
(deps.add :janet-lang/janet.vim)
(deps.add :towolf/vim-helm)

(deps.add :Olical/nfnl)

(deps.add :Olical/conjure)
(set vim.g.conjure#highlight#enabled true)
(set vim.g.conjure#filetypes [:clojure :fennel :janet :rust :python])
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
                                     :go {:lsp_format :fallback}
                                     :just [:just]
                                     :proto {:lsp_format :fallback}
                                     :python {:lsp_format :fallback}}
                  :format_on_save {:timeout_ms 5000}}))

(deps.add :mfussenegger/nvim-lint)
(let [nvim-lint (require :lint)]
  ;; https://github.com/mfussenegger/nvim-lint#available-linters
  (set nvim-lint.linters_by_ft
       {:fish [:fish] :janet [:janet] :fennel [:fennel]})
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
                     :incremental_selection {:enable true}
                     :ensure_installed [:c
                                        :lua
                                        :vim
                                        :vimdoc
                                        :query
                                        :bash
                                        :c_sharp
                                        :clojure
                                        :comment
                                        :css
                                        :diff
                                        :djot
                                        :dockerfile
                                        :editorconfig
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
                                        :janet_simple
                                        :java
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
                                        :starlark
                                        :textproto
                                        :toml
                                        :xml
                                        :yaml
                                        :zig]}))

(let [filetype-to-langs {:c_sharp [:csharp]
                         :bash [:shellsession :console]
                         :proto [:protobuf]}]
  (each [filetype langs (pairs filetype-to-langs)]
    (vim.treesitter.language.register filetype langs)))

(deps.add :julienvincent/nvim-paredit)
;; NOTE: This must be after adding treesitter.
(let [nvim-paredit (require :nvim-paredit)]
  (nvim-paredit.setup {}))

;; Colorschemes
(deps.add :stefanvanburen/rams)
(deps.add :mcchrish/zenbones.nvim)
(deps.add :rose-pine/neovim)
(deps.add :lunacookies/vim-plan9)
(deps.add :miikanissi/modus-themes.nvim)
(vim.cmd.colorscheme :modus)

;;; Autocommands and FileType settings

(vim.api.nvim_create_autocmd :VimResized {:command ":wincmd ="})

(local filetype-settings {:go {:expandtab false :textwidth 100}
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
                          :sql {:wrap true
                                :commentstring "-- %s"
                                :expandtab true
                                :shiftwidth 4}
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
                   :filename {:.ignore :gitignore
                              :.dockerignore :gitignore
                              :buf.lock :yaml
                              :uv.lock :toml}})

;; Skeleton files.
;; :h skeleton
(each [pattern skeleton-file (pairs {:buf.gen.yaml :buf.gen.yaml
                                     :.nfnl.fnl :.nfnl.fnl})]
  (vim.api.nvim_create_autocmd [:BufNewFile]
                               {: pattern
                                :command (.. "0r ~/.config/nvim/skeletons/"
                                             skeleton-file)}))

;; Template files.
(let [autemplates (vim.api.nvim_create_augroup :templates {})]
  (vim.api.nvim_create_autocmd :BufNewFile
                               {:pattern "*"
                                :group autemplates
                                :callback (fn [args]
                                            (let [fname (vim.fs.basename args.file)
                                                  ext (vim.fn.fnamemodify args.file
                                                                          ":e")
                                                  ft (. vim.bo args.buf
                                                        :filetype)
                                                  candidates [fname ext ft]]
                                              (var done? false)
                                              (each [_ candidate (ipairs candidates)
                                                     &until done?]
                                                (let [tmpl (vim.fs.joinpath (vim.fn.stdpath :config)
                                                                            :templates
                                                                            (: "%s.tmpl"
                                                                               :format
                                                                               candidate))
                                                      f (io.open tmpl :r)]
                                                  (when f
                                                    ;; (vim.snippet.expand (f:read :*a))
                                                    (set done? true))))))}))

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

(vim.diagnostic.config {:signs {:text {vim.diagnostic.severity.ERROR "×"
                                       vim.diagnostic.severity.WARN "!"
                                       vim.diagnostic.severity.INFO "✳︎"
                                       vim.diagnostic.severity.HINT "?"}}
                        :virtual_text {:severity {:min vim.diagnostic.severity.WARN}}
                        :virtual_lines {:current_line true}
                        :underline true
                        :float {:border :single
                                :focusable false
                                :source :always}})

;;; LSP

(fn lsp-attach [{: buf :data {: client_id}}]
  (local client (vim.lsp.get_client_by_id client_id))

  (fn goimports []
    ;; https://github.com/golang/tools/blob/master/gopls/doc/vim.md#imports-and-formatting
    (vim.lsp.buf.code_action {:context {:only [:source.organizeImports]}
                              :apply true})
    (vim.lsp.buf.format))

  ;; Only enable formatting for gopls.
  (when (and (client:supports_method :textDocument/formatting)
             (= client.name :gopls))
    (vim.api.nvim_create_autocmd :BufWritePre {:buffer buf :callback goimports}))
  (when (client:supports_method :textDocument/inlayHint)
    (vim.lsp.inlay_hint.enable true {:bufnr buf}))
  (when (client:supports_method :textDocument/documentHighlight)
    (let [augroup-id (vim.api.nvim_create_augroup :lsp-document-highlight
                                                  {:clear false})]
      (vim.api.nvim_create_autocmd [:CursorHold :CursorHoldI :InsertLeave]
                                   {:group augroup-id
                                    :buffer buf
                                    :callback vim.lsp.buf.document_highlight})
      (vim.api.nvim_create_autocmd [:CursorMoved :InsertEnter]
                                   {:group augroup-id
                                    :buffer buf
                                    :callback vim.lsp.buf.clear_references})))
  (map :n :gD vim.lsp.buf.declaration {:buffer buf})
  (map :n :gd vim.lsp.buf.definition {:buffer buf})
  (map :n :grt vim.lsp.buf.type_definition {:buffer buf}))

(vim.api.nvim_create_autocmd :LspAttach {:callback lsp-attach})

(local schemastore (require :schemastore))

(local server-settings {;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#gopls
                        :gopls {;; https://github.com/golang/tools/blob/master/gopls/doc/daemon.md
                                :cmd [:gopls :-remote=auto]
                                :settings {:gopls {;; https://github.com/golang/tools/blob/master/gopls/doc/settings.md#semantictokens-bool
                                                   :semanticTokens true}}}
                        ;;; https://github.com/b0o/SchemaStore.nvim#usage
                        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#jsonls
                        :jsonls {:settings {:json {:schemas (schemastore.json.schemas)
                                                   :validate {:enable true}}}}
                        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#yamlls
                        :yamlls {:settings {:yaml {:schemas (schemastore.yaml.schemas)
                                                   :schemaStore {:enable false
                                                                 :url ""}}}}
                        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#clojure_lsp
                        :clojure_lsp {}
                        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#fish_lsp
                        :fish_lsp {}
                        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#janet_lsp
                        :janet_lsp {}
                        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#cssls
                        :cssls {}
                        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#ruff
                        :ruff {}
                        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#ts_ls
                        :ts_ls {}
                        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#pylsp
                        ;; https://github.com/python-lsp/python-lsp-server/blob/develop/CONFIGURATION.md
                        ;; https://github.com/python-lsp/python-lsp-server
                        ;; uv tool install python-lsp-server
                        :pylsp {:cmd [:uv
                                      :tool
                                      :run
                                      :--from
                                      :python-lsp-server
                                      :pylsp]
                                :settings {:pylsp {:plugins {:pycodestyle {:enabled false}}
                                                   :pyflakes {:enabled false}}}}
                        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#eslint
                        :eslint {}
                        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#helm_ls
                        :helm_ls {}
                        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#bashls
                        :bashls {}
                        ;; LSP for TOML.
                        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#taplo
                        :taplo {}
                        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#omnisharp
                        ;; NOTE: Download omnisharp with mason.
                        :omnisharp {:cmd [:omnisharp]}
                        ;; Dockerfiles
                        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#dockerls
                        :dockerls {:settings {:docker {:languageserver {:formatter {:ignoreMultilineInstructions true}}}}}
                        ;; https://sr.ht/~xerool/fennel-ls/
                        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#fennel_ls
                        :fennel_ls {:settings {:fennel-ls {:extra-globals :vim}}}
                        ;; LSP for Lua.
                        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#lua_ls
                        :lua_ls {:settings {:Lua {:runtime {:version :LuaJIT}
                                                  :workspace {:checkThirdParty false
                                                              :library vim.env.VIMRUNTIME}}}}
                        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#rust_analyzer
                        :rust_analyzer {}
                        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#buf_ls
                        :buf_ls {}
                        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#postgres_lsp
                        :postgres_lsp {}
                        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#tailwindcss
                        :tailwindcss {}})

(each [server settings (pairs server-settings)]
  (vim.lsp.config server settings)
  (vim.lsp.enable server))
