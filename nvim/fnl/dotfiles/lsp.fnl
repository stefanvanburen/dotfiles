(module dotfiles.lsp
  {autoload {nvim aniseed.nvim
             lspinstaller "nvim-lsp-installer"}
   ;; for autocmd and augroup
   require-macros [dotfiles.macros]})

(defn- nnoremap [bufnr from to]
  "Sets a normal mode mapping within a buffer."
  (nvim.buf_set_keymap bufnr :n from to {:noremap true :silent true}))

(defn- capable? [client capability]
  (. client.resolved_capabilities capability))

(defn- on-attach [client bufnr]
  ; NOTE: Useful for debugging
  ; https://github.com/nanotee/nvim-lua-guide#the-vim-namespace
  ; (print (vim.inspect client))

  ;; Set some keybinds conditional on server capabilities - prefer range
  ;; formatting, if available
  (if (capable? client :document_formatting)
    (nnoremap bufnr "<leader>af" "<cmd>lua vim.lsp.buf.formatting()<CR>"))

  (if (capable? client :document_range_formatting)
    (nnoremap bufnr "<leader>af" "<cmd>lua vim.lsp.buf.range_formatting()<CR>"))

  (when (capable? client :document_highlight)
    (do
      (nvim.ex.augroup (tostring lsp-document-highlight))
      ;; https://github.com/neovim/nvim-lspconfig/pull/728/files
      (nvim.ex.autocmd_ :* :<buffer>)
      (nvim.ex.autocmd  :CursorHold  :<buffer> "lua vim.lsp.buf.document_highlight()")
      (nvim.ex.autocmd  :CursorMoved :<buffer> "lua vim.lsp.buf.clear_references()")
      ;; Trying this out, tentatively
      (nvim.ex.autocmd  :CursorHold  :<buffer> "lua vim.diagnostic.open_float(nil, {border = 'rounded', focusable = false, source = 'always'})")
      (nvim.ex.augroup  :END)))

  ;; set the omnifunc for the buffer
  (when (capable? client :completion)
    (set nvim.bo.omnifunc "v:lua.vim.lsp.omnifunc"))

  ;; setup mappings
  ;; See `:help vim.lsp.*` for documentation on any of the below functions
  (nnoremap bufnr "gD"         "<cmd>lua vim.lsp.buf.declaration()<CR>")
  (nnoremap bufnr "gd"         "<cmd>lua vim.lsp.buf.definition()<CR>")
  (nnoremap bufnr "gi"         "<cmd>lua vim.lsp.buf.implementation()<CR>")
  (nnoremap bufnr "K"          "<cmd>lua vim.lsp.buf.hover()<CR>")
  (nnoremap bufnr "<C-k>"      "<cmd>lua vim.lsp.buf.signature_help()<CR>")
  (nnoremap bufnr "<leader>D"  "<cmd>lua vim.lsp.buf.type_definition()<CR>")
  (nnoremap bufnr "<leader>rn" "<cmd>lua vim.lsp.buf.rename()<CR>")
  (nnoremap bufnr "<leader>ca" "<cmd>lua vim.lsp.buf.code_action()<CR>")
  (nnoremap bufnr "gr"         "<cmd>lua vim.lsp.buf.references()<CR>")
  (nnoremap bufnr "[w"         "<cmd>lua vim.diagnostic.goto_prev()<CR>")
  (nnoremap bufnr "]w"         "<cmd>lua vim.diagnostic.goto_next()<CR>")
  (nnoremap bufnr "<leader>q"  "<cmd>lua vim.diagnostic.setloclist()<CR>"))

(def- handlers
  {;; add a border to hover
   "textDocument/hover"
   (vim.lsp.with
     vim.lsp.handlers.hover
     {:border "single"})

   ;; add a border to signatureHelp
   "textDocument/signatureHelp"
   (vim.lsp.with
     vim.lsp.handlers.signature_help
     {:border "single"})})

(vim.fn.sign_define "DiagnosticSignError" {:text "×" :texthl "DiagnosticSignError"})
(vim.fn.sign_define "DiagnosticSignWarn"  {:text "‽" :texthl "DiagnosticSignWarn"})
(vim.fn.sign_define "DiagnosticSignInfo"  {:text "※" :texthl "DiagnosticSignInfo"})
(vim.fn.sign_define "DiagnosticSignHint"  {:text "⁖" :texthl "DiagnosticSignHint"})

(vim.diagnostic.config {:underline true
                        :virtual_text false
                        :signs true
                        :update_in_insert false
                        :severity_sort true})

(lspinstaller.on_server_ready
   (lambda [server]
     (server:setup {:on_attach on-attach
                    :handlers handlers})))
