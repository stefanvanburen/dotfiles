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
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.o.exrc = true
local function _2_(opts)
  return vim.ui.open(opts.fargs[1])
end
vim.api.nvim_create_user_command("Browse", _2_, {nargs = 1})
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.maplocalleader = ","
do
  local opts = {foldmethod = "indent", breakindentopt = {shift = 2, sbr = true}, showbreak = "\226\134\179", shiftround = true, gdefault = true, copyindent = true, list = true, listchars = {tab = "\226\135\165 ", eol = "\194\172", trail = "\226\163\191"}, grepprg = "rg --vimgrep", clipboard = "unnamedplus", formatoptions = "tcqjronp", updatetime = 300, wildignorecase = true, swapfile = false}
  for opt, val in pairs(opts) do
    local _3_ = type(val)
    if (_3_ == "table") then
      vim.opt[opt] = val
    elseif true then
      local _ = _3_
      vim.o[opt] = val
    else
    end
  end
end
deps.add("echasnovski/mini.nvim")
do
  local mini_basics = require("mini.basics")
  mini_basics.setup()
end
local map = vim.keymap.set
do
  local mini_pairs = require("mini.pairs")
  mini_pairs.setup()
end
do
  local mini_splitjoin = require("mini.splitjoin")
  mini_splitjoin.setup()
end
do
  local mini_trailspace = require("mini.trailspace")
  mini_trailspace.setup()
  map("n", "<leader>sw", mini_trailspace.trim)
end
do
  local mini_surround = require("mini.surround")
  mini_surround.setup({mappings = {add = "ys", delete = "ds", find = "", find_left = "", highlight = "", replace = "cs", update_n_lines = "", suffix_last = "", suffix_next = ""}, search_method = "cover_or_next"})
  vim.keymap.del("x", "ys")
  map("x", "S", ":<C-U>lua MiniSurround.add('visual')<CR>", {silent = true})
  map("n", "yss", "ys_", {remap = true})
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
deps.add("justinmk/vim-gtfo")
vim.g["gtfo#terminals"] = {mac = "kitty"}
deps.add("lewis6991/fileline.nvim")
deps.add("tpope/vim-fugitive")
vim.g.fugitive_legacy_commands = 0
deps.add("tpope/vim-rhubarb")
deps.add("tpope/vim-dadbod")
deps.add("mattn/vim-gotmpl")
deps.add("fladson/vim-kitty")
deps.add("NoahTheDuke/vim-just")
deps.add("jaawerth/fennel.vim")
deps.add("janet-lang/janet.vim")
deps.add("Olical/nfnl")
deps.add("Olical/conjure")
vim.g["conjure#highlight#enabled"] = true
vim.g["conjure#filetypes"] = {"clojure", "fennel", "janet", "python", "rust"}
vim.g["conjure#client#clojure#nrepl#connection#auto_repl#hidden"] = true
vim.g["conjure#filetype#janet"] = "conjure.client.janet.stdio"
vim.g["conjure#mapping#doc_word"] = false
deps.add("gpanders/nvim-parinfer")
deps.add("vim-test/vim-test")
vim.g["test#strategy"] = "neovim_sticky"
local function _9_()
  return vim.cmd({cmd = "TestNearest"})
end
map("n", "<leader>tn", _9_)
local function _10_()
  return vim.cmd({cmd = "TestFile"})
end
map("n", "<leader>tf", _10_)
deps.add("neovim/nvim-lspconfig")
deps.add("b0o/SchemaStore.nvim")
deps.add("stevearc/conform.nvim")
do
  local conform = require("conform")
  conform.setup({formatters_by_ft = {fennel = {"fnlfmt"}, fish = {"fish_indent"}, go = {"goimports"}, just = {"just"}, proto = {"buf"}}, format_on_save = {timeout_ms = 2000, lsp_fallback = true}})
end
deps.add("mfussenegger/nvim-lint")
do
  local nvim_lint = require("lint")
  nvim_lint.linters_by_ft = {proto = {"buf_lint"}, fish = {"fish"}, janet = {"janet"}, fennel = {"fennel"}}
  local function _11_()
    return nvim_lint.try_lint()
  end
  vim.api.nvim_create_autocmd("BufWritePost", {callback = _11_})
end
local function _12_()
  return vim.cmd(":MasonUpdate")
end
deps.add({source = "williamboman/mason.nvim", hooks = {post_checkout = _12_}})
do
  local mason = require("mason")
  mason.setup()
end
deps.add("williamboman/mason-lspconfig.nvim")
do
  local mason_lspconfig = require("mason-lspconfig")
  mason_lspconfig.setup()
end
local function _13_()
  return vim.cmd(":TSUpdate")
