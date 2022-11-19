(module dotfiles.plugin.gitsigns)

;; https://github.com/lewis6991/gitsigns.nvim#keymaps
(fn on-attach [bufnr]
  (let [gs package.loaded.gitsigns
        map (fn [mode l r ?opts]
              (let [opts (or ?opts {})]
                (set opts.buffer bufnr)
                (vim.keymap.set mode l r opts)))]

    ;; Navigation
    (map "n" "]c" (fn []
                    (if (= vim.wo.diff true)
                      "]c"
                      (do
                        (vim.schedule #(gs.next_hunk))
                        "<Ignore>")))
         {:expr true})
    (map "n" "[c" (fn []
                    (if (= vim.wo.diff true)
                      "[c"
                      (do
                        (vim.schedule #(gs.prev_hunk))
                        "<Ignore>")))
         {:expr true})

    ;; Actions
    (map ["n" "v"] "<leader>hs" ":Gitsigns stage_hunk<CR>")
    (map ["n" "v"] "<leader>hr" ":Gitsigns reset_hunk<CR>")
    (map "n" "<leader>hS" gs.stage_buffer)
    (map "n" "<leader>hR" gs.reset_buffer)
    (map "n" "<leader>hu" gs.undo_stage_hunk)
    (map "n" "<leader>hp" gs.preview_hunk)
    (map "n" "<leader>hb" #(gs.blame_line {:full true}))
    (map "n" "<leader>tb" gs.toggle_current_line_blame)
    (map "n" "<leader>hd" gs.diffthis)
    (map "n" "<leader>hD" #(gs.diffthis "~"))
    (map "n" "<leader>td" gs.toggle_deleted)

    ;; Text object
    (map ["o" "x"] "ih" ":<C-U>Gitsigns select_hunk<CR>")))

(let [(ok? gitsigns) (pcall require :gitsigns)]
  (when ok?
    (gitsigns.setup
      {:attach_to_untracked false
       :on_attach on-attach})))
