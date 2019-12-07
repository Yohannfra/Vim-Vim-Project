let s:vimproj_template_array = [
            \ "\" VimProject file",
            \ "",
            \ "\" Project Name:",
            \ "let g:vim_project_ProjectName = \"DefaultName\"",
            \ "",
            \ "\" Autoload vim project:",
            \ "let g:vim_project_AutoLoadProject = 1",
            \ "",
            \ "\" Build command:",
            \ "let g:vim_project_BuildCommand = \"\"",
            \ "",
            \ "\" Run command:",
            \ "let g:vim_project_RunCommand = \"\"",
            \ "",
            \ "\" Save vim layout:",
            \ "let g:vim_project_SaveLayout = 1",
            \ "",
            \ "\" Autoload vim layout:",
            \ "let g:vim_project_AutoLoadLayout = 1",
            \]

function! vim_project#Init()
    if isdirectory('.vimproject') || filereadable('.vimproject/vimproj.vim')
        echo "There is already a vim project here"
        return
    endif
    call mkdir('.vimproject', 'p')
    execute 'edit .vimproject/vimproj.vim'
    for line in reverse(s:vimproj_template_array)
        call append('^', line)
    endfor
    write
endfunction
