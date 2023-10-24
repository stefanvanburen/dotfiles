-- [nfnl] Compiled from init.fnl by https://github.com/Olical/nfnl, do not edit.
local lazypath = (vim.fn.stdpath("data") .. "/lazy/lazy.nvim")
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath})
else
end
do end (vim.opt.rtp):prepend(lazypath)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.o.completeopt = "menuone,noselect"
vim.o.background = "light"
vim.o.termguicolors = true
vim.o.linebreak = true
vim.o.breakindent = true
vim.o.breakindentopt = "shift:2,sbr"
vim.o.showbreak = "\226\134\179"
vim.o.shiftround = true
vim.o.fillchars = "eob: ,"
vim.o.gdefault = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.copyindent = true
vim.o.updatetime = 100
vim.o.infercase = true
vim.o.list = true
vim.o.listchars = "tab:\226\134\146 ,eol:\194\172,trail:\226\163\191"
vim.o.showmode = false
vim.o.undofile = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.clipboard = "unnamedplus"
vim.o.swapfile = false
vim.o.formatoptions = "tcqjronp"
vim.o.wildignorecase = true
vim.o.statusline = "%f%m %{FugitiveHead()}%=%l,%c %{&filetype}"
local lazy = require("lazy")
local function _2_()
  vim.g["gtfo#terminals"] = {mac = "kitty"}
  return nil
end
local function _3_()
  local gitsigns = require("gitsigns")
  local function _4_(bufnr)
    local function map(mode, l, r, _3fopts)
      local opts = (_3fopts or {})
      opts.buffer = bufnr
      return vim.keymap.set(mode, l, r, opts)
    end
    local function _5_()
      return gitsigns.next_hunk()
    end
    map("n", "]c", _5_)
    local function _6_()
      return gitsigns.prev_hunk()
    end
    map("n", "[c", _6_)
    map({"n", "v"}, "<leader>hs", gitsigns.stage_hunk)
    map({"n", "v"}, "<leader>hr", gitsigns.reset_hunk)
    map("n", "<leader>hS", gitsigns.stage_buffer)
    map("n", "<leader>hR", gitsigns.reset_buffer)
    map("n", "<leader>hu", gitsigns.undo_stage_hunk)
    map("n", "<leader>hp", gitsigns.preview_hunk)
    local function _7_()
      return gitsigns.blame_line({full = true})
    end
    map("n", "<leader>hb", _7_)
    map("n", "<leader>tb", gitsigns.toggle_current_line_blame)
    map("n", "<leader>hd", gitsigns.diffthis)
    local function _8_()
      return gitsigns.diffthis("~")
    end
    map("n", "<leader>hD", _8_)
    map("n", "<leader>td", gitsigns.toggle_deleted)
    return map({"o", "x"}, "ih", ":<C-U>Gitsigns select_hunk<CR>")
  end
  return gitsigns.setup({on_attach = _4_, attach_to_untracked = false})
end
local function _9_()
  vim.g.fugitive_legacy_commands = 0
  return nil
end
local function _10_()
  vim.g["conjure#highlight#enabled"] = true
  vim.g["conjure#client#clojure#nrepl#connection#auto_repl#hidden"] = true
  return nil
end
local function _11_()
  vim.g["test#strategy"] = "dispatch"
  vim.keymap.set("n", "<C-t>n", ":TestNearest<cr>")
  vim.keymap.set("n", "<C-t>f", ":TestFile<cr>")
  vim.keymap.set("n", "<C-t>s", ":TestSuite<cr>")
  vim.keymap.set("n", "<C-t>l", ":TestLast<cr>")
  return vim.keymap.set("n", "<C-t>v", ":TestVisit<cr>")
end
local function _12_()
  local lint = require("lint")
  lint.linters_by_ft = {proto = {"buf_lint"}}
  local function _13_()
    return lint.try_lint()
  end
  return vim.api.nvim_create_autocmd("BufWritePost", {callback = _13_})
end
local function _14_()
  local treesitter = require("nvim-treesitter.configs")
  return treesitter.setup({highlight = {enable = true}, matchup = {enable = true}, ensure_installed = {"c", "lua", "vim", "vimdoc", "clojure", "comment", "css", "diff", "dockerfile", "fennel", "fish", "html", "gitcommit", "git_rebase", "gitattributes", "go", "gomod", "javascript", "json", "make", "markdown", "markdown_inline", "proto", "python", "sql", "toml", "yaml", "zig"}})
