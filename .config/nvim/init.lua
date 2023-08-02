-- [nfnl] Compiled from  by https://github.com/Olical/nfnl, do not edit.
local lazypath = (vim.fn.stdpath("data") .. "/lazy/lazy.nvim")
do end (vim.opt.rtp):prepend(lazypath)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
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
local function _1_()
  local copilot = require("copilot")
  return copilot.setup({suggestion = {auto_trigger = false}})
end
local function _2_()
  local gitsigns = require("gitsigns")
  local function _3_(bufnr)
    local function map(mode, l, r, _3fopts)
      local opts = (_3fopts or {})
      opts.buffer = bufnr
      return vim.keymap.set(mode, l, r, opts)
    end
    local function _4_()
      return gitsigns.next_hunk()
    end
    map("n", "]c", _4_)
    local function _5_()
      return gitsigns.prev_hunk()
    end
    map("n", "[c", _5_)
    map({"n", "v"}, "<leader>hs", gitsigns.stage_hunk)
    map({"n", "v"}, "<leader>hr", gitsigns.reset_hunk)
    map("n", "<leader>hS", gitsigns.stage_buffer)
    map("n", "<leader>hR", gitsigns.reset_buffer)
    map("n", "<leader>hu", gitsigns.undo_stage_hunk)
    map("n", "<leader>hp", gitsigns.preview_hunk)
    local function _6_()
      return gitsigns.blame_line({full = true})
    end
    map("n", "<leader>hb", _6_)
    map("n", "<leader>tb", gitsigns.toggle_current_line_blame)
    map("n", "<leader>hd", gitsigns.diffthis)
    local function _7_()
      return gitsigns.diffthis("~")
    end
    map("n", "<leader>hD", _7_)
    map("n", "<leader>td", gitsigns.toggle_deleted)
    return map({"o", "x"}, "ih", ":<C-U>Gitsigns select_hunk<CR>")
  end
  return gitsigns.setup({on_attach = _3_, attach_to_untracked = false})
end
local function _8_()
  vim.g.fugitive_legacy_commands = 0
  return nil
end
local function _9_()
  vim.g["conjure#highlight#enabled"] = true
  vim.g["conjure#client#clojure#nrepl#connection#auto_repl#hidden"] = true
  return nil
end
local function _10_()
  vim.g["test#strategy"] = "dispatch"
  vim.keymap.set("n", "<C-t>n", ":TestNearest<cr>")
  vim.keymap.set("n", "<C-t>f", ":TestFile<cr>")
  vim.keymap.set("n", "<C-t>s", ":TestSuite<cr>")
  vim.keymap.set("n", "<C-t>l", ":TestLast<cr>")
  return vim.keymap.set("n", "<C-t>v", ":TestVisit<cr>")
end
local function _11_()
  local treesitter = require("nvim-treesitter.configs")
  return treesitter.setup({highlight = {enable = true}, matchup = {enable = true}, ensure_installed = {"c", "lua", "vim", "vimdoc", "clojure", "comment", "css", "diff", "fennel", "fish", "html", "git_rebase", "gitattributes", "go", "gomod", "javascript", "json", "make", "markdown", "markdown_inline", "python", "sql", "toml", "yaml", "zig"}})
end
local function _12_()
  local mini_pairs = require("mini.pairs")
  local mini_trailspace = require("mini.trailspace")
  local mini_comment = require("mini.comment")
  local mini_surround = require("mini.surround")
  local mini_hues = require("mini.hues")
  mini_pairs.setup()
  mini_trailspace.setup()
  vim.keymap.set("n", "<leader>sw", mini_trailspace.trim)
  mini_comment.setup({options = {ignore_blank_line = true}})
  return mini_surround.setup({mappings = {add = "gza", delete = "gzd", find = "gzf", find_left = "gzF", highlight = "gzh", replace = "gzr", update_n_lines = "gzn"}})
