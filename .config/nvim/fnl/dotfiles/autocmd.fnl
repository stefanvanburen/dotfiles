(module dotfiles.autocmd)

(local create-autocmd vim.api.nvim_create_autocmd)
(local create-augroup vim.api.nvim_create_augroup)

(create-autocmd :VimResized {:command ":wincmd ="})

(create-autocmd :TextYankPost {:callback #(vim.highlight.on_yank)})

(local filetype-settings
  {:go              {:expandtab false :shiftwidth 4 :tabstop 4}
   :javascript      {:expandtab true  :shiftwidth 4 :tabstop 4}
   :javascriptreact {:expandtab true  :shiftwidth 4 :tabstop 4}
   :typescript      {:expandtab true  :shiftwidth 4 :tabstop 4}
   :typescriptreact {:expandtab true  :shiftwidth 4 :tabstop 4}
   :html            {:expandtab true  :shiftwidth 2 :tabstop 2}
   :css             {:expandtab true  :shiftwidth 2 :tabstop 2}
   :gohtmltmpl      {:expandtab true  :shiftwidth 2 :tabstop 2 :commentstring "{{/* %s */}}"}
   :gotexttmpl      {:expandtab true  :shiftwidth 2 :tabstop 2 :commentstring "{{/* %s */}}"}
   :fish            {:expandtab true  :shiftwidth 4 :tabstop 4 :commentstring "# %s"}
   :yaml            {:expandtab true  :shiftwidth 2 :tabstop 2}
   :svg             {:expandtab true  :shiftwidth 2 :tabstop 2}
   :json            {:expandtab true  :shiftwidth 2 :tabstop 2}
   :bash            {:expandtab true  :shiftwidth 2 :tabstop 2}
   :python          {:expandtab true  :shiftwidth 4 :tabstop 4}
   :xml             {:expandtab true  :shiftwidth 4 :tabstop 4}
   :starlark        {:expandtab true  :shiftwidth 4 :tabstop 4 :commentstring "# %s"}
   :gitcommit       {:spell true}
   :sql             {:wrap true :commentstring "-- %s"}
   :clojure         {:expandtab true :textwidth 80}
   :proto           {:commentstring "// %s"}
   :markdown        {:spell true :wrap true :conceallevel 0 :shiftwidth 2}})

(let [aufiletypes (create-augroup "filetypes" {})]
  (each [filetype settings (pairs filetype-settings)]
    (create-autocmd :FileType {:group aufiletypes
                               :pattern filetype
                               :callback #(each [name value (pairs settings)]
                                            (vim.api.nvim_set_option_value name value {:scope "local"}))}))

  ;; treat `justfile`s as makefiles
  ;; This helps with setting up correct commentstring, etc
  (create-autocmd [:BufNewFile :BufRead] {:group aufiletypes
                                          :pattern "justfile"
                                          :callback #(vim.api.nvim_set_option_value "filetype" "make" {:scope "local"})})
  ;; treat mdx files as markdown
  (create-autocmd [:BufNewFile :BufRead] {:group aufiletypes
                                          :pattern "*.mdx"
                                          :callback #(vim.api.nvim_set_option_value "filetype" "markdown" {:scope "local"})})
  (create-autocmd [:BufNewFile :BufRead] {:group aufiletypes
                                          :pattern "*.star"
                                          :callback #(vim.api.nvim_set_option_value "filetype" "starlark" {:scope "local"})})
  (create-autocmd :FileType {:group aufiletypes
                             :pattern :fennel
                             ;; For fennel files, remove ':' and '.' from 'iskeyword'
                             ;; Original from: https://github.com/Olical/aniseed/blob/master/ftplugin/fennel.vim#L14
                             ;; See: https://github.com/bakpakin/fennel.vim/issues/9
                             :callback #(vim.api.nvim_set_option_value "iskeyword" "!,$,%,#,*,+,-,/,<,=,>,?,_,a-z,A-Z,48-57,128-247,124,94" {:scope "local"})}))
