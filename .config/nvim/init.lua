-- [nfnl] Compiled from init.fnl by https://github.com/Olical/nfnl, do not edit.
local lazypath = (vim.fn.stdpath("data") .. "/lazy/lazy.nvim")
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath})
else
end
do end (vim.opt.rtp):prepend(lazypath)
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
local lazy = require("lazy")
local function _2_()
  vim.g["gtfo#terminals"] = {mac = "kitty"}
  return nil
end
local function _3_()
  local gitsigns = require("gitsigns")
  local function _4_(bufnr)
    local function buffer_map(mode, l, r, _3fopts)
      local opts = (_3fopts or {})
      opts.buffer = bufnr
      return map(mode, l, r, opts)
    end
    local function _5_()
      return gitsigns.next_hunk()
    end
    buffer_map("n", "]c", _5_)
    local function _6_()
      return gitsigns.prev_hunk()
    end
    buffer_map("n", "[c", _6_)
    buffer_map({"n", "v"}, "<leader>hs", gitsigns.stage_hunk)
    buffer_map({"n", "v"}, "<leader>hr", gitsigns.reset_hunk)
    buffer_map("n", "<leader>hS", gitsigns.stage_buffer)
    buffer_map("n", "<leader>hR", gitsigns.reset_buffer)
    buffer_map("n", "<leader>hu", gitsigns.undo_stage_hunk)
    buffer_map("n", "<leader>hp", gitsigns.preview_hunk)
    local function _7_()
      return gitsigns.blame_line({full = true})
    end
    buffer_map("n", "<leader>hb", _7_)
    buffer_map("n", "<leader>tb", gitsigns.toggle_current_line_blame)
    buffer_map("n", "<leader>hd", gitsigns.diffthis)
    local function _8_()
      return gitsigns.diffthis("~")
    end
    buffer_map("n", "<leader>hD", _8_)
    buffer_map("n", "<leader>td", gitsigns.toggle_deleted)
    return buffer_map({"o", "x"}, "ih", ":<C-U>Gitsigns select_hunk<CR>")
  end
  return gitsigns.setup({on_attach = _4_})
end
local function _9_()
  vim.g.fugitive_legacy_commands = 0
  return nil
end
local function _10_()
  vim.g["conjure#highlight#enabled"] = true
  vim.g["conjure#filetypes"] = {"clojure", "fennel", "janet", "python"}
  vim.g["conjure#client#clojure#nrepl#connection#auto_repl#hidden"] = true
  vim.g["conjure#filetype#janet"] = "conjure.client.janet.stdio"
  return nil
end
local function _11_()
  vim.g["test#strategy"] = "dispatch"
  map("n", "<C-t>n", ":TestNearest<cr>")
  map("n", "<C-t>f", ":TestFile<cr>")
  map("n", "<C-t>s", ":TestSuite<cr>")
  map("n", "<C-t>l", ":TestLast<cr>")
  return map("n", "<C-t>v", ":TestVisit<cr>")
end
local function _12_()
  local lint = require("lint")
  lint.linters_by_ft = {proto = {"buf_lint"}, fish = {"fish"}}
  local function _13_()
    return lint.try_lint()
  end
  return vim.api.nvim_create_autocmd("BufWritePost", {callback = _13_})
end
local function _14_()
  local treesitter = require("nvim-treesitter.configs")
  return treesitter.setup({highlight = {enable = true}, matchup = {enable = true}, ensure_installed = {"c", "lua", "vim", "vimdoc", "clojure", "comment", "css", "diff", "dockerfile", "fennel", "fish", "html", "gitcommit", "git_rebase", "gitattributes", "go", "gomod", "javascript", "json", "make", "markdown", "markdown_inline", "proto", "python", "requirements", "ssh_config", "sql", "toml", "yaml", "zig"}})
