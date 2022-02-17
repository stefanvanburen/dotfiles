-- init dot lua

local execute = vim.api.nvim_command
local fn = vim.fn

local pack_path = fn.stdpath("data") .. "/site/pack"
local fmt = string.format

function ensure (user, repo)
  -- Ensures a given github.com/USER/REPO is cloned in the pack/packer/start directory.
  local install_path = fmt("%s/packer/start/%s", pack_path, repo)
  if fn.empty(fn.glob(install_path)) > 0 then
    execute(fmt("!git clone https://github.com/%s/%s %s", user, repo, install_path))
    execute(fmt("packadd %s", repo))
  end
end


-- Disable netrw
vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1

-- Do not source the default filetype.vim
-- Needed for filetype.nvim
vim.g.did_load_filetypes = 1

-- Bootstrap essential plugins required for installing and loading the rest.
ensure("wbthomason", "packer.nvim")
ensure("Olical", "aniseed")
ensure("lewis6991", "impatient.nvim")

-- Load impatient which pre-compiles and caches Lua modules.
require("impatient")

-- Enable Aniseed's automatic compilation and loading of Fennel source code.
require('aniseed.env').init({
  module = "dotfiles.init",
  compile = true
})