end
local function _13_()
  local fzf_lua = require("fzf-lua")
  fzf_lua.setup({winopts = {border = "single"}, fzf_colors = {fg = {"fg", "CursorLine"}, bg = {"bg", "Normal"}, hl = {"fg", "Comment"}, ["fg+"] = {"fg", "Normal"}, ["bg+"] = {"bg", "CursorLine"}, ["hl+"] = {"fg", "Statement"}, info = {"fg", "PreProc"}, prompt = {"fg", "Conditional"}, pointer = {"fg", "Exception"}, marker = {"fg", "Keyword"}, spinner = {"fg", "Label"}, header = {"fg", "Comment"}, gutter = {"bg", "Normal"}}, global_git_icons = false, global_file_icons = false})
  vim.keymap.set("n", "<leader>ff", fzf_lua.files)
  vim.keymap.set("n", "<leader>fg", fzf_lua.git_files)
  vim.keymap.set("n", "<leader>fb", fzf_lua.buffers)
  vim.keymap.set("n", "<leader>fl", fzf_lua.grep_project)
  vim.keymap.set("n", "<leader>fh", fzf_lua.help_tags)
  vim.keymap.set("n", "<leader>fr", fzf_lua.lsp_references)
  vim.keymap.set("n", "<leader>fs", fzf_lua.git_stash)
  local function _14_()
    return fzf_lua.git_files({cwd = "~"})
  end
  vim.keymap.set("n", "<leader>ed", _14_)
  local function _15_()
    return fzf_lua.files({cwd = "~/.config/nvim"})
  end
  return vim.keymap.set("n", "<leader>ev", _15_)
end
local function _16_()
  vim.g.matchup_matchparen_offscreen = {}
  return nil
end
local function _17_()
  local leap = require("leap")
  return leap.add_default_mappings()
end
local function _18_()
  return vim.cmd.colorscheme("alabaster")
end
local function _19_()
  return vim.cmd.colorscheme("rams")
end
local function _20_()
  return vim.cmd.colorscheme("zenwritten")
end
local function _21_()
  return vim.cmd.colorscheme("rose-pine")
end
lazy.setup({{url = "https://github.com/justinmk/vim-dirvish"}, {url = "https://github.com/zbirenbaum/copilot.lua", config = _1_, enabled = false}, {url = "https://github.com/tyru/open-browser.vim"}, {url = "https://github.com/lewis6991/fileline.nvim"}, {url = "https://github.com/lewis6991/gitsigns.nvim", config = _2_}, {url = "https://github.com/tpope/vim-fugitive", config = _8_}, {url = "https://github.com/tpope/vim-rhubarb"}, {url = "https://github.com/mattn/vim-gotmpl"}, {url = "https://github.com/fladson/vim-kitty"}, {url = "https://github.com/janet-lang/janet.vim"}, {url = "https://github.com/Olical/nfnl"}, {url = "https://github.com/Olical/conjure", config = _9_}, {url = "https://github.com/gpanders/nvim-parinfer"}, {url = "https://github.com/vim-test/vim-test", dependencies = {{url = "https://github.com/tpope/vim-dispatch"}}, config = _10_}, {url = "https://github.com/neovim/nvim-lspconfig"}, {url = "https://github.com/b0o/SchemaStore.nvim"}, {url = "https://github.com/williamboman/mason.nvim", config = true, build = ":MasonUpdate"}, {url = "https://github.com/williamboman/mason-lspconfig.nvim", config = true}, {url = "https://github.com/nvim-treesitter/nvim-treesitter", build = ":TSUpdate", config = _11_}, {url = "https://github.com/echasnovski/mini.nvim", config = _12_}, {url = "https://github.com/ibhagwan/fzf-lua", config = _13_}, {url = "https://github.com/tpope/vim-eunuch"}, {url = "https://github.com/andymass/vim-matchup", config = _16_}, {url = "https://github.com/ggandor/leap.nvim", dependencies = {{url = "https://github.com/tpope/vim-repeat"}}, config = _17_}, {url = "https://github.com/tpope/vim-abolish"}, {url = "https://github.com/tpope/vim-repeat"}, {url = "https://github.com/rktjmp/lush.nvim"}, {url = "https://git.sr.ht/~p00f/alabaster.nvim", lazy = true, priority = 1000, config = _18_}, {url = "https://github.com/stefanvanburen/rams", lazy = true, priority = 1000, config = _19_}, {url = "https://github.com/mcchrish/zenbones.nvim", priority = 1000, config = _20_, lazy = false}, {url = "https://github.com/rose-pine/neovim", name = "rose-pine", lazy = true, priority = 1000, config = _21_}}, {install = {colorscheme = {"randomhue", "zenwritten", "rams", "alabaster", "rose-pine"}}})
local create_autocmd = vim.api.nvim_create_autocmd
local create_augroup = vim.api.nvim_create_augroup
create_autocmd("VimResized", {command = ":wincmd ="})
local function _22_()
  return vim.highlight.on_yank()