end
local function _15_()
  local mini_basics = require("mini.basics")
  local mini_pairs = require("mini.pairs")
  local mini_trailspace = require("mini.trailspace")
  local mini_comment = require("mini.comment")
  local mini_surround = require("mini.surround")
  local mini_hues = require("mini.hues")
  local mini_pick = require("mini.pick")
  local mini_extra = require("mini.extra")
  local mini_statusline = require("mini.statusline")
  local mini_completion = require("mini.completion")
  local mini_bracketed = require("mini.bracketed")
  local mini_files = require("mini.files")
  local mini_notify = require("mini.notify")
  mini_basics.setup()
  mini_pairs.setup()
  mini_trailspace.setup()
  map("n", "<leader>sw", mini_trailspace.trim)
  mini_comment.setup({options = {ignore_blank_line = true}})
  mini_surround.setup({mappings = {add = "gza", delete = "gzd", find = "gzf", find_left = "gzF", highlight = "gzh", replace = "gzr", update_n_lines = "gzn"}})
  vim.cmd.colorscheme("randomhue")
  mini_pick.setup()
  map("n", "<leader>ff", mini_pick.builtin.files)
  local function _16_()
    return mini_pick.builtin.files({tool = "git"})
  end
  map("n", "<leader>fg", _16_)
  map("n", "<leader>fb", mini_pick.builtin.buffers)
  map("n", "<leader>fl", mini_pick.builtin.grep_live)
  map("n", "<leader>fh", mini_pick.builtin.help)
  local function _17_()
    return mini_extra.pickers.lsp({scope = "document_symbol"})
  end
  map("n", "<leader>fs", _17_)
  local function _18_()
    return mini_extra.pickers.lsp({scope = "references"})
  end
  map("n", "<leader>fr", _18_)
  mini_statusline.setup()
  mini_completion.setup()
  mini_bracketed.setup()
  mini_files.setup({mappings = {go_in_plus = "<CR>"}})
  local function _19_()
    return mini_files.open(vim.api.nvim_buf_get_name(0))
  end
  map("n", "-", _19_)
  return mini_notify.setup()
end
local function _20_()
  vim.g.matchup_matchparen_offscreen = {}
  return nil
end
local function _21_()
  return vim.cmd.colorscheme("alabaster")
end
local function _22_()
  return vim.cmd.colorscheme("rams")
end
local function _23_()
  return vim.cmd.colorscheme("zenwritten")
end
local function _24_()
  return vim.cmd.colorscheme("rose-pine")
end
lazy.setup({{url = "https://github.com/justinmk/vim-gtfo", config = _2_}, {url = "https://github.com/tyru/open-browser.vim"}, {url = "https://github.com/lewis6991/fileline.nvim"}, {url = "https://github.com/lewis6991/gitsigns.nvim", config = _3_}, {url = "https://github.com/tpope/vim-fugitive", config = _9_}, {url = "https://github.com/tpope/vim-rhubarb"}, {url = "https://github.com/mattn/vim-gotmpl"}, {url = "https://github.com/fladson/vim-kitty"}, {url = "https://github.com/NoahTheDuke/vim-just"}, {url = "https://github.com/raimon49/requirements.txt.vim"}, {url = "https://github.com/jaawerth/fennel.vim"}, {url = "https://github.com/janet-lang/janet.vim"}, {url = "https://github.com/Olical/nfnl"}, {url = "https://github.com/Olical/conjure", config = _10_}, {url = "https://github.com/gpanders/nvim-parinfer"}, {url = "https://github.com/vim-test/vim-test", dependencies = {{url = "https://github.com/tpope/vim-dispatch"}}, config = _11_}, {url = "https://github.com/neovim/nvim-lspconfig"}, {url = "https://github.com/b0o/SchemaStore.nvim"}, {url = "https://github.com/stevearc/conform.nvim", opts = {formatters_by_ft = {proto = {"buf"}, just = {"just"}, fish = {"fish_indent"}, json = {"prettier"}, typescriptreact = {"prettier"}}, format_on_save = {timeout_ms = 500, lsp_fallback = true}}}, {url = "https://github.com/mfussenegger/nvim-lint", config = _12_}, {url = "https://github.com/williamboman/mason.nvim", config = true, build = ":MasonUpdate"}, {url = "https://github.com/williamboman/mason-lspconfig.nvim", config = true}, {url = "https://github.com/nvim-treesitter/nvim-treesitter", build = ":TSUpdate", config = _14_}, {url = "https://github.com/echasnovski/mini.nvim", config = _15_}, {url = "https://github.com/tpope/vim-eunuch"}, {url = "https://github.com/andymass/vim-matchup", config = _20_}, {url = "https://github.com/tpope/vim-abolish"}, {url = "https://github.com/rktjmp/paperplanes.nvim"}, {url = "https://github.com/rktjmp/lush.nvim"}, {url = "https://git.sr.ht/~p00f/alabaster.nvim", lazy = true, priority = 1000, config = _21_}, {url = "https://github.com/stefanvanburen/rams", lazy = true, priority = 1000, dependencies = {{url = "https://github.com/stefanvanburen/rams"}}, config = _22_}, {url = "https://github.com/mcchrish/zenbones.nvim", lazy = true, priority = 1000, config = _23_}, {url = "https://github.com/rose-pine/neovim", name = "rose-pine", lazy = true, priority = 1000, config = _24_}}, {install = {colorscheme = {"randomhue", "zenwritten", "rams", "alabaster", "rose-pine"}}})
vim.api.nvim_create_autocmd("VimResized", {command = ":wincmd ="})
local function _25_()
  return vim.highlight.on_yank()
