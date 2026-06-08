-- [nfnl] init.fnl
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.maplocalleader = ","
do
  local opts = {foldlevelstart = 99, foldtext = "", breakindentopt = {shift = 2, sbr = true}, showbreak = "\226\134\179", shiftround = true, gdefault = true, copyindent = true, list = true, listchars = {tab = "\226\135\165 ", eol = "\194\172", trail = "\226\163\191", nbsp = "\226\144\163"}, grepprg = "rg --vimgrep", clipboard = "unnamedplus", undofile = true, exrc = true, cursorlineopt = "number", diffopt = "internal,filler,closeoff", completeopt = "fuzzy,menu,menuone,popup,noselect", formatoptions = "tcqjronp1l", spelloptions = "camel", virtualedit = "block", iskeyword = "@,48-57,_,192-255,-", tabstop = 2, title = true, updatetime = 250, wildignorecase = true, inccommand = "split", winborder = "rounded", swapfile = false}
  for opt, val in pairs(opts) do
    local case_1_ = type(val)
    if (case_1_ == "table") then
      vim.opt[opt] = val
    else
      local _ = case_1_
      vim.o[opt] = val
    end
  end
end
vim.g.diffs = {integrations = {fugitive = true}, highlights = {warn_max_lines = false}}
local function _3_(ev)
  for pkg, cmd in pairs({["nvim-treesitter"] = "TSUpdate", mason = "MasonUpdate"}) do
    if ((ev.data.spec.name == pkg) and (ev.data.kind == "update") and not ev.data.active) then
      vim.cmd.packadd(pkg)
      vim.cmd({cmd = cmd})
    else
    end
  end
  return nil
end
vim.api.nvim_create_autocmd("PackChanged", {callback = _3_})
vim.pack.add({"https://github.com/nvim-mini/mini.nvim", "https://github.com/rafamadriz/friendly-snippets", "https://github.com/chrisgrieser/nvim-scissors", "https://github.com/chrisgrieser/nvim-origami", "https://github.com/tpope/vim-eunuch", "https://github.com/andymass/vim-matchup", "https://github.com/tpope/vim-abolish", "https://github.com/rktjmp/paperplanes.nvim", "https://github.com/tpope/vim-fugitive", "https://github.com/tpope/vim-rhubarb", "https://git.sr.ht/~willdurand/srht.vim", "https://github.com/barrettruth/diffs.nvim", "https://github.com/tpope/vim-dispatch", "https://github.com/tpope/vim-dadbod", "https://github.com/janet-lang/janet.vim", "https://github.com/qvalentin/helm-ls.nvim", "https://github.com/Olical/nfnl", "https://github.com/Olical/conjure", "https://github.com/gpanders/nvim-parinfer", "https://github.com/vim-test/vim-test", "https://github.com/neovim/nvim-lspconfig", "https://github.com/b0o/SchemaStore.nvim", "https://github.com/stevearc/conform.nvim", "https://github.com/mfussenegger/nvim-lint", "https://github.com/williamboman/mason.nvim", "https://github.com/williamboman/mason-lspconfig.nvim", "https://github.com/nvim-treesitter/nvim-treesitter", "https://github.com/nvim-treesitter/nvim-treesitter-context", "https://github.com/julienvincent/nvim-paredit", "https://github.com/stefanvanburen/rams", "https://github.com/savq/melange-nvim", "https://github.com/mcchrish/zenbones.nvim", "https://github.com/rose-pine/neovim", "https://github.com/lunacookies/vim-plan9", "https://github.com/raphael-proust/vacme", "https://github.com/stefanvanburen/usgc-nvim", "https://github.com/miikanissi/modus-themes.nvim"})
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
  map("x", "S", ":<C-U>lua MiniSurround.add('visual')<CR>", {silent = true, desc = "Add surround (visual)"})
  map("n", "yss", "ys_", {remap = true, desc = "Surround current line"})
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
  mini_misc.setup_restore_cursor()
  map("n", "<leader>z", mini_misc.zoom, {desc = "Toggle zoom of the current buffer"})
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
  local function _5_()
    local buf_name = vim.api.nvim_buf_get_name(0)
    if vim.uv.fs_stat(buf_name) then
      return mini_files.open(buf_name, false)
    else
      return mini_files.open()
    end
  end
  map("n", "-", _5_, {desc = "Open the file picker from the current file, or in the current working directory if the file does not exist"})
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
  local mini_input = require("mini.input")
  mini_input.setup()
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
local function _7_()
  return vim.cmd({cmd = "DB", args = {"$DATABASE_URL"}})
