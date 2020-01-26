if exists('g:vim_project_loadded')
    finish
endif

let g:vim_project_loadded = 1

if !exists('g:vim_project_general_save_on_write')
    let g:vim_project_general_save_on_write = 1
endif

let g:vim_project_found = 0

if filereadable('.vimproject/vimproj.vim')
    let choice = input("vimproject found, do you want to load it ? (y/n) : ")
    if choice == "y"
        call vim_project#Load()
    endif
endif

autocmd BufWritePost vimproj.vim :source %

command! VimProjectInit :call vim_project#Init()
command! VimProjectRun :call vim_project#Run()
command! VimProjectBuild :call vim_project#Build()
command! VimProjectSaveLayout :call vim_project#SaveLayout()
command! VimProjectRestoreLayout :call vim_project#RestoreLayout()
