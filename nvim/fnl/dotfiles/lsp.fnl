(module dotfiles.lsp
  {autoload {lspinstaller "nvim-lsp-installer"}})

(def- create-autocmd vim.api.nvim_create_autocmd)
(def- create-augroup vim.api.nvim_create_augroup)

;; See `:help vim.diagnostic.*` for documentation on any of the below functions
(vim.keymap.set :n "<leader>?"  vim.diagnostic.open_float)
(vim.keymap.set :n "[w"         vim.diagnostic.goto_prev)
(vim.keymap.set :n "]w"         vim.diagnostic.goto_next)
(vim.keymap.set :n "<leader>q"  vim.diagnostic.setloclist)

(defn- buffer-map [bufnr from to]
  "Sets a normal mode mapping within a buffer."
  (vim.keymap.set :n from to {:buffer bufnr :silent true}))

(defn- capable? [client capability]
  (. client.server_capabilities capability))

(defn- on-attach [client bufnr]
  ; NOTE: Useful for debugging
  ; https://github.com/nanotee/nvim-lua-guide#the-vim-namespace
  ; (print (vim.inspect client))

  ;; Set some keybinds conditional on server capabilities
  (if (capable? client :documentFormattingProvider)
    (buffer-map bufnr "<leader>af" vim.lsp.buf.formatting))

  (if (capable? client :documentRangeFormattingProvider)
    (buffer-map bufnr "<leader>rf" vim.lsp.buf.range_formatting))

  (when (capable? client :documentHighlightProvider)
    (let [augroup (create-augroup "lsp-document-highlight" {})]
      (create-autocmd "CursorHold"  {:group augroup
                                     :buffer bufnr
                                     :callback vim.lsp.buf.document_highlight})
      (create-autocmd "CursorMoved" {:group augroup
                                     :buffer bufnr
                                     :callback vim.lsp.buf.clear_references})))
  ;; set the omnifunc for the buffer
  (when (capable? client :completionProvider)
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
