(module dotfiles.lsp
  {autoload {nvim aniseed.nvim
             lspinstaller "nvim-lsp-installer"}})

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
    (buffer-map bufnr "<leader>af" "<cmd>lua vim.lsp.buf.formatting()<cr>"))

  (if (capable? client :document_range_formatting)
    (buffer-map bufnr "<leader>rf" "<cmd>lua vim.lsp.buf.range_formatting()<cr>"))

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
    (nvim.buf_set_option bufnr "omnifunc" "v:lua.vim.lsp.omnifunc"))

  ;; setup mappings
  ;; See `:help vim.lsp.*` for documentation on any of the below functions
  (buffer-map bufnr "gD"         "<cmd>lua vim.lsp.buf.declaration()<cr>")
  (buffer-map bufnr "gd"         "<cmd>lua vim.lsp.buf.definition()<cr>")
  (buffer-map bufnr "gi"         "<cmd>lua vim.lsp.buf.implementation()<cr>")
  (buffer-map bufnr "K"          "<cmd>lua vim.lsp.buf.hover()<cr>")
  (buffer-map bufnr "<C-k>"      "<cmd>lua vim.lsp.buf.signature_help()<cr>")
  (buffer-map bufnr "<leader>D"  "<cmd>lua vim.lsp.buf.type_definition()<cr>")
  (buffer-map bufnr "<leader>rn" "<cmd>lua vim.lsp.buf.rename()<cr>")
  (buffer-map bufnr "<leader>ca" "<cmd>lua vim.lsp.buf.code_action()<cr>")
  (buffer-map bufnr "gr"         "<cmd>lua vim.lsp.buf.references()<cr>")
  ;; See `:help vim.diagnostic.*` for documentation on any of the below functions
  (buffer-map bufnr "<leader>?"  "<cmd>lua vim.diagnostic.open_float()<cr>")
  (buffer-map bufnr "[w"         "<cmd>lua vim.diagnostic.goto_prev()<cr>")
  (buffer-map bufnr "]w"         "<cmd>lua vim.diagnostic.goto_next()<cr>")
  (buffer-map bufnr "<leader>q"  "<cmd>lua vim.diagnostic.setloclist()<cr>"))

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
