(module dotfiles.plugin.fzf)

(let [(ok? fzf-lua) (pcall require :fzf-lua)]
  (when ok?
    ;; https://github.com/ibhagwan/fzf-lua#neovim-api
    (fzf-lua.register_ui_select)
    ;; https://github.com/ibhagwan/fzf-lua#default-options
    (fzf-lua.setup {:winopts {:border :single}
                    :global_git_icons false
                    :global_file_icons false})))
