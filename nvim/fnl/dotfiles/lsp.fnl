(module dotfiles.lsp
  {autoload {nvim aniseed.nvim
             lspinstaller "nvim-lsp-installer"}})

;; See `:help vim.diagnostic.*` for documentation on any of the below functions
(vim.keymap.set :n "<leader>?"  vim.diagnostic.open_float)
(vim.keymap.set :n "[w"         vim.diagnostic.goto_prev)
(vim.keymap.set :n "]w"         vim.diagnostic.goto_next)
(vim.keymap.set :n "<leader>q"  vim.diagnostic.setloclist)

(defn- buffer-map [bufnr from to]
  "Sets a normal mode mapping within a buffer."
  (vim.keymap.set :n from to {:buffer bufnr :silent true}))

(defn- capable? [client capability]
  (. client.resolved_capabilities capability))

(defn- on-attach [client bufnr]
  ; NOTE: Useful for debugging
  ; https://github.com/nanotee/nvim-lua-guide#the-vim-namespace
  ; (print (vim.inspect client))

  ;; Set some keybinds conditional on server capabilities
  (if (capable? client :document_formatting)
    (buffer-map bufnr "<leader>af" vim.lsp.buf.formatting))

  (if (capable? client :document_range_formatting)
    (buffer-map bufnr "<leader>rf" vim.lsp.buf.range_formatting))

  (when (capable? client :document_highlight)
    (do
      (nvim.ex.augroup (tostring lsp-document-highlight))
      ;; https://github.com/neovim/nvim-lspconfig/pull/728/files
      (nvim.ex.autocmd_ :* :<buffer>)
      (nvim.ex.autocmd  :CursorHold  :<buffer> "lua vim.lsp.buf.document_highlight()")
      (nvim.ex.autocmd  :CursorMoved :<buffer> "lua vim.lsp.buf.clear_references()")
      (nvim.ex.augroup  :END)))

  ;; set the omnifunc for the buffer
  (when (capable? client :completion)
    (vim.api.nvim_buf_set_option bufnr "omnifunc" "v:lua.vim.lsp.omnifunc"))

  ;; setup mappings
  ;; See `:help vim.lsp.*` for documentation on any of the below functions
  (buffer-map bufnr "gD"         vim.lsp.buf.declaration)
  (buffer-map bufnr "gd"         vim.lsp.buf.definition)
  (buffer-map bufnr "gi"         vim.lsp.buf.implementation)
  (buffer-map bufnr "K"          vim.lsp.buf.hover)
  (buffer-map bufnr "<C-k>"      vim.lsp.buf.signature_help)
  (buffer-map bufnr "<leader>D"  vim.lsp.buf.type_definition)
  (buffer-map bufnr "<leader>rn" vim.lsp.buf.rename)
  (buffer-map bufnr "<leader>ca" vim.lsp.buf.code_action)
  (buffer-map bufnr "gr"         vim.lsp.buf.references))

(def- handlers
  {"textDocument/hover"         (vim.lsp.with vim.lsp.handlers.hover          {:border "single"})
   "textDocument/signatureHelp" (vim.lsp.with vim.lsp.handlers.signature_help {:border "single"})})

(vim.fn.sign_define "DiagnosticSignError" {:text "×" :texthl "DiagnosticSignError"})
(vim.fn.sign_define "DiagnosticSignWarn"  {:text "!" :texthl "DiagnosticSignWarn"})
(vim.fn.sign_define "DiagnosticSignInfo"  {:text "i" :texthl "DiagnosticSignInfo"})
(vim.fn.sign_define "DiagnosticSignHint"  {:text "?" :texthl "DiagnosticSignHint"})

(vim.diagnostic.config {:virtual_text {:prefix "▪"}
                        :float {:border "single"
                                :focusable false
                                :source "always"}})

(lspinstaller.on_server_ready
   (lambda [server]
     (let [opts {:on_attach on-attach
                 :handlers handlers}]
       (if (= server.name "gopls")
         (do
          (tset opts :cmd ["gopls" "-remote=auto"])
          (tset opts :settings {:gopls {:staticcheck true
                                        :analyses {:unusedparams true}}})))

       (server:setup opts))))
