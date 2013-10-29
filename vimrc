
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif


function! SuperCleverTab()
    if strpart(getline('.'), 0, col('.') - 1) =~ '^\s*$'
        return "\<Tab>"
    else
        if &omnifunc != ''
            return "\<C-X>\<C-O>"
        elseif &dictionary != ''
            return "\<C-K>"
        else
            return "\<C-N>"
        endif
    endif
endfunction

inoremap <Tab> <C-R>=SuperCleverTab()<cr>

let g:gist_detect_filetype = 1
let g:gist_post_private = 1

"Abbreviations
:iabbrev @@     web@flexd.net
:iabbrev ccopy  Copyright 2013 Kristoffer Berdal, all rights reserved.
:iabbrev pdb    # XXX BREAKPOINT XXX <cr>import pdb; pdb.set_trace()
:iabbrev ppython #!/usr/bin/env python <cr>#-*- coding: utf-8 -*-

let g:pymode_folding = 0
set colorcolumn=81                           " line to show 81 character mark
set nocompatible
set t_Co=256
set tabstop=4
set expandtab
set shiftwidth=4
set fileencoding=utf-8
set encoding=utf-8
set termencoding=utf-8
set showcmd
set noshowmode "" Using vim-powerline so we do not need to see modes like INSERT/VISUAL

filetype plugin indent on
syntax enable
autocmd! BufNewFile * silent! 0r ~/.vim/skel/tmpl.%:e
set laststatus=2 " Always show the statusline

set backspace=indent,eol,start  " backspace through everything in insert mode

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

"" Appearence
colorscheme jellybeans
"" Mappings
" use comma as <Leader> key instead of backslash
let mapleader=","
" double percentage sign in command mode is expanded
" to directory of current file - http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" Quickly edit/source .vimrc
noremap <leader>ve :edit ~/.vimrc<CR>
noremap <leader>vs :source ~/.vimrc<CR>

" Move faster
map <C-j> <C-d>
map <C-k> <C-u>

" Bubbling (bracket matching)
nmap <C-up> [e
nmap <C-down> ]e
vmap <C-up> [egv
vmap <C-down> ]egv
" Double <Leader> to switch between buffers
nnoremap <leader><leader> <c-^>
nmap <F8> :TagbarToggle<CR>
nmap <F7> :PyLintAuto<CR>
let g:ctrlp_map = '<Leader>f'
let g:ctrlp_custom_ignore = 'node_modules/|git'
""" Highlight characters past 80, toggle with <leader>h {{{
nnoremap <Leader>h :call ToggleOverLengthHighlight()<CR>
let g:overlength_enabled = 0
highlight OverLength ctermbg=cyan guibg=#212121

function! ToggleOverLengthHighlight()
    if g:overlength_enabled == 0
        match OverLength /\%80v.*/
        let g:overlength_enabled = 1
        echo 'OverLength highlighting turned on'
    else
        match
        let g:overlength_enabled = 0
        echo 'OverLength highlighting turned off'
    endif
endfunction
""" }}}
if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
endif
nnoremap <F3> :NumbersToggle<CR>
nnoremap <F4> :NumbersOnOff<CR>
nnoremap <F5> :UndotreeToggle<cr>

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif
