-- [nfnl] Compiled from init.fnl by https://github.com/Olical/nfnl, do not edit.
local path_package = (vim.fn.stdpath("data") .. "/site/")
local mini_path = (path_package .. "pack/deps/start/mini.nvim")
if not vim.loop.fs_stat(mini_path) then
  vim.fn.system({"git", "clone", "--filter=blob:none", "https://github.com/echasnovski/mini.nvim", mini_path})
  vim.cmd("packadd mini.nvim | helptags ALL")
else
end
local deps = require("mini.deps")
deps.setup({path = {package = path_package}})
local map = vim.keymap.set
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.maplocalleader = ","
vim.o.breakindentopt = "shift:2,sbr"
vim.o.showbreak = "\226\134\179"
vim.o.shiftround = true
vim.o.gdefault = true
vim.o.copyindent = true
vim.o.list = true
vim.o.listchars = "tab:\226\135\165 ,eol:\194\172,trail:\226\163\191"
vim.o.clipboard = "unnamedplus"
vim.o.swapfile = false
vim.o.formatoptions = "tcqjronp"
vim.o.wildignorecase = true
deps.add("justinmk/vim-gtfo")
vim.g["gtfo#terminals"] = {mac = "kitty"}
deps.add("tyru/open-browser.vim")
deps.add("lewis6991/fileline.nvim")
deps.add("tpope/vim-fugitive")
vim.g.fugitive_legacy_commands = 0
deps.add("tpope/vim-rhubarb")
deps.add("mattn/vim-gotmpl")
deps.add("fladson/vim-kitty")
deps.add("NoahTheDuke/vim-just")
deps.add("raimon49/requirements.txt.vim")
deps.add("jaawerth/fennel.vim")
deps.add("janet-lang/janet.vim")
deps.add("Olical/nfnl")
deps.add("Olical/conjure")
vim.g["conjure#highlight#enabled"] = true
vim.g["conjure#filetypes"] = {"clojure", "fennel", "janet", "python"}
vim.g["conjure#client#clojure#nrepl#connection#auto_repl#hidden"] = true
vim.g["conjure#filetype#janet"] = "conjure.client.janet.stdio"
deps.add("gpanders/nvim-parinfer")
deps.add("tpope/vim-dispatch")
deps.add("vim-test/vim-test")
vim.g["test#strategy"] = "dispatch"
map("n", "<C-t>n", ":TestNearest<cr>")
map("n", "<C-t>f", ":TestFile<cr>")
map("n", "<C-t>s", ":TestSuite<cr>")
map("n", "<C-t>l", ":TestLast<cr>")
map("n", "<C-t>v", ":TestVisit<cr>")
deps.add("neovim/nvim-lspconfig")
deps.add("b0o/SchemaStore.nvim")
deps.add("stevearc/conform.nvim")
do
  local conform = require("conform")
  conform.setup({formatters_by_ft = {fennel = {"fnlfmt"}, fish = {"fish_indent"}, json = {"prettier"}, just = {"just"}, proto = {"buf"}, sql = {"pg_format"}, swift = {"swift_format"}, typescriptreact = {"prettier"}}, format_on_save = {timeout_ms = 500, lsp_fallback = true}})
end
deps.add("mfussenegger/nvim-lint")
do
  local nvim_lint = require("lint")
  nvim_lint.linters_by_ft = {proto = {"buf_lint"}, fish = {"fish"}, go = {"golangcilint"}, janet = {"janet"}, fennel = {"fennel"}}
  local function _2_()
    return nvim_lint.try_lint()
  end
  vim.api.nvim_create_autocmd("BufWritePost", {callback = _2_})
end
local function _3_()
  return vim.cmd(":MasonUpdate")
end
deps.add({source = "williamboman/mason.nvim", hooks = {post_checkout = _3_}})
do
  local mason = require("mason")
  mason.setup()
end
deps.add("williamboman/mason-lspconfig.nvim")
do
  local mason_lspconfig = require("mason-lspconfig")
  mason_lspconfig.setup()
end
local function _4_()
  return vim.cmd(":TSUpdate")
