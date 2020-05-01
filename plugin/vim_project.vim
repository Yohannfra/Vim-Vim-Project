let g:NoVimProject = get(g:, 'NoVimProject')

if exists('g:vim_project_loadded') || g:NoVimProject == 1
    finish
endif

let g:vim_project_loadded = 1

let g:vim_project_general_save_on_write =
            \ get(g:, 'vim_project_general_save_on_write', 1)

let g:vim_project_found = 0

if filereadable('.vimproject/vimproj.vim')
    if 1 == confirm("vimproject found, do you want to load it ?", "&Yes\n&No", "n")
        call vim_project#Load()
    endif
endif

autocmd BufWritePost vimproj.vim :source %

command! VimProjectInit :call vim_project#Init()
command! VimProjectLoad :call vim_project#Load()
command! VimProjectRun :call vim_project#Run()
command! VimProjectBuild :call vim_project#Build()
command! VimProjectSaveLayout :call vim_project#SaveLayout()
command! VimProjectRestoreLayout :call vim_project#RestoreLayout()
