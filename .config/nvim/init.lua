-- [nfnl] init.fnl
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.maplocalleader = ","
do
  local opts = {foldlevelstart = 99, foldtext = "", breakindentopt = "sbr,list:-1", showbreak = "\226\134\179 ", shiftround = true, gdefault = true, copyindent = true, list = true, listchars = {tab = "\226\135\165 ", eol = "\194\172", trail = "\226\163\191", nbsp = "\226\144\163"}, grepprg = "rg --vimgrep", clipboard = "unnamedplus", undofile = true, exrc = true, cursorlineopt = "number", diffopt = "internal,filler,closeoff", completeopt = "fuzzy,menu,menuone,popup,noselect", formatoptions = "tcqjronp1l", spelloptions = "camel", virtualedit = "block", iskeyword = "@,48-57,_,192-255,-", tabstop = 2, title = true, updatetime = 250, wildignorecase = true, inccommand = "split", winborder = "rounded", swapfile = false}
  for opt, val in pairs(opts) do
    vim.opt[opt] = val
  end
end
vim.g.diffs = {integrations = {fugitive = true}, highlights = {warn_max_lines = false}}
local function _1_(ev)
  for pkg, cmd in pairs({["nvim-treesitter"] = "TSUpdate", mason = "MasonUpdate"}) do
    if ((ev.data.spec.name == pkg) and (ev.data.kind == "update")) then
      if not ev.data.active then
        vim.cmd.packadd(pkg)
      else
      end
      vim.cmd({cmd = cmd})
    else
    end
  end
  if (ev.data.spec.name == "tree-sitter-ghostty") then
    local pkg_dir = (vim.fn.stdpath("data") .. "/site/pack/core/opt/tree-sitter-ghostty")
    local proc = vim.system({"make", "-C", pkg_dir, "nvim_install"})
    return proc:wait()
  else
    return nil
  end
end
vim.api.nvim_create_autocmd("PackChanged", {group = vim.api.nvim_create_augroup("pack-changed", {}), callback = _1_})
vim.pack.add({"https://github.com/nvim-mini/mini.nvim", "https://github.com/rafamadriz/friendly-snippets", "https://github.com/chrisgrieser/nvim-scissors", "https://github.com/chrisgrieser/nvim-origami", "https://github.com/tpope/vim-eunuch", "https://github.com/andymass/vim-matchup", "https://github.com/tpope/vim-abolish", "https://github.com/rktjmp/paperplanes.nvim", "https://github.com/tpope/vim-fugitive", "https://github.com/tpope/vim-rhubarb", "https://git.sr.ht/~willdurand/srht.vim", "https://git.sr.ht/~mellow/supplement.nvim", "https://forge.barrettruth.com/barrettruth/diffs.nvim", "https://forge.barrettruth.com/barrettruth/ci.nvim", "https://forge.barrettruth.com/barrettruth/forge.nvim", "https://github.com/tpope/vim-dispatch", "https://github.com/tpope/vim-dadbod", "https://github.com/janet-lang/janet.vim", "https://github.com/qvalentin/helm-ls.nvim", "https://github.com/Olical/nfnl", "https://github.com/Olical/conjure", "https://github.com/gpanders/nvim-parinfer", "https://github.com/vim-test/vim-test", "https://github.com/neovim/nvim-lspconfig", "https://github.com/b0o/SchemaStore.nvim", "https://github.com/stevearc/conform.nvim", "https://github.com/mfussenegger/nvim-lint", "https://github.com/mason-org/mason.nvim", "https://github.com/mason-org/mason-lspconfig.nvim", "https://github.com/nvim-treesitter/nvim-treesitter", "https://github.com/nvim-treesitter/nvim-treesitter-context", "https://github.com/bezhermoso/tree-sitter-ghostty", "https://github.com/julienvincent/nvim-paredit", "https://github.com/stefanvanburen/rams", "https://github.com/rktjmp/lush.nvim", "https://github.com/zenbones-theme/zenbones.nvim", "https://github.com/rose-pine/neovim", "https://github.com/stefanvanburen/usgc-nvim", "https://github.com/miikanissi/modus-themes.nvim"})
do
  local mini_basics = require("mini.basics")
  mini_basics.setup({mappings = {basic = false}})
end
local map = vim.keymap.set
for _, module in ipairs({"pairs", "ai", "splitjoin", "move", "starter", "jump", "cmdline", "jump2d", "colors", "indentscope", "bracketed"}) do
  require(("mini." .. module)).setup()
end
local function _5_()
  return vim.treesitter.select("parent", vim.v.count1)
end
map("x", "+", _5_, {desc = "Select parent node"})
local function _6_()
  return vim.treesitter.select("child", vim.v.count1)
end
map("x", "-", _6_, {desc = "Select child node"})
do
  local mini_keymap = require("mini.keymap")
  mini_keymap.setup()
  mini_keymap.map_multistep("i", "<CR>", {"pmenu_accept", "minipairs_cr"})
  mini_keymap.map_multistep("i", "<BS>", {"minipairs_bs"})
