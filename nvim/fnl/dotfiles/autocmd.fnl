(module dotfiles.autocmd
  {autoload {nvim aniseed.nvim}
   require-macros [dotfiles.macros]})

;; on resize, resize windows
(autocmd :VimResized :* ":wincmd =")

;; show yanked text
(autocmd :TextYankPost :* "lua vim.highlight.on_yank()")

;; after writing init.lua, recompile
(autocmd :BufWritePost :init.lua "PackerCompile")

(augroup filetypes
         (do
           (autocmd :FileType :go "setlocal noexpandtab tabstop=4 shiftwidth=4")
           (autocmd :FileType :python "setlocal tabstop=4 shiftwidth=4 expandtab")
           (autocmd :FileType :javascript "setlocal expandtab tabstop=2 shiftwidth=2")
           (autocmd :FileType :html "setlocal expandtab tabstop=2 shiftwidth=2")
           (autocmd :FileType :css "setlocal expandtab tabstop=2 shiftwidth=2 iskeyword+=-")
           (autocmd :FileType :scss "setlocal expandtab tabstop=2 shiftwidth=2 iskeyword+=-")
           (autocmd :FileType :fish "setlocal expandtab tabstop=4 shiftwidth=4")
           (autocmd :FileType :yaml "setlocal expandtab tabstop=2 shiftwidth=2")
           (autocmd :FileType :gitcommit "setlocal spell")
           (autocmd :FileType :sql "setlocal wrap")
           (autocmd :FileType :markdown "setlocal spell wrap conceallevel=2 shiftwidth=2")
           ;; treat `justfile`s as makefiles
           ;; This helps with setting up correct commentstring, etc
           (autocmd :BufRead :justfile "setf make")))

