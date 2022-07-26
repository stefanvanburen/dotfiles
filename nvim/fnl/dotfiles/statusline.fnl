(module dotfiles.statusline
  {autoload {str aniseed.string}})

(let [stl ["%f"
           "%m "
           "%{FugitiveHead()}"
           "%="
           "%l,%c "
           "%{&filetype}"]]
  (set vim.o.statusline (str.join stl)))
