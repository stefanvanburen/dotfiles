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
  local opts = {foldmethod = "indent", foldlevelstart = 99, breakindentopt = {shift = 2, sbr = true}, showbreak = "\226\134\179", shiftround = true, gdefault = true, copyindent = true, list = true, listchars = {tab = "\226\135\165 ", eol = "\194\172", trail = "\226\163\191"}, grepprg = "rg --vimgrep", clipboard = "unnamedplus", exrc = true, cursorlineopt = "number", completeopt = "fuzzy,menu,menuone,popup,noselect", formatoptions = "tcqjronp", title = true, updatetime = 300, wildignorecase = true, inccommand = "split", winborder = "rounded", swapfile = false}
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
  local mini_pick = require("mini.pick")
  mini_pick.setup()
  map("n", "<leader>ff", mini_pick.builtin.files)
  map("n", "<leader>fb", mini_pick.builtin.buffers)
  map("n", "<leader>fl", mini_pick.builtin.grep_live)
  map("n", "<leader>fh", mini_pick.builtin.help)
end
do
  local mini_extra = require("mini.extra")
  map("n", "<leader>fd", mini_extra.pickers.diagnostic)
  map("n", "<leader>fg", mini_extra.pickers.git_files)
  map("n", "<leader>fm", mini_extra.pickers.keymaps)
  map("n", "<leader>fo", mini_extra.pickers.options)
  map("n", "<leader>fc", mini_extra.pickers.colorschemes)
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
  local function _4_()
    return mini_files.open(vim.api.nvim_buf_get_name(0), false)
  end
  map("n", "-", _4_)
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
local function _5_()
  return vim.cmd({cmd = "DB", args = {"$DATABASE_URL"}})
end
map("n", "<leader>db", _5_)
deps.add("fladson/vim-kitty")
deps.add("NoahTheDuke/vim-just")
deps.add("janet-lang/janet.vim")
deps.add("qvalentin/helm-ls.nvim")
deps.add("Olical/nfnl")
deps.add("Olical/conjure")
vim.g["conjure#highlight#enabled"] = true
vim.g["conjure#filetypes"] = {"clojure", "fennel", "janet", "rust", "python"}
vim.g["conjure#client#clojure#nrepl#connection#auto_repl#hidden"] = true
vim.g["conjure#filetype#janet"] = "conjure.client.janet.stdio"
vim.g["conjure#mapping#doc_word"] = false
deps.add("gpanders/nvim-parinfer")
deps.add("vim-test/vim-test")
vim.g["test#strategy"] = "neovim_sticky"
local function _6_()
  return vim.cmd({cmd = "TestNearest"})
end
map("n", "<leader>tt", _6_)
local function _7_()
  return vim.cmd({cmd = "TestFile"})
end
map("n", "<leader>tf", _7_)
deps.add("neovim/nvim-lspconfig")
deps.add("b0o/SchemaStore.nvim")
deps.add("stevearc/conform.nvim")
do
  local conform = require("conform")
  conform.setup({formatters_by_ft = {fennel = {"fnlfmt"}, fish = {"fish_indent"}, go = {lsp_format = "fallback"}, just = {"just"}, proto = {lsp_format = "fallback"}, python = {lsp_format = "fallback"}}, format_on_save = {timeout_ms = 5000}})
end
deps.add("mfussenegger/nvim-lint")
do
  local nvim_lint = require("lint")
  nvim_lint.linters_by_ft = {fish = {"fish"}, janet = {"janet"}, fennel = {"fennel"}}
  local function _8_()
    return nvim_lint.try_lint()
  end
  vim.api.nvim_create_autocmd("BufWritePost", {callback = _8_})
end
local function _9_()
  return vim.cmd(":MasonUpdate")
end
deps.add({source = "williamboman/mason.nvim", hooks = {post_checkout = _9_}})
do
  local mason = require("mason")
  mason.setup()
end
deps.add("williamboman/mason-lspconfig.nvim")
do
  local mason_lspconfig = require("mason-lspconfig")
  mason_lspconfig.setup()
end
local function _10_()
  return vim.cmd(":TSUpdate")
