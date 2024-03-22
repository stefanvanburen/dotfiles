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
vim.o.updatetime = 100
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
deps.add("lewis6991/gitsigns.nvim")
local gitsigns = require("gitsigns")
do
  local on_attach
  local function _2_(bufnr)
    local function buffer_map(mode, l, r, _3fopts)
      local opts = (_3fopts or {})
      opts.buffer = bufnr
      return map(mode, l, r, opts)
    end
    local function _3_()
      return gitsigns.next_hunk()
    end
    buffer_map("n", "]c", _3_)
    local function _4_()
      return gitsigns.prev_hunk()
    end
    buffer_map("n", "[c", _4_)
    buffer_map({"n", "v"}, "<leader>hs", gitsigns.stage_hunk)
    buffer_map({"n", "v"}, "<leader>hr", gitsigns.reset_hunk)
    buffer_map("n", "<leader>hS", gitsigns.stage_buffer)
    buffer_map("n", "<leader>hR", gitsigns.reset_buffer)
    buffer_map("n", "<leader>hu", gitsigns.undo_stage_hunk)
    buffer_map("n", "<leader>hp", gitsigns.preview_hunk)
    local function _5_()
      return gitsigns.blame_line({full = true})
    end
    buffer_map("n", "<leader>hb", _5_)
    buffer_map("n", "<leader>tb", gitsigns.toggle_current_line_blame)
    buffer_map("n", "<leader>hd", gitsigns.diffthis)
    local function _6_()
      return gitsigns.diffthis("~")
    end
    buffer_map("n", "<leader>hD", _6_)
    buffer_map("n", "<leader>td", gitsigns.toggle_deleted)
    return buffer_map({"o", "x"}, "ih", ":<C-U>Gitsigns select_hunk<CR>")
  end
  on_attach = _2_
  gitsigns.setup({on_attach = on_attach})
end
local function _7_(bufnr)
  local function buffer_map(mode, l, r, _3fopts)
    local opts = (_3fopts or {})
    opts.buffer = bufnr
    return map(mode, l, r, opts)
  end
  local function _8_()
    return gitsigns.next_hunk()
  end
  buffer_map("n", "]c", _8_)
  local function _9_()
    return gitsigns.prev_hunk()
  end
  buffer_map("n", "[c", _9_)
  buffer_map({"n", "v"}, "<leader>hs", gitsigns.stage_hunk)
  buffer_map({"n", "v"}, "<leader>hr", gitsigns.reset_hunk)
  buffer_map("n", "<leader>hS", gitsigns.stage_buffer)
  buffer_map("n", "<leader>hR", gitsigns.reset_buffer)
  buffer_map("n", "<leader>hu", gitsigns.undo_stage_hunk)
  buffer_map("n", "<leader>hp", gitsigns.preview_hunk)
  local function _10_()
    return gitsigns.blame_line({full = true})
  end
  buffer_map("n", "<leader>hb", _10_)
  buffer_map("n", "<leader>tb", gitsigns.toggle_current_line_blame)
  buffer_map("n", "<leader>hd", gitsigns.diffthis)
  local function _11_()
    return gitsigns.diffthis("~")
  end
  buffer_map("n", "<leader>hD", _11_)
  buffer_map("n", "<leader>td", gitsigns.toggle_deleted)
  return buffer_map({"o", "x"}, "ih", ":<C-U>Gitsigns select_hunk<CR>")
end
gitsigns.setup({on_attach = _7_})
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
local conform = require("conform")
conform.setup({formatters_by_ft = {proto = {"buf"}, just = {"just"}, fennel = {"fnlfmt"}, fish = {"fish_indent"}, json = {"prettier"}, typescriptreact = {"prettier"}}, format_on_save = {timeout_ms = 500, lsp_fallback = true}})
deps.add("mfussenegger/nvim-lint")
local nvim_lint = require("lint")
nvim_lint.linters_by_ft = {proto = {"buf_lint"}, fish = {"fish"}, go = {"golangcilint"}, janet = {"janet"}, fennel = {"fennel"}}
local function _12_()
  return nvim_lint.try_lint()