end
map("n", "<leader>db", _7_, {desc = "Open dadbod to the current $DATABASE_URL"})
vim.g["conjure#highlight#enabled"] = true
vim.g["conjure#client#clojure#nrepl#connection#auto_repl#hidden"] = true
vim.g["conjure#filetype#janet"] = "conjure.client.janet.stdio"
vim.g["conjure#mapping#doc_word"] = false
vim.g["test#strategy"] = "neovim_sticky"
vim.g["test#neovim_sticky#reopen_window"] = 1
vim.g["test#neovim#term_position"] = "horizontal 30"
local function _8_()
  return vim.cmd({cmd = "TestNearest"})
end
map("n", "<leader>tt", _8_, {desc = "Run nearest test"})
local function _9_()
  return vim.cmd({cmd = "TestFile"})
end
map("n", "<leader>tf", _9_, {desc = "Run all tests in the file"})
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
    for k, v in pairs({fish = {"fish"}, janet = {"janet"}, markdown = {"rumdl"}, go = {"golangcilint"}}) do
      local k_22_, v_23_
      local function _10_(...)
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
      k_22_, v_23_ = k, _10_(...)
      if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
        tbl_21_[k_22_] = v_23_
      else
      end
    end
    linters = tbl_21_
  end
  nvim_lint.linters_by_ft = linters
  local function _14_()
    return nvim_lint.try_lint()
  end
  vim.api.nvim_create_autocmd("BufWritePost", {callback = _14_})
end
do
  local mason = require("mason")
  mason.setup()
end
do
  local mason_lspconfig = require("mason-lspconfig")
  mason_lspconfig.setup({automatic_enable = false})
end
do
  local treesitter = require("nvim-treesitter")
  local treesitter_parsers = {"c", "lua", "vim", "vimdoc", "query", "bash", "c_sharp", "clojure", "comment", "css", "diff", "djot", "dockerfile", "editorconfig", "fennel", "fish", "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore", "go", "gomod", "gosum", "gotmpl", "helm", "html", "http", "janet_simple", "java", "javascript", "json", "json5", "jsx", "just", "kotlin", "make", "markdown", "markdown_inline", "proto", "python", "requirements", "sql", "ssh_config", "starlark", "textproto", "toml", "tsx", "typescript", "vhs", "xml", "yaml", "zig"}
  local treesitter_filetypes
  do
    local tmp_9_ = vim.deepcopy(treesitter_parsers)
    table.insert(tmp_9_, "buf-config")
    table.insert(tmp_9_, "yaml.github-actions")
    treesitter_filetypes = tmp_9_
  end
  treesitter.install(treesitter_parsers)
  local function _15_()
    vim.treesitter.start()
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.wo.foldmethod = "expr"
    return nil
  end
  vim.api.nvim_create_autocmd("FileType", {pattern = treesitter_filetypes, callback = _15_})
end
do
  local filetype_to_langs = {c_sharp = {"csharp"}, bash = {"shellsession", "console", "shell_session"}, objc = {"objectivec"}, proto = {"protobuf"}, yaml = {"buf-config", "yaml.github-actions"}, tiltfile = {"starlark"}}
  for filetype, langs in pairs(filetype_to_langs) do
    vim.treesitter.language.register(filetype, langs)
  end
end
do
  local nvim_paredit = require("nvim-paredit")
  nvim_paredit.setup()
end
do
  local now = os.date("*t")
  local colorscheme
  do
    local case_16_ = now.month
    if (case_16_ == 1) then
      colorscheme = "miniwinter"
    elseif (case_16_ == 2) then
      if (now.day < 4) then
        colorscheme = "miniwinter"
      else
        colorscheme = "minispring"
      end
    elseif (case_16_ == 3) then
      colorscheme = "minispring"
    elseif (case_16_ == 4) then
      colorscheme = "minispring"
    elseif (case_16_ == 5) then
      if (now.day < 6) then
        colorscheme = "minispring"
      else
        colorscheme = "minisummer"
      end
    elseif (case_16_ == 6) then
      colorscheme = "minisummer"
    elseif (case_16_ == 7) then
      colorscheme = "minisummer"
    elseif (case_16_ == 8) then
      if (now.day < 8) then
        colorscheme = "minisummer"
      else
        colorscheme = "miniautumn"
      end
    elseif (case_16_ == 9) then
      colorscheme = "miniautumn"
    elseif (case_16_ == 10) then
      colorscheme = "miniautumn"
    elseif (case_16_ == 11) then
      if (now.day < 8) then
        colorscheme = "miniautumn"
      else
        colorscheme = "miniwinter"
      end
    elseif (case_16_ == 12) then
      colorscheme = "miniwinter"
    else
      colorscheme = nil
    end
  end
  vim.cmd.colorscheme(colorscheme)
