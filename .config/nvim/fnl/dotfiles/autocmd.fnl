(module dotfiles.autocmd)

(def- create-autocmd vim.api.nvim_create_autocmd)
(def- create-augroup vim.api.nvim_create_augroup)

(create-autocmd "VimResized" {:pattern "*"
                              :desc "on resize, resize windows"
                              :command ":wincmd ="})

(create-autocmd "TextYankPost" {:pattern "*"
                                :desc "show yanked text"
                                :callback #(vim.highlight.on_yank)})

(create-autocmd "BufWritePost" {:pattern "init.lua"
                                :desc "after writing init.lua, recompile"
                                :command "PackerCompile"})

(def- filetype-settings {:go         {:expandtab false :shiftwidth 4 :tabstop 4}
                         :javascript {:expandtab true :shiftwidth 2 :tabstop 2}
                         :html       {:expandtab true :shiftwidth 2 :tabstop 2}
                         :gohtmltmpl {:expandtab true :shiftwidth 2 :tabstop 2}
                         :fish       {:expandtab true :shiftwidth 4 :tabstop 4}
                         :yaml       {:expandtab true :shiftwidth 2 :tabstop 2}
                         :json       {:expandtab true :shiftwidth 2 :tabstop 2}
                         :bash       {:expandtab true :shiftwidth 2 :tabstop 2}
                         :gitcommit  {:spell true}
                         :sql        {:wrap true :commentstring "-- %s"}
                         :clojure    {:expandtab true :textwidth 80}
                         :markdown   {:spell true :wrap true :conceallevel 2 :shiftwidth 2}})

(let [aufiletypes (create-augroup "filetypes" {})]
  (each [filetype settings (pairs filetype-settings)]
    (create-autocmd "FileType" {:group aufiletypes
                                :pattern filetype
                                :callback #(each [name value (pairs settings)]
                                             (vim.api.nvim_set_option_value name value {:scope "local"}))}))

  ;; treat `justfile`s as makefiles
  ;; This helps with setting up correct commentstring, etc
  (create-autocmd "BufRead" {:group aufiletypes
                             :pattern "justfile"
                             :callback #(vim.api.nvim_set_option_value "filetype" "make" {:scope "local"})}))