end
deps.add({source = "nvim-treesitter/nvim-treesitter", hooks = {post_checkout = _10_}})
do
  local treesitter = require("nvim-treesitter.configs")
  vim.o.foldexpr = "nvim_treesitter#foldexpr()"
  vim.o.foldmethod = "expr"
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
deps.add("mcchrish/zenbones.nvim")
deps.add("rose-pine/neovim")
deps.add("lunacookies/vim-plan9")
deps.add("miikanissi/modus-themes.nvim")
do
  local _11_ = vim.fn.strftime("%m")
  if (_11_ == "01") then
    vim.cmd.colorscheme("miniwinter")
  elseif (_11_ == "02") then
    vim.cmd.colorscheme("miniwinter")
  elseif (_11_ == "03") then
    vim.cmd.colorscheme("minispring")
  elseif (_11_ == "04") then
    vim.cmd.colorscheme("minispring")
  elseif (_11_ == "05") then
    vim.cmd.colorscheme("minispring")
  elseif (_11_ == "06") then
    vim.cmd.colorscheme("minisummer")
  elseif (_11_ == "07") then
    vim.cmd.colorscheme("minisummer")
  elseif (_11_ == "08") then
    vim.cmd.colorscheme("minisummer")
  elseif (_11_ == "09") then
    vim.cmd.colorscheme("miniautumn")
  elseif (_11_ == "10") then
    vim.cmd.colorscheme("miniautumn")
  elseif (_11_ == "11") then
    vim.cmd.colorscheme("miniautumn")
  elseif (_11_ == "12") then
    vim.cmd.colorscheme("miniwinter")
  else
  end
end
vim.api.nvim_create_autocmd("VimResized", {command = ":wincmd ="})
local filetype_settings = {go = {textwidth = 100, expandtab = false}, javascript = {expandtab = true, shiftwidth = 2}, javascriptreact = {expandtab = true, shiftwidth = 2}, typescript = {expandtab = true, shiftwidth = 2}, typescriptreact = {expandtab = true, shiftwidth = 2}, html = {expandtab = true, shiftwidth = 2}, css = {expandtab = true, shiftwidth = 2}, cs = {commentstring = "// %s"}, helm = {expandtab = true, shiftwidth = 2, commentstring = "{{/* %s */}}"}, gotmpl = {expandtab = true, shiftwidth = 2, commentstring = "{{/* %s */}}"}, fish = {expandtab = true, shiftwidth = 4, commentstring = "# %s"}, yaml = {expandtab = true, shiftwidth = 2}, svg = {expandtab = true, shiftwidth = 2}, json = {expandtab = true, shiftwidth = 2}, bash = {expandtab = true, shiftwidth = 2}, python = {expandtab = true, shiftwidth = 4}, xml = {expandtab = true, shiftwidth = 4}, starlark = {expandtab = true, shiftwidth = 4, commentstring = "# %s"}, proto = {expandtab = true, shiftwidth = 2, commentstring = "// %s", cindent = true}, gitcommit = {spell = true}, fennel = {commentstring = ";; %s"}, sql = {wrap = true, commentstring = "-- %s", expandtab = true, shiftwidth = 4}, clojure = {expandtab = true, textwidth = 80}, kotlin = {commentstring = "// %s"}, markdown = {spell = true, wrap = true, conceallevel = 0, shiftwidth = 2}}
do
  local aufiletypes = vim.api.nvim_create_augroup("filetypes", {})
  for filetype, settings in pairs(filetype_settings) do
    local function _13_()
      for name, value in pairs(settings) do
        vim.api.nvim_set_option_value(name, value, {scope = "local"})
      end
      return nil
    end
    vim.api.nvim_create_autocmd("FileType", {group = aufiletypes, pattern = filetype, callback = _13_})
  end