end
local function _15_()
  local mini_pairs = require("mini.pairs")
  local mini_trailspace = require("mini.trailspace")
  local mini_comment = require("mini.comment")
  local mini_surround = require("mini.surround")
  local mini_hues = require("mini.hues")
  local mini_pick = require("mini.pick")
  mini_pairs.setup()
  mini_trailspace.setup()
  vim.keymap.set("n", "<leader>sw", mini_trailspace.trim)
  mini_comment.setup({options = {ignore_blank_line = true}})
  mini_surround.setup({mappings = {add = "gza", delete = "gzd", find = "gzf", find_left = "gzF", highlight = "gzh", replace = "gzr", update_n_lines = "gzn"}})
  mini_pick.setup()
  vim.keymap.set("n", "<leader>ff", mini_pick.builtin.files)
  local function _16_()
    return mini_pick.builtin.files({tool = "git"})
  end
  vim.keymap.set("n", "<leader>fg", _16_)
  vim.keymap.set("n", "<leader>fb", mini_pick.builtin.buffers)
  vim.keymap.set("n", "<leader>fl", mini_pick.builtin.grep_live)
  return vim.keymap.set("n", "<leader>fh", mini_pick.builtin.help)
end
local function _17_()
  vim.g.matchup_matchparen_offscreen = {}
  return nil
end
local function _18_()
  local leap = require("leap")
  return leap.add_default_mappings()
end
local function _19_()
  return vim.cmd.colorscheme("alabaster")
end
local function _20_()
  return vim.cmd.colorscheme("rams")
end
local function _21_()
  return vim.cmd.colorscheme("zenwritten")
end
local function _22_()
  return vim.cmd.colorscheme("rose-pine")
end
lazy.setup({{url = "https://github.com/justinmk/vim-dirvish"}, {url = "https://github.com/justinmk/vim-gtfo", config = _2_}, {url = "https://github.com/tyru/open-browser.vim"}, {url = "https://github.com/lewis6991/fileline.nvim"}, {url = "https://github.com/lewis6991/gitsigns.nvim", config = _3_}, {url = "https://github.com/tpope/vim-fugitive", config = _9_}, {url = "https://github.com/tpope/vim-rhubarb"}, {url = "https://github.com/mattn/vim-gotmpl"}, {url = "https://github.com/fladson/vim-kitty"}, {url = "https://github.com/NoahTheDuke/vim-just"}, {url = "https://github.com/jaawerth/fennel.vim"}, {url = "https://github.com/janet-lang/janet.vim"}, {url = "https://github.com/Olical/nfnl"}, {url = "https://github.com/Olical/conjure", config = _10_}, {url = "https://github.com/gpanders/nvim-parinfer"}, {url = "https://github.com/vim-test/vim-test", dependencies = {{url = "https://github.com/tpope/vim-dispatch"}}, config = _11_}, {url = "https://github.com/neovim/nvim-lspconfig"}, {url = "https://github.com/mfussenegger/nvim-lsp-compl"}, {url = "https://github.com/b0o/SchemaStore.nvim"}, {url = "https://github.com/stevearc/conform.nvim", opts = {formatters_by_ft = {proto = {"buf"}, just = {"just"}}, format_on_save = {timeout_ms = 500, lsp_fallback = true}}}, {url = "https://github.com/mfussenegger/nvim-lint", config = _12_}, {url = "https://github.com/williamboman/mason.nvim", config = true, build = ":MasonUpdate"}, {url = "https://github.com/williamboman/mason-lspconfig.nvim", config = true}, {url = "https://github.com/nvim-treesitter/nvim-treesitter", build = ":TSUpdate", config = _14_}, {url = "https://github.com/echasnovski/mini.nvim", config = _15_}, {url = "https://github.com/mfussenegger/nvim-overfly", dependencies = {{url = "https://github.com/mfussenegger/nvim-qwahl"}}}, {url = "https://github.com/tpope/vim-eunuch"}, {url = "https://github.com/andymass/vim-matchup", config = _17_}, {url = "https://github.com/ggandor/leap.nvim", dependencies = {{url = "https://github.com/tpope/vim-repeat"}}, config = _18_}, {url = "https://github.com/tpope/vim-abolish"}, {url = "https://github.com/tpope/vim-repeat"}, {url = "https://github.com/rktjmp/lush.nvim"}, {url = "https://git.sr.ht/~p00f/alabaster.nvim", lazy = true, priority = 1000, config = _19_}, {url = "https://github.com/stefanvanburen/rams", lazy = true, priority = 1000, config = _20_}, {url = "https://github.com/mcchrish/zenbones.nvim", priority = 1000, config = _21_, lazy = false}, {url = "https://github.com/rose-pine/neovim", name = "rose-pine", lazy = true, priority = 1000, config = _22_}}, {install = {colorscheme = {"randomhue", "zenwritten", "rams", "alabaster", "rose-pine"}}})
vim.api.nvim_create_autocmd("VimResized", {command = ":wincmd ="})
local function _23_()
  return vim.highlight.on_yank()
