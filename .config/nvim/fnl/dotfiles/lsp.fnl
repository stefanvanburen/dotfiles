(module dotfiles.lsp
  {autoload {: lspconfig
             : lsp_compl}})

(local create-autocmd vim.api.nvim_create_autocmd)
(local create-augroup vim.api.nvim_create_augroup)

(fn organize-imports [wait-ms]
  (local params (vim.lsp.util.make_range_params))
  (set params.context {:only ["source.organizeImports"]})
  (local result (vim.lsp.buf_request_sync 0 "textDocument/codeAction" params wait-ms))
  (when (not= result nil)
    (each [_ res (pairs result)]
      (when (and (not= res nil)
                 (not= res.result nil))
        (each [_ r (pairs res.result)]
          (if r.edit
            (vim.lsp.util.apply_workspace_edit r.edit "UTF-8")
            (vim.lsp.buf.execute_command r.command)))))))

(fn on-attach [{: buf
                :data {: client_id}}]
  (local client (vim.lsp.get_client_by_id client_id))

  ;; https://github.com/mfussenegger/nvim-lsp-compl#configuration
  ;; null-ls typically does not provide completion.
  (if (not= client.name "null-ls")
    (lsp_compl.attach client buf))

  (fn buffer-map [from to]
    (vim.keymap.set :n from to {:buffer buf :silent true}))

  (when (= client.name "gopls")
    (create-autocmd :BufWritePre {:buffer buf
                                  :callback #(organize-imports 1000)}))

  (when client.server_capabilities.documentFormattingProvider
    (buffer-map :<leader>af vim.lsp.buf.format)
    ;; Don't auto-format with null-ls
    (when (not= client.name "null-ls")
      (create-autocmd :BufWritePre {:buffer buf
                                    :callback #(vim.lsp.buf.format)})))

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
(lspconfig.gopls.setup {:handlers handlers
                        :cmd ["gopls" "-remote=auto"]
                        ;; https://github.com/golang/tools/blob/master/gopls/doc/settings.md
                        :settings {:gopls {;; https://github.com/golang/tools/blob/master/gopls/doc/settings.md#staticcheck-bool
                                           :staticcheck true
                                           ;; https://github.com/golang/tools/blob/master/gopls/doc/analyzers.md
                                           ;; Most of these analyzers are enabled by default.
                                           :analyses {;; https://github.com/golang/tools/blob/master/gopls/doc/analyzers.md#unusedparams
                                                      :unusedparams true}}}})

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
                lspconfig.eslint])

(each [_ lsp-server (ipairs servers)]
  (lsp-server.setup {:handlers handlers}))
