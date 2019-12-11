let s:vimproj_template_array = [
            \ "\" VimProject file", "",
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

function! s:PrintErrMsgProject()
    if g:vim_project_found == 0
        echoerr "No Vim Project found. Use :VimProjectInit to create one"
        return
    endif
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
    if g:vim_project_found && exists('g:vim_project_RunCommand') &&
                \ !empty(g:vim_project_RunCommand)
        execute ":! " . g:vim_project_RunCommand
    else
        call s:PrintErrMsgProject()
    endif
endfunction

function! vim_project#Build()
    if g:vim_project_found && exists('g:vim_project_BuildCommand') &&
                \ !empty(g:vim_project_BuildCommand)
        execute ":! " . g:vim_project_BuildCommand
    else
        call s:PrintErrMsgProject()
    endif
endfunction

function! vim_project#SaveLayout()
    if g:vim_project_found && s:VimProjDirExists()
        execute ":mksession! .vimproject/session.vim"
    else
        call s:PrintErrMsgProject()
    endif
endfunction

function! vim_project#RestoreLayout()
    if g:vim_project_found && s:VimProjDirExists()
        if filereadable('.vimproject/session.vim')
            execute ":source .vimproject/session.vim"
        endif
    else
        call s:PrintErrMsgProject()
    endif
endfunction
