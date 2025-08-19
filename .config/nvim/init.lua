-- [nfnl] init.fnl
local path_package = (vim.fn.stdpath("data") .. "/site/")
local mini_path = (path_package .. "pack/deps/start/mini.nvim")
if not vim.uv.fs_stat(mini_path) then
  vim.system({"git", "clone", "--filter=blob:none", "https://github.com/echasnovski/mini.nvim", mini_path})
  vim.cmd("packadd mini.nvim | helptags ALL")
else
end
local deps = require("mini.deps")
deps.setup({path = {package = path_package}})
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.maplocalleader = ","
do
  local opts = {foldmethod = "expr", foldlevelstart = 99, foldexpr = "vim.treesitter.foldexpr()", breakindentopt = {shift = 2, sbr = true}, showbreak = "\226\134\179", shiftround = true, gdefault = true, copyindent = true, list = true, listchars = {tab = "\226\135\165 ", eol = "\194\172", trail = "\226\163\191"}, grepprg = "rg --vimgrep", clipboard = "unnamedplus", exrc = true, cursorlineopt = "number", completeopt = "fuzzy,menu,menuone,popup,noselect", formatoptions = "tcqjronp", title = true, updatetime = 300, wildignorecase = true, inccommand = "split", winborder = "rounded", swapfile = false}
  for opt, val in pairs(opts) do
    local _2_ = type(val)
    if (_2_ == "table") then
      vim.opt[opt] = val
    else
      local _ = _2_
      vim.o[opt] = val
    end
  end
end
deps.add("echasnovski/mini.nvim")
do
  local mini_basics = require("mini.basics")
  mini_basics.setup({mappings = {basic = false}})
end
local map = vim.keymap.set
do
  local mini_pairs = require("mini.pairs")
  mini_pairs.setup()
end
do
  local mini_ai = require("mini.ai")
  mini_ai.setup()
end
do
  local mini_splitjoin = require("mini.splitjoin")
  mini_splitjoin.setup()
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
  map("x", "S", ":<C-U>lua MiniSurround.add('visual')<CR>", {silent = true})
  map("n", "yss", "ys_", {remap = true})
end
do
  local mini_pick = require("mini.pick")
  mini_pick.setup()
  map("n", "<leader>ff", mini_pick.builtin.files, {desc = "Pick files"})
  map("n", "<leader>fb", mini_pick.builtin.buffers, {desc = "Pick buffers"})
  map("n", "<leader>fl", mini_pick.builtin.grep_live, {desc = "Pick lines"})
  map("n", "<leader>fh", mini_pick.builtin.help, {desc = "Pick help"})
end
do
  local mini_extra = require("mini.extra")
  map("n", "<leader>fd", mini_extra.pickers.diagnostic, {desc = "Pick diagnostics"})
  map("n", "<leader>fg", mini_extra.pickers.git_files, {desc = "Pick git files"})
  map("n", "<leader>fm", mini_extra.pickers.keymaps, {desc = "Pick keymaps"})
  map("n", "<leader>fo", mini_extra.pickers.options, {desc = "Pick options"})
  map("n", "<leader>fc", mini_extra.pickers.colorschemes, {desc = "Pick colorschemes"})
end
do
  local mini_completion = require("mini.completion")
  mini_completion.setup()
end
do
  local mini_colors = require("mini.colors")
  mini_colors.setup()
end
do
  local mini_hipatterns = require("mini.hipatterns")
  mini_hipatterns.setup({highlighters = {hex_color = mini_hipatterns.gen_highlighter.hex_color()}})
end
do
  local mini_bracketed = require("mini.bracketed")
  mini_bracketed.setup()
end
do
  local mini_files = require("mini.files")
  mini_files.setup({mappings = {go_in_plus = "<CR>"}})
  local function _4_()
    local buf_name = vim.api.nvim_buf_get_name(0)
    if vim.uv.fs_stat(buf_name) then
      return mini_files.open(buf_name, false)
    else
      return mini_files.open()
    end
  end
  map("n", "-", _4_, {desc = "Open the file picker from the current file, or in the current working directory if the file does not exist"})
end
do
  local mini_notify = require("mini.notify")
  mini_notify.setup({lsp_progress = {enable = false}})
end
do
  local mini_diff = require("mini.diff")
  mini_diff.setup({view = {signs = {add = "\226\148\131", change = "\226\148\131", delete = "\226\150\129"}, style = "sign"}})
end
do
  local mini_git = require("mini.git")
  mini_git.setup()
end
do
  local mini_statusline = require("mini.statusline")
  mini_statusline.setup()
