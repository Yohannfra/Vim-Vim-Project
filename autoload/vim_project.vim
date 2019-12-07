let s:vimproj_template_array = [
            \ "\" VimProject file",
            \ "\" Project Name:",
            \ "let g:vim_project_ProjectName = \"DefaultName\"",
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
            \ "let g:vim_project_AutoRestoreLayout = 1",
            \]

function! s:VimProjDirExists()
    return isdirectory('.vimproject') && filereadable('.vimproject/vimproj.vim')
endfunction

function! vim_project#Init()
    if s:VimProjDirExists()
        echo "There is already a vim project : " . g:vim_project_ProjectName
        return
    endif
    call mkdir('.vimproject', 'p')
    execute 'edit .vimproject/vimproj.vim'
    for line in reverse(s:vimproj_template_array)
        call append('^', line)
    endfor
    write
endfunction

function! vim_project#Run()
    if !empty(g:vim_project_RunCommand)
        execute ":! " . g:vim_project_RunCommand
    endif
endfunction

function! vim_project#Build()
    if !empty(g:vim_project_BuildCommand)
        execute ":! " . g:vim_project_BuildCommand
    endif
endfunction

function! vim_project#SaveLayout()
    if s:VimProjDirExists()
        execute ":mksession! .vimproject/session"
    endif
endfunction

function! vim_project#RestoreLayout()
    if s:VimProjDirExists()
        if filereadable('.vimproject/session')
            execute ":source .vimproject/session"
        endif
    endif
endfunction
