(module dotfiles.module.plugin.ale
  {require {nvim aniseed.nvim}})

(set nvim.g.ale_sign_error "×")
(set nvim.g.ale_sign_warning "→")
(set nvim.g.ale_sign_info "→")
(set nvim.g.ale_echo_msg_format "%linter%: %s")

;; in general, this is the right thing to do
(set nvim.g.ale_fix_on_save 1)

(set nvim.g.ale_virtualtext_cursor 1)
(set nvim.g.ale_virtualtext_prefix  "∴ ")

(nvim.set_keymap :n :<leader>af ":ALEFix<cr>" {:noremap true})
; (nvim.set_keymap :n :[w "<plug>(ale_previous_wrap)" {})
; (nvim.set_keymap :n :]w "<plug>(ale_next_wrap)" {})
