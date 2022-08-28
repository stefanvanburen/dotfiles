(module dotfiles.lsp
  {autoload {: lspconfig}})

(def- create-autocmd vim.api.nvim_create_autocmd)
(def- create-augroup vim.api.nvim_create_augroup)

(defn- buffer-map [bufnr from to]
  "Sets a normal mode mapping within a buffer."
  (vim.keymap.set :n from to {:buffer bufnr :silent true}))

(defn- capable? [client capability]
  (. client.server_capabilities capability))

(defn on-attach [client bufnr]
  ;; NOTE: Useful for debugging
  ;; https://github.com/nanotee/nvim-lua-guide#the-vim-namespace
  ; (print (vim.inspect client))

  (when (capable? client :documentFormattingProvider)
    (buffer-map bufnr "<leader>af" vim.lsp.buf.formatting))

  (when (capable? client :documentRangeFormattingProvider)
    (buffer-map bufnr "<leader>rf" vim.lsp.buf.range_formatting))

  (when (capable? client :hoverProvider)
    (buffer-map bufnr "K"          vim.lsp.buf.hover))

  (when (capable? client :documentHighlightProvider)
    (let [augroup (create-augroup "lsp-document-highlight" {})]
      (create-autocmd "CursorHold"  {:group augroup
                                     :buffer bufnr
                                     :callback vim.lsp.buf.document_highlight})
      (create-autocmd "CursorMoved" {:group augroup
                                     :buffer bufnr
                                     :callback vim.lsp.buf.clear_references})))

  (when (capable? client :completionProvider)
    (vim.api.nvim_buf_set_option bufnr "omnifunc" "v:lua.vim.lsp.omnifunc"))

  (when (capable? client :definitionProvider)
    (vim.api.nvim_buf_set_option bufnr "tagfunc" "v:lua.vim.lsp.tagfunc"))

  ;; setup mappings
  ;; See `:help vim.lsp.*` for documentation on any of the below functions
  (buffer-map bufnr "gD"         vim.lsp.buf.declaration)
  (buffer-map bufnr "gd"         vim.lsp.buf.definition)
  (buffer-map bufnr "gi"         vim.lsp.buf.implementation)
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

(lspconfig.gopls.setup {:on_attach on-attach
                        :handlers handlers
                        :cmd ["gopls" "-remote=auto"]
                        ;; https://github.com/golang/tools/blob/master/gopls/doc/settings.md
                        :settings {:gopls {:staticcheck true
                                           ;; https://github.com/golang/tools/blob/master/gopls/doc/analyzers.md
                                           :analyses {:unusedparams true}
                                           ;; https://github.com/golang/tools/blob/master/gopls/doc/inlayHints.md
                                           :hints {:parameterNames true
                                                   :assignVariableTypes true
                                                   :compositeLiteralFields true
                                                   :compositeLiteralTypes true
                                                   :constantValues true
                                                   :functionTypeParameters true
                                                   :rangeVariableTypes true}}}})

(lspconfig.clojure_lsp.setup {:on_attach on-attach
                              :handlers handlers})

(lspconfig.bufls.setup {:on_attach on-attach
                        :handlers handlers})