end
deps.add({source = "nvim-treesitter/nvim-treesitter", hooks = {post_checkout = _13_}})
do
  local treesitter = require("nvim-treesitter.configs")
  vim.o.foldexpr = "nvim_treesitter#foldexpr()"
  vim.o.foldmethod = "expr"
  treesitter.setup({highlight = {enable = true, disable = {"fennel"}}, matchup = {enable = true, disable = {"fennel"}}, ensure_installed = {"c", "lua", "vim", "vimdoc", "query", "clojure", "comment", "css", "diff", "djot", "dockerfile", "fennel", "fish", "git_rebase", "gitattributes", "gitcommit", "go", "gomod", "gosum", "gotmpl", "html", "javascript", "json", "just", "make", "markdown", "markdown_inline", "proto", "python", "requirements", "sql", "ssh_config", "textproto", "toml", "xml", "yaml", "zig"}})
end
deps.add("stefanvanburen/rams")
deps.add("mcchrish/zenbones.nvim")
deps.add("rose-pine/neovim")
deps.add("lunacookies/vim-plan9")
deps.add("miikanissi/modus-themes.nvim")
vim.cmd.colorscheme("modus")
vim.api.nvim_create_autocmd("VimResized", {command = ":wincmd ="})
local filetype_settings = {go = {expandtab = false}, javascript = {expandtab = true, shiftwidth = 2}, javascriptreact = {expandtab = true, shiftwidth = 2}, typescript = {expandtab = true, shiftwidth = 2}, typescriptreact = {expandtab = true, shiftwidth = 2}, html = {expandtab = true, shiftwidth = 2}, css = {expandtab = true, shiftwidth = 2}, cs = {commentstring = "// %s"}, gohtmltmpl = {expandtab = true, shiftwidth = 2, commentstring = "{{/* %s */}}"}, gotexttmpl = {expandtab = true, shiftwidth = 2, commentstring = "{{/* %s */}}"}, fish = {expandtab = true, shiftwidth = 4, commentstring = "# %s"}, yaml = {expandtab = true, shiftwidth = 2}, svg = {expandtab = true, shiftwidth = 2}, json = {expandtab = true, shiftwidth = 2}, bash = {expandtab = true, shiftwidth = 2}, python = {expandtab = true, shiftwidth = 4}, xml = {expandtab = true, shiftwidth = 4}, starlark = {expandtab = true, shiftwidth = 4, commentstring = "# %s"}, proto = {expandtab = true, shiftwidth = 2, commentstring = "// %s", cindent = true}, gitcommit = {spell = true}, sql = {wrap = true, commentstring = "-- %s"}, clojure = {expandtab = true, textwidth = 80}, kotlin = {commentstring = "// %s"}, markdown = {spell = true, wrap = true, conceallevel = 0, shiftwidth = 2}}
do
  local aufiletypes = vim.api.nvim_create_augroup("filetypes", {})
  for filetype, settings in pairs(filetype_settings) do
    local function _14_()
      for name, value in pairs(settings) do
        vim.api.nvim_set_option_value(name, value, {scope = "local"})
      end
      return nil
    end
    vim.api.nvim_create_autocmd("FileType", {group = aufiletypes, pattern = filetype, callback = _14_})
  end
  local function extension__3efiletype(extension, filetype)
    local function _15_()
      return vim.api.nvim_set_option_value("filetype", filetype, {scope = "local"})
    end
    return vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {group = aufiletypes, pattern = ("*." .. tostring(extension)), callback = _15_})
  end
  for extension, filetype in pairs({mdx = "markdown", star = "starlark", tpl = "gotexttmpl", gotext = "gotexttmpl"}) do
    extension__3efiletype(extension, filetype)
  end
end
for pattern, skeleton_file in pairs({["buf.yaml"] = "buf.yaml", ["buf.gen.yaml"] = "buf.gen.yaml", Makefile = "Makefile", [".nfnl.fnl"] = ".nfnl.fnl", ["*.proto"] = "proto.proto"}) do
  vim.api.nvim_create_autocmd({"BufNewFile"}, {pattern = pattern, command = ("0r ~/.config/nvim/skeletons/" .. skeleton_file)})
end
map("n", ";", ":")
local function _16_()
  return vim.cmd({cmd = "Git", mods = {vertical = true}})
end
map("n", "<leader>gs", _16_)
local function _17_()
  return vim.cmd({cmd = "Gwrite"})
end
map("n", "<leader>gw", _17_)
local function _18_()
  return vim.cmd({cmd = "Git", args = {"commit"}})
end
map("n", "<leader>gc", _18_)
local function _19_()
  return vim.cmd({cmd = "Git", args = {"push"}})
end
map("n", "<leader>gp", _19_)
local function _20_()
  return vim.cmd({cmd = "Git", args = {"blame"}})