end
vim.api.nvim_create_autocmd("VimResized", {command = ":wincmd ="})
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
    local function _24_()
      if vim.api.nvim_buf_is_valid(orphan) then
        return vim.api.nvim_buf_delete(orphan, {})
      else
        return nil
      end
    end
    vim.schedule(_24_)
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
local filetype_settings = {go = {textwidth = 100, expandtab = false}, javascript = two_space, javascriptreact = two_space, typescript = two_space, typescriptreact = two_space, html = two_space, css = two_space, cs = {commentstring = "// %s"}, helm = {expandtab = true, shiftwidth = 2, commentstring = "{{/* %s */}}"}, gotmpl = {expandtab = true, shiftwidth = 2, commentstring = "{{/* %s */}}"}, fish = {expandtab = true, shiftwidth = 4, commentstring = "# %s"}, yaml = two_space, ["buf-config"] = two_space, svg = two_space, json = two_space, json5 = two_space, bash = two_space, toml = two_space, python = four_space, xml = four_space, starlark = {expandtab = true, shiftwidth = 4, commentstring = "# %s"}, proto = {expandtab = true, shiftwidth = 2, commentstring = "// %s", cindent = true}, gitcommit = {spell = true}, gitconfig = {shiftwidth = 2, expandtab = false}, fennel = {commentstring = ";; %s"}, sql = {wrap = true, commentstring = "-- %s", expandtab = true, shiftwidth = 4}, clojure = {expandtab = true, textwidth = 80}, kotlin = {commentstring = "// %s"}, just = {expandtab = true, shiftwidth = 4}, markdown = {spell = true, wrap = true, expandtab = false}}
local function _28_(args)
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
vim.api.nvim_create_autocmd("FileType", {group = vim.api.nvim_create_augroup("filetypes", {}), pattern = vim.tbl_keys(filetype_settings), callback = _28_})
local function _30_(_path, bufnr)
  local first_line = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1]
  if (first_line and string.match(first_line, "^#!.*[/ ]bash[%w]*%s*$")) then
    return "bash"
  else
    return nil
  end
end
vim.filetype.add({extension = {mdx = "markdown", star = "starlark", gotext = "gotmpl", gotmpl = "gotmpl", sh = _30_}, filename = {[".ignore"] = "gitignore", [".dockerignore"] = "gitignore", ["buf.yaml"] = "buf-config", ["buf.gen.yaml"] = "buf-config", ["buf.policy.yaml"] = "buf-config", ["buf.lock"] = "buf-config", ["uv.lock"] = "toml", Tiltfile = "tiltfile", [".envrc"] = "bash", [".envrc.local"] = "bash"}, pattern = {[".*/%.github/workflows/.*%.ya?ml"] = "yaml.github-actions", [".*/%.github/actions/**/.*%.ya?ml"] = "yaml.github-actions"}})
do
  local template_dir = vim.fs.joinpath(vim.fn.stdpath("config"), "templates")
  local function _32_(args)
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
  vim.api.nvim_create_autocmd("BufNewFile", {pattern = "*", callback = _32_})
end
map("n", "<leader>du", vim.pack.update, {desc = "Update plugins"})
local function _35_()
  return vim.cmd({cmd = "Mason"})
end
map("n", "<leader>ma", _35_, {desc = ":Mason"})
map("n", ";", ":", {desc = "Enter command mode"})
local function _36_()
  return vim.cmd({cmd = "Git", mods = {vertical = true}})
end
map("n", "<leader>gs", _36_, {desc = "Open :Git in a vertical split"})
local function _37_()
  return vim.cmd({cmd = "Gwrite"})
end
map("n", "<leader>gw", _37_, {desc = ":Gwrite"})
local function _38_()
  return vim.cmd({cmd = "Git", args = {"commit"}})
end
map("n", "<leader>gc", _38_, {desc = ":Git commit"})
local function _39_()
  return vim.cmd({cmd = "Git", args = {"push"}})
end
map("n", "<leader>gp", _39_, {desc = ":Git push"})
local function _40_()
  return vim.cmd({cmd = "Git", args = {"blame"}})
end
map("n", "<leader>gb", _40_, {desc = ":Git blame"})
local function _41_()
  if (vim.v.count ~= 0) then
    return "j"
  else
    return "gj"
  end
end
map({"n", "v"}, "j", _41_, {expr = true, desc = "Down by visual line (gj when no count)"})
local function _43_()
  if (vim.v.count ~= 0) then
    return "k"
  else
    return "gk"
  end
end
map({"n", "v"}, "k", _43_, {expr = true, desc = "Up by visual line (gk when no count)"})
map({"n", "v"}, "<tab>", "%", {remap = true, desc = "Navigate between matching brackets"})
for keymap, file in pairs({["<leader>ef"] = "$HOME/.config/fish/config.fish", ["<leader>egi"] = "$HOME/.config/git/config", ["<leader>ego"] = "$HOME/.config/ghostty/config", ["<leader>ev"] = "$HOME/.config/nvim/init.fnl"}) do
  local function _45_()
    return vim.cmd({cmd = "edit", args = {file}})
  end
  map("n", keymap, _45_, {desc = (":edit " .. file)})