end
deps.add({source = "nvim-treesitter/nvim-treesitter", hooks = {post_checkout = _4_}})
do
  local treesitter = require("nvim-treesitter.configs")
  treesitter.setup({highlight = {enable = true, disable = {"fennel"}}, matchup = {enable = true, disable = {"fennel"}}, ensure_installed = {"c", "lua", "vim", "vimdoc", "clojure", "comment", "css", "diff", "djot", "dockerfile", "fennel", "fish", "git_rebase", "gitattributes", "gitcommit", "go", "gomod", "html", "javascript", "json", "just", "make", "markdown", "markdown_inline", "proto", "python", "requirements", "sql", "ssh_config", "textproto", "toml", "yaml", "zig"}})
end
deps.add("echasnovski/mini.nvim")
do
  local mini_basics = require("mini.basics")
  mini_basics.setup()
end
do
  local mini_pairs = require("mini.pairs")
  mini_pairs.setup()
end
do
  local mini_splitjoin = require("mini.splitjoin")
  mini_splitjoin.setup()
end
do
  local mini_cursorword = require("mini.cursorword")
  mini_cursorword.setup()
end
do
  local mini_trailspace = require("mini.trailspace")
  mini_trailspace.setup()
  map("n", "<leader>sw", mini_trailspace.trim)
end
do
  local mini_surround = require("mini.surround")
  mini_surround.setup({mappings = {add = "gza", delete = "gzd", find = "gzf", find_left = "gzF", highlight = "gzh", replace = "gzr", update_n_lines = "gzn"}})
end
do
  local mini_indentscope = require("mini.indentscope")
  mini_indentscope.setup()
end
do
  local mini_pick = require("mini.pick")
  mini_pick.setup()
  map("n", "<leader>ff", mini_pick.builtin.files)
  local function _5_()
    return mini_pick.builtin.files({tool = "git"})
  end
  map("n", "<leader>fg", _5_)
  map("n", "<leader>fb", mini_pick.builtin.buffers)
  map("n", "<leader>fl", mini_pick.builtin.grep_live)
  map("n", "<leader>fh", mini_pick.builtin.help)
end
do
  local mini_extra = require("mini.extra")
  local function _6_()
    return mini_extra.pickers.lsp({scope = "document_symbol"})
  end
  map("n", "<leader>fs", _6_)
  local function _7_()
    return mini_extra.pickers.lsp({scope = "references"})
  end
  map("n", "<leader>fr", _7_)
end
do
  local mini_statusline = require("mini.statusline")
  mini_statusline.setup()
end
do
  local mini_completion = require("mini.completion")
  mini_completion.setup()
end
do
  local mini_bracketed = require("mini.bracketed")
  mini_bracketed.setup()
end
do
  local mini_files = require("mini.files")
  mini_files.setup({mappings = {go_in_plus = "<CR>"}})
  local function _8_()
    return mini_files.open(vim.api.nvim_buf_get_name(0))
  end
  map("n", "-", _8_)
end
do
  local mini_notify = require("mini.notify")
  mini_notify.setup()
end
do
  local mini_diff = require("mini.diff")
  mini_diff.setup({view = {signs = {add = "\226\148\131", change = "\226\148\131", delete = "\226\150\129"}, style = "sign"}})