end
vim.api.nvim_create_autocmd("TextYankPost", {callback = _25_})
local filetype_settings = {go = {expandtab = false}, javascript = {expandtab = true, shiftwidth = 2}, javascriptreact = {expandtab = true, shiftwidth = 2}, typescript = {expandtab = true, shiftwidth = 2}, typescriptreact = {expandtab = true, shiftwidth = 2}, html = {expandtab = true, shiftwidth = 2}, css = {expandtab = true, shiftwidth = 2}, gohtmltmpl = {expandtab = true, shiftwidth = 2, commentstring = "{{/* %s */}}"}, gotexttmpl = {expandtab = true, shiftwidth = 2, commentstring = "{{/* %s */}}"}, fish = {expandtab = true, shiftwidth = 4, commentstring = "# %s"}, yaml = {expandtab = true, shiftwidth = 2}, svg = {expandtab = true, shiftwidth = 2}, json = {expandtab = true, shiftwidth = 2}, bash = {expandtab = true, shiftwidth = 2}, python = {expandtab = true, shiftwidth = 4}, xml = {expandtab = true, shiftwidth = 4}, starlark = {expandtab = true, shiftwidth = 4, commentstring = "# %s"}, proto = {expandtab = true, shiftwidth = 2, commentstring = "// %s", cindent = true}, gitcommit = {spell = true}, sql = {wrap = true, commentstring = "-- %s"}, clojure = {expandtab = true, textwidth = 80}, kotlin = {commentstring = "// %s"}, markdown = {spell = true, wrap = true, conceallevel = 0, shiftwidth = 2}}
do
  local aufiletypes = vim.api.nvim_create_augroup("filetypes", {})
  for filetype, settings in pairs(filetype_settings) do
    local function _26_()
      for name, value in pairs(settings) do
        vim.api.nvim_set_option_value(name, value, {scope = "local"})
      end
      return nil
    end
    vim.api.nvim_create_autocmd("FileType", {group = aufiletypes, pattern = filetype, callback = _26_})
  end
  local function _27_()
    return vim.api.nvim_set_option_value("filetype", "markdown", {scope = "local"})
  end
  vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {group = aufiletypes, pattern = "*.mdx", callback = _27_})
  local function _28_()
    return vim.api.nvim_set_option_value("filetype", "starlark", {scope = "local"})
  end
  vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {group = aufiletypes, pattern = "*.star", callback = _28_})
  local function _29_()
    return vim.api.nvim_set_option_value("filetype", "gotmpl", {scope = "local"})
  end
  vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {group = aufiletypes, pattern = "*.tpl", callback = _29_})
end
map("n", ";", ":")
map("n", "<leader>?", vim.diagnostic.open_float)
local function _30_()
  return vim.cmd({cmd = "Git", mods = {vertical = true}})
end
map("n", "<leader>gs", _30_)
local function _31_()
  return vim.cmd({cmd = "Gwrite"})