end
do
  local mini_icons = require("mini.icons")
  mini_icons.setup({style = "ascii"})
end
deps.add("tpope/vim-eunuch")
deps.add("andymass/vim-matchup")
vim.g.matchup_matchparen_offscreen = {method = "popup"}
deps.add("tpope/vim-abolish")
deps.add("rktjmp/paperplanes.nvim")
do
  local paperplanes = require("paperplanes")
  paperplanes.setup({provider = "gist"})
end
deps.add("rktjmp/lush.nvim")
deps.add("lewis6991/fileline.nvim")
deps.add("tpope/vim-fugitive")
vim.g.fugitive_legacy_commands = 0
deps.add("tpope/vim-rhubarb")
deps.add("https://git.sr.ht/~willdurand/srht.vim")
deps.add("tpope/vim-dadbod")
deps.add("tpope/vim-dispatch")
local function _6_()
  return vim.cmd({cmd = "DB", args = {"$DATABASE_URL"}})
end
map("n", "<leader>db", _6_, {desc = "Open dadbod to the current $DATABASE_URL"})
deps.add("fladson/vim-kitty")
deps.add("janet-lang/janet.vim")
deps.add("qvalentin/helm-ls.nvim")
deps.add("Olical/nfnl")
deps.add("Olical/conjure")
vim.g["conjure#highlight#enabled"] = true
vim.g["conjure#client#clojure#nrepl#connection#auto_repl#hidden"] = true
vim.g["conjure#filetype#janet"] = "conjure.client.janet.stdio"
vim.g["conjure#mapping#doc_word"] = false
deps.add("gpanders/nvim-parinfer")
deps.add("vim-test/vim-test")
vim.g["test#strategy"] = "neovim_sticky"
vim.g["test#neovim_sticky#reopen_window"] = 1
vim.g["test#neovim#term_position"] = "horizontal 30"
local function _7_()
  return vim.cmd({cmd = "TestNearest"})
end
map("n", "<leader>tt", _7_, {desc = "Run nearest test"})
local function _8_()
  return vim.cmd({cmd = "TestFile"})
end
map("n", "<leader>tf", _8_, {desc = "Run all tests in the file"})
deps.add("neovim/nvim-lspconfig")
deps.add("b0o/SchemaStore.nvim")
deps.add("stevearc/conform.nvim")
do
  local conform = require("conform")
  conform.setup({formatters_by_ft = {fennel = {"fnlfmt"}, fish = {"fish_indent"}, go = {lsp_format = "fallback"}, proto = {lsp_format = "fallback"}}, format_on_save = {timeout_ms = 5000}})
end
deps.add("mfussenegger/nvim-lint")
do
  local nvim_lint = require("lint")
  local linters
  do
    local tbl_16_ = {}
    for k, v in pairs({fish = {"fish"}, janet = {"janet"}, go = {"golangcilint"}, fennel = {"fennel"}}) do
      local k_17_, v_18_ = nil, nil
      local function _9_(...)
        local tbl_21_ = {}
        local i_22_ = 0
        for _, v0 in ipairs(v) do
          local val_23_
          if (1 == vim.fn.executable(v0)) then
            val_23_ = v0
          else
            val_23_ = nil
          end
          if (nil ~= val_23_) then
            i_22_ = (i_22_ + 1)
            tbl_21_[i_22_] = val_23_
          else
          end
        end
        return tbl_21_
      end
      k_17_, v_18_ = k, _9_(...)
      if ((k_17_ ~= nil) and (v_18_ ~= nil)) then
        tbl_16_[k_17_] = v_18_
      else
      end
    end
    linters = tbl_16_
  end
  nvim_lint.linters_by_ft = linters
  local function _13_()
    return nvim_lint.try_lint()
  end
  vim.api.nvim_create_autocmd("BufWritePost", {callback = _13_})
end
local function _14_()
  return vim.cmd(":MasonUpdate")
end
deps.add({source = "williamboman/mason.nvim", hooks = {post_checkout = _14_}})
do
  local mason = require("mason")
  mason.setup()
end
deps.add("williamboman/mason-lspconfig.nvim")
do
  local mason_lspconfig = require("mason-lspconfig")
  mason_lspconfig.setup()
end
local function _15_()
  return vim.cmd(":TSUpdate")
