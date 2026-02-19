-- [nfnl] init.fnl
local path_package = (vim.fn.stdpath("data") .. "/site/")
local mini_path = (path_package .. "pack/deps/start/mini.nvim")
if not vim.uv.fs_stat(mini_path) then
  vim.system({"git", "clone", "--filter=blob:none", "https://github.com/nvim-mini/mini.nvim", mini_path})
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
  local opts = {foldlevelstart = 99, foldtext = "", breakindentopt = {shift = 2, sbr = true}, showbreak = "\226\134\179", shiftround = true, gdefault = true, copyindent = true, list = true, listchars = {tab = "\226\135\165 ", eol = "\194\172", trail = "\226\163\191"}, grepprg = "rg --vimgrep", clipboard = "unnamedplus", exrc = true, cursorlineopt = "number", diffopt = "internal,filler,closeoff", completeopt = "fuzzy,menu,menuone,popup,noselect", formatoptions = "tcqjronp1l", spelloptions = "camel", virtualedit = "block", iskeyword = "@,48-57,_,192-255,-", tabstop = 2, title = true, updatetime = 100, wildignorecase = true, inccommand = "split", winborder = "rounded", swapfile = false}
  for opt, val in pairs(opts) do
    local case_2_ = type(val)
    if (case_2_ == "table") then
      vim.opt[opt] = val
    else
      local _ = case_2_
      vim.o[opt] = val
    end
  end
end
deps.add("nvim-mini/mini.nvim")
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
  local mini_starter = require("mini.starter")
  mini_starter.setup()
end
do
  local mini_jump = require("mini.jump")
  mini_jump.setup()
end
do
  local mini_cmdline = require("mini.cmdline")
  mini_cmdline.setup()
end
do
  local mini_jump2d = require("mini.jump2d")
  mini_jump2d.setup()
end
do
  local mini_keymap = require("mini.keymap")
  mini_keymap.setup()
  mini_keymap.map_multistep("i", "<CR>", {"pmenu_accept", "minipairs_cr"})
  mini_keymap.map_multistep("i", "<BS>", {"minipairs_bs"})
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
  map("n", "<leader>fk", mini_extra.pickers.manpages, {desc = "Pick manpages"})
  map("n", "<leader>fo", mini_extra.pickers.options, {desc = "Pick options"})
  map("n", "<leader>fc", mini_extra.pickers.colorschemes, {desc = "Pick colorschemes"})
end
do
  local mini_colors = require("mini.colors")
  mini_colors.setup()
end
do
  local mini_misc = require("mini.misc")
  mini_misc.setup()
  mini_misc.setup_termbg_sync()
end
do
  local mini_hipatterns = require("mini.hipatterns")
  mini_hipatterns.setup({highlighters = {hex_color = mini_hipatterns.gen_highlighter.hex_color(), fixme = {pattern = "FIXME", group = "MiniHipatternsFixme"}, hack = {pattern = "HACK", group = "MiniHipatternsHack"}, todo = {pattern = "TODO", group = "MiniHipatternsTodo"}, note = {pattern = "NOTE", group = "MiniHipatternsNote"}}})
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
  mini_notify.setup()
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
do
  local mini_misc = require("mini.misc")
  mini_misc.setup()
  map("n", "<leader>z", mini_misc.zoom, {desc = "Toggle zoom of the current buffer"})
end
deps.add("rafamadriz/friendly-snippets")
local snippets_dir = (vim.fn.stdpath("config") .. "/snippets")
do
  local mini_snippets = require("mini.snippets")
  mini_snippets.setup({snippets = {mini_snippets.gen_loader.from_file((snippets_dir .. "/global.json")), mini_snippets.gen_loader.from_lang()}})
end
deps.add("chrisgrieser/nvim-scissors")
do
  local scissors = require("scissors")
  scissors.setup({snippetDir = snippets_dir})
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
deps.add("tpope/vim-dispatch")
map("n", "<leader>mm", ":make<cr>")
map("n", "<leader>MM", ":Make<cr>")
map("n", "<leader>m!", ":make!<cr>")
map("n", "<leader>M!", ":Make!<cr>")
deps.add({source = "tpope/vim-dadbod", depends = {"tpope/vim-dispatch"}})
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
  conform.setup({formatters_by_ft = {fennel = {"fnlfmt"}, fish = {"fish_indent"}, toml = {lsp_format = "never"}, yaml = {lsp_format = "never"}}, format_on_save = {timeout_ms = 5000}, default_format_opts = {lsp_format = "fallback"}})
  vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