end
create_autocmd("TextYankPost", {callback = _22_})
local filetype_settings = {go = {shiftwidth = 4, tabstop = 4, expandtab = false}, javascript = {expandtab = true, shiftwidth = 2, tabstop = 2}, javascriptreact = {expandtab = true, shiftwidth = 2, tabstop = 2}, typescript = {expandtab = true, shiftwidth = 2, tabstop = 2}, typescriptreact = {expandtab = true, shiftwidth = 2, tabstop = 2}, html = {expandtab = true, shiftwidth = 2, tabstop = 2}, css = {expandtab = true, shiftwidth = 2, tabstop = 2}, gohtmltmpl = {expandtab = true, shiftwidth = 2, tabstop = 2, commentstring = "{{/* %s */}}"}, gotexttmpl = {expandtab = true, shiftwidth = 2, tabstop = 2, commentstring = "{{/* %s */}}"}, fish = {expandtab = true, shiftwidth = 4, tabstop = 4, commentstring = "# %s"}, yaml = {expandtab = true, shiftwidth = 2, tabstop = 2}, svg = {expandtab = true, shiftwidth = 2, tabstop = 2}, json = {expandtab = true, shiftwidth = 2, tabstop = 2}, bash = {expandtab = true, shiftwidth = 2, tabstop = 2}, python = {expandtab = true, shiftwidth = 4, tabstop = 4}, xml = {expandtab = true, shiftwidth = 4, tabstop = 4}, starlark = {expandtab = true, shiftwidth = 4, tabstop = 4, commentstring = "# %s"}, gitcommit = {spell = true}, sql = {wrap = true, commentstring = "-- %s"}, clojure = {expandtab = true, textwidth = 80}, proto = {commentstring = "// %s"}, kotlin = {commentstring = "// %s"}, markdown = {spell = true, wrap = true, conceallevel = 0, shiftwidth = 2}}
do
  local aufiletypes = create_augroup("filetypes", {})
  for filetype, settings in pairs(filetype_settings) do
    local function _23_()
      for name, value in pairs(settings) do
        vim.api.nvim_set_option_value(name, value, {scope = "local"})
      end
      return nil
    end
    create_autocmd("FileType", {group = aufiletypes, pattern = filetype, callback = _23_})
  end
  local function _24_()
    return vim.api.nvim_set_option_value("filetype", "make", {scope = "local"})
  end
  create_autocmd({"BufNewFile", "BufRead"}, {group = aufiletypes, pattern = "justfile", callback = _24_})
  local function _25_()
    return vim.api.nvim_set_option_value("filetype", "markdown", {scope = "local"})
  end
  create_autocmd({"BufNewFile", "BufRead"}, {group = aufiletypes, pattern = "*.mdx", callback = _25_})
  local function _26_()
    return vim.api.nvim_set_option_value("filetype", "starlark", {scope = "local"})
  end
  create_autocmd({"BufNewFile", "BufRead"}, {group = aufiletypes, pattern = "*.star", callback = _26_})
  local function _27_()
    return vim.api.nvim_set_option_value("iskeyword", "!,$,%,#,*,+,-,/,<,=,>,?,_,a-z,A-Z,48-57,128-247,124,94", {scope = "local"})
  end
  create_autocmd("FileType", {group = aufiletypes, pattern = "fennel", callback = _27_})