end
deps.add({source = "nvim-treesitter/nvim-treesitter", hooks = {post_checkout = _15_}})
do
  local treesitter = require("nvim-treesitter.configs")
  treesitter.setup({highlight = {enable = true}, matchup = {enable = true}, incremental_selection = {enable = true}, ensure_installed = {"c", "lua", "vim", "vimdoc", "query", "bash", "c_sharp", "clojure", "comment", "css", "diff", "djot", "dockerfile", "editorconfig", "fennel", "fish", "git_rebase", "gitattributes", "gitcommit", "go", "gomod", "gosum", "gotmpl", "helm", "html", "janet_simple", "java", "javascript", "json", "just", "make", "markdown", "markdown_inline", "proto", "python", "requirements", "sql", "ssh_config", "starlark", "textproto", "toml", "xml", "yaml", "zig"}})
end
do
  local filetype_to_langs = {c_sharp = {"csharp"}, bash = {"shellsession", "console"}, proto = {"protobuf"}}
  for filetype, langs in pairs(filetype_to_langs) do
    vim.treesitter.language.register(filetype, langs)
  end
end
deps.add("julienvincent/nvim-paredit")
do
  local nvim_paredit = require("nvim-paredit")
  nvim_paredit.setup({})
end
deps.add("stefanvanburen/rams")
deps.add("savq/melange-nvim")
deps.add("mcchrish/zenbones.nvim")
deps.add("rose-pine/neovim")
deps.add("lunacookies/vim-plan9")
deps.add("miikanissi/modus-themes.nvim")
do
  local day_of_month = tonumber(vim.fn.strftime("%d"))
  local colorscheme
  do
    local _16_ = vim.fn.strftime("%m")
    if (_16_ == "01") then
      colorscheme = "miniwinter"
    elseif (_16_ == "02") then
      if (day_of_month < 4) then
        colorscheme = "miniwinter"
      else
        colorscheme = "minispring"
      end
    elseif (_16_ == "03") then
      colorscheme = "minispring"
    elseif (_16_ == "04") then
      colorscheme = "minispring"
    elseif (_16_ == "05") then
      if (day_of_month < 6) then
        colorscheme = "minispring"
      else
        colorscheme = "minisummer"
      end
    elseif (_16_ == "06") then
      colorscheme = "minisummer"
    elseif (_16_ == "07") then
      colorscheme = "minisummer"
    elseif (_16_ == "08") then
      if (day_of_month < 8) then
        colorscheme = "minisummer"
      else
        colorscheme = "miniautumn"
      end
    elseif (_16_ == "09") then
      colorscheme = "miniautumn"
    elseif (_16_ == "10") then
      colorscheme = "miniautumn"
    elseif (_16_ == "11") then
      if (day_of_month < 8) then
        colorscheme = "miniautumn"
      else
        colorscheme = "miniwinter"
      end
    elseif (_16_ == "12") then
      colorscheme = "miniwinter"
    else
      colorscheme = nil
    end
  end
  vim.cmd.colorscheme(colorscheme)
end
vim.api.nvim_create_autocmd("VimResized", {command = ":wincmd ="})
local filetype_settings = {go = {textwidth = 100, expandtab = false}, javascript = {expandtab = true, shiftwidth = 2}, javascriptreact = {expandtab = true, shiftwidth = 2}, typescript = {expandtab = true, shiftwidth = 2}, typescriptreact = {expandtab = true, shiftwidth = 2}, html = {expandtab = true, shiftwidth = 2}, css = {expandtab = true, shiftwidth = 2}, cs = {commentstring = "// %s"}, helm = {expandtab = true, shiftwidth = 2, commentstring = "{{/* %s */}}"}, gotmpl = {expandtab = true, shiftwidth = 2, commentstring = "{{/* %s */}}"}, fish = {expandtab = true, shiftwidth = 4, commentstring = "# %s"}, yaml = {expandtab = true, shiftwidth = 2}, svg = {expandtab = true, shiftwidth = 2}, json = {expandtab = true, shiftwidth = 2}, bash = {expandtab = true, shiftwidth = 2}, python = {expandtab = true, shiftwidth = 4}, xml = {expandtab = true, shiftwidth = 4}, starlark = {expandtab = true, shiftwidth = 4, commentstring = "# %s"}, proto = {expandtab = true, shiftwidth = 2, commentstring = "// %s", cindent = true}, gitcommit = {spell = true}, fennel = {commentstring = ";; %s"}, sql = {wrap = true, commentstring = "-- %s", expandtab = true, shiftwidth = 4}, clojure = {expandtab = true, textwidth = 80}, kotlin = {commentstring = "// %s"}, markdown = {spell = true, wrap = true, conceallevel = 0, shiftwidth = 2}}
do
  local aufiletypes = vim.api.nvim_create_augroup("filetypes", {})
  for filetype, settings in pairs(filetype_settings) do
    local function _22_()
      for name, value in pairs(settings) do
        vim.api.nvim_set_option_value(name, value, {scope = "local"})
      end
      return nil
    end
    vim.api.nvim_create_autocmd("FileType", {group = aufiletypes, pattern = filetype, callback = _22_})
  end