end
deps.add("mfussenegger/nvim-lint")
do
  local nvim_lint = require("lint")
  local linters
  do
    local tbl_21_ = {}
    for k, v in pairs({fish = {"fish"}, janet = {"janet"}, markdown = {"rumdl"}, go = {"golangcilint"}, fennel = {"fennel"}}) do
      local k_22_, v_23_
      local function _9_(...)
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
      k_22_, v_23_ = k, _9_(...)
      if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
        tbl_21_[k_22_] = v_23_
      else
      end
    end
    linters = tbl_21_
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
  local treesitter = require("nvim-treesitter")
  local treesitter_languages = {"c", "lua", "vim", "vimdoc", "query", "bash", "c_sharp", "clojure", "comment", "css", "diff", "djot", "dockerfile", "editorconfig", "fennel", "fish", "git_rebase", "gitattributes", "gitcommit", "go", "gomod", "gosum", "gotmpl", "helm", "html", "janet_simple", "java", "javascript", "json", "just", "kotlin", "make", "markdown", "markdown_inline", "proto", "python", "requirements", "sql", "ssh_config", "starlark", "textproto", "toml", "xml", "yaml", "zig"}
  treesitter.install(treesitter_languages)
  local function _16_()
    vim.treesitter.start()
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.wo.foldmethod = "expr"
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    return nil
  end
  vim.api.nvim_create_autocmd("FileType", {pattern = treesitter_languages, callback = _16_})
end
do
  local filetype_to_langs = {c_sharp = {"csharp"}, bash = {"shellsession", "console"}, proto = {"protobuf"}}
  for filetype, langs in pairs(filetype_to_langs) do
    vim.treesitter.language.register(filetype, langs)
  end
end
deps.add("nvim-treesitter/nvim-treesitter-context")
deps.add("julienvincent/nvim-paredit")
do
  local nvim_paredit = require("nvim-paredit")
  nvim_paredit.setup()
end
deps.add("icholy/lsplinks.nvim")
do
  local lsplinks = require("lsplinks")
  lsplinks.setup()
  vim.keymap.set("n", "gx", lsplinks.gx)
end
do
  local vault_dir = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Vault"
  if (vim.fn.isdirectory(vault_dir) == 1) then
    deps.add("obsidian-nvim/obsidian.nvim")
    local obsidian = require("obsidian")
    obsidian.setup({workspaces = {{name = "vault", path = vault_dir}}, legacy_commands = false})
  else
  end
end
deps.add("stefanvanburen/rams")
deps.add("savq/melange-nvim")
deps.add("mcchrish/zenbones.nvim")
deps.add("rose-pine/neovim")
deps.add("lunacookies/vim-plan9")
deps.add("raphael-proust/vacme")
deps.add("miikanissi/modus-themes.nvim")
deps.add("https://git.sr.ht/~p00f/alabaster.nvim")
deps.add("https://git.sr.ht/~p00f/moduster.nvim")
do
  local day_of_month = tonumber(vim.fn.strftime("%d"))
  local colorscheme
  do
    local case_18_ = vim.fn.strftime("%m")
    if (case_18_ == "01") then
      colorscheme = "miniwinter"
    elseif (case_18_ == "02") then
      if (day_of_month < 4) then
        colorscheme = "miniwinter"
      else
        colorscheme = "minispring"
      end
    elseif (case_18_ == "03") then
      colorscheme = "minispring"
    elseif (case_18_ == "04") then
      colorscheme = "minispring"
    elseif (case_18_ == "05") then
      if (day_of_month < 6) then
        colorscheme = "minispring"
      else
        colorscheme = "minisummer"
      end
    elseif (case_18_ == "06") then
      colorscheme = "minisummer"
    elseif (case_18_ == "07") then
      colorscheme = "minisummer"
    elseif (case_18_ == "08") then
      if (day_of_month < 8) then
        colorscheme = "minisummer"
      else
        colorscheme = "miniautumn"
      end
    elseif (case_18_ == "09") then
      colorscheme = "miniautumn"
    elseif (case_18_ == "10") then
      colorscheme = "miniautumn"
    elseif (case_18_ == "11") then
      if (day_of_month < 8) then
        colorscheme = "miniautumn"
      else
        colorscheme = "miniwinter"
      end
    elseif (case_18_ == "12") then
      colorscheme = "miniwinter"
    else
      colorscheme = nil
    end
  end
  vim.cmd.colorscheme(colorscheme)
