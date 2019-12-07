if exists('g:vim_project_loadded')
    finish
endif

let g:vim_project_loadded = 1

if !exists('g:vim_project_general_save_on_write')
    let g:vim_project_general_save_on_write = 1
endif

if argc() == 0 && filereadable('.vimproject/vimproj.vim')
        source .vimproject/vimproj.vim
        echo "Project found : " . g:vim_project_ProjectName
        if exists('g:vim_project_AutoRestoreLayout') &&
                    \ g:vim_project_AutoRestoreLayout == 1
            call vim_project#RestoreLayout()
        endif
        if exists('g:vim_project_SaveLayout') &&
                    \ g:vim_project_SaveLayout == 1 &&
                    \ g:vim_project_general_save_on_write == 1
            autocmd! BufWritePre * :mksession! .vimproject/session
        endif
endif

autocmd BufWritePost vimproj.vim :source %

command! VimProjectInit :call vim_project#Init()
command! VimProjectRun :call vim_project#Run()
command! VimProjectBuild :call vim_project#Build()
command! VimProjectSaveLayout :call vim_project#SaveLayout()
command! VimProjectRestoreLayout :call vim_project#RestoreLayout()
