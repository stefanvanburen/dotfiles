(module dotfiles.module.core
  {autoload {nvim aniseed.nvim
             str aniseed.string}})

(let [stl ["%f"
           "%m "
           " %{FugitiveHead()}"
           "%="
           "%l,%c "
           "%{&filetype}"]]
  (set nvim.o.statusline (str.join stl)))