end
vim.filetype.add({extension = {mdx = "markdown", star = "starlark", gotext = "gotmpl", gotmpl = "gotmpl"}, filename = {[".ignore"] = "gitignore", [".dockerignore"] = "gitignore", ["buf.lock"] = "yaml", ["uv.lock"] = "toml"}})
for pattern, skeleton_file in pairs({["buf.gen.yaml"] = "buf.gen.yaml", [".nfnl.fnl"] = ".nfnl.fnl", justfile = "justfile"}) do
  vim.api.nvim_create_autocmd("BufNewFile", {pattern = pattern, group = vim.api.nvim_create_augroup("skeletons", {clear = true}), command = ("0r ~/.config/nvim/skeletons/" .. skeleton_file)})
end
local function _23_(args)
  local fname = vim.fs.basename(args.file)
  local ext = vim.fn.fnamemodify(args.file, ":e")
  local ft = vim.bo[args.buf].filetype
  local candidates = {fname, ext, ft}
  local done_3f = false
  for _, candidate in ipairs(candidates) do
    if done_3f then break end
    local tmpl = vim.fs.joinpath(vim.fn.stdpath("config"), "templates", ("%s.tmpl"):format(candidate))
    local f = io.open(tmpl, "r")
    if f then
      vim.snippet.expand(f:read("*a"))
      done_3f = true
    else
    end
  end
  return nil
end
vim.api.nvim_create_autocmd("BufNewFile", {pattern = "*", group = vim.api.nvim_create_augroup("templates", {clear = true}), callback = _23_})
--[[ (vim.api.nvim_get_current_buf) (vim.fs.basename (vim.api.nvim_buf_get_name 0)) ]]
local open = vim.ui.open
vim.ui.open = function(uri)
  if (not string.match(uri, "[a-z]*://[^ >,;]*") and string.match(uri, "[%w%p\\-]*/[%w%p\\-]*")) then
    return open(string.format("https://github.com/%s", uri))
  else
    return open(uri)
  end
end
map("n", ";", ":")
local function _26_()
  return vim.cmd({cmd = "Git", mods = {vertical = true}})
end
map("n", "<leader>gs", _26_, {desc = "Open :Git in a vertical split"})
local function _27_()
  return vim.cmd({cmd = "Gwrite"})
end
map("n", "<leader>gw", _27_, {desc = ":Gwrite"})
local function _28_()
  return vim.cmd({cmd = "Git", args = {"commit"}})
end
map("n", "<leader>gc", _28_, {desc = ":Git commit"})
local function _29_()
  return vim.cmd({cmd = "Git", args = {"push"}})
end
map("n", "<leader>gp", _29_, {desc = ":Git push"})
local function _30_()
  return vim.cmd({cmd = "Git", args = {"blame"}})
end
map("n", "<leader>gb", _30_, {desc = ":Git blame"})
local function _31_()
  if (vim.v.count ~= 0) then
    return "j"
  else
    return "gj"
  end
end
map({"n", "v"}, "j", _31_, {expr = true})
local function _33_()
  if (vim.v.count ~= 0) then
    return "k"
  else
    return "gk"
  end
end
map({"n", "v"}, "k", _33_, {expr = true})
map({"n", "v"}, "<tab>", "%", {remap = true, desc = "Navigate between matching brackets"})
for keymap, file in pairs({["<leader>ef"] = "$HOME/.config/fish/config.fish", ["<leader>egi"] = "$HOME/.config/git/config", ["<leader>ego"] = "$HOME/.config/ghostty/config", ["<leader>ek"] = "$HOME/.config/kitty/kitty.conf", ["<leader>ev"] = "$HOME/.config/nvim/init.fnl"}) do
  local function _35_()
    return vim.cmd({cmd = "edit", args = {file}})
  end
  map("n", keymap, _35_, {desc = (":edit " .. file)})
end
local function _36_()
  return vim.cmd({cmd = "write"})
end
map("n", "<leader>w", _36_, {desc = ":write the buffer to the file"})
local function _37_()
  return vim.cmd({cmd = "close"})
end
map("n", "<leader>cl", _37_, {desc = ":close the current window"})
local function _38_()
  return vim.cmd({cmd = "split"})
end
map("n", "<leader>ss", _38_, {desc = "Create a horizontal split"})
local function _39_()
  return vim.cmd({cmd = "vsplit"})
