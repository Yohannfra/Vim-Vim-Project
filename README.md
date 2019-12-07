# Vim-Vim-Project
A simple and lightweight vim plugin for an IDE-like project feature.

## Installation

### Using Plug
```
Plug 'Yohannfra/Vim-Vim-Project'
```

### Manual installation
```
git clone https://github.com/Yohannfra/Vim-Vim-Project/ ~/.vim/plugin/
```

## Features

- Super easy/transparent to use and configure
- Build command
- Run command
- Save and restore vim layout
- I didn't really need more, feel free to open an issue if you want to add something

## Commands

#### Initialize a vim project.

It will create a .vimproject, generate a vimproj.vim in it and open it.
```vim
:VimProjectInit
```

The default vimproj.vim looks like that
```vim
" VimProject file

" Project Name:
let g:vim_project_ProjectName = "DefaultName"

" Build command:
let g:vim_project_BuildCommand = ""

" Run command:
let g:vim_project_RunCommand = ""

" Save vim layout:
let g:vim_project_SaveLayout = 1

" Autoload vim layout:
let g:vim_project_AutoRestoreLayout = 1
```

#### Build

Execute the g:vim_project_BuildCommand you set in your vimproj.vim.
```vim
:VimProjectBuild
```

In my .vimrc i mapped the F4 key for this.
```vim
nnoremap <F4> :VimProjectBuild <CR>
```

#### Run

Execute the g:vim_project_RunCommand you set in your vimproj.vim.
```vim
:VimProjectRun
```

In my .vimrc i mapped the F5 key for this.
```vim
nnoremap <F5> :VimProjectRun<CR>
```

####  Save/Restore Layout

Save the current layout. It uses the :mksession feature of vim.\
If you want to understand how it works read :h :mksession
It will save it in .vimproject/session
```vim
:VimProjectSaveLayout
```

By default it will call this command after time you write a buffer.\
Use this if you don't want this behavior
```vim
let g:vim_project_general_save_on_write = 0
```

Restore the saved layout if there is one.\
This command is called on vim startup if g:vim_project_AutoRestoreLayout is set to 1
and if you don't call vim with command line arguments
```vim
:VimProjectRestoreLayout
```

## License

This project is licensed under the terms of the MIT license.
