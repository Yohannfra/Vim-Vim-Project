if exists('g:vim_project_loadded')
    finish
endif

let g:vim_project_loadded = 1

if argc() == 0 && filereadable('.vimproject/vimproj.vim')
        echo "Project found !"
        source .vimproject/vimproj.vim
        echo "Project loadded !"
        autocmd! BufWritePre * :mksession! .vimproject/session
endif

command! VimProjectInit :call vim_project#Init()