end
vim.api.nvim_create_autocmd("TextYankPost", {callback = _23_})
local filetype_settings = {go = {shiftwidth = 4, tabstop = 4, expandtab = false}, javascript = {expandtab = true, shiftwidth = 2, tabstop = 2}, javascriptreact = {expandtab = true, shiftwidth = 2, tabstop = 2}, typescript = {expandtab = true, shiftwidth = 2, tabstop = 2}, typescriptreact = {expandtab = true, shiftwidth = 2, tabstop = 2}, html = {expandtab = true, shiftwidth = 2, tabstop = 2}, css = {expandtab = true, shiftwidth = 2, tabstop = 2}, gohtmltmpl = {expandtab = true, shiftwidth = 2, tabstop = 2, commentstring = "{{/* %s */}}"}, gotexttmpl = {expandtab = true, shiftwidth = 2, tabstop = 2, commentstring = "{{/* %s */}}"}, fish = {expandtab = true, shiftwidth = 4, tabstop = 4, commentstring = "# %s"}, yaml = {expandtab = true, shiftwidth = 2, tabstop = 2}, svg = {expandtab = true, shiftwidth = 2, tabstop = 2}, json = {expandtab = true, shiftwidth = 2, tabstop = 2}, bash = {expandtab = true, shiftwidth = 2, tabstop = 2}, python = {expandtab = true, shiftwidth = 4, tabstop = 4}, xml = {expandtab = true, shiftwidth = 4, tabstop = 4}, starlark = {expandtab = true, shiftwidth = 4, tabstop = 4, commentstring = "# %s"}, gitcommit = {spell = true}, sql = {wrap = true, commentstring = "-- %s"}, clojure = {expandtab = true, textwidth = 80}, proto = {commentstring = "// %s"}, kotlin = {commentstring = "// %s"}, markdown = {spell = true, wrap = true, conceallevel = 0, shiftwidth = 2}}
do
  local aufiletypes = vim.api.nvim_create_augroup("filetypes", {})
  for filetype, settings in pairs(filetype_settings) do
    local function _24_()
      for name, value in pairs(settings) do
        vim.api.nvim_set_option_value(name, value, {scope = "local"})
      end
      return nil
    end
    vim.api.nvim_create_autocmd("FileType", {group = aufiletypes, pattern = filetype, callback = _24_})
  end
  local function _25_()
    return vim.api.nvim_set_option_value("filetype", "markdown", {scope = "local"})
  end
  vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {group = aufiletypes, pattern = "*.mdx", callback = _25_})
  local function _26_()
    return vim.api.nvim_set_option_value("filetype", "starlark", {scope = "local"})
  end
  vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {group = aufiletypes, pattern = "*.star", callback = _26_})
end
local map = vim.keymap.set
map("n", ";", ":")
map("n", "<leader>?", vim.diagnostic.open_float)
local function _27_()
  return vim.cmd({cmd = "Git", mods = {vertical = true}})
end
map("n", "<leader>gs", _27_)
local function _28_()
  return vim.cmd({cmd = "Gwrite"})
end
map("n", "<leader>gw", _28_)
local function _29_()
  return vim.cmd({cmd = "Git", args = {"commit"}})
end
map("n", "<leader>gc", _29_)
local function _30_()
  return vim.cmd({cmd = "Git", args = {"push"}})
end
map("n", "<leader>gp", _30_)
local function _31_()
  return vim.cmd({cmd = "Git", args = {"blame"}})
end
map("n", "<leader>gb", _31_)
map({"n", "v"}, "gx", "<plug>(openbrowser-smart-search)", {})
local function _32_()
  if (vim.v.count ~= 0) then
    return "j"
  else
    return "gj"
  end
end
map({"n", "v"}, "j", _32_, {expr = true})
local function _34_()
  if (vim.v.count ~= 0) then
    return "k"
  else
    return "gk"
  end
end
map({"n", "v"}, "k", _34_, {expr = true})
map({"n", "v"}, "<tab>", "%", {remap = true})
local function _36_()
  return vim.cmd({cmd = "edit", args = {"$HOME/.config/fish/config.fish"}})