end
deps.add("tpope/vim-eunuch")
deps.add("andymass/vim-matchup")
vim.g.matchup_matchparen_offscreen = {method = "popup"}
deps.add("tpope/vim-abolish")
deps.add("rktjmp/paperplanes.nvim")
deps.add("rktjmp/lush.nvim")
deps.add("stefanvanburen/rams")
deps.add("mcchrish/zenbones.nvim")
deps.add("rose-pine/neovim")
deps.add("lunacookies/vim-plan9")
vim.cmd.colorscheme("plan9")
vim.api.nvim_create_autocmd("VimResized", {command = ":wincmd ="})
local filetype_settings = {go = {expandtab = false}, javascript = {expandtab = true, shiftwidth = 2}, javascriptreact = {expandtab = true, shiftwidth = 2}, typescript = {expandtab = true, shiftwidth = 2}, typescriptreact = {expandtab = true, shiftwidth = 2}, html = {expandtab = true, shiftwidth = 2}, css = {expandtab = true, shiftwidth = 2}, gohtmltmpl = {expandtab = true, shiftwidth = 2, commentstring = "{{/* %s */}}"}, gotexttmpl = {expandtab = true, shiftwidth = 2, commentstring = "{{/* %s */}}"}, fish = {expandtab = true, shiftwidth = 4, commentstring = "# %s"}, yaml = {expandtab = true, shiftwidth = 2}, svg = {expandtab = true, shiftwidth = 2}, json = {expandtab = true, shiftwidth = 2}, bash = {expandtab = true, shiftwidth = 2}, python = {expandtab = true, shiftwidth = 4}, xml = {expandtab = true, shiftwidth = 4}, starlark = {expandtab = true, shiftwidth = 4, commentstring = "# %s"}, proto = {expandtab = true, shiftwidth = 2, commentstring = "// %s", cindent = true}, gitcommit = {spell = true}, swift = {commentstring = "// %s"}, sql = {wrap = true, commentstring = "-- %s"}, clojure = {expandtab = true, textwidth = 80}, kotlin = {commentstring = "// %s"}, markdown = {spell = true, wrap = true, conceallevel = 0, shiftwidth = 2}}
do
  local aufiletypes = vim.api.nvim_create_augroup("filetypes", {})
  for filetype, settings in pairs(filetype_settings) do
    local function _9_()
      for name, value in pairs(settings) do
        vim.api.nvim_set_option_value(name, value, {scope = "local"})
      end
      return nil
    end
    vim.api.nvim_create_autocmd("FileType", {group = aufiletypes, pattern = filetype, callback = _9_})
  end
  local function extension__3efiletype(extension, filetype)
    local function _10_()
      return vim.api.nvim_set_option_value("filetype", filetype, {scope = "local"})
    end
    return vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {group = aufiletypes, pattern = ("*." .. tostring(extension)), callback = _10_})
  end
  for extension, filetype in pairs({mdx = "markdown", star = "starlark", tpl = "gotmpl", txtpb = "textproto"}) do
    extension__3efiletype(extension, filetype)
  end
end
map("n", ";", ":")
map("n", "<leader>?", vim.diagnostic.open_float)
local function _11_()
  return vim.cmd({cmd = "Git", mods = {vertical = true}})
end
map("n", "<leader>gs", _11_)
local function _12_()
  return vim.cmd({cmd = "Gwrite"})
end
map("n", "<leader>gw", _12_)
local function _13_()
  return vim.cmd({cmd = "Git", args = {"commit"}})
end
map("n", "<leader>gc", _13_)
local function _14_()
  return vim.cmd({cmd = "Git", args = {"push"}})
end
map("n", "<leader>gp", _14_)
local function _15_()
  return vim.cmd({cmd = "Git", args = {"blame"}})
end
map("n", "<leader>gb", _15_)
map({"n", "v"}, "gx", "<plug>(openbrowser-smart-search)", {})
local function _16_()
  if (vim.v.count ~= 0) then
    return "j"
  else
    return "gj"
  end
end
map({"n", "v"}, "j", _16_, {expr = true})
local function _18_()
  if (vim.v.count ~= 0) then
    return "k"
  else
    return "gk"
  end
end
map({"n", "v"}, "k", _18_, {expr = true})
map({"n", "v"}, "<tab>", "%", {remap = true})
for keymap, file in pairs({["<leader>ef"] = "$HOME/.config/fish/config", ["<leader>eg"] = "$HOME/.config/git/config", ["<leader>ek"] = "$HOME/.config/kitty/kitty.conf", ["<leader>ev"] = "$HOME/.config/nvim/init.fnl"}) do
  local function _20_()
    return vim.cmd({cmd = "edit", args = {file}})
  end
  map("n", keymap, _20_)
end
local function _21_()
  return vim.cmd({cmd = "write"})
end
map("n", "<leader>w", _21_)
local function _22_()
  return vim.cmd({cmd = "close"})
end
map("n", "<leader>cl", _22_)
local function _23_()
  return vim.cmd({cmd = "split"})
end
map("n", "<leader>ss", _23_)
local function _24_()
  return vim.cmd({cmd = "vsplit"})