end
map("n", "<leader>gw", _31_)
local function _32_()
  return vim.cmd({cmd = "Git", args = {"commit"}})
end
map("n", "<leader>gc", _32_)
local function _33_()
  return vim.cmd({cmd = "Git", args = {"push"}})
end
map("n", "<leader>gp", _33_)
local function _34_()
  return vim.cmd({cmd = "Git", args = {"blame"}})
end
map("n", "<leader>gb", _34_)
map({"n", "v"}, "gx", "<plug>(openbrowser-smart-search)", {})
local function _35_()
  if (vim.v.count ~= 0) then
    return "j"
  else
    return "gj"
  end
end
map({"n", "v"}, "j", _35_, {expr = true})
local function _37_()
  if (vim.v.count ~= 0) then
    return "k"
  else
    return "gk"
  end
end
map({"n", "v"}, "k", _37_, {expr = true})
map({"n", "v"}, "<tab>", "%", {remap = true})
local function _39_()
  return vim.cmd({cmd = "edit", args = {"$HOME/.config/fish/config.fish"}})
end
map("n", "<leader>ef", _39_)
local function _40_()
  return vim.cmd({cmd = "edit", args = {"$HOME/.config/git/config"}})
end
map("n", "<leader>eg", _40_)
local function _41_()
  return vim.cmd({cmd = "edit", args = {"$HOME/.config/kitty/kitty.conf"}})
end
map("n", "<leader>ek", _41_)
local function _42_()
  return vim.cmd({cmd = "edit", args = {"$HOME/.config/nvim/init.fnl"}})
end
map("n", "<leader>ev", _42_)
local function _43_()
  return vim.cmd({cmd = "write"})
end
map("n", "<leader>w", _43_)
local function _44_()
  return vim.cmd({cmd = "close"})
end
map("n", "<leader>cl", _44_)
local function _45_()
  return vim.cmd({cmd = "split"})
end
map("n", "<leader>ss", _45_)
local function _46_()
  return vim.cmd({cmd = "vsplit"})
end
map("n", "<leader>vs", _46_)
local function _47_()
  return vim.cmd({cmd = "tabnew"})
end
map("n", "<leader>tn", _47_)
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
local function _51_(_48_)
  local _arg_49_ = _48_
  local buf = _arg_49_["buf"]
  local _arg_50_ = _arg_49_["data"]
  local client_id = _arg_50_["client_id"]
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
    local function _53_()
      return format(client)
    end
    buffer_map("<leader>af", _53_)
    if (client.name ~= "tsserver") then
      local function _54_()
        return format(client)
      end
      vim.api.nvim_create_autocmd("BufWritePre", {buffer = buf, callback = _54_})
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
vim.api.nvim_create_autocmd("LspAttach", {callback = _51_})
local lspconfig = require("lspconfig")
local schemastore = require("schemastore")
local server_settings = {[lspconfig.gopls] = {cmd = {"gopls", "-remote=auto"}, settings = {gopls = {staticcheck = true, linkTarget = "godocs.io", analyses = {unusedparams = true, unusedwrite = true, useany = true}}}}, [lspconfig.jsonls] = {settings = {json = {schemas = schemastore.json.schemas(), validate = {enable = true}}}}, [lspconfig.yamlls] = {settings = {yaml = {schemas = schemastore.yaml.schemas(), schemaStore = {url = "", enable = false}}}}, [lspconfig.clojure_lsp] = {}, [lspconfig.cssls] = {}, [lspconfig.bufls] = {}, [lspconfig.ruff_lsp] = {}, [lspconfig.pylsp] = {settings = {pylsp = {plugins = {pycodestyle = {enabled = false}, pyflakes = {enabled = false}}}}}, [lspconfig.tsserver] = {}, [lspconfig.eslint] = {}, [lspconfig.bashls] = {}, [lspconfig.taplo] = {}, [lspconfig.lua_ls] = {settings = {Lua = {runtime = {version = "LuaJIT"}, workspace = {library = vim.api.nvim_list_runtime_paths()}}}}, [lspconfig.rust_analyzer] = {}}
for server, settings in pairs(server_settings) do
  server.setup(settings)
end
return nil
