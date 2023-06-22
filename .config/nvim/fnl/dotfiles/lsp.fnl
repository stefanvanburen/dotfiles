(module dotfiles.lsp
  {autoload {: lspconfig
             : schemastore}})

(local create-autocmd vim.api.nvim_create_autocmd)
(local create-augroup vim.api.nvim_create_augroup)

(fn organize-imports []
  (vim.lsp.buf.code_action {:context {:only ["source.organizeImports"]}
                            :apply true}))

(fn format [client]
  (do
    (vim.lsp.buf.format {:timeout_ms 2000})
    (when (= client.name "gopls")
      (organize-imports))))

(fn on-attach [{: buf
                :data {: client_id}}]
  (local client (vim.lsp.get_client_by_id client_id))

  (fn buffer-map [from to]
    (vim.keymap.set :n from to {:buffer buf :silent true}))

  (when client.server_capabilities.documentFormattingProvider
    (buffer-map :<leader>af #(format client))
    ;; Don't auto-format with null-ls
    (when (not= client.name "null-ls")
      (create-autocmd :BufWritePre {:buffer buf
                                    :callback #(format client)})))

  ;; requires neovim nightly
  (when client.server_capabilities.inlayHintProvider
    (vim.lsp.buf.inlay_hint buf true))

  (when client.server_capabilities.hoverProvider
    (buffer-map :K vim.lsp.buf.hover))

  (when client.server_capabilities.documentHighlightProvider
    (let [augroup-id (create-augroup "lsp-document-highlight" {:clear false})]
      (create-autocmd :CursorHold  {:group augroup-id
                                    :buffer buf
                                    :callback vim.lsp.buf.document_highlight})
      (create-autocmd :CursorMoved {:group augroup-id
                                    :buffer buf
                                    :callback vim.lsp.buf.clear_references})))

  ;; setup mappings
  ;; See `:help vim.lsp.*` for documentation on any of the below functions
  (buffer-map :gD         vim.lsp.buf.declaration)
  (buffer-map :gd         vim.lsp.buf.definition)
  (buffer-map :gi         vim.lsp.buf.implementation)
  (buffer-map :gr         vim.lsp.buf.references)
  (buffer-map :<C-k>      vim.lsp.buf.signature_help)
  (buffer-map :<leader>D  vim.lsp.buf.type_definition)
  (buffer-map :<leader>rn vim.lsp.buf.rename)
  (buffer-map :<leader>ca vim.lsp.buf.code_action))

(create-autocmd :LspAttach {:callback on-attach})

;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#gopls
(lspconfig.gopls.setup {:cmd ["gopls" "-remote=auto"]
                        ;; https://github.com/golang/tools/blob/master/gopls/doc/settings.md
                        :settings {:gopls {;; https://github.com/golang/tools/blob/master/gopls/doc/settings.md#staticcheck-bool
                                           :staticcheck true
                                           ;; https://github.com/golang/tools/blob/master/gopls/doc/analyzers.md
                                           ;; Most of these analyzers are enabled by default.
                                           :analyses {;; https://github.com/golang/tools/blob/master/gopls/doc/analyzers.md#unusedparams
                                                      :unusedparams true}
                                           ;; https://github.com/golang/tools/blob/master/gopls/doc/inlayHints.md
                                           :hints {:parameterNames true
                                                   :assignVariableTypes true
                                                   :compositeLiteralFields true
                                                   :compositeLiteralTypes true
                                                   :constantValues true
                                                   :functionTypeParameters true
                                                   :rangeVariableTypes true}}}})

(lspconfig.jsonls.setup {:settings {:json {:schemas (schemastore.json.schemas)
                                           :validate {:enable true}}}})

(lspconfig.yamlls.setup {:settings {:yaml {:schemas (schemastore.yaml.schemas)}}})

(local servers [;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#clojure_lsp
                lspconfig.clojure_lsp
                ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#bufls
                lspconfig.bufls
                ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#ruff_lsp
                lspconfig.ruff_lsp
                ;; pipx install python-lsp-server ; https://github.com/python-lsp/python-lsp-server
                ;; pipx inject python-lsp-server pylsp-mypy ; https://github.com/python-lsp/pylsp-mypy
                ;; pipx inject python-lsp-server python-lsp-black ; https://github.com/python-lsp/python-lsp-black
                lspconfig.pylsp
                ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tsserver
                lspconfig.tsserver
                ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#eslint
                lspconfig.eslint
                ;; Swift LSP: https://github.com/apple/sourcekit-lsp
                ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sourcekit
                lspconfig.sourcekit
                ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#bashls
                lspconfig.bashls])

(each [_ lsp-server (ipairs servers)]
  (lsp-server.setup {}))
