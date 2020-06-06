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
            \ "",
            \]

function! s:VimProjDirExists()
    return isdirectory(s:project_path) && filereadable(s:project_path_vimproj)
endfunction

function! s:PrintErrMsgProject()
    if g:vim_project_found == 0
        echoerr "No Vim Project found. Use :VimProjectInit to create one"
        return
    endif
endfunction

function! vim_project#Init()
    let s:project_path = getcwd() . '/' . '.vimproject/'
    let s:project_path_vimproj = s:project_path . 'vimproj.vim'
    let s:project_path_session = s:project_path . 'session.vim'
    if s:VimProjDirExists()
        echo "There is already a vim project : " . g:vim_project_ProjectName
        return
    endif
    call mkdir('.vimproject', 'p')
    execute 'edit .vimproject/vimproj.vim'
    if exists("g:vim_project_custom_variables") &&
                \ !empty(g:vim_project_custom_variables)
        for line in reverse(g:vim_project_custom_variables)
            call append('^', line)
        endfor
    endif
    for line in reverse(s:vimproj_template_array)
        call append('^', line)
    endfor
    write
    call vim_project#Load()
endfunction

function! vim_project#Load()
    let s:project_path = getcwd() . '/' . '.vimproject/'
    let s:project_path_vimproj = s:project_path . 'vimproj.vim'
    let s:project_path_session = s:project_path . 'session.vim'
    execute "source " . s:project_path_vimproj
    echo "Project found : " . g:vim_project_ProjectName
    let g:vim_project_found = 1
    call vim_project#RestoreLayout()
    if exists('g:vim_project_SaveLayout') &&
                \ g:vim_project_SaveLayout == 1 &&
                \ g:vim_project_general_save_on_write == 1
        autocmd! BufWritePre * :mksession! .vimproject/session.vim
        execute "autocmd! BufWritePre * :mksession! " . s:project_path_session
    endif
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
        execute ":mksession! " . s:project_path_session
    else
        call s:PrintErrMsgProject()
    endif
endfunction

function! vim_project#RestoreLayout()
    if g:vim_project_found && s:VimProjDirExists()
        if !filereadable(s:project_path_session)
            return
        endif
        if g:vim_project_AutoRestoreLayout == 0
            if 1 == confirm("vimproject layout found, do you want to load it ?", "&Yes\n&No", "n")
                execute ":silent! source " . s:project_path_session
            endif
        else
            execute ":silent! source " . s:project_path_session
        endif
    else
        call s:PrintErrMsgProject()
    endif
endfunction
