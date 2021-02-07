(module dotfiles.module.core
  {require {nvim aniseed.nvim
            str aniseed.string}})

(let [stl ["%f"
           "%m"
           "%="
           "%l,%c "
           "%{&filetype}"]]
  (set nvim.o.statusline (str.join stl)))
