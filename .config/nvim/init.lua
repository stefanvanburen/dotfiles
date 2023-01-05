-- init dot lua

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Bootstrap Aniseed
local aniseedpath = vim.fn.stdpath("data") .. "/lazy/aniseed"
if not vim.loop.fs_stat(aniseedpath) then
  vim.fn.system({
    "git",
    "clone",
    "https://github.com/Olical/aniseed.git",
    aniseedpath,
  })
end
vim.opt.rtp:prepend(aniseedpath)

-- Disable netrw
vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1

-- Enable Aniseed's automatic compilation and loading of Fennel source code.
require('aniseed.env').init({
  module = "dotfiles.init",
  compile = true
})