end
vim.api.nvim_create_autocmd("VimResized", {command = ":wincmd ="})
local filetype_settings = {go = {textwidth = 100, expandtab = false}, javascript = {expandtab = true, shiftwidth = 2}, javascriptreact = {expandtab = true, shiftwidth = 2}, typescript = {expandtab = true, shiftwidth = 2}, typescriptreact = {expandtab = true, shiftwidth = 2}, html = {expandtab = true, shiftwidth = 2}, css = {expandtab = true, shiftwidth = 2}, cs = {commentstring = "// %s"}, helm = {expandtab = true, shiftwidth = 2, commentstring = "{{/* %s */}}"}, gotmpl = {expandtab = true, shiftwidth = 2, commentstring = "{{/* %s */}}"}, fish = {expandtab = true, shiftwidth = 4, commentstring = "# %s"}, yaml = {expandtab = true, shiftwidth = 2}, svg = {expandtab = true, shiftwidth = 2}, json = {expandtab = true, shiftwidth = 2}, bash = {expandtab = true, shiftwidth = 2}, toml = {expandtab = true, shiftwidth = 2}, python = {expandtab = true, shiftwidth = 4}, xml = {expandtab = true, shiftwidth = 4}, starlark = {expandtab = true, shiftwidth = 4, commentstring = "# %s"}, proto = {expandtab = true, shiftwidth = 2, commentstring = "// %s", cindent = true}, gitcommit = {spell = true}, fennel = {commentstring = ";; %s"}, sql = {wrap = true, commentstring = "-- %s", expandtab = true, shiftwidth = 4}, clojure = {expandtab = true, textwidth = 80}, kotlin = {commentstring = "// %s"}, markdown = {spell = true, wrap = true}}
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
end
local yaml_ghactions_filetype = "yaml.ghactions"
vim.filetype.add({extension = {mdx = "markdown", star = "starlark", gotext = "gotmpl", gotmpl = "gotmpl"}, filename = {[".ignore"] = "gitignore", [".dockerignore"] = "gitignore", ["buf.lock"] = "yaml", ["uv.lock"] = "toml"}, pattern = {[".*/%.github/workflows/.*%.ya?ml"] = yaml_ghactions_filetype}})
for pattern, skeleton_file in pairs({["buf.gen.yaml"] = "buf.gen.yaml", [".nfnl.fnl"] = ".nfnl.fnl", justfile = "justfile"}) do
  vim.api.nvim_create_autocmd("BufNewFile", {pattern = pattern, command = ("0r ~/.config/nvim/skeletons/" .. skeleton_file)})
end
local function _25_(args)
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
vim.api.nvim_create_autocmd("BufNewFile", {pattern = "*", callback = _25_})
local function _27_()
  return vim.cmd({cmd = "DepsUpdate"})
end
map("n", "<leader>du", _27_)
map("n", ";", ":")
local function _28_()
  return vim.cmd({cmd = "Git", mods = {vertical = true}})
end
map("n", "<leader>gs", _28_, {desc = "Open :Git in a vertical split"})
local function _29_()
  return vim.cmd({cmd = "Gwrite"})
end
map("n", "<leader>gw", _29_, {desc = ":Gwrite"})
local function _30_()
  return vim.cmd({cmd = "Git", args = {"commit"}})
end
map("n", "<leader>gc", _30_, {desc = ":Git commit"})
local function _31_()
  return vim.cmd({cmd = "Git", args = {"push"}})
end
map("n", "<leader>gp", _31_, {desc = ":Git push"})
local function _32_()
  return vim.cmd({cmd = "Git", args = {"blame"}})
end
map("n", "<leader>gb", _32_, {desc = ":Git blame"})
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
map({"n", "v"}, "<tab>", "%", {remap = true, desc = "Navigate between matching brackets"})
for keymap, file in pairs({["<leader>ef"] = "$HOME/.config/fish/config.fish", ["<leader>egi"] = "$HOME/.config/git/config", ["<leader>ego"] = "$HOME/.config/ghostty/config", ["<leader>ek"] = "$HOME/.config/kitty/kitty.conf", ["<leader>ev"] = "$HOME/.config/nvim/init.fnl"}) do
  local function _37_()
    return vim.cmd({cmd = "edit", args = {file}})
  end
  map("n", keymap, _37_, {desc = (":edit " .. file)})
end
local function _38_()
  return vim.cmd({cmd = "write"})
end
map("n", "<leader>w", _38_, {desc = ":write the buffer to the file"})
local function _39_()
  return vim.cmd({cmd = "close"})
end
map("n", "<leader>cl", _39_, {desc = ":close the current window"})
local function _40_()
  return vim.cmd({cmd = "split"})
