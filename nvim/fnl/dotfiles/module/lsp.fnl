(module dotfiles.module.lsp
  {require {nvim aniseed.nvim
            a    aniseed.core
            lsp "lspconfig"}
   ;; for autocmd and augroup
   require-macros [dotfiles.macros]})

(defn- nnoremap [bufnr from to]
  "Sets a normal mode mapping within a buffer."
  (nvim.buf_set_keymap bufnr :n from to {:noremap true :silent true}))

(defn- capable? [client capability]
  (. client.resolved_capabilities capability))

(defn- on-attach [client bufnr]
  ;; Set some keybinds conditional on server capabilities
  (when (or (capable? client :document_formatting)
            (capable? client :document_range_formatting))
    (nnoremap bufnr "<leader>af" "<cmd>lua vim.lsp.buf.formatting()<CR>"))

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
    (set nvim.bo.omnifunc "v:lua.vim.lsp.omnifunc"))

  ;; setup mappings
  (nnoremap bufnr "gD"         "<cmd>lua vim.lsp.buf.declaration()<CR>")
  (nnoremap bufnr "gd"         "<cmd>lua vim.lsp.buf.definition()<CR>")
  (nnoremap bufnr "gi"         "<cmd>lua vim.lsp.buf.implementation()<CR>")
  (nnoremap bufnr "K"          "<cmd>lua vim.lsp.buf.hover()<CR>")
  (nnoremap bufnr "<C-k>"      "<cmd>lua vim.lsp.buf.signature_help()<CR>")
  (nnoremap bufnr "<leader>D"  "<cmd>lua vim.lsp.buf.type_definition()<CR>")
  (nnoremap bufnr "<leader>rn" "<cmd>lua vim.lsp.buf.rename()<CR>")
  (nnoremap bufnr "gr"         "<cmd>lua vim.lsp.buf.references()<CR>")
  (nnoremap bufnr "<leader>e"  "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>")
  (nnoremap bufnr "[w"         "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>")
  (nnoremap bufnr "]w"         "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>")
  (nnoremap bufnr "<leader>q"  "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>"))

(defn set-signs []
  (let [sign vim.fn.sign_define]
    (sign "LspDiagnosticsSignError"       {:text "×" :texthl "LspDiagnosticsDefaultError"})
    (sign "LspDiagnosticsSignWarning"     {:text "‽" :texthl "LspDiagnosticsDefaultWarning"})
    (sign "LspDiagnosticsSignInformation" {:text "※" :texthl "LspDiagnosticsDefaultInformation"})
    (sign "LspDiagnosticsSignHint"        {:text "⁖" :texthl "LspDiagnosticsDefaultHint"})))

(def- handlers
  {"textDocument/publishDiagnostics"
   (vim.lsp.with
     vim.lsp.diagnostic.on_publish_diagnostics
     {:virtual_text {:prefix "∴"
                     :spacing 1}
      :signs true
      :underline true
      :update_in_insert false})})

(def- servers
  {:jsonls {}
   :cssls {}
   :gopls {:cmd ["gopls" "serve"]
           :settings {:gopls {:analyses {:unusedparams true}
                              :staticcheck true}}}
   :rust_analyzer {}
   :tsserver {}
   :clojure_lsp {}})

(defn- set-server [s c]
  ((. lsp s :setup)
   (vim.tbl_extend
     "force"
     {:on_attach on-attach
      : handlers
      :capabilities (or c.capabilities {})}
     (or c {}))))

(set-signs)
(each [server config (pairs servers)] (set-server server config))