end
map("n", "<leader>vs", _24_)
local function _25_()
  return vim.cmd({cmd = "tabnew"})
end
map("n", "<leader>tn", _25_)
map("n", "Q", "@@")
map("n", "0", "^")
map("n", "^", "0")
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
map("n", "<C-l>", ":nohlsearch<cr>")
for sign, text in pairs({DiagnosticSignError = "\195\151", DiagnosticSignWarn = "!", DiagnosticSignInfo = "\226\156\179\239\184\142", DiagnosticSignHint = "?"}) do
  vim.fn.sign_define(sign, {text = text, texthl = sign})
end
vim.diagnostic.config({virtual_text = {prefix = "\226\150\170"}, float = {border = "single", source = "always", focusable = false}})
local function lsp_attach(_26_)
  local _arg_27_ = _26_
  local buf = _arg_27_["buf"]
  local _arg_28_ = _arg_27_["data"]
  local client_id = _arg_28_["client_id"]
  local client = vim.lsp.get_client_by_id(client_id)
  local function format()
    vim.lsp.buf.format({timeout_ms = 2000})
    if (client.name == "gopls") then
      return vim.lsp.buf.code_action({context = {only = {"source.organizeImports"}}, apply = true})
    else
      return nil
    end
  end
  local function buffer_map(from, to)
    return vim.keymap.set("n", from, to, {buffer = buf, silent = true})
  end
  if client.server_capabilities.documentFormattingProvider then
    buffer_map("<leader>af", format)
    if (client.name ~= "tsserver") then
      vim.api.nvim_create_autocmd("BufWritePre", {buffer = buf, callback = format})
    else
    end
  else
  end
  if (client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint) then
    vim.lsp.inlay_hint.enable(buf, true)
  else
  end
  if client.server_capabilities.hoverProvider then
    buffer_map("K", vim.lsp.buf.hover)
  else
  end
  buffer_map("gD", vim.lsp.buf.declaration)
  buffer_map("gd", vim.lsp.buf.definition)
  buffer_map("gi", vim.lsp.buf.implementation)
  buffer_map("gr", vim.lsp.buf.references)
  buffer_map("<C-k>", vim.lsp.buf.signature_help)
  buffer_map("<leader>D", vim.lsp.buf.type_definition)
  buffer_map("<leader>rn", vim.lsp.buf.rename)
  return buffer_map("<leader>ca", vim.lsp.buf.code_action)
end
vim.api.nvim_create_autocmd("LspAttach", {callback = lsp_attach})
local lspconfig = require("lspconfig")
local schemastore = require("schemastore")
local server_settings = {[lspconfig.gopls] = {cmd = {"gopls", "-remote=auto"}, settings = {gopls = {staticcheck = true, linkTarget = "godocs.io", analyses = {unusedparams = true, unusedwrite = true, useany = true}}}}, [lspconfig.jsonls] = {settings = {json = {schemas = schemastore.json.schemas(), validate = {enable = true}}}}, [lspconfig.yamlls] = {settings = {yaml = {schemas = schemastore.yaml.schemas(), schemaStore = {url = "", enable = false}}}}, [lspconfig.clojure_lsp] = {}, [lspconfig.cssls] = {}, [lspconfig.bufls] = {}, [lspconfig.ruff] = {}, [lspconfig.pylsp] = {settings = {pylsp = {plugins = {pycodestyle = {enabled = false}, pyflakes = {enabled = false}}}}}, [lspconfig.tsserver] = {}, [lspconfig.eslint] = {}, [lspconfig.bashls] = {}, [lspconfig.taplo] = {}, [lspconfig.dockerls] = {}, [lspconfig.fennel_ls] = {settings = {["fennel-ls"] = {["extra-globals"] = "vim"}}}, [lspconfig.sourcekit] = {}, [lspconfig.lua_ls] = {settings = {Lua = {runtime = {version = "LuaJIT"}, workspace = {library = vim.api.nvim_list_runtime_paths()}}}}, [lspconfig.rust_analyzer] = {}}
for server, settings in pairs(server_settings) do
  server.setup(settings)
end
return nil