end
vim.api.nvim_create_autocmd("BufWritePost", {callback = _12_})
local function _13_()
  return vim.cmd(":MasonUpdate")
end
deps.add({source = "williamboman/mason.nvim", hooks = {post_checkout = _13_}})
local mason = require("mason")
mason.setup()
deps.add("williamboman/mason-lspconfig.nvim")
local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup()
local function _14_()
  return vim.cmd(":TSUpdate")
end
deps.add({source = "nvim-treesitter/nvim-treesitter", hooks = {post_checkout = _14_}})
local treesitter = require("nvim-treesitter.configs")
treesitter.setup({highlight = {enable = true, disable = {"fennel"}}, matchup = {enable = true, disable = {"fennel"}}, ensure_installed = {"c", "lua", "vim", "vimdoc", "clojure", "comment", "css", "diff", "dockerfile", "fennel", "fish", "git_rebase", "gitattributes", "gitcommit", "go", "gomod", "html", "javascript", "json", "just", "make", "markdown", "markdown_inline", "proto", "python", "requirements", "sql", "ssh_config", "textproto", "toml", "yaml", "zig"}})
deps.add("echasnovski/mini.nvim")
local mini_basics = require("mini.basics")
mini_basics.setup()
local mini_pairs = require("mini.pairs")
mini_pairs.setup()
local mini_trailspace = require("mini.trailspace")
mini_trailspace.setup()
map("n", "<leader>sw", mini_trailspace.trim)
local mini_comment = require("mini.comment")
mini_comment.setup({options = {ignore_blank_line = true}})
local mini_surround = require("mini.surround")
mini_surround.setup({mappings = {add = "gza", delete = "gzd", find = "gzf", find_left = "gzF", highlight = "gzh", replace = "gzr", update_n_lines = "gzn"}})
local mini_hues = require("mini.hues")
vim.cmd.colorscheme("randomhue")
local mini_indentscope = require("mini.indentscope")
mini_indentscope.setup()
local mini_pick = require("mini.pick")
mini_pick.setup()
map("n", "<leader>ff", mini_pick.builtin.files)
local function _15_()
  return mini_pick.builtin.files({tool = "git"})
end
map("n", "<leader>fg", _15_)
map("n", "<leader>fb", mini_pick.builtin.buffers)
map("n", "<leader>fl", mini_pick.builtin.grep_live)
map("n", "<leader>fh", mini_pick.builtin.help)
local mini_extra = require("mini.extra")
local function _16_()
  return mini_extra.pickers.lsp({scope = "document_symbol"})
end
map("n", "<leader>fs", _16_)
local function _17_()
  return mini_extra.pickers.lsp({scope = "references"})
end
map("n", "<leader>fr", _17_)
local mini_statusline = require("mini.statusline")
mini_statusline.setup()
local mini_completion = require("mini.completion")
mini_completion.setup()
local mini_bracketed = require("mini.bracketed")
mini_bracketed.setup()
local mini_files = require("mini.files")
mini_files.setup({mappings = {go_in_plus = "<CR>"}})
local function _18_()
  return mini_files.open(vim.api.nvim_buf_get_name(0))