end
local map = vim.keymap.set
map("n", ";", ":")
map("n", "<leader>?", vim.diagnostic.open_float)
map("n", "[w", vim.diagnostic.goto_prev)
map("n", "]w", vim.diagnostic.goto_next)
map("n", "<leader>q", vim.diagnostic.setloclist)
local function _28_()
  return vim.cmd({cmd = "Git", mods = {vertical = true}})
end
map("n", "<leader>gs", _28_)
local function _29_()
  return vim.cmd({cmd = "Gwrite"})
end
map("n", "<leader>gw", _29_)
local function _30_()
  return vim.cmd({cmd = "Git", args = {"commit"}})
end
map("n", "<leader>gc", _30_)
local function _31_()
  return vim.cmd({cmd = "Git", args = {"push"}})
end
map("n", "<leader>gp", _31_)
local function _32_()
  return vim.cmd({cmd = "Git", args = {"blame"}})
end
map("n", "<leader>gb", _32_)
map({"n", "v"}, "gx", "<plug>(openbrowser-open)", {})
local function _33_()
  if (vim.v.count ~= 0) then
    return "j"
  else
    return "gj"
  end
end
map({"n", "v"}, "j", _33_, {expr = true})
local function _35_()
  if (vim.v.count ~= 0) then
    return "k"
  else
    return "gk"
  end
end
map({"n", "v"}, "k", _35_, {expr = true})
map({"n", "v"}, "<tab>", "%", {remap = true})
local function _37_()
  return vim.cmd({cmd = "edit", args = {"$HOME/.config/fish/config.fish"}})
end
map("n", "<leader>ef", _37_)
local function _38_()
  return vim.cmd({cmd = "edit", args = {"$HOME/.config/git/config"}})
end
map("n", "<leader>eg", _38_)
local function _39_()
  return vim.cmd({cmd = "edit", args = {"$HOME/.config/kitty/kitty.conf"}})
end
map("n", "<leader>ek", _39_)
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
local lspconfig = require("lspconfig")
local schemastore = require("schemastore")
local create_autocmd0 = vim.api.nvim_create_autocmd
local create_augroup0 = vim.api.nvim_create_augroup
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
      create_autocmd0("BufWritePre", {buffer = buf, callback = _49_})
    else
    end
  else
  end
  if client.server_capabilities.inlayHintProvider then
    vim.lsp.inlay_hint(buf, true)
  else
  end
  if client.server_capabilities.hoverProvider then
    buffer_map("K", vim.lsp.buf.hover)
  else
  end
  if client.server_capabilities.documentHighlightProvider then
    local augroup_id = create_augroup0("lsp-document-highlight", {clear = false})
    create_autocmd0("CursorHold", {group = augroup_id, buffer = buf, callback = vim.lsp.buf.document_highlight})
    create_autocmd0("CursorMoved", {group = augroup_id, buffer = buf, callback = vim.lsp.buf.clear_references})
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
create_autocmd0("LspAttach", {callback = on_attach})
lspconfig.gopls.setup({cmd = {"gopls", "-remote=auto"}, settings = {gopls = {staticcheck = true, analyses = {unusedparams = true, unusedwrite = true, nilness = true}, hints = {parameterNames = true, compositeLiteralTypes = false, assignVariableTypes = false, constantValues = false, functionTypeParameters = false, rangeVariableTypes = false, compositeLiteralFields = false}}}})
lspconfig.jsonls.setup({settings = {json = {schemas = schemastore.json.schemas(), validate = {enable = true}}}})
lspconfig.yamlls.setup({settings = {yaml = {schemas = schemastore.yaml.schemas()}}})
local servers = {lspconfig.clojure_lsp, lspconfig.bufls, lspconfig.ruff_lsp, lspconfig.pylsp, lspconfig.tsserver, lspconfig.eslint, lspconfig.sourcekit, lspconfig.bashls}
for _, lsp_server in ipairs(servers) do
  lsp_server.setup({})
end
return nil