end
map("n", "<leader>gb", _20_)
local function _21_()
  if (vim.v.count ~= 0) then
    return "j"
  else
    return "gj"
  end
end
map({"n", "v"}, "j", _21_, {expr = true})
local function _23_()
  if (vim.v.count ~= 0) then
    return "k"
  else
    return "gk"
  end
end
map({"n", "v"}, "k", _23_, {expr = true})
map({"n", "v"}, "<tab>", "%", {remap = true})
for keymap, file in pairs({["<leader>ef"] = "$HOME/.config/fish/config.fish", ["<leader>eg"] = "$HOME/.config/git/config", ["<leader>ek"] = "$HOME/.config/kitty/kitty.conf", ["<leader>ev"] = "$HOME/.config/nvim/init.fnl"}) do
  local function _25_()
    return vim.cmd({cmd = "edit", args = {file}})
  end
  map("n", keymap, _25_)
end
local function _26_()
  return vim.cmd({cmd = "write"})
end
map("n", "<leader>w", _26_)
local function _27_()
  return vim.cmd({cmd = "close"})
end
map("n", "<leader>cl", _27_)
local function _28_()
  return vim.cmd({cmd = "split"})
end
map("n", "<leader>ss", _28_)
local function _29_()
  return vim.cmd({cmd = "vsplit"})
end
map("n", "<leader>vs", _29_)
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
vim.diagnostic.config({virtual_text = {severity = {min = vim.diagnostic.severity.WARN}}, underline = true, float = {border = "single", source = "always", focusable = false}})
local function lsp_attach(_30_)
  local _arg_31_ = _30_
  local buf = _arg_31_["buf"]
  local _arg_32_ = _arg_31_["data"]
  local client_id = _arg_32_["client_id"]
  local client = vim.lsp.get_client_by_id(client_id)
  if (client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint) then
    vim.lsp.inlay_hint.enable(true, {bufnr = buf})
  else
  end
  if client.server_capabilities.documentHighlightProvider then
    local augroup_id = vim.api.nvim_create_augroup("lsp-document-highlight", {clear = false})
    vim.api.nvim_create_autocmd({"CursorHold", "InsertLeave"}, {group = augroup_id, buffer = buf, callback = vim.lsp.buf.document_highlight})
    vim.api.nvim_create_autocmd({"CursorMoved", "InsertEnter"}, {group = augroup_id, buffer = buf, callback = vim.lsp.buf.clear_references})
  else
  end
  local function buffer_map(from, to)
    return map("n", from, to, {buffer = buf})
  end
  buffer_map("gD", vim.lsp.buf.declaration)
  buffer_map("gd", vim.lsp.buf.definition)
  buffer_map("gi", vim.lsp.buf.implementation)
  buffer_map("grr", vim.lsp.buf.references)
  buffer_map("grt", vim.lsp.buf.type_definition)
  buffer_map("grn", vim.lsp.buf.rename)
  map({"n", "x"}, "gra", vim.lsp.buf.code_action, {buffer = buf})
  return map("i", "<C-s>", vim.lsp.buf.signature_help, {buffer = buf})
end
vim.api.nvim_create_autocmd("LspAttach", {callback = lsp_attach})
local lspconfig = require("lspconfig")
local schemastore = require("schemastore")
local server_settings = {[lspconfig.gopls] = {cmd = {"gopls", "-remote=auto"}, filetypes = {"go", "gomod", "gowork", "gotmpl", "gohtmltmpl", "gotexttmpl"}, settings = {gopls = {staticcheck = true, linkTarget = "godocs.io", templateExtensions = {"tpl", "tmpl"}, analyses = {unusedparams = true, unusedwrite = true, useany = true}}}}, [lspconfig.jsonls] = {settings = {json = {schemas = schemastore.json.schemas(), validate = {enable = true}}}}, [lspconfig.yamlls] = {settings = {yaml = {schemas = schemastore.yaml.schemas(), schemaStore = {url = "", enable = false}}}}, [lspconfig.clojure_lsp] = {}, [lspconfig.cssls] = {}, [lspconfig.ruff] = {}, [lspconfig.tsserver] = {}, [lspconfig.eslint] = {}, [lspconfig.bashls] = {}, [lspconfig.taplo] = {}, [lspconfig.omnisharp] = {cmd = {"omnisharp"}}, [lspconfig.dockerls] = {}, [lspconfig.fennel_ls] = {settings = {["fennel-ls"] = {["extra-globals"] = "vim"}}}, [lspconfig.lua_ls] = {settings = {Lua = {runtime = {version = "LuaJIT"}, workspace = {library = vim.api.nvim_list_runtime_paths()}}}}, [lspconfig.rust_analyzer] = {}}
for server, settings in pairs(server_settings) do
  server.setup(settings)
end
return nil