end
map("n", "<leader>vs", _39_, {desc = "Create a vertical split"})
map("n", "Q", "@@", {desc = "Repeat last macro"})
map("n", "0", "^", {desc = "Go to first non-whitespace character"})
map("n", "^", "0", {desc = "Go to first column in the line"})
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-f>", "<C-f>zz")
map("n", "<C-b>", "<C-b>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "c", "\"_c")
map("n", "C", "\"_C")
map("n", "J", "mzJ`z")
map("x", "<", "<gv")
map("x", ">", ">gv")
map("i", "<c-k>", "<esc>")
map("c", "<c-k>", "<c-c>")
map("t", "<c-k>", "<c-\\><c-n>")
local function _40_()
  return vim.cmd({cmd = "tabnew"})
end
map("n", "<leader>tn", _40_, {desc = "Create a new tab"})
local function _41_()
  return vim.cmd({cmd = "tabnext"})
end
map("n", "]r", _41_, {desc = "Go to next tab"})
local function _42_()
  return vim.cmd({cmd = "tabprev"})
end
map("n", "[r", _42_, {desc = "Go to prev tab"})
map("n", "<C-l>", ":nohlsearch<cr>")
vim.diagnostic.config({signs = {text = {[vim.diagnostic.severity.ERROR] = "\195\151", [vim.diagnostic.severity.WARN] = "!", [vim.diagnostic.severity.INFO] = "\226\156\179\239\184\142", [vim.diagnostic.severity.HINT] = "?"}}, virtual_text = {severity = {min = vim.diagnostic.severity.WARN}}, underline = true, float = {border = "single", source = "always", focusable = false}})
local function lsp_attach(_43_)
  local buf = _43_["buf"]
  local _arg_44_ = _43_["data"]
  local client_id = _arg_44_["client_id"]
  local client = vim.lsp.get_client_by_id(client_id)
  local function format_and_fix_imports()
    vim.lsp.buf.code_action({context = {only = {"source.organizeImports"}}, apply = true})
    return vim.lsp.buf.format()
  end
  if (client:supports_method("textDocument/formatting") and ((client.name == "gopls") or (client.name == "ruff"))) then
    vim.api.nvim_create_autocmd("BufWritePre", {buffer = buf, callback = format_and_fix_imports})
  else
  end
  if client:supports_method("textDocument/inlayHint") then
    vim.lsp.inlay_hint.enable(true, {bufnr = buf})
  else
  end
  if client:supports_method("textDocument/documentHighlight") then
    local augroup_id = vim.api.nvim_create_augroup("lsp-document-highlight", {clear = false})
    vim.api.nvim_create_autocmd({"CursorHold", "CursorHoldI", "InsertLeave"}, {group = augroup_id, buffer = buf, callback = vim.lsp.buf.document_highlight})
    vim.api.nvim_create_autocmd({"CursorMoved", "InsertEnter"}, {group = augroup_id, buffer = buf, callback = vim.lsp.buf.clear_references})
  else
  end
  map("n", "gD", vim.lsp.buf.declaration, {buffer = buf, desc = "Go to declaration"})
  return map("n", "gd", vim.lsp.buf.definition, {buffer = buf, desc = "Go to definition"})
end
vim.api.nvim_create_autocmd("LspAttach", {callback = lsp_attach})
local schemastore = require("schemastore")
local server_settings = {gopls = {cmd = {"gopls", "-remote=auto"}, settings = {gopls = {semanticTokens = true}}}, jsonls = {settings = {json = {schemas = schemastore.json.schemas(), validate = {enable = true}}}}, yamlls = {settings = {yaml = {schemas = schemastore.yaml.schemas(), schemaStore = {url = "", enable = false}}}}, clojure_lsp = {}, biome = {}, fish_lsp = {}, janet_lsp = {}, ruff = {}, helm_ls = {}, bashls = {}, taplo = {}, omnisharp = {cmd = {"omnisharp"}}, docker_language_server = {}, fennel_ls = {}, harper_ls = {settings = {["harper-ls"] = {userDictPath = "~/.config/nvim/spell/en.utf-8.add", linters = {SentenceCapitalization = false, SpellCheck = false, ToDoHyphen = false}}}}, lua_ls = {settings = {Lua = {runtime = {version = "LuaJIT"}, workspace = {library = vim.env.VIMRUNTIME, checkThirdParty = false}}}}, rust_analyzer = {}, buf_ls = {}, postgres_lsp = {}, tailwindcss = {}, ty = {}}
for server, settings in pairs(server_settings) do
  vim.lsp.config(server, settings)
  vim.lsp.enable(server)
end
return nil
