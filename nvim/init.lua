-- init dot lua

-- Disable standard plugins
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_zipPlugin = 1

-- bootstrap packer
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.api.nvim_command('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
end

vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
  use {'wbthomason/packer.nvim', opt = true}

  use {'rrethy/vim-hexokinase', run = 'make hexokinase', opt = true, ft = {'css', 'scss'} }

  -- directory / file viewer. Largely replaces netrw.
  use 'justinmk/vim-dirvish'

  use 'tyru/open-browser.vim'

  -- Adds git added / modified / deleted in the sidebar (amongst other things)
  -- Use ]c / [c to go to hunks within a file
  use 'airblade/vim-gitgutter'

  -- Better whitespace highlighting / provides :StripWhitespace
  use 'ntpeters/vim-better-whitespace'

  -- git!
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'

  use 'w0rp/ale'

  -- Allows for viewing git commit messages related to the current line
  -- <leader>gm to trigger the window, again to go inside.
  use {'rhysd/git-messenger.vim', opt = true, cmd = {'GitMessenger'} }

  -- language syntax and indent
  use 'sheerun/vim-polyglot'

  -- TODO: will I use this?
  -- use 'lervag/vimtex'

  use {'fatih/vim-go', run = ':GoInstallBinaries' }

  -- profiling startup time
  use 'dstein64/vim-startuptime'

  -- configuration in fennel
  use 'Olical/aniseed'

  -- local configuration, in fennel
  use 'Olical/nvim-local-fennel'

  -- lisp languages
  use 'guns/vim-sexp'
  use 'tpope/vim-sexp-mappings-for-regular-people'
  use {'Olical/conjure', ft = {'clojure', 'fennel'} }
  use {'eraserhd/parinfer-rust', run = 'cargo build --release' }

  -- TODO: research a better way to use conjure with a builtin neovim terminal.
  use 'kassio/neoterm'

  -- typical lsp configurations
  use 'neovim/nvim-lspconfig'

  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- Automatically match parenthesis
  use 'tmsvg/pear-tree'

  -- testing / build commands
  use 'tpope/vim-dispatch'
  use 'vim-test/vim-test'

  -- s{char}{char} to search for a set of two characters
  use 'justinmk/vim-sneak'

  -- Fuzzy find
  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'

  -- Commenting
  use 'tpope/vim-commentary'

  -- Adds unix shell commands
  use 'tpope/vim-eunuch'

  -- Database access
  use {'tpope/vim-dadbod', opt = true, cmd = {'DB'}}

  -- Deal with parentheses, quotes, etc.
  use 'tpope/vim-surround'

  -- Repeat plugin maps
  use 'tpope/vim-repeat'

  -- Handy bracket ( ] and [ ) mappings
  use 'tpope/vim-unimpaired'

  -- enhanced version of matchit plugin
  use 'andymass/vim-matchup'

  -- Easily search for, substitute, and abbreviate multiple variants of a word
  use 'tpope/vim-abolish'

  -- autocomplete
  use 'hrsh7th/nvim-compe'

  -- colorscheme
  use {'svanburen/rams.vim', branch = 'lsp' }

  -- sr.ht
  use 'https://git.sr.ht/~willdurand/srht.vim'

end)

-- initialize aniseed
vim.g['aniseed#env'] = "v:true"

-- initialize nvim-compe
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
  };
}