end
vim.filetype.add({extension = {mdx = "markdown", star = "starlark", gotext = "gotmpl", gotmpl = "gotmpl"}, filename = {[".ignore"] = "gitignore", [".dockerignore"] = "gitignore", ["buf.lock"] = "yaml", ["uv.lock"] = "toml"}})
for pattern, skeleton_file in pairs({["buf.gen.yaml"] = "buf.gen.yaml", [".nfnl.fnl"] = ".nfnl.fnl"}) do
  vim.api.nvim_create_autocmd({"BufNewFile"}, {pattern = pattern, command = ("0r ~/.config/nvim/skeletons/" .. skeleton_file)})
end
do
  local autemplates = vim.api.nvim_create_augroup("templates", {})
  local function _14_(args)
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
        done_3f = true
      else
      end
    end
    return nil
  end
  vim.api.nvim_create_autocmd("BufNewFile", {pattern = "*", group = autemplates, callback = _14_})
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
for keymap, file in pairs({["<leader>ef"] = "$HOME/.config/fish/config.fish", ["<leader>egi"] = "$HOME/.config/git/config", ["<leader>ego"] = "$HOME/.config/ghostty/config", ["<leader>ek"] = "$HOME/.config/kitty/kitty.conf", ["<leader>ev"] = "$HOME/.config/nvim/init.fnl"}) do
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
local function _30_()
  return vim.cmd({cmd = "tabnew"})
end
map("n", "<leader>tn", _30_)
local function _31_()
  return vim.cmd({cmd = "tabnext"})
end
map("n", "]r", _31_)
local function _32_()
  return vim.cmd({cmd = "tabprev"})
end
map("n", "[r", _32_)
map("n", "<C-l>", ":nohlsearch<cr>")
vim.diagnostic.config({signs = {text = {[vim.diagnostic.severity.ERROR] = "\195\151", [vim.diagnostic.severity.WARN] = "!", [vim.diagnostic.severity.INFO] = "\226\156\179\239\184\142", [vim.diagnostic.severity.HINT] = "?"}}, virtual_text = {severity = {min = vim.diagnostic.severity.WARN}}, underline = true, float = {border = "single", source = "always", focusable = false}})
local function lsp_attach(_33_)
  local buf = _33_["buf"]
  local _arg_34_ = _33_["data"]
  local client_id = _arg_34_["client_id"]
  local client = vim.lsp.get_client_by_id(client_id)
  local function goimports()
    vim.lsp.buf.code_action({context = {only = {"source.organizeImports"}}, apply = true})
    return vim.lsp.buf.format()
  end
  if (client:supports_method("textDocument/formatting") and (client.name == "gopls")) then
    vim.api.nvim_create_autocmd("BufWritePre", {buffer = buf, callback = goimports})
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
  map("n", "gD", vim.lsp.buf.declaration, {buffer = buf})
  map("n", "gd", vim.lsp.buf.definition, {buffer = buf})
  return map("n", "grt", vim.lsp.buf.type_definition, {buffer = buf})
end
vim.api.nvim_create_autocmd("LspAttach", {callback = lsp_attach})
local schemastore = require("schemastore")
local server_settings = {gopls = {cmd = {"gopls", "-remote=auto"}, settings = {gopls = {semanticTokens = true}}}, jsonls = {settings = {json = {schemas = schemastore.json.schemas(), validate = {enable = true}}}}, yamlls = {settings = {yaml = {schemas = schemastore.yaml.schemas(), schemaStore = {url = "", enable = false}}}}, clojure_lsp = {}, biome = {}, fish_lsp = {}, janet_lsp = {}, cssls = {}, ruff = {}, ts_ls = {}, eslint = {}, helm_ls = {}, bashls = {}, taplo = {}, omnisharp = {cmd = {"omnisharp"}}, dockerls = {settings = {docker = {languageserver = {formatter = {ignoreMultilineInstructions = true}}}}}, fennel_ls = {settings = {["fennel-ls"] = {["extra-globals"] = "vim"}}}, lua_ls = {settings = {Lua = {runtime = {version = "LuaJIT"}, workspace = {library = vim.env.VIMRUNTIME, checkThirdParty = false}}}}, rust_analyzer = {}, buf_ls = {}, postgres_lsp = {}, tailwindcss = {}, ty = {}}
for server, settings in pairs(server_settings) do
  vim.lsp.config(server, settings)
  vim.lsp.enable(server)
end
return nil
