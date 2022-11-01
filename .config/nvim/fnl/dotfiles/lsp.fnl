(module dotfiles.lsp
  {autoload {: lspconfig}})

(def- create-autocmd vim.api.nvim_create_autocmd)
(def- create-augroup vim.api.nvim_create_augroup)

(defn- buffer-map [bufnr from to]
  "Sets a normal mode mapping within a buffer."
  (vim.keymap.set :n from to {:buffer bufnr :silent true}))

(defn organize-imports [wait-ms]
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

(defn on-attach [{: buf
                  :data {: client_id}}]
  (local client (vim.lsp.get_client_by_id client_id))

  ;; NOTE: Useful for debugging
  ;; https://github.com/nanotee/nvim-lua-guide#the-vim-namespace
  ; (vim.pretty_print client)

  (when (= client.name "gopls")
    (create-autocmd "BufWritePre" {:buffer buf
                                   :callback #(organize-imports 1000)}))

  (when client.server_capabilities.documentFormattingProvider
    (buffer-map buf :<leader>af vim.lsp.buf.format)
    (create-autocmd "BufWritePre" {:buffer buf
                                   :callback #(vim.lsp.buf.format)}))

  (when client.server_capabilities.hoverProvider
    (buffer-map buf :K vim.lsp.buf.hover))

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
  (buffer-map buf :gD         vim.lsp.buf.declaration)
  (buffer-map buf :gd         vim.lsp.buf.definition)
  (buffer-map buf :gi         vim.lsp.buf.implementation)
  (buffer-map buf :gr         vim.lsp.buf.references)
  (buffer-map buf :<C-k>      vim.lsp.buf.signature_help)
  (buffer-map buf :<leader>D  vim.lsp.buf.type_definition)
  (buffer-map buf :<leader>rn vim.lsp.buf.rename)
  (buffer-map buf :<leader>ca vim.lsp.buf.code_action))

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

;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#gopls
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

;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#clojure_lsp
(lspconfig.clojure_lsp.setup {:handlers handlers})

;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#bufls
(lspconfig.bufls.setup {:handlers handlers})

;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pylsp
(lspconfig.pylsp.setup {:handlers handlers})

;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tsserver
(lspconfig.tsserver.setup {:handlers handlers})

;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#eslint
(lspconfig.eslint.setup {:handlers handlers})

;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#marksman
(lspconfig.marksman.setup {:handlers handlers})
