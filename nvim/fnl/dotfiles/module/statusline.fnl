(module dotfiles.module.core
  {require {nvim aniseed.nvim
            str aniseed.string}})

(let [stl ["%f"
           "%m "
           " %{FugitiveHead()}"
           "%="
           "%l,%c "
           "%{&filetype}"]]
  (set nvim.o.statusline (str.join stl)))
