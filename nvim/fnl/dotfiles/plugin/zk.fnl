(module dotfiles.plugin.autopairs
  {autoload {zk zk
             nvim aniseed.nvim}})

(defn- nnoremap [bufnr from to]
  "Sets a normal mode mapping within a buffer."
  (nvim.buf_set_keymap bufnr :n from to {:noremap true :silent true}))

(defn- on-attach [client bufnr]
  ; NOTE: Useful for debugging
  ; https://github.com/nanotee/nvim-lua-guide#the-vim-namespace
  ; (print (vim.inspect client))

  ;; set the omnifunc for the buffer
  (nvim.buf_set_option bufnr "omnifunc" "v:lua.vim.lsp.omnifunc")

  ;; setup mappings
  ;; See `:help vim.lsp.*` for documentation on any of the below functions
  (nnoremap bufnr "gd"         "<cmd>lua vim.lsp.buf.definition()<CR>")
  (nnoremap bufnr "K"          "<cmd>lua vim.lsp.buf.hover()<CR>")
  (nnoremap bufnr "<leader>ca" "<cmd>lua vim.lsp.buf.code_action()<CR>")
  (nnoremap bufnr "gr"         "<cmd>lua vim.lsp.buf.references()<CR>")
  ;; See `:help vim.diagnostic.*` for documentation on any of the below functions
  (nnoremap bufnr "<leader>?"  "<cmd>lua vim.diagnostic.open_float()<CR>")
  (nnoremap bufnr "[w"         "<cmd>lua vim.diagnostic.goto_prev()<CR>")
  (nnoremap bufnr "]w"         "<cmd>lua vim.diagnostic.goto_next()<CR>")
  (nnoremap bufnr "<leader>q"  "<cmd>lua vim.diagnostic.setloclist()<CR>")

  ;; TODO: does this need the language server running?
  ;; presumably yes.
  (nvim.buf_set_keymap bufnr :x "<leader>zc" ":'<'>ZkNewFromTitleSelection<CR>" {:noremap true}))

(zk.setup {:picker "fzf"
           :lsp {:config {:on_attach on-attach}}})