end
map("n", "<leader>ss", _40_, {desc = "Create a horizontal split"})
local function _41_()
  return vim.cmd({cmd = "vsplit"})
end
map("n", "<leader>vs", _41_, {desc = "Create a vertical split"})
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
local function _42_()
  return vim.show_pos()
end
map("n", "<leader>i", _42_)
map("i", "<c-k>", "<esc>")
map("c", "<c-k>", "<c-c>")
map("t", "<c-k>", "<c-\\><c-n>")
local function _43_()
  return vim.cmd({cmd = "tabnew"})
end
map("n", "<leader>tn", _43_, {desc = "Create a new tab"})
local function _44_()
  return vim.cmd({cmd = "tabnext"})
end
map("n", "]r", _44_, {desc = "Go to next tab"})
local function _45_()
  return vim.cmd({cmd = "tabprev"})
end
map("n", "[r", _45_, {desc = "Go to prev tab"})
map("n", "<C-l>", ":nohlsearch<cr>")
vim.diagnostic.config({signs = {text = {[vim.diagnostic.severity.ERROR] = "\195\151", [vim.diagnostic.severity.WARN] = "!", [vim.diagnostic.severity.INFO] = "\226\156\179\239\184\142", [vim.diagnostic.severity.HINT] = "?"}}, virtual_text = {severity = {min = vim.diagnostic.severity.WARN}}, underline = true, float = {border = "single", source = "always", focusable = false}})
local function lsp_attach(_46_)
  local buf = _46_.buf
  local _arg_47_ = _46_.data
  local client_id = _arg_47_.client_id
  local client = vim.lsp.get_client_by_id(client_id)
  if client:supports_method("textDocument/codeAction") then
    local function organize_imports()
      return vim.lsp.buf.code_action({context = {only = {"source.organizeImports"}}, apply = true})
    end
    vim.api.nvim_buf_create_user_command(buf, "OrganizeImports", organize_imports, {desc = "Organize Imports"})
    local function _48_()
      return vim.cmd({cmd = "OrganizeImports"})
    end
    map("n", "gro", _48_, {desc = "Organize Imports"})
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
  if client:supports_method("textDocument/foldingRange") then
    vim.wo[vim.api.nvim_get_current_win()]["foldexpr"] = "v:lua.vim.lsp.foldexpr()"
  else
  end
  if client:supports_method("textDocument/codeLens") then
    local augroup_id = vim.api.nvim_create_augroup("lsp-code-lens", {clear = false})
    vim.api.nvim_create_autocmd({"BufEnter", "CursorHold", "InsertLeave"}, {group = augroup_id, buffer = buf, callback = vim.lsp.codelens.refresh})
  else
  end
  if client:supports_method("textDocument/completion") then
    vim.lsp.completion.enable(true, client.id, buf, {autotrigger = true})
    map("i", "<C-space>", vim.lsp.completion.get, {buffer = buf, desc = "Manually trigger completion"})
  else
  end
  return map("n", "gD", vim.lsp.buf.declaration, {buffer = buf, desc = "Go to declaration"})
end
vim.api.nvim_create_autocmd("LspAttach", {callback = lsp_attach})
local schemastore = require("schemastore")
local server_settings = {gopls = {cmd = {"gopls", "-remote=auto"}, settings = {gopls = {semanticTokens = true, hints = {constantValues = true}}}}, jsonls = {settings = {json = {schemas = schemastore.json.schemas(), validate = {enable = true}}}}, yamlls = {settings = {yaml = {schemas = schemastore.yaml.schemas(), schemaStore = {url = "", enable = false}}}}, clojure_lsp = {}, biome = {}, fish_lsp = {}, janet_lsp = {}, ruff = {}, helm_ls = {}, bashls = {}, tombi = {}, omnisharp = {cmd = {"omnisharp"}}, docker_language_server = {}, fennel_ls = {}, lua_ls = {settings = {Lua = {runtime = {version = "LuaJIT"}, workspace = {library = vim.env.VIMRUNTIME, checkThirdParty = false}}}}, rust_analyzer = {}, buf_ls = {}, postgres_lsp = {}, tailwindcss = {}, ty = {}, starpls = {filetypes = {"bzl", "starlark"}}, cue = {}, ts_query_ls = {}, just = {}, gh_actions_ls = {filetypes = {yaml_ghactions_filetype}}}
for server, settings in pairs(server_settings) do
  vim.lsp.config(server, settings)
  vim.lsp.enable(server)
end
return nil
