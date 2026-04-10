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

(let [opts {;; Start with all folds open.
            :foldlevelstart 99
            ;; Show text under fold with its highlighting
            :foldtext ""
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
            ;; Remove linematch from default diffopt
            :diffopt "internal,filler,closeoff"
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
            ;;   1 - don't break a line after a one-letter word (break before it instead, if possible)
            ;;   l - long lines are not broken in insert mode
            :formatoptions :tcqjronp1l
            ;; Treat camelCase word parts as separate words
            :spelloptions :camel
            ;; Allow going past the end of the line in blockwise mode
            :virtualedit :block
            ;; Treat dash as `word` textobject part
            :iskeyword "@,48-57,_,192-255,-"
            ;; Show tab as this number of spaces
            :tabstop 2
            ;; Set the title of the window.
            :title true
            ;; Tied to CursorHold, which makes LSP document highlighting reasonable.
            :updatetime 100
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

(set vim.g.diffs {:integrations {:fugitive true}
                  ;; Don't warn when hunks have too many lines to highlight.
                  :highlights {:warn_max_lines false}})

(vim.api.nvim_create_autocmd :PackChanged
                             {:callback (fn [ev]
                                          (let [name ev.data.spec.name
                                                kind ev.data.kind]
                                            (when (and (= name :nvim-treesitter)
                                                       (= kind :update))
                                              (when (not ev.data.active)
                                                (vim.cmd.packadd :nvim-treesitter)
                                                (vim.cmd {:cmd :TSUpdate})))
                                            (when (and (= name :mason)
                                                       (= kind :update))
                                              (when (not ev.data.active)
                                                (vim.cmd.packadd :mason)
                                                (vim.cmd {:cmd :MasonUpdate})))))})

(vim.pack.add ["https://github.com/nvim-mini/mini.nvim"
               ;; snippets
               "https://github.com/rafamadriz/friendly-snippets"
               "https://github.com/chrisgrieser/nvim-scissors"
               "https://github.com/chrisgrieser/nvim-origami"
               "https://github.com/tpope/vim-eunuch"
               "https://github.com/andymass/vim-matchup"
               "https://github.com/tpope/vim-abolish"
               "https://github.com/rktjmp/paperplanes.nvim"
               "https://github.com/lewis6991/fileline.nvim"
               "https://github.com/tpope/vim-fugitive"
               "https://github.com/tpope/vim-rhubarb"
               "https://git.sr.ht/~willdurand/srht.vim"
               "https://github.com/barrettruth/diffs.nvim"
               "https://github.com/tpope/vim-dispatch"
               ;; dispatch is a dependency of dadbod
               "https://github.com/tpope/vim-dadbod"
               "https://github.com/fladson/vim-kitty"
               "https://github.com/janet-lang/janet.vim"
               "https://github.com/qvalentin/helm-ls.nvim"
               "https://github.com/Olical/nfnl"
               "https://github.com/Olical/conjure"
               "https://github.com/gpanders/nvim-parinfer"
               "https://github.com/vim-test/vim-test"
               "https://github.com/neovim/nvim-lspconfig"
               "https://github.com/b0o/SchemaStore.nvim"
               "https://github.com/stevearc/conform.nvim"
               "https://github.com/mfussenegger/nvim-lint"
               "https://github.com/williamboman/mason.nvim"
               "https://github.com/williamboman/mason-lspconfig.nvim"
               "https://github.com/nvim-treesitter/nvim-treesitter"
               "https://github.com/nvim-treesitter/nvim-treesitter-context"
               "https://github.com/julienvincent/nvim-paredit"
               ;; Colorschemes
               "https://github.com/stefanvanburen/rams"
               "https://github.com/savq/melange-nvim"
               "https://github.com/mcchrish/zenbones.nvim"
               "https://github.com/rose-pine/neovim"
               "https://github.com/lunacookies/vim-plan9"
               "https://github.com/raphael-proust/vacme"
               "https://github.com/miikanissi/modus-themes.nvim"])

;; mini-basics should be first, to set up mappings like <Leader>
(let [mini-basics (require :mini.basics)]
  (mini-basics.setup {;; mappings override the default g0 and <C-S> from :h lsp-defaults
                      ;; for now, skip them.
                      :mappings {:basic false}}))

;; <leader> mappings shouldn't be set up until now.
(local map vim.keymap.set)

(let [mini-pairs (require :mini.pairs)]
  (mini-pairs.setup))

(let [mini-ai (require :mini.ai)]
  (mini-ai.setup))

(let [mini-splitjoin (require :mini.splitjoin)]
  (mini-splitjoin.setup))

(let [mini-starter (require :mini.starter)]
  (mini-starter.setup))

;; Enhanced `f`/`F`/`t`/`T`
(let [mini-jump (require :mini.jump)]
  (mini-jump.setup))

(let [mini-cmdline (require :mini.cmdline)]
  (mini-cmdline.setup))

;; Use <CR> in normal mode to begin jumping.
(let [mini-jump2d (require :mini.jump2d)]
  (mini-jump2d.setup))

(let [mini-keymap (require :mini.keymap)]
  (mini-keymap.setup)
  (mini-keymap.map_multistep :i :<CR> [:pmenu_accept :minipairs_cr])
  (mini-keymap.map_multistep :i :<BS> [:minipairs_bs]))

(let [mini-trailspace (require :mini.trailspace)]
  (mini-trailspace.setup)
  (map :n :<leader>sw mini-trailspace.trim {:desc "Strip whitespace"}))

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

(let [mini-pick (require :mini.pick)]
  (mini-pick.setup)
  (map :n :<leader>ff mini-pick.builtin.files {:desc "Pick files"})
  (map :n :<leader>fb mini-pick.builtin.buffers {:desc "Pick buffers"})
  (map :n :<leader>fl mini-pick.builtin.grep_live {:desc "Pick lines"})
  (map :n :<leader>fh mini-pick.builtin.help {:desc "Pick help"}))

(let [mini-extra (require :mini.extra)]
  (map :n :<leader>fd mini-extra.pickers.diagnostic {:desc "Pick diagnostics"})
  (map :n :<leader>fg mini-extra.pickers.git_files {:desc "Pick git files"})
  (map :n :<leader>fm mini-extra.pickers.keymaps {:desc "Pick keymaps"})
  (map :n :<leader>fk mini-extra.pickers.manpages {:desc "Pick manpages"})
  (map :n :<leader>fo mini-extra.pickers.options {:desc "Pick options"})
  (map :n :<leader>fc mini-extra.pickers.colorschemes
       {:desc "Pick colorschemes"}))

(let [mini-colors (require :mini.colors)]
  (mini-colors.setup))

(let [mini-misc (require :mini.misc)]
  (mini-misc.setup)
  (mini-misc.setup_termbg_sync)
  (mini-misc.setup_restore_cursor)
  (map :n :<leader>z mini-misc.zoom {:desc "Toggle zoom of the current buffer"}))

(let [mini-hipatterns (require :mini.hipatterns)]
  (mini-hipatterns.setup {:highlighters {:hex_color (mini-hipatterns.gen_highlighter.hex_color)
                                         :fixme {:pattern :FIXME
                                                 :group :MiniHipatternsFixme}
                                         :hack {:pattern :HACK
                                                :group :MiniHipatternsHack}
                                         :todo {:pattern :TODO
                                                :group :MiniHipatternsTodo}
                                         :note {:pattern :NOTE
                                                :group :MiniHipatternsNote}}}))

(let [mini-bracketed (require :mini.bracketed)]
  (mini-bracketed.setup))

(let [mini-files (require :mini.files)]
  (mini-files.setup {:mappings {:go_in_plus :<CR>}})
  (map :n "-" #(let [buf-name (vim.api.nvim_buf_get_name 0)]
                 (if (vim.uv.fs_stat buf-name)
                     (mini-files.open buf-name false)
                     (mini-files.open)))
       {:desc "Open the file picker from the current file, or in the current working directory if the file does not exist"}))

(let [mini-notify (require :mini.notify)]
  (mini-notify.setup))

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

(let [mini-completion (require :mini.completion)]
  (mini-completion.setup {:delay {:completion 1000000}}))

;;;; snippets

(local snippets-dir (.. (vim.fn.stdpath :config) :/snippets))

(let [mini-snippets (require :mini.snippets)]
  (mini-snippets.setup {:snippets [(mini-snippets.gen_loader.from_file (.. snippets-dir
                                                                           :/global.json))
                                   ;; pull in snippets matching language types, from friendly-snippets
                                   (mini-snippets.gen_loader.from_lang)]}))

(let [scissors (require :scissors)]
  (scissors.setup {:snippetDir snippets-dir}))

;;;;

(let [origami (require :origami)]
  (origami.setup {;; drop comments from autofold kinds, which are important.
                  :autoFold {:kinds [:imports]}
                  ;; Disable keymaps
                  :foldKeymaps {:setup false}}))

(set vim.g.matchup_matchparen_offscreen {:method :popup})
(let [paperplanes (require :paperplanes)]
  (paperplanes.setup {:provider :gist}))

;; Remove legacy fugitive commands (which only result in warnings, rather than something useful)
(set vim.g.fugitive_legacy_commands 0)

;; vim-dispatch
(map :n :<leader>mm ":make<cr>")
(map :n :<leader>MM ":Make<cr>")
(map :n :<leader>m! ":make!<cr>")
(map :n :<leader>M! ":Make!<cr>")

;; Set DATABASE_URL in the environment to access the configured database via dadbod.
(map :n :<leader>db #(vim.cmd {:cmd :DB :args [:$DATABASE_URL]})
     {:desc "Open dadbod to the current $DATABASE_URL"})

;; Filetype-specific plugins

;; NOTE: sql in conjure defaults to postgres.
;; for sqlite (using `sqlite3` CLI):
;; (set vim.g.conjure#client#sql#stdio#command "sqlite3 <.db-file-path>")
;; (set vim.g.conjure#client#sql#stdio#prompt_pattern "sqlite> ")
(set vim.g.conjure#highlight#enabled true)
(set vim.g.conjure#client#clojure#nrepl#connection#auto_repl#hidden true)
(set vim.g.conjure#filetype#janet :conjure.client.janet.stdio)
(set vim.g.conjure#mapping#doc_word false)

(set vim.g.test#strategy :neovim_sticky)
;; reopen the buffer if it's already open
(set vim.g.test#neovim_sticky#reopen_window 1)
;; use a little less vertical space; 30% instead of 50% is good.
;; horizontal is easier to view than vertical.
(set vim.g.test#neovim#term_position "horizontal 30")
(map :n :<leader>tt #(vim.cmd {:cmd :TestNearest}) {:desc "Run nearest test"})
(map :n :<leader>tf #(vim.cmd {:cmd :TestFile})
     {:desc "Run all tests in the file"})

(let [conform (require :conform)]
  ;; https://github.com/stevearc/conform.nvim?tab=readme-ov-file#formatters
  (conform.setup {:formatters_by_ft {:fennel [:fnlfmt]
                                     :fish [:fish_indent]
                                     :yaml {:lsp_format :never}}
                  :format_on_save {:timeout_ms 5000}
                  :default_format_opts {:lsp_format :fallback}})
  (set vim.o.formatexpr "v:lua.require'conform'.formatexpr()"))

(let [nvim-lint (require :lint)
      ;; https://github.com/mfussenegger/nvim-lint#available-linters
      linters (collect [k v (pairs {:fish [:fish]
                                    :janet [:janet]
                                    :markdown [:rumdl]
                                    :go [:golangcilint]})]
                (values k
                        (icollect [_ v (ipairs v)]
                          (if (= 1 (vim.fn.executable v)) v))))]
  (set nvim-lint.linters_by_ft linters)
  (vim.api.nvim_create_autocmd :BufWritePost {:callback #(nvim-lint.try_lint)}))

(let [mason (require :mason)]
  (mason.setup))

(let [mason-lspconfig (require :mason-lspconfig)]
  ;; NOTE: Will enable Mason-installed LSP servers by default.
  (mason-lspconfig.setup))

(let [treesitter (require :nvim-treesitter)
      treesitter-languages [:c
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
                            :git_config
                            :git_rebase
                            :gitattributes
                            :gitcommit
                            :gitignore
                            :go
                            :gomod
                            :gosum
                            :gotmpl
                            :helm
                            :html
                            :http
                            :janet_simple
                            :java
                            :javascript
                            :json
                            :json5
                            :jsx
                            :just
                            :kotlin
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
                            :tsx
                            :typescript
                            :vhs
                            :xml
                            :yaml
                            :zig]]
  (treesitter.install treesitter-languages)
  (vim.api.nvim_create_autocmd :FileType
                               {:pattern treesitter-languages
                                :callback (fn []
                                            (vim.treesitter.start)
                                            ;; Default to treesitter folding (overridden if LSP supports it)
                                            (set vim.wo.foldexpr
                                                 "v:lua.vim.treesitter.foldexpr()")
                                            (set vim.wo.foldmethod :expr))}))

(let [filetype-to-langs {:c_sharp [:csharp]
                         :bash [:shellsession :console :shell_session]
                         :objc [:objectivec]
                         :proto [:protobuf]
                         :buf-config [:yaml]}]
  (each [filetype langs (pairs filetype-to-langs)]
    (vim.treesitter.language.register filetype langs)))

;; NOTE: This must be after adding treesitter.
(let [nvim-paredit (require :nvim-paredit)]
  (nvim-paredit.setup))

;; Only enable Obsidian on PC.
(let [vault-dir "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Vault"]
  (when (= (vim.fn.isdirectory vault-dir) 1)
    (vim.pack.add ["https://github.com/obsidian-nvim/obsidian.nvim"])
    (let [obsidian (require :obsidian)]
      (obsidian.setup {:legacy_commands false
                       :workspaces [{:name :vault :path vault-dir}]}))))

;; https://smallseasons.guide
;; https://stefan.vanburen.xyz/blog/small-seasons/
(let [day-of-month (tonumber (vim.fn.strftime "%d"))
      colorscheme (case (vim.fn.strftime "%m")
                    :01 :miniwinter
                    :02 (if (< day-of-month 4) :miniwinter :minispring)
                    :03 :minispring
                    :04 :minispring
                    :05 (if (< day-of-month 6) :minispring :minisummer)
                    :06 :minisummer
                    :07 :minisummer
                    :08 (if (< day-of-month 8) :minisummer :miniautumn)
                    :09 :miniautumn
                    :10 :miniautumn
                    :11 (if (< day-of-month 8) :miniautumn :miniwinter)
                    :12 :miniwinter)]
  (vim.cmd.colorscheme colorscheme))

;;; Autocommands and FileType settings

(vim.api.nvim_create_autocmd :VimResized {:command ":wincmd ="})

(local filetype-settings
       {:go {:expandtab false :textwidth 100}
        :javascript {:expandtab true :shiftwidth 2}
        :javascriptreact {:expandtab true :shiftwidth 2}
        :typescript {:expandtab true :shiftwidth 2}
        :typescriptreact {:expandtab true :shiftwidth 2}
        :html {:expandtab true :shiftwidth 2}
        :css {:expandtab true :shiftwidth 2}
        ;; C#
        :cs {:commentstring "// %s"}
        :helm {:expandtab true :shiftwidth 2 :commentstring "{{/* %s */}}"}
        :gotmpl {:expandtab true :shiftwidth 2 :commentstring "{{/* %s */}}"}
        :fish {:expandtab true :shiftwidth 4 :commentstring "# %s"}
        :yaml {:expandtab true :shiftwidth 2}
        :svg {:expandtab true :shiftwidth 2}
        :json {:expandtab true :shiftwidth 2}
        :bash {:expandtab true :shiftwidth 2}
        :toml {:expandtab true :shiftwidth 2}
        :python {:expandtab true :shiftwidth 4}
        :xml {:expandtab true :shiftwidth 4}
        :starlark {:expandtab true :shiftwidth 4 :commentstring "# %s"}
        :proto {:expandtab true
                :shiftwidth 2
                :commentstring "// %s"
                :cindent true}
        :gitcommit {:spell true}
        :gitconfig {:expandtab false :shiftwidth 2}
        :fennel {:commentstring ";; %s"}
        :sql {:wrap true :commentstring "-- %s" :expandtab true :shiftwidth 4}
        :clojure {:expandtab true :textwidth 80}
        :kotlin {:commentstring "// %s"}
        :just {:expandtab true :shiftwidth 4}
        :markdown {:spell true :wrap true :expandtab false}})

(let [aufiletypes (vim.api.nvim_create_augroup :filetypes {})]
  (each [filetype settings (pairs filetype-settings)]
    (vim.api.nvim_create_autocmd :FileType
                                 {:group aufiletypes
                                  :pattern filetype
                                  :callback #(each [name value (pairs settings)]
                                               (vim.api.nvim_set_option_value name
                                                                              value
                                                                              {:scope :local}))})))

(local yaml-ghactions-filetype :yaml.ghactions)

(vim.filetype.add {:extension {:mdx :markdown
                               :star :starlark
                               :gotext :gotmpl
                               :gotmpl :gotmpl}
                   :filename {:.ignore :gitignore
                              :.dockerignore :gitignore
                              :buf.yaml :buf-config
                              :buf.gen.yaml :buf-config
                              :buf.policy.yaml :buf-config
                              :buf.lock :buf-config
                              :uv.lock :toml}
                   :pattern {".*/%.github/workflows/.*%.ya?ml" yaml-ghactions-filetype}})

;; Skeleton files.
;; :h skeleton
(each [pattern skeleton-file (pairs {:buf.gen.yaml :buf.gen.yaml
                                     :.nfnl.fnl :.nfnl.fnl
                                     :justfile :justfile})]
  (vim.api.nvim_create_autocmd :BufNewFile
                               {: pattern
                                :command (.. "0r ~/.config/nvim/skeletons/"
                                             skeleton-file)}))

;; Template files.
(vim.api.nvim_create_autocmd :BufNewFile
                             {:pattern "*"
                              :callback (fn [args]
                                          (let [fname (vim.fs.basename args.file)
                                                ext (vim.fn.fnamemodify args.file
                                                                        ":e")
                                                ft (. vim.bo args.buf :filetype)
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
                                                  (vim.snippet.expand (f:read :*a))
                                                  (set done? true))))))})

;;; Mappings

(map :n :<leader>du vim.pack.update)
(map :n :<leader>ma #(vim.cmd {:cmd :Mason}))

;; ; -> :
(map :n ";" ":")

;; Fugitive
(map :n :<leader>gs #(vim.cmd {:cmd :Git :mods {:vertical true}})
     {:desc "Open :Git in a vertical split"})

(map :n :<leader>gw #(vim.cmd {:cmd :Gwrite}) {:desc ":Gwrite"})
(map :n :<leader>gc #(vim.cmd {:cmd :Git :args [:commit]})
     {:desc ":Git commit"})

(map :n :<leader>gp #(vim.cmd {:cmd :Git :args [:push]}) {:desc ":Git push"})
(map :n :<leader>gb #(vim.cmd {:cmd :Git :args [:blame]}) {:desc ":Git blame"})

;; move by visual lines instead of real lines, except when a count is provided,
;; which helps when targeting a specific line with `relativenumber`.
(map [:n :v] :j #(if (not= vim.v.count 0) :j :gj) {:expr true})
(map [:n :v] :k #(if (not= vim.v.count 0) :k :gk) {:expr true})

;; Navigate between matching brackets
;; These specifically `remap` because we want to be bound to whatever % is
;; (currently vim-matchup).
(map [:n :v] :<tab> "%"
     {:remap true :desc "Navigate between matching brackets"})

;; edit config files
(each [keymap file (pairs {:<leader>ef :$HOME/.config/fish/config.fish
                           :<leader>egi :$HOME/.config/git/config
                           :<leader>ego :$HOME/.config/ghostty/config
                           :<leader>ek :$HOME/.config/kitty/kitty.conf
                           :<leader>ev :$HOME/.config/nvim/init.fnl})]
  (map :n keymap #(vim.cmd {:cmd :edit :args [file]})
       {:desc (.. ":edit " file)}))

(map :n :<leader>w #(vim.cmd {:cmd :write})
     {:desc ":write the buffer to the file"})

(map :n :<leader>ss #(vim.cmd {:cmd :split})
     {:desc "Create a horizontal split"})

(map :n :<leader>vs #(vim.cmd {:cmd :vsplit}) {:desc "Create a vertical split"})

;; Use Q to repeat last macro, rather than going into ex mode
(map :n :Q "@@" {:desc "Repeat last macro"})

;; Swap the behavior of the ^ and 0 operators
;; ^ Usually goes to the first non-whitespace character, while 0 goes to the
;; first column in the line. ^ is more useful, but harder to hit, so swap it
;; with 0
(map :n :0 "^" {:desc "Go to first non-whitespace character"})
(map :n "^" :0 {:desc "Go to first column in the line"})

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

;; inspect the current position
(map :n :<leader>i #(vim.show_pos))

;; <c-k> escape sequences.
(map :i :<c-k> :<esc>)
(map :c :<c-k> :<c-c>)
(map :t :<c-k> "<c-\\><c-n>")

;; tab commands.
(map :n :<leader>tn #(vim.cmd {:cmd :tabnew}) {:desc "Create a new tab"})
(map :n "]r" #(vim.cmd {:cmd :tabnext}) {:desc "Go to next tab"})
(map :n "[r" #(vim.cmd {:cmd :tabprev}) {:desc "Go to prev tab"})

(map :n :<C-l> ":nohlsearch<cr>")

;;; Diagnostics

(vim.diagnostic.config {:signs {:text {vim.diagnostic.severity.ERROR "×"
                                       vim.diagnostic.severity.WARN "!"
                                       vim.diagnostic.severity.INFO "✳︎"
                                       vim.diagnostic.severity.HINT "?"}}
                        :virtual_text {:severity {:min vim.diagnostic.severity.WARN}}
                        :underline true
                        :float {:border :single
                                :focusable false
                                :source :always}})

;;; LSP

(fn lsp-attach [{: buf :data {: client_id}}]
  (local client (vim.lsp.get_client_by_id client_id))
  ;; NOTE: Formatting is handled by conform.
  (when (client:supports_method :textDocument/codeAction)
    (fn organize-imports []
      (vim.lsp.buf.code_action {:context {:only [:source.organizeImports]}
                                :apply true}))

    (vim.api.nvim_buf_create_user_command buf :OrganizeImports organize-imports
                                          {:desc "Organize Imports"})
    (map :n :gro #(vim.cmd {:cmd :OrganizeImports}) {:desc "Organize Imports"}))
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
  (when (client:supports_method :textDocument/foldingRange)
    (tset vim.wo (vim.api.nvim_get_current_win) :foldexpr
          "v:lua.vim.lsp.foldexpr()"))
  (when (client:supports_method :textDocument/codeLens)
    (let [augroup-id (vim.api.nvim_create_augroup :lsp-code-lens {:clear false})]
      (vim.api.nvim_create_autocmd [:BufEnter :CursorHold :InsertLeave]
                                   {:group augroup-id
                                    :buffer buf
                                    :callback #(vim.lsp.codelens.enable true)})))
  (map :n :gD vim.lsp.buf.declaration {:buffer buf :desc "Go to declaration"}))

(vim.api.nvim_create_autocmd :LspAttach {:callback lsp-attach})

(local schemastore (require :schemastore))

(local server-settings
       {;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#gopls
        :gopls {;; https://go.dev/gopls/daemon
                :cmd [:gopls :-remote=auto]
                :settings {:gopls {;; https://go.dev/gopls/settings#semantictokens-bool
                                   :semanticTokens true
                                   ;; https://github.com/golang/tools/blob/master/gopls/doc/inlayHints.md
                                   :hints {:constantValues true}}}}
        ;;; https://github.com/b0o/SchemaStore.nvim#usage
        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#jsonls
        :jsonls {:settings {:json {:schemas (schemastore.json.schemas)
                                   :validate {:enable true}}}
                 :filetypes [:json :jsonc :json5]}
        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#yamlls
        :yamlls {:settings {:yaml {:schemas (schemastore.yaml.schemas)
                                   :schemaStore {:enable false :url ""}}}}
        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#clojure_lsp
        :clojure_lsp {}
        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#biome
        :biome {}
        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#fish_lsp
        :fish_lsp {}
        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#janet_lsp
        :janet_lsp {}
        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#ruff
        :ruff {}
        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#helm_ls
        :helm_ls {}
        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#bashls
        :bashls {}
        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#tombi
        :tombi {}
        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#omnisharp
        ;; NOTE: Download omnisharp with mason.
        :omnisharp {:cmd [:omnisharp]}
        ;; Dockerfiles
        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#docker_language_server
        :docker_language_server {}
        ;; https://sr.ht/~xerool/fennel-ls/
        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#fennel_ls
        ;; See ./flsproject.fnl for configuration.
        ;; :fennel_ls {}
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
        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#ty
        :ty {}
        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#starpls
        :starpls {:filetypes [:bzl :starlark]}
        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#cue
        :cue {}
        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#ts_query_ls
        :ts_query_ls {}
        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#just
        :just {}
        ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#gh_actions_ls
        :gh_actions_ls {:filetypes [yaml-ghactions-filetype]}
        ;; https://github.com/stefanvanburen/cells
        :cells {:cmd [:cells :serve] :filetypes [:cel]}
        ;; https://docs.zizmor.sh/integrations/#generic-lsp-integration
        :zizmor {:cmd [:zizmor :--lsp] :filetypes [yaml-ghactions-filetype]}
        ;; https://docs.syntaqlite.com/v0.2.15/getting-started/other-editors/
        :syntaqlite {:cmd [:syntaqlite :lsp]
                     :filetypes [:sql]
                     :root_markers [:syntaqlite.toml :.git]}})

(vim.lsp.config "*" {:root_markers [:.git]})
(each [server settings (pairs server-settings)]
  (vim.lsp.config server settings)
  (vim.lsp.enable server))
