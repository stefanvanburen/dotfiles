(module dotfiles.lsp
  {autoload {: lspconfig}})

(local create-autocmd vim.api.nvim_create_autocmd)
(local create-augroup vim.api.nvim_create_augroup)

(fn buffer-map [bufnr from to]
  "Sets a normal mode mapping within a buffer."
  (vim.keymap.set :n from to {:buffer bufnr :silent true}))

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

  ;; NOTE: Useful for debugging
  ;; https://github.com/nanotee/nvim-lua-guide#the-vim-namespace
  ; (vim.pretty_print client)

  (when (= client.name "gopls")
    (create-autocmd :BufWritePre {:buffer buf
                                  :callback #(organize-imports 1000)}))

  (when client.server_capabilities.documentFormattingProvider
    (buffer-map buf :<leader>af vim.lsp.buf.format)
    (create-autocmd :BufWritePre {:buffer buf
                                  :callback #(vim.lsp.buf.format)}))

  (when client.server_capabilities.hoverProvider
    (buffer-map buf :K vim.lsp.buf.hover))

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
  (buffer-map buf :gD         vim.lsp.buf.declaration)
  (buffer-map buf :gd         vim.lsp.buf.definition)
  (buffer-map buf :gi         vim.lsp.buf.implementation)
  (buffer-map buf :gr         vim.lsp.buf.references)
  (buffer-map buf :<C-k>      vim.lsp.buf.signature_help)
  (buffer-map buf :<leader>D  vim.lsp.buf.type_definition)
  (buffer-map buf :<leader>rn vim.lsp.buf.rename)
  (buffer-map buf :<leader>ca vim.lsp.buf.code_action))

(create-autocmd :LspAttach {:callback on-attach})

(vim.fn.sign_define "DiagnosticSignError" {:text "×" :texthl "DiagnosticSignError"})
(vim.fn.sign_define "DiagnosticSignWarn"  {:text "!" :texthl "DiagnosticSignWarn"})
(vim.fn.sign_define "DiagnosticSignInfo"  {:text "i" :texthl "DiagnosticSignInfo"})
(vim.fn.sign_define "DiagnosticSignHint"  {:text "?" :texthl "DiagnosticSignHint"})

(vim.diagnostic.config {:virtual_text {:prefix "▪"}
                        :float {:border "single"
                                :focusable false
                                :source "always"}})

(local handlers {"textDocument/hover"         (vim.lsp.with vim.lsp.handlers.hover          {:border "single"})
                 "textDocument/signatureHelp" (vim.lsp.with vim.lsp.handlers.signature_help {:border "single"})})

;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#gopls
(lspconfig.gopls.setup {:handlers handlers
                        :cmd ["gopls" "-remote=auto"]
                        ;; https://github.com/golang/tools/blob/master/gopls/doc/settings.md
                        :settings {:gopls {;; https://github.com/golang/tools/blob/master/gopls/doc/settings.md#staticcheck-bool
                                           :staticcheck true
                                           ;; https://github.com/golang/tools/blob/master/gopls/doc/settings.md#vulncheck-enum
                                           :vulncheck "Imports"
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

(local servers [;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#clojure_lsp
                lspconfig.clojure_lsp
                ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#bufls
                lspconfig.bufls
                ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#ruff_lsp
                lspconfig.ruff_lsp ; for python, instead of pylsp - seems strictly better?
                ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tsserver
                lspconfig.tsserver
                ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#eslint
                lspconfig.eslint
                ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#marksman
                lspconfig.marksman])

(each [_ lsp-server (ipairs servers)]
  (lsp-server.setup {:handlers handlers}))
