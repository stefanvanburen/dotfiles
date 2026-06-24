if did_filetype()
  finish
endif

if getline(1) =~# 'uv run --script'
  setf python
endif
