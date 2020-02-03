if exists('g:vim_project_loadded')
    finish
endif

let g:vim_project_loadded = 1

if !exists('g:vim_project_general_save_on_write')
    let g:vim_project_general_save_on_write = 1
endif

let g:vim_project_found = 0

fun! Confirm(msg)
    echo a:msg . ' '
    let l:answer = nr2char(getchar())

    if l:answer ==? 'y'
        return 1
    elseif l:answer ==? 'n'
        return 0
    else
        echo 'Please enter "y" or "n"'
        return Confirm(a:msg)
    endif
endfun

if filereadable('.vimproject/vimproj.vim')
    if 1 == confirm("vimproject found, do you want to load it ?", "&Yes\n&No", "n")
        call vim_project#Load()
    endif
endif

autocmd BufWritePost vimproj.vim :source %

command! VimProjectInit :call vim_project#Init()
command! VimProjectRun :call vim_project#Run()
command! VimProjectBuild :call vim_project#Build()
command! VimProjectSaveLayout :call vim_project#SaveLayout()
command! VimProjectRestoreLayout :call vim_project#RestoreLayout()
