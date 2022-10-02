(module dotfiles.lsp
  {autoload {: lspconfig}})

(def- create-autocmd vim.api.nvim_create_autocmd)
(def- create-augroup vim.api.nvim_create_augroup)

(defn- buffer-map [bufnr from to]
  "Sets a normal mode mapping within a buffer."
  (vim.keymap.set :n from to {:buffer bufnr :silent true}))

(defn on-attach [{: buf
                  :data {: client_id}}]
  (local client (vim.lsp.get_client_by_id client_id))

  ;; NOTE: Useful for debugging
  ;; https://github.com/nanotee/nvim-lua-guide#the-vim-namespace
  ; (print (vim.inspect client))

  (when client.server_capabilities.documentFormattingProvider
    (buffer-map buf "<leader>af" vim.lsp.buf.format))

  (when client.server_capabilities.hoverProvider
    (buffer-map buf "K"          vim.lsp.buf.hover))

  (when client.server_capabilities.documentHighlightProvider
    (let [augroup (create-augroup "lsp-document-highlight" {})]
      (create-autocmd "CursorHold"  {:group augroup
                                     :buffer buf
                                     :callback #(vim.lsp.buf.document_highlight)})
      (create-autocmd "CursorMoved" {:group augroup
                                     :buffer buf
                                     :callback #(vim.lsp.buf.clear_references)})))

  ;; setup mappings
  ;; See `:help vim.lsp.*` for documentation on any of the below functions
  (buffer-map buf "gD"         vim.lsp.buf.declaration)
  (buffer-map buf "gd"         vim.lsp.buf.definition)
  (buffer-map buf "gi"         vim.lsp.buf.implementation)
  (buffer-map buf "<C-k>"      vim.lsp.buf.signature_help)
  (buffer-map buf "<leader>D"  vim.lsp.buf.type_definition)
  (buffer-map buf "<leader>rn" vim.lsp.buf.rename)
  (buffer-map buf "<leader>ca" vim.lsp.buf.code_action)
  (buffer-map buf "gr"         vim.lsp.buf.references))

(create-autocmd :LspAttach {:callback on-attach})

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

(lspconfig.gopls.setup {:handlers handlers
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

(lspconfig.clojure_lsp.setup {:handlers handlers})

(lspconfig.bufls.setup {:handlers handlers})

(lspconfig.pylsp.setup {:handlers handlers})
