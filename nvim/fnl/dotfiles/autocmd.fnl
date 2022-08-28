(module dotfiles.autocmd)

(def- create-autocmd vim.api.nvim_create_autocmd)
(def- create-augroup vim.api.nvim_create_augroup)

(create-autocmd "VimResized" {:pattern "*"
                              :desc "on resize, resize windows"
                              :command ":wincmd ="})

(create-autocmd "TextYankPost" {:pattern "*"
                                :desc "show yanked text"
                                :callback vim.highlight.on_yank})

(create-autocmd "BufWritePost" {:pattern "init.lua"
                                :desc "after writing init.lua, recompile"
                                :command "PackerCompile"})

(def- filetype-settings {:go "noexpandtab tabstop=4 shiftwidth=4"
                         :python "tabstop=4 shiftwidth=4 expandtab"
                         :javascript "expandtab tabstop=2 shiftwidth=2"
                         :html "expandtab tabstop=2 shiftwidth=2"
                         :gohtmltmpl "expandtab tabstop=2 shiftwidth=2"
                         :css "expandtab tabstop=2 shiftwidth=2 iskeyword+=-"
                         :scss "expandtab tabstop=2 shiftwidth=2 iskeyword+=-"
                         :fish "expandtab tabstop=4 shiftwidth=4"
                         :yaml "expandtab tabstop=2 shiftwidth=2"
                         :json "expandtab tabstop=2 shiftwidth=2"
                         :gitcommit "spell"
                         :sql "wrap"
                         :markdown "spell wrap conceallevel=2 shiftwidth=2"})

(let [aufiletypes (create-augroup "filetypes" {})]
  (each [k v (pairs filetype-settings)]
    (create-autocmd "FileType" {:group aufiletypes
                                :pattern k
                                :command (.. "setlocal " v)}))
  ;; treat `justfile`s as makefiles
  ;; This helps with setting up correct commentstring, etc
  (create-autocmd "BufRead" {:group aufiletypes
                             :pattern "justfile"
                             :command "setfiletype make"}))