end
map("n", "-", _18_)
local mini_notify = require("mini.notify")
mini_notify.setup()
deps.add("tpope/vim-eunuch")
deps.add("andymass/vim-matchup")
vim.g.matchup_matchparen_offscreen = {}
deps.add("tpope/vim-abolish")
deps.add("rktjmp/paperplanes.nvim")
deps.add("rktjmp/lush.nvim")
deps.add("stefanvanburen/rams")
deps.add("mcchrish/zenbones.nvim")
deps.add("rose-pine/neovim")
vim.api.nvim_create_autocmd("VimResized", {command = ":wincmd ="})
local filetype_settings = {go = {expandtab = false}, javascript = {expandtab = true, shiftwidth = 2}, javascriptreact = {expandtab = true, shiftwidth = 2}, typescript = {expandtab = true, shiftwidth = 2}, typescriptreact = {expandtab = true, shiftwidth = 2}, html = {expandtab = true, shiftwidth = 2}, css = {expandtab = true, shiftwidth = 2}, gohtmltmpl = {expandtab = true, shiftwidth = 2, commentstring = "{{/* %s */}}"}, gotexttmpl = {expandtab = true, shiftwidth = 2, commentstring = "{{/* %s */}}"}, fish = {expandtab = true, shiftwidth = 4, commentstring = "# %s"}, yaml = {expandtab = true, shiftwidth = 2}, svg = {expandtab = true, shiftwidth = 2}, json = {expandtab = true, shiftwidth = 2}, bash = {expandtab = true, shiftwidth = 2}, python = {expandtab = true, shiftwidth = 4}, xml = {expandtab = true, shiftwidth = 4}, starlark = {expandtab = true, shiftwidth = 4, commentstring = "# %s"}, proto = {expandtab = true, shiftwidth = 2, commentstring = "// %s", cindent = true}, gitcommit = {spell = true}, sql = {wrap = true, commentstring = "-- %s"}, clojure = {expandtab = true, textwidth = 80}, kotlin = {commentstring = "// %s"}, markdown = {spell = true, wrap = true, conceallevel = 0, shiftwidth = 2}}
do
  local aufiletypes = vim.api.nvim_create_augroup("filetypes", {})
  for filetype, settings in pairs(filetype_settings) do
    local function _19_()
      for name, value in pairs(settings) do
        vim.api.nvim_set_option_value(name, value, {scope = "local"})
      end
      return nil
    end
    vim.api.nvim_create_autocmd("FileType", {group = aufiletypes, pattern = filetype, callback = _19_})
  end
  local function extension__3efiletype(extension, filetype)
    local function _20_()
      return vim.api.nvim_set_option_value("filetype", filetype, {scope = "local"})
    end
    return vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {group = aufiletypes, pattern = ("*." .. tostring(extension)), callback = _20_})
  end
  extension__3efiletype("mdx", "markdown")
  extension__3efiletype("star", "starlark")
  extension__3efiletype("tpl", "gotmpl")
  extension__3efiletype("txtpb", "textproto")
end
map("n", ";", ":")
map("n", "<leader>?", vim.diagnostic.open_float)
local function _21_()
  return vim.cmd({cmd = "Git", mods = {vertical = true}})
end
map("n", "<leader>gs", _21_)
local function _22_()
  return vim.cmd({cmd = "Gwrite"})
end
map("n", "<leader>gw", _22_)
local function _23_()
  return vim.cmd({cmd = "Git", args = {"commit"}})
end
map("n", "<leader>gc", _23_)
local function _24_()
  return vim.cmd({cmd = "Git", args = {"push"}})
end
map("n", "<leader>gp", _24_)
local function _25_()
  return vim.cmd({cmd = "Git", args = {"blame"}})
end
map("n", "<leader>gb", _25_)
map({"n", "v"}, "gx", "<plug>(openbrowser-smart-search)", {})
local function _26_()
  if (vim.v.count ~= 0) then
    return "j"
  else
    return "gj"
  end
end
map({"n", "v"}, "j", _26_, {expr = true})
local function _28_()
  if (vim.v.count ~= 0) then
    return "k"
  else
    return "gk"
  end
end
map({"n", "v"}, "k", _28_, {expr = true})
map({"n", "v"}, "<tab>", "%", {remap = true})
local function _30_()
  return vim.cmd({cmd = "edit", args = {"$HOME/.config/fish/config.fish"}})
end
map("n", "<leader>ef", _30_)
local function _31_()
  return vim.cmd({cmd = "edit", args = {"$HOME/.config/git/config"}})