end
local matchup_clues = {{mode = "x", keys = "[%", desc = "Go to previous unmatched group"}, {mode = "x", keys = "]%", desc = "Go to next unmatched group"}, {mode = "x", keys = "g%", desc = "Cycle through matching groups"}, {mode = "n", keys = "z%", desc = "Go inside nearest block"}, {mode = "x", keys = "z%", desc = "Go inside nearest block"}}
local dispatch_clues = {{mode = "n", keys = "g'<CR>", desc = ":Spawn"}, {mode = "n", keys = "g'<Space>", desc = ":Spawn (prompts for command)"}, {mode = "n", keys = "g'!", desc = ":Spawn!"}, {mode = "n", keys = "g'?", desc = "Show 'shell'"}, {mode = "n", keys = "g`<CR>", desc = ":Spawn"}, {mode = "n", keys = "g`<Space>", desc = ":Spawn (prompts for command)"}, {mode = "n", keys = "g`!", desc = ":Spawn!"}, {mode = "n", keys = "g`?", desc = "Show 'shell'"}}
do
  local mini_clue = require("mini.clue")
  mini_clue.setup({triggers = {{mode = "n", keys = "<Leader>"}, {mode = "x", keys = "<Leader>"}, {mode = "n", keys = "<LocalLeader>"}, {mode = "x", keys = "<LocalLeader>"}, {mode = "n", keys = "g"}, {mode = "x", keys = "g"}, {mode = "n", keys = "z"}, {mode = "x", keys = "z"}, {mode = "n", keys = "'"}, {mode = "n", keys = "`"}, {mode = "n", keys = "\""}, {mode = "x", keys = "\""}, {mode = "i", keys = "<C-r>"}, {mode = "c", keys = "<C-r>"}, {mode = "n", keys = "<C-w>"}, {mode = "n", keys = "["}, {mode = "n", keys = "]"}}, clues = {mini_clue.gen_clues.builtin_completion(), mini_clue.gen_clues.g(), mini_clue.gen_clues.marks(), mini_clue.gen_clues.registers(), mini_clue.gen_clues.square_brackets(), mini_clue.gen_clues.windows(), mini_clue.gen_clues.z(), {mode = "n", keys = "<Leader>d", desc = "+deps/db"}, {mode = "n", keys = "<Leader>e", desc = "+edit config"}, {mode = "n", keys = "<Leader>f", desc = "+find"}, {mode = "n", keys = "<Leader>g", desc = "+git"}, {mode = "n", keys = "<Leader>s", desc = "+split/strip"}, {mode = "n", keys = "<Leader>t", desc = "+test/tab"}, {mode = "n", keys = "<Leader>v", desc = "+vertical split"}, matchup_clues, dispatch_clues}, window = {config = {width = 50}}})
end
do
  local mini_trailspace = require("mini.trailspace")
  mini_trailspace.setup()
  map("n", "<leader>sw", mini_trailspace.trim, {desc = "Strip whitespace"})
end
do
  local mini_surround = require("mini.surround")
  mini_surround.setup({mappings = {add = "ys", delete = "ds", find = "", find_left = "", highlight = "", replace = "cs", update_n_lines = "", suffix_last = "", suffix_next = ""}, search_method = "cover_or_next"})
  vim.keymap.del("x", "ys")
  map("x", "S", ":<C-U>lua MiniSurround.add('visual')<CR>", {silent = true, desc = "Add surround (visual)"})
  map("n", "yss", "ys_", {remap = true, desc = "Surround current line"})
end
do
  local mini_pick = require("mini.pick")
  mini_pick.setup()
  map("n", "<leader>ff", mini_pick.builtin.files, {desc = "Pick files"})
  map("n", "<leader>fb", mini_pick.builtin.buffers, {desc = "Pick buffers"})
  map("n", "<leader>fl", mini_pick.builtin.grep_live, {desc = "Pick grep (live)"})
  map("n", "<leader>fh", mini_pick.builtin.help, {desc = "Pick help"})
  map("n", "<leader>fR", mini_pick.builtin.resume, {desc = "Resume last picker"})
end
do
  local mini_extra = require("mini.extra")
  map("n", "<leader>fd", mini_extra.pickers.diagnostic, {desc = "Pick diagnostics"})
  map("n", "<leader>fg", mini_extra.pickers.git_files, {desc = "Pick git files"})
  map("n", "<leader>fm", mini_extra.pickers.keymaps, {desc = "Pick keymaps"})
  map("n", "<leader>fk", mini_extra.pickers.manpages, {desc = "Pick manpages"})
  map("n", "<leader>fo", mini_extra.pickers.options, {desc = "Pick options"})
  map("n", "<leader>fc", mini_extra.pickers.colorschemes, {desc = "Pick colorschemes"})
  map("n", "<leader>fr", mini_extra.pickers.oldfiles, {desc = "Pick recent files"})
  map("n", "<leader>fH", mini_extra.pickers.git_hunks, {desc = "Pick git hunks"})
  map("n", "<leader>ft", mini_extra.pickers.treesitter, {desc = "Pick treesitter nodes"})
  local function _7_()
    return mini_extra.pickers.buf_lines({scope = "current"})
  end
  map("n", "<leader>f/", _7_, {desc = "Pick lines in buffer"})
  local function _8_()
    return mini_extra.pickers.lsp({scope = "document_symbol"})
  end
  map("n", "<leader>fs", _8_, {desc = "Pick document symbols"})
  local function _9_()
    return mini_extra.pickers.lsp({scope = "workspace_symbol_live"})
  end
  map("n", "<leader>fS", _9_, {desc = "Pick workspace symbols (live)"})
  local function _10_()
    return mini_extra.pickers.list({scope = "quickfix"})
  end
  map("n", "<leader>fq", _10_, {desc = "Pick quickfix list"})
  local function _11_()
    return mini_extra.pickers.list({scope = "jump"})
  end
  map("n", "<leader>fj", _11_, {desc = "Pick jumplist"})
end
do
  local mini_misc = require("mini.misc")
  mini_misc.setup()
  mini_misc.setup_restore_cursor()
  mini_misc.setup_auto_root()
  map("n", "<leader>z", mini_misc.zoom, {desc = "Toggle zoom of the current buffer"})