end
local function _46_()
  return vim.cmd({cmd = "write"})
end
map("n", "<leader>w", _46_, {desc = ":write the buffer to the file"})
local function _47_()
  return vim.cmd({cmd = "split"})
end
map("n", "<leader>ss", _47_, {desc = "Create a horizontal split"})
local function _48_()
  return vim.cmd({cmd = "vsplit"})
end
map("n", "<leader>vs", _48_, {desc = "Create a vertical split"})
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
local function _49_()
  return vim.show_pos()
end
map("n", "<leader>i", _49_, {desc = "Inspect position (treesitter/syntax)"})
map("i", "<c-k>", "<esc>", {desc = "Escape insert mode"})
map("c", "<c-k>", "<c-c>", {desc = "Cancel cmdline"})
map("t", "<c-k>", "<c-\\><c-n>", {desc = "Exit terminal mode"})
local function _50_()
  return vim.cmd({cmd = "tabnew"})
end
map("n", "<leader>tn", _50_, {desc = "Create a new tab"})
local function _51_()
  return vim.cmd({cmd = "tabnext"})
end
map("n", "]r", _51_, {desc = "Go to next tab"})
local function _52_()
  return vim.cmd({cmd = "tabprev"})
end
map("n", "[r", _52_, {desc = "Go to prev tab"})
map("n", "<C-l>", ":nohlsearch<cr>", {desc = "Clear search highlight"})
vim.diagnostic.config({signs = {text = {[vim.diagnostic.severity.ERROR] = "\195\151", [vim.diagnostic.severity.WARN] = "!", [vim.diagnostic.severity.INFO] = "\226\156\179\239\184\142", [vim.diagnostic.severity.HINT] = "?"}}, virtual_text = {severity = {min = vim.diagnostic.severity.WARN}}, underline = true, severity_sort = true, float = {border = "single", source = "always", focusable = false}})
local function lsp_attach(_53_)
  local buf = _53_.buf
  local _arg_54_ = _53_.data
  local client_id = _arg_54_.client_id
  local client = vim.lsp.get_client_by_id(client_id)
  if client:supports_method("textDocument/codeAction") then
    local function organize_imports()
      return vim.lsp.buf.code_action({context = {only = {"source.organizeImports"}}, apply = true})
    end
    vim.api.nvim_buf_create_user_command(buf, "OrganizeImports", organize_imports, {desc = "Organize Imports"})
    local function _55_()
      return vim.cmd({cmd = "OrganizeImports"})
    end
    map("n", "gro", _55_, {desc = "Organize Imports"})
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
    local function _60_()
      return vim.lsp.codelens.enable(true)
    end
    vim.api.nvim_create_autocmd({"BufEnter", "CursorHold", "InsertLeave"}, {group = augroup_id, buffer = buf, callback = _60_})
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
local server_settings = {gopls = {cmd = {"gopls", "-remote=auto"}, settings = {gopls = {semanticTokens = true, hints = {constantValues = true}}}}, jsonls = {settings = {json = {schemas = schemastore.json.schemas(), validate = {enable = true}}}, filetypes = {"json", "jsonc", "json5"}}, yamlls = {settings = {yaml = {schemas = schemastore.yaml.schemas(), schemaStore = {url = "", enable = false}}}}, clojure_lsp = {}, biome = {}, fish_lsp = {}, janet_lsp = {}, ruff = {}, helm_ls = {}, bashls = {}, tombi = {}, omnisharp = {cmd = {"omnisharp"}}, docker_language_server = {}, fennel_ls = {}, lua_ls = {settings = {Lua = {runtime = {version = "LuaJIT"}, workspace = {library = vim.env.VIMRUNTIME, checkThirdParty = false}}}}, rust_analyzer = {}, buf_ls = {}, postgres_lsp = {}, ty = {}, starpls = {filetypes = {"bzl", "starlark"}}, cue = {}, tilt_ls = {}, ts_query_ls = {}, just = {}, gh_actions_ls = {filetypes = {"yaml.github-actions"}}, cells = {cmd = {"cells", "serve"}, filetypes = {"cel"}}, zizmor = {filetypes = {"yaml", "yaml.github-actions"}}, syntaqlite = {cmd = {"syntaqlite", "lsp"}, filetypes = {"sql"}, root_markers = {"syntaqlite.toml", ".git"}}}
vim.lsp.config("*", {root_markers = {".git"}})
for server, settings in pairs(server_settings) do
  vim.lsp.config(server, settings)
  vim.lsp.enable(server)
end
return nil
