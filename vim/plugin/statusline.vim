" statusline
" crufted together from https://github.com/bluz71/vim-moonfly-statusline

let s:modes = {
  \  "n":      ["%1*", " normal "],
  \  "i":      ["%2*", " insert "],
  \  "R":      ["%4*", " r-mode "],
  \  "v":      ["%3*", " visual "],
  \  "V":      ["%3*", " v-line "],
  \  "\<C-v>": ["%3*", " v-rect "],
  \  "c":      ["%1*", " c-mode "],
  \  "s":      ["%3*", " select "],
  \  "S":      ["%3*", " s-line "],
  \  "\<C-s>": ["%3*", " s-rect "],
  \  "t":      ["%2*", " term "],
  \}

function! ModeColor(mode)
    return get(s:modes, a:mode, "%*1")[0]
endfunction

function! ModeText(mode)
    return get(s:modes, a:mode, " normal ")[1]
endfunction

function! FugitiveBranch()
    if !exists("g:loaded_fugitive") || !exists("b:git_dir")
        return ""
    endif

    return "[ " . fugitive#head() . "]"
endfunction

function! ShortFilePath()
    if &buftype == "terminal"
        return expand("%:t")
    else
        let l:path = expand("%:f")
        if len(l:path) == 0
            return ""
        else
            return pathshorten(fnamemodify(expand("%:f"), ":~:."))
        endif
    endif
endfunction

function! PluginsStatus()
    let l:status = ""

    " ALE plugin indicator.
    if exists("g:loaded_ale")
        if ale#statusline#Count(bufnr('')).total > 0
            let l:status .= "✖" . " "
        endif
    endif

    return l:status
endfunction

function! ActiveStatusLine()
    let l:mode = mode()
    let l:statusline = ModeColor(l:mode)
    let l:statusline .= ModeText(l:mode)
    let l:statusline .= "%* %<%{ShortFilePath()} %H%M%R"
    let l:statusline .= "%5* %{FugitiveBranch()} "
    let l:statusline .= "%6*%{PluginsStatus()}"
    let l:statusline .= "%*%=%l:%c | %7*%L%* | %P "
    return l:statusline
endfunction

function! InactiveStatusLine()
    let l:statusline = " %*%<%{ShortFilePath()}\ %H%M%R"
    let l:statusline .= "%*%=%l:%c | %L | %P "
    return l:statusline
endfunction

function! NoFileStatusLine()
    let l:statusline = " %{pathshorten(fnamemodify(getcwd(), ':~:.'))}"
    return l:statusline
endfunction

function! s:StatusLine(active)
    if &buftype == "nofile" || &filetype == "netrw"
        " Likely a file explorer.
        setlocal statusline=%!NoFileStatusLine()
    elseif &buftype == "nowrite"
        " Don't set a custom status line for certain special windows.
        return
    elseif a:active == v:true
        setlocal statusline=%!ActiveStatusLine()
    else
        setlocal statusline=%!InactiveStatusLine()
    endif
endfunction

" Iterate though the windows and update the status line for all inactive
" windows.
"
" This is needed when starting Vim with multiple splits, for example 'vim -O
" file1 file2', otherwise all 'status lines will be rendered as if they are
" active. Inactive statuslines are usually rendered via the WinLeave and
" BufLeave events, but those events are not triggered when starting Vim.
"
" Note - https://jip.dev/posts/a-simpler-vim-statusline/#inactive-statuslines
function! s:UpdateInactiveWindows()
    for winnum in range(1, winnr('$'))
        if winnum != winnr()
            call setwinvar(winnum, '&statusline', '%!InactiveStatusLine()')
        endif
    endfor
endfunction

augroup StatuslineEvents
    autocmd!
    autocmd VimEnter              * call s:UpdateInactiveWindows()
    autocmd WinEnter,BufWinEnter  * call s:StatusLine(v:true)
    autocmd WinLeave              * call s:StatusLine(v:false)
    if exists("##CmdlineEnter")
        autocmd CmdlineEnter      * call s:StatusLine(v:true) | redraw
    endif
augroup END