end
local github_reference_patterns
do
  local sha = "[%da-f][%da-f][%da-f][%da-f][%da-f][%da-f][%da-f]+"
  local owner = "%f[%w_.%-/][%w%-]+"
  local repo = "/[%w_.%-]+"
  local word_end = "%f[^%w_]"
  local tbl_26_ = {}
  local i_27_ = 0
  for _, pattern in ipairs({"%f[#%w_]#%d+", "%f[%w_]GH%-%d+", (owner .. repo .. "#%d+"), ("%f[%w_@]" .. sha), (owner .. "@" .. sha), (owner .. repo .. "@" .. sha)}) do
    local val_28_
    local function _12_(_241)
      if (vim.bo[_241].filetype == "gitcommit") then
        return (pattern .. word_end)
      else
        return nil
      end
    end
    val_28_ = _12_
    if (nil ~= val_28_) then
      i_27_ = (i_27_ + 1)
      tbl_26_[i_27_] = val_28_
    else
    end
  end
  github_reference_patterns = tbl_26_
end
local github_reference_nodes = {subject = true, message_line = true, trailer = true, breaking_change = true}
local function github_reference_group(buf, text, data)
  local sha = (text:match("@(%x+)$") or text:match("^%x+$"))
  local plausible_sha_3f = ((nil == sha) or ((#sha <= 40) and sha:find("%a")))
  local node = vim.treesitter.get_node({bufnr = buf, pos = {(data.line - 1), (data.from_col - 1)}})
  while (node and not github_reference_nodes[node:type()]) do
    node = node:parent()
  end
  if (node and plausible_sha_3f) then
    return "@markup.link"
  else
    return nil
  end
end
local function github_repo(buf)
  if (nil == vim.b[buf].github_repo) then
    local dir = vim.fs.dirname(vim.api.nvim_buf_get_name(buf))
    local result = vim.system({"git", "-C", dir, "remote", "get-url", "origin"}, {text = true}):wait()
    local remote
    if (result.code == 0) then
      remote = vim.trim(result.stdout)
    else
      remote = ""
    end
    vim.b[buf]["github_repo"] = (remote:gsub("%.git$", ""):match("github%.com[:/]([^/]+/[^/]+)$") or false)
  else
  end
  return (vim.b[buf].github_repo or nil)
end
local function github_reference_path(text, here)
  local repo, issue = text:match("^(.+/.+)#(%d+)$")
  local local_issue = (text:match("^#(%d+)$") or text:match("^GH%-(%d+)$"))
  local repo_commit, repo_sha = text:match("^(.+/.+)@(%x+)$")
  local user, user_sha = text:match("^([^/]+)@(%x+)$")
  local sha = text:match("^%x+$")
  if repo then
    return (repo .. "/issues/" .. issue)
  elseif (local_issue and here) then
    return (here .. "/issues/" .. local_issue)
  elseif repo_commit then
    return (repo_commit .. "/commit/" .. repo_sha)
  elseif (user and here) then
    return (user .. "/" .. here:match("[^/]+$") .. "/commit/" .. user_sha)
  elseif (sha and here) then
    return (here .. "/commit/" .. sha)
  else
    return nil
  end
end
local function github_reference_extmark(buf, text, data)
  local path = github_reference_path(text, github_repo(buf))
  local _19_
  if path then
    _19_ = ("https://github.com/" .. path)
  else
    _19_ = nil
  end
  return {hl_group = data.hl_group, end_row = (data.line - 1), end_col = data.to_col, priority = 200, url = _19_}
end
do
  local mini_hipatterns = require("mini.hipatterns")
  mini_hipatterns.setup({highlighters = {github_reference = {pattern = github_reference_patterns, group = github_reference_group, extmark_opts = github_reference_extmark}, hex_color = mini_hipatterns.gen_highlighter.hex_color(), fixme = {pattern = "FIXME", group = "MiniHipatternsFixme"}, hack = {pattern = "HACK", group = "MiniHipatternsHack"}, todo = {pattern = "TODO", group = "MiniHipatternsTodo"}, note = {pattern = "NOTE", group = "MiniHipatternsNote"}}})
end
local function _21_(args)
  vim.b[args.buf]["miniindentscope_disable"] = true
  return nil
end
vim.api.nvim_create_autocmd("FileType", {group = vim.api.nvim_create_augroup("indentscope-disable", {}), pattern = {"checkhealth", "diff", "fugitive", "git", "gitcommit", "help", "man", "minifiles", "qf", "starter"}, callback = _21_})
do
  local mini_files = require("mini.files")
  mini_files.setup({mappings = {go_in_plus = "<CR>"}})
  local function _22_()
    local buf_name = vim.api.nvim_buf_get_name(0)
    if vim.uv.fs_stat(buf_name) then
      return mini_files.open(buf_name, false)
    else
      return mini_files.open()
    end
  end
  map("n", "-", _22_, {desc = "Open the file picker from the current file, or in the current working directory if the file does not exist"})
end
do
  local mini_notify = require("mini.notify")
  mini_notify.setup()
  map("n", "<leader>fn", mini_notify.show_history, {desc = "Pick notifications"})
end
do
  local mini_diff = require("mini.diff")
  mini_diff.setup({view = {signs = {add = "\226\148\131", change = "\226\148\131", delete = "\226\150\129"}, style = "sign"}})
  map("n", "<leader>go", mini_diff.toggle_overlay, {desc = "Toggle diff overlay"})
end
do
  local mini_git = require("mini.git")
  mini_git.setup()
  map({"n", "x"}, "<leader>gi", mini_git.show_at_cursor, {desc = "Git info at cursor"})
end
do
  local mini_icons = require("mini.icons")
  mini_icons.setup({style = "ascii"})
  mini_icons.tweak_lsp_kind()
end
for _, module in ipairs({"statusline", "tabline", "input", "statuscolumn"}) do
  require(("mini." .. module)).setup()
end
local snippets_dir = vim.fs.joinpath(vim.fn.stdpath("config"), "snippets")
do
  local mini_snippets = require("mini.snippets")
  mini_snippets.setup({snippets = {mini_snippets.gen_loader.from_file(vim.fs.joinpath(snippets_dir, "global.json")), mini_snippets.gen_loader.from_lang()}})
end
do
  local scissors = require("scissors")
  scissors.setup({snippetDir = snippets_dir})
end
do
  local origami = require("origami")
  origami.setup({autoFold = {kinds = {"imports"}}, foldKeymaps = {setup = false}})
end
vim.g.matchup_matchparen_offscreen = {method = "popup"}
do
  local paperplanes = require("paperplanes")
  paperplanes.setup({provider = "gist"})
end
vim.g.fugitive_legacy_commands = 0
map("n", "<leader>mm", ":make<cr>", {desc = ":make"})
map("n", "<leader>MM", ":Make<cr>", {desc = ":Make (vim-dispatch async)"})
map("n", "<leader>m!", ":make!<cr>", {desc = ":make! (no jump to first error)"})
map("n", "<leader>M!", ":Make!<cr>", {desc = ":Make! (vim-dispatch async, no jump to first error)"})
local function _24_()
  return vim.cmd({cmd = "DB", args = {"$DATABASE_URL"}})
end
map("n", "<leader>db", _24_, {desc = "Open dadbod to the current $DATABASE_URL"})
vim.g["conjure#highlight#enabled"] = true
vim.g["conjure#client#clojure#nrepl#connection#auto_repl#hidden"] = true
vim.g["conjure#filetype#janet"] = "conjure.client.janet.stdio"
vim.g["conjure#mapping#doc_word"] = false
vim.g["test#strategy"] = "neovim_sticky"
vim.g["test#neovim_sticky#reopen_window"] = 1
vim.g["test#neovim#term_position"] = "horizontal 30"
local function _25_()
  return vim.cmd({cmd = "TestNearest"})
end
map("n", "<leader>tt", _25_, {desc = "Run nearest test"})
local function _26_()
  return vim.cmd({cmd = "TestFile"})
end
map("n", "<leader>tf", _26_, {desc = "Run all tests in the file"})
do
  local conform = require("conform")
  conform.setup({formatters_by_ft = {fennel = {"fnlfmt"}, fish = {"fish_indent"}, yaml = {lsp_format = "never"}, json5 = {lsp_format = "never"}}, format_on_save = {timeout_ms = 5000}, default_format_opts = {lsp_format = "fallback"}})
  vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
end
do
  local nvim_lint = require("lint")
  local linters
  do
    local tbl_21_ = {}
    for k, v in pairs({fish = {"fish"}, janet = {"janet"}, markdown = {"rumdl"}}) do
      local k_22_, v_23_
      local function _27_(...)
        local tbl_26_ = {}
        local i_27_ = 0
        for _, v0 in ipairs(v) do
          local val_28_
          if (1 == vim.fn.executable(v0)) then
            val_28_ = v0
          else
            val_28_ = nil
          end
          if (nil ~= val_28_) then
            i_27_ = (i_27_ + 1)
            tbl_26_[i_27_] = val_28_
          else
          end
        end
        return tbl_26_
      end
      k_22_, v_23_ = k, _27_(...)
      if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
        tbl_21_[k_22_] = v_23_
      else
      end
    end
    linters = tbl_21_
  end
  local golangci_configs = {".golangci.yml", ".golangci.yaml", ".golangci.toml", ".golangci.json"}
  local lint_go
  local function _31_(buf)
    local root = vim.fs.root(buf, golangci_configs)
    if (root and (1 == vim.fn.executable("golangci-lint"))) then
      return nvim_lint.try_lint("golangcilint", {cwd = root})
    else
      return nil
    end
  end
  lint_go = _31_
  nvim_lint.linters_by_ft = linters
  local function _33_(ev)
    if ("go" == vim.bo[ev.buf].filetype) then
      return lint_go(ev.buf)
    else
      return nvim_lint.try_lint()
    end
  end
  vim.api.nvim_create_autocmd("BufWritePost", {group = vim.api.nvim_create_augroup("lint", {}), callback = _33_})
end
do
  local mason = require("mason")
  mason.setup()
end
do
  local mason_lspconfig = require("mason-lspconfig")
  mason_lspconfig.setup({automatic_enable = false})
end
local function parser_fork(url, branch)
  local head
  if (vim.v.vim_did_enter == 1) then
    local result = vim.system({"git", "ls-remote", url, ("refs/heads/" .. branch)}, {text = true, timeout = 10000}):wait()
    if (result.code == 0) then
      head = result.stdout:match("^%x+")
    else
      head = nil
    end
  else
    head = nil
  end
  return {url = url, branch = branch, revision = head}
end
local function _37_()
  require("nvim-treesitter.parsers")["go"]["install_info"] = parser_fork("https://github.com/stefanvanburen/tree-sitter-go", "master")
  return nil
end
vim.api.nvim_create_autocmd("User", {group = vim.api.nvim_create_augroup("treesitter-go-fork", {}), pattern = "TSUpdate", callback = _37_})
local function _38_()
  require("nvim-treesitter.parsers")["cel"] = {install_info = parser_fork("https://github.com/stefanvanburen/tree-sitter-cel", "main")}
  return nil
end
vim.api.nvim_create_autocmd("User", {group = vim.api.nvim_create_augroup("treesitter-cel-fork", {}), pattern = "TSUpdate", callback = _38_})
do
  local treesitter = require("nvim-treesitter")
  local treesitter_parsers = {"c", "lua", "vim", "vimdoc", "query", "bash", "c_sharp", "cel", "clojure", "comment", "css", "diff", "djot", "dockerfile", "editorconfig", "fennel", "fish", "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore", "go", "gomod", "gosum", "gotmpl", "helm", "html", "http", "janet_simple", "java", "javascript", "json", "json5", "jsx", "just", "kotlin", "make", "markdown", "markdown_inline", "proto", "python", "requirements", "ruby", "rust", "sql", "ssh_config", "starlark", "textproto", "toml", "tsx", "typescript", "vhs", "xml", "yaml", "zig"}
  treesitter.install(treesitter_parsers)
  local function _39_(args)
    if pcall(vim.treesitter.start, args.buf) then
      vim.wo[0][0]["foldexpr"] = "v:lua.vim.treesitter.foldexpr()"
      vim.wo[0][0]["foldmethod"] = "expr"
      return nil
    else
      return nil
    end
  end
  vim.api.nvim_create_autocmd("FileType", {group = vim.api.nvim_create_augroup("treesitter", {}), callback = _39_})
end
do
  local filetype_to_langs = {c_sharp = {"csharp"}, bash = {"shellsession", "console", "shell_session"}, objc = {"objectivec"}, proto = {"protobuf"}, yaml = {"buf-config", "yaml.github-actions"}, starlark = {"tiltfile"}}
  for filetype, langs in pairs(filetype_to_langs) do
    vim.treesitter.language.register(filetype, langs)
  end
end
do
  local nvim_paredit = require("nvim-paredit")
  nvim_paredit.setup()
end
do
  local helm_ls = require("helm-ls")
  helm_ls.setup()
end
local function seasonal_colorscheme()
  local now = os.date("*t")
  local case_41_ = now.month
  if (case_41_ == 1) then
    return "miniwinter"
  elseif (case_41_ == 2) then
    if (now.day < 4) then
      return "miniwinter"
    else
      return "minispring"
    end
  elseif (case_41_ == 3) then
    return "minispring"
  elseif (case_41_ == 4) then
    return "minispring"
  elseif (case_41_ == 5) then
    if (now.day < 6) then
      return "minispring"
    else
      return "minisummer"
    end
  elseif (case_41_ == 6) then
    return "minisummer"
  elseif (case_41_ == 7) then
    return "minisummer"
  elseif (case_41_ == 8) then
    if (now.day < 8) then
      return "minisummer"
    else
      return "miniautumn"
    end
  elseif (case_41_ == 9) then
    return "miniautumn"
  elseif (case_41_ == 10) then
    return "miniautumn"
  elseif (case_41_ == 11) then
    if (now.day < 8) then
      return "miniautumn"
    else
      return "miniwinter"
    end
  elseif (case_41_ == 12) then
    return "miniwinter"
  else
    return nil
  end
end
local constant_highlights = {["@lsp.mod.readonly.go"] = {link = "@constant"}, ["@lsp.typemod.variable.defaultLibrary.go"] = {link = "@constant.builtin"}, ["@lsp.typemod.variable.static.go"] = {}, ["@lsp.mod.readonly.python"] = {link = "@constant"}}
local function _47_()
  for group, hl in pairs(constant_highlights) do
    vim.api.nvim_set_hl(0, group, hl)
  end
  return nil
end
vim.api.nvim_create_autocmd("ColorScheme", {group = vim.api.nvim_create_augroup("lsp-constants", {}), callback = _47_})
local function _48_()
  local function _49_()
    local tmp_9_ = vim.api.nvim_get_hl(0, {name = "LspReferenceText", link = false})
    tmp_9_["underline"] = true
    return tmp_9_
  end
  return vim.api.nvim_set_hl(0, "LspReferenceWrite", _49_())
end
vim.api.nvim_create_autocmd("ColorScheme", {group = vim.api.nvim_create_augroup("lsp-reference-write", {}), callback = _48_})
vim.cmd.colorscheme(seasonal_colorscheme())
local function _50_()
  return vim.cmd.colorscheme(seasonal_colorscheme())
end
vim.api.nvim_create_autocmd("OptionSet", {group = vim.api.nvim_create_augroup("background", {}), nested = true, pattern = "background", callback = _50_})
vim.api.nvim_create_autocmd("VimResized", {group = vim.api.nvim_create_augroup("resize", {}), command = ":wincmd ="})
local fileline_patterns = {"^(.+):(%d+):(%d+):?$", "^(.+):(%d+):?$", "^(.+)%((%d+):(%d+)%)$", "^(.+)%((%d+)%)$", "^(.+)#L(%d+)-L?%d+$", "^(.+)#L(%d+)$"}
local function parse_fileline(name)
  local result = nil
  for _, pat in ipairs(fileline_patterns) do
    if result then break end
    local file, line, col = string.match(name, pat)
    if file then
      result = {file = file, line = tonumber(line), col = tonumber(col)}
    else
    end
  end
  return result
end
local function fileline_jump(args)
  local parsed
  if (vim.bo[args.buf].buftype == "") then
    parsed = parse_fileline(args.file)
  else
    parsed = nil
  end
  if (parsed and (1 == vim.fn.filereadable(parsed.file))) then
    local orphan = args.buf
    vim.cmd.edit({args = {vim.fn.fnameescape(parsed.file)}, mods = {keepalt = true}})
    local function _53_()
      if vim.api.nvim_buf_is_valid(orphan) then
        return vim.api.nvim_buf_delete(orphan, {})
      else
        return nil
      end
    end
    vim.schedule(_53_)
    do
      local lnum = math.max(1, math.min(parsed.line, vim.api.nvim_buf_line_count(0)))
      local ccol
      if parsed.col then
        ccol = math.max(0, (parsed.col - 1))
      else
        ccol = 0
      end
      vim.api.nvim_win_set_cursor(0, {lnum, ccol})
    end
    return vim.cmd.normal({args = {"zvzz"}, bang = true})
  else
    return nil
  end
end
vim.api.nvim_create_autocmd("BufNewFile", {group = vim.api.nvim_create_augroup("fileline", {}), nested = true, callback = fileline_jump})
local two_space = {expandtab = true, shiftwidth = 2}
local four_space = {expandtab = true, shiftwidth = 4}
local go_template = {expandtab = true, shiftwidth = 2, commentstring = "{{/* %s */}}"}
local four_space_hash = {expandtab = true, shiftwidth = 4, commentstring = "# %s"}
local git_folds = {foldmethod = "expr", foldexpr = "v:lua.MiniGit.diff_foldexpr()"}
local filetype_settings = {go = {textwidth = 100, expandtab = false}, javascript = two_space, javascriptreact = two_space, typescript = two_space, typescriptreact = two_space, html = two_space, css = two_space, cs = {commentstring = "// %s"}, helm = go_template, gotmpl = go_template, fish = four_space_hash, yaml = two_space, ["buf-config"] = two_space, svg = two_space, json = two_space, json5 = two_space, bash = two_space, toml = two_space, python = four_space, xml = four_space, starlark = four_space_hash, proto = {expandtab = true, shiftwidth = 2, commentstring = "// %s", cindent = true}, gitcommit = {spell = true}, gitconfig = {shiftwidth = 2, expandtab = false}, git = git_folds, diff = git_folds, fennel = {commentstring = ";; %s"}, sql = {wrap = true, commentstring = "-- %s", expandtab = true, shiftwidth = 4}, clojure = {expandtab = true, textwidth = 80}, kotlin = {commentstring = "// %s"}, just = {expandtab = true, shiftwidth = 4}, markdown = {spell = true, wrap = true, expandtab = false}}
local _57_
do
  local tmp_9_ = vim.tbl_keys(filetype_settings)
  table.insert(tmp_9_, "yaml.github-actions")
  _57_ = tmp_9_
end
local function _58_(args)
  local ft = args.match
  local settings = (filetype_settings[ft] or filetype_settings[string.match(ft, "^([^.]+)")])
  if settings then
    for name, value in pairs(settings) do
      vim.api.nvim_set_option_value(name, value, {scope = "local"})
    end
    return nil
  else
    return nil
  end
end
vim.api.nvim_create_autocmd("FileType", {group = vim.api.nvim_create_augroup("filetypes", {}), pattern = _57_, callback = _58_})
local function _60_(_path, bufnr)
  local first_line = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1]
  if (first_line and string.match(first_line, "^#!.*%f[%w]bash%f[%W]")) then
    return "bash"
  else
    return nil
  end
end
vim.filetype.add({extension = {mdx = "markdown", star = "starlark", gotext = "gotmpl", gotmpl = "gotmpl", theme = "fish", ["code-workspace"] = "jsonc", sh = _60_}, filename = {[".ignore"] = "gitignore", [".dockerignore"] = "gitignore", ["buf.yaml"] = "buf-config", ["buf.gen.yaml"] = "buf-config", ["buf.policy.yaml"] = "buf-config", ["buf.lock"] = "buf-config", ["uv.lock"] = "toml", Tiltfile = "tiltfile", [".envrc"] = "bash", [".envrc.local"] = "bash", [".helmignore"] = "gitignore", ["Chart.lock"] = "yaml", ["manifest.lock"] = "json"}, pattern = {[".*/%.github/workflows/.*%.ya?ml"] = "yaml.github-actions", [".*%.go%.tpl"] = "gotmpl", [".*%.go%.tmpl"] = "gotmpl", [".*/charts/.*%.ya?ml%.tpl"] = "helm"}})
do
  local template_dir = vim.fs.joinpath(vim.fn.stdpath("config"), "templates")
  local function _62_(args)
    local fname = vim.fs.basename(args.file)
    local ext = vim.fn.fnamemodify(args.file, ":e")
    local ft = vim.bo[args.buf].filetype
    local done_3f = false
    for _, candidate in ipairs({fname, ext, ft}) do
      if done_3f then break end
      if (candidate ~= "") then
        local tmpl = vim.fs.joinpath(template_dir, ("%s.tmpl"):format(candidate))
        local f = io.open(tmpl, "r")
        if f then
          local content = f:read("*a")
          f:close()
          vim.snippet.expand(content)
          done_3f = true
        else
        end
      else
      end
    end
    return nil
  end
  vim.api.nvim_create_autocmd("BufNewFile", {group = vim.api.nvim_create_augroup("templates", {}), pattern = "*", callback = _62_})
end
map("n", "<leader>du", vim.pack.update, {desc = "Update plugins"})
local function _65_()
  return vim.cmd({cmd = "Mason"})
end
map("n", "<leader>ma", _65_, {desc = ":Mason"})
local function _66_()
  return vim.cmd({cmd = "checkhealth"})
end
map("n", "<leader>ch", _66_, {desc = ":checkhealth"})
map("n", ";", ":", {desc = "Enter command mode"})
local function _67_()
  return vim.cmd({cmd = "Git", mods = {vertical = true}})
end
map("n", "<leader>gs", _67_, {desc = "Open :Git in a vertical split"})
local function _68_()
  return vim.cmd({cmd = "Gwrite"})
end
map("n", "<leader>gw", _68_, {desc = ":Gwrite"})
local function _69_()
  return vim.cmd({cmd = "Git", args = {"commit"}})
end
map("n", "<leader>gc", _69_, {desc = ":Git commit"})
local function _70_()
  return vim.cmd({cmd = "Git", args = {"push"}})
end
map("n", "<leader>gp", _70_, {desc = ":Git push"})
local function _71_()
  return vim.cmd({cmd = "Git", args = {"blame"}})
end
map("n", "<leader>gb", _71_, {desc = ":Git blame"})
local function _72_()
  return vim.cmd({cmd = "PR"})
end
map("n", "<leader>gP", _72_, {desc = ":PR"})
local function _73_()
  return vim.cmd({cmd = "Issue"})
end
map("n", "<leader>gI", _73_, {desc = ":Issue"})
local function _74_()
  return vim.cmd({cmd = "CI"})
end
map("n", "<leader>gA", _74_, {desc = ":CI"})
local function _75_()
  if (vim.v.count ~= 0) then
    return "j"
  else
    return "gj"
  end
end
map({"n", "v"}, "j", _75_, {expr = true, desc = "Down by visual line (gj when no count)"})
local function _77_()
  if (vim.v.count ~= 0) then
    return "k"
  else
    return "gk"
  end
end
map({"n", "v"}, "k", _77_, {expr = true, desc = "Up by visual line (gk when no count)"})
map({"n", "v"}, "<tab>", "%", {remap = true, desc = "Navigate between matching brackets"})
for keymap, file in pairs({["<leader>ef"] = "$HOME/.config/fish/config.fish", ["<leader>egi"] = "$HOME/.config/git/config", ["<leader>ego"] = "$HOME/.config/ghostty/config", ["<leader>ev"] = "$HOME/.config/nvim/init.fnl"}) do
  local function _79_()
    return vim.cmd({cmd = "edit", args = {file}})
  end
  map("n", keymap, _79_, {desc = (":edit " .. file)})
end
local function _80_()
  return vim.cmd({cmd = "write"})
end
map("n", "<leader>w", _80_, {desc = ":write the buffer to the file"})
local function _81_()
  return vim.cmd({cmd = "split"})
end
map("n", "<leader>ss", _81_, {desc = "Create a horizontal split"})
local function _82_()
  return vim.cmd({cmd = "vsplit"})
end
map("n", "<leader>vs", _82_, {desc = "Create a vertical split"})
map("n", "Q", "@@", {desc = "Repeat last macro"})
map("n", "0", "^", {desc = "Go to first non-whitespace character"})
map("n", "^", "0", {desc = "Go to first column in the line"})
map("n", "<C-d>", "<C-d>zz", {desc = "Half-page down, recentered"})
map("n", "<C-f>", "<C-f>zz", {desc = "Page down, recentered"})
map("n", "<C-b>", "<C-b>zz", {desc = "Page up, recentered"})
map("n", "<C-u>", "<C-u>zz", {desc = "Half-page up, recentered"})
map("n", "c", "\"_c", {desc = "Change to black-hole register"})
map("n", "C", "\"_C", {desc = "Change to end of line, black-hole register"})
map("n", "J", "mzJ`z", {desc = "Join lines, keep cursor position"})
map("x", "<", "<gv", {desc = "Indent left, keep selection"})
map("x", ">", ">gv", {desc = "Indent right, keep selection"})
local function _83_()
  return vim.show_pos()
end
map("n", "<leader>i", _83_, {desc = "Inspect position (treesitter/syntax)"})
map("i", "<c-k>", "<esc>", {desc = "Escape insert mode"})
map("c", "<c-k>", "<c-c>", {desc = "Cancel cmdline"})
map("t", "<c-k>", "<c-\\><c-n>", {desc = "Exit terminal mode"})
local function _84_()
  return vim.cmd({cmd = "tabnew"})
end
map("n", "<leader>tn", _84_, {desc = "Create a new tab"})
local function _85_()
  return vim.cmd({cmd = "tabnext"})
end
map("n", "]r", _85_, {desc = "Go to next tab"})
local function _86_()
  return vim.cmd({cmd = "tabprev"})
end
map("n", "[r", _86_, {desc = "Go to prev tab"})
map("n", "<C-l>", ":nohlsearch<cr>", {desc = "Clear search highlight"})
vim.diagnostic.config({signs = {text = {[vim.diagnostic.severity.ERROR] = "\195\151", [vim.diagnostic.severity.WARN] = "!", [vim.diagnostic.severity.INFO] = "\226\156\179\239\184\142", [vim.diagnostic.severity.HINT] = "?"}}, virtual_lines = true, underline = true, severity_sort = true, float = {border = "single", source = true, focusable = false}, virtual_text = false})
local organize_imports_on_save = {gopls = true, buf_ls = true, tsc = true, ruff = true, biome = true}
local function organize_imports(client, buf)
  if not ((client.name == "tsc") and next(vim.lsp.get_clients({bufnr = buf, name = "biome"}))) then
    local params = vim.lsp.util.make_range_params(0, client.offset_encoding)
    params.context = {only = {"source.organizeImports"}, diagnostics = {}}
    local res = client:request_sync("textDocument/codeAction", params, 3000, buf)
    local _88_
    do
      local t_87_ = res
      if (nil ~= t_87_) then
        t_87_ = t_87_.result
      else
      end
      _88_ = t_87_
    end
    for _, action in ipairs((_88_ or {})) do
      local action0
      if (not action.edit and client:supports_method("codeAction/resolve")) then
        local t_90_ = client:request_sync("codeAction/resolve", action, 3000, buf)
        if (nil ~= t_90_) then
          t_90_ = t_90_.result
        else
        end
        action0 = t_90_
      else
        action0 = action
      end
      local _94_
      do
        local t_93_ = action0
        if (nil ~= t_93_) then
          t_93_ = t_93_.edit
        else
        end
        _94_ = t_93_
      end
      if _94_ then
        vim.lsp.util.apply_workspace_edit(action0.edit, client.offset_encoding)
      else
      end
    end
    return nil
  else
    return nil
  end
end
local function lsp_attach(_98_)
  local buf = _98_.buf
  local _arg_99_ = _98_.data
  local client_id = _arg_99_.client_id
  local client = vim.lsp.get_client_by_id(client_id)
  if client:supports_method("textDocument/codeAction") then
    local function _100_()
      return vim.lsp.buf.code_action({context = {only = {"source.organizeImports"}}, apply = true})
    end
    map("n", "gro", _100_, {buffer = buf, desc = "Organize Imports"})
  else
  end
  if organize_imports_on_save[client.name] then
    local group = vim.api.nvim_create_augroup(("organize-imports-" .. client.name), {clear = false})
    vim.api.nvim_clear_autocmds({group = group, buffer = buf})
    local function _102_()
      return organize_imports(client, buf)
    end
    vim.api.nvim_create_autocmd("BufWritePre", {group = group, buffer = buf, callback = _102_})
  else
  end
  if client:supports_method("textDocument/inlayHint") then
    vim.lsp.inlay_hint.enable(true, {bufnr = buf})
  else
  end
  if client:supports_method("textDocument/documentHighlight") then
    local augroup_id = vim.api.nvim_create_augroup("lsp-document-highlight", {clear = false})
    vim.api.nvim_create_autocmd({"CursorHold", "CursorHoldI", "InsertLeave"}, {group = augroup_id, buf = buf, callback = vim.lsp.buf.document_highlight})
    vim.api.nvim_create_autocmd({"CursorMoved", "InsertEnter"}, {group = augroup_id, buf = buf, callback = vim.lsp.buf.clear_references})
  else
  end
  if client:supports_method("textDocument/foldingRange") then
    vim.wo[vim.api.nvim_get_current_win()][0]["foldexpr"] = "v:lua.vim.lsp.foldexpr()"
  else
  end
  if client:supports_method("textDocument/codeLens") then
    vim.lsp.codelens.enable(true, {bufnr = buf})
  else
  end
  if client:supports_method("textDocument/completion") then
    vim.lsp.completion.enable(true, client.id, buf, {autotrigger = true})
    map("i", "<C-space>", vim.lsp.completion.get, {buffer = buf, desc = "Manually trigger completion"})
  else
  end
  return map("n", "gD", vim.lsp.buf.declaration, {buffer = buf, desc = "Go to declaration"})
end
vim.api.nvim_create_autocmd("LspAttach", {group = vim.api.nvim_create_augroup("lsp-attach", {}), callback = lsp_attach})
local schemastore = require("schemastore")
local function venv_cmd(name)
  local function _109_(dispatchers, config)
    local venv_bin = (config.root_dir and (config.root_dir .. "/.venv/bin/" .. name))
    local bin
    if (venv_bin and vim.uv.fs_stat(venv_bin)) then
      bin = venv_bin
    else
      bin = name
    end
    return vim.lsp.rpc.start({bin, "server"}, dispatchers)
  end
  return _109_
end
local function tsqueryrc_settings()
  local _let_111_ = vim.pack.get({"nvim-treesitter"}, {info = false})
  local pack = _let_111_[1]
  local path = (pack.path .. "/.tsqueryrc.json")
  if vim.uv.fs_stat(path) then
    return vim.fn.json_decode(vim.fn.readfile(path))
  else
    return {}
  end
end
local default_servers = {"bashls", "biome", "buf_ls", "clojure_lsp", "csskit", "docker_language_server", "fennel_ls", "helm_ls", "janet_lsp", "just", "postgres_lsp", "rust_analyzer", "tilt_ls", "tombi"}
local server_settings
local function _113_(client)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
  return nil
end
server_settings = {gopls = {cmd = {"gopls", "-remote=auto"}, settings = {gopls = {semanticTokens = true, semanticTokenTypes = {keyword = false, string = false}, hints = {constantValues = true, ignoredError = true}, vulncheck = "Imports"}}}, jsonls = {settings = {json = {schemas = schemastore.json.schemas(), validate = {enable = true}}}, filetypes = {"json", "jsonc", "json5"}}, yamlls = {settings = {yaml = {schemas = schemastore.yaml.schemas(), schemaStore = {url = "", enable = false}}}}, fish_lsp = {cmd_env = {MANPAGER = "cat"}}, ruff = {cmd = venv_cmd("ruff")}, lua_ls = {settings = {Lua = {runtime = {version = "LuaJIT"}, workspace = {library = {vim.env.VIMRUNTIME}, checkThirdParty = false}}}}, ty = {cmd = venv_cmd("ty")}, tsc = {on_init = _113_}, ts_query_ls = {settings = tsqueryrc_settings()}, gh_actions_ls = {filetypes = {"yaml.github-actions"}}, cells = {cmd = {"cells", "serve"}, filetypes = {"cel"}}, zizmor = {filetypes = {"yaml", "yaml.github-actions"}}, syntaqlite = {cmd = {"syntaqlite", "lsp"}, filetypes = {"sql"}, root_markers = {"syntaqlite.toml", ".git"}}}
vim.lsp.config("*", {root_markers = {".git"}})
for server, settings in pairs(server_settings) do
  vim.lsp.config(server, settings)
end
return vim.lsp.enable(vim.list_extend(vim.tbl_keys(server_settings), default_servers))