end
map("n", "<leader>ef", _36_)
local function _37_()
  return vim.cmd({cmd = "edit", args = {"$HOME/.config/git/config"}})
end
map("n", "<leader>eg", _37_)
local function _38_()
  return vim.cmd({cmd = "edit", args = {"$HOME/.config/kitty/kitty.conf"}})
end
map("n", "<leader>ek", _38_)
local function _39_()
  return vim.cmd({cmd = "edit", args = {"~/.config/nvim/init.fnl"}})
end
map("n", "<leader>ev", _39_)
local function _40_()
  return vim.cmd({cmd = "write"})
end
map("n", "<leader>w", _40_)
local function _41_()
  return vim.cmd({cmd = "close"})
end
map("n", "<leader>cl", _41_)
local function _42_()
  return vim.cmd({cmd = "split"})
end
map("n", "<leader>ss", _42_)
local function _43_()
  return vim.cmd({cmd = "vsplit"})
end
map("n", "<leader>vs", _43_)
map("n", "]r", ":tabnext<cr>")
map("n", "[r", ":tabprev<cr>")
map("n", "<leader>tn", ":tabnew<cr>")
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
map("n", "<C-l>", ":nohlsearch<cr>", {})
local function organize_imports()
  return vim.lsp.buf.code_action({context = {only = {"source.organizeImports"}}, apply = true})
end
local function format(client)
  vim.lsp.buf.format({timeout_ms = 2000})
  if (client.name == "gopls") then
    return organize_imports()
  else
    return nil
  end
end
local function on_attach(_45_)
  local _arg_46_ = _45_
  local buf = _arg_46_["buf"]
  local _arg_47_ = _arg_46_["data"]
  local client_id = _arg_47_["client_id"]
  local client = vim.lsp.get_client_by_id(client_id)
  do
    local lsp_compl = require("lsp_compl")
    lsp_compl.attach(client, buf, {})
  end
  local function buffer_map(from, to)
    return vim.keymap.set("n", from, to, {buffer = buf, silent = true})
  end
  if client.server_capabilities.documentFormattingProvider then
    local function _48_()
      return format(client)
    end
    buffer_map("<leader>af", _48_)
    if (client.name ~= "tsserver") then
      local function _49_()
        return format(client)
      end
      vim.api.nvim_create_autocmd("BufWritePre", {buffer = buf, callback = _49_})
    else
    end
  else
  end
  if (client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint) then
    vim.lsp.inlay_hint(buf, true)
  else
  end
  if client.server_capabilities.hoverProvider then
    buffer_map("K", vim.lsp.buf.hover)
  else
  end
  if client.server_capabilities.documentHighlightProvider then
    local augroup_id = vim.api.nvim_create_augroup("lsp-document-highlight", {clear = false})
    vim.api.nvim_create_autocmd("CursorHold", {group = augroup_id, buffer = buf, callback = vim.lsp.buf.document_highlight})
    vim.api.nvim_create_autocmd("CursorMoved", {group = augroup_id, buffer = buf, callback = vim.lsp.buf.clear_references})
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
vim.api.nvim_create_autocmd("LspAttach", {callback = on_attach})
local lspconfig = require("lspconfig")
local schemastore = require("schemastore")
local server_settings = {[lspconfig.gopls.setup] = {cmd = {"gopls", "-remote=auto"}, settings = {gopls = {staticcheck = true, analyses = {unusedparams = true, unusedwrite = true, nilness = true}, hints = {parameterNames = true, compositeLiteralTypes = false, rangeVariableTypes = false, functionTypeParameters = false, assignVariableTypes = false, constantValues = false, compositeLiteralFields = false}}}}, [lspconfig.jsonls.setup] = {settings = {json = {schemas = schemastore.json.schemas(), validate = {enable = true}}}}, [lspconfig.yamlls.setup] = {settings = {yaml = {schemas = schemastore.yaml.schemas(), schemaStore = {url = "", enable = false}}}}, [lspconfig.clojure_lsp] = {}, [lspconfig.cssls] = {}, [lspconfig.bufls] = {}, [lspconfig.ruff_lsp] = {}, [lspconfig.pylsp] = {}, [lspconfig.tsserver] = {}, [lspconfig.eslint] = {}, [lspconfig.bashls] = {}, [lspconfig.taplo] = {}, [lspconfig.rust_analyzer] = {}}
for server, settings in pairs(server_settings) do
  server.setup(settings)
end
return nil