end
map("n", "<leader>eg", _31_)
local function _32_()
  return vim.cmd({cmd = "edit", args = {"$HOME/.config/kitty/kitty.conf"}})
end
map("n", "<leader>ek", _32_)
local function _33_()
  return vim.cmd({cmd = "edit", args = {"$HOME/.config/nvim/init.fnl"}})
end
map("n", "<leader>ev", _33_)
local function _34_()
  return vim.cmd({cmd = "write"})
end
map("n", "<leader>w", _34_)
local function _35_()
  return vim.cmd({cmd = "close"})
end
map("n", "<leader>cl", _35_)
local function _36_()
  return vim.cmd({cmd = "split"})
end
map("n", "<leader>ss", _36_)
local function _37_()
  return vim.cmd({cmd = "vsplit"})
end
map("n", "<leader>vs", _37_)
local function _38_()
  return vim.cmd({cmd = "tabnew"})
end
map("n", "<leader>tn", _38_)
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
vim.fn.sign_define("DiagnosticSignError", {text = "\195\151", texthl = "DiagnosticSignError"})
vim.fn.sign_define("DiagnosticSignWarn", {text = "!", texthl = "DiagnosticSignWarn"})
vim.fn.sign_define("DiagnosticSignInfo", {text = "\226\156\179\239\184\142", texthl = "DiagnosticSignInfo"})
vim.fn.sign_define("DiagnosticSignHint", {text = "?", texthl = "DiagnosticSignHint"})
vim.diagnostic.config({virtual_text = {prefix = "\226\150\170"}, float = {border = "single", source = "always", focusable = false}})
local function lsp_attach(_39_)
  local _arg_40_ = _39_
  local buf = _arg_40_["buf"]
  local _arg_41_ = _arg_40_["data"]
  local client_id = _arg_41_["client_id"]
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
    local function _43_()
      return format(client)
    end
    buffer_map("<leader>af", _43_)
    if (client.name ~= "tsserver") then
      local function _44_()
        return format(client)
      end
      vim.api.nvim_create_autocmd("BufWritePre", {buffer = buf, callback = _44_})
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
  if client.server_capabilities.documentHighlightProvider then
    local augroup_id = vim.api.nvim_create_augroup("lsp-document-highlight", {clear = false})
    vim.api.nvim_create_autocmd({"CursorHold", "InsertLeave"}, {group = augroup_id, buffer = buf, callback = vim.lsp.buf.document_highlight})
    vim.api.nvim_create_autocmd({"CursorMoved", "InsertEnter"}, {group = augroup_id, buffer = buf, callback = vim.lsp.buf.clear_references})
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
local server_settings = {[lspconfig.gopls] = {cmd = {"gopls", "-remote=auto"}, settings = {gopls = {staticcheck = true, linkTarget = "godocs.io", analyses = {unusedparams = true, unusedwrite = true, useany = true}}}}, [lspconfig.jsonls] = {settings = {json = {schemas = schemastore.json.schemas(), validate = {enable = true}}}}, [lspconfig.yamlls] = {settings = {yaml = {schemas = schemastore.yaml.schemas(), schemaStore = {url = "", enable = false}}}}, [lspconfig.clojure_lsp] = {}, [lspconfig.cssls] = {}, [lspconfig.bufls] = {}, [lspconfig.ruff_lsp] = {}, [lspconfig.pylsp] = {settings = {pylsp = {plugins = {pycodestyle = {enabled = false}, pyflakes = {enabled = false}}}}}, [lspconfig.tsserver] = {}, [lspconfig.eslint] = {}, [lspconfig.bashls] = {}, [lspconfig.taplo] = {}, [lspconfig.dockerls] = {}, [lspconfig.lua_ls] = {settings = {Lua = {runtime = {version = "LuaJIT"}, workspace = {library = vim.api.nvim_list_runtime_paths()}}}}, [lspconfig.rust_analyzer] = {}}
for server, settings in pairs(server_settings) do
  server.setup(settings)
end
return nil
