(module dotfiles.module.core
  {require {nvim aniseed.nvim
            str aniseed.string
            a aniseed.core}})

(let [stl ["%f"
           "%m"
           "%="
           "%l,%c "
           "%{&filetype}"]]
  (set nvim.o.statusline (str.join stl)))
