" Load in the Vundle bundles
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
:iabbrev ccopy  Copyright 2015 Kristoffer Berdal, all rights reserved.
:iabbrev pdb    # XXX BREAKPOINT XXX <cr>import pdb; pdb.set_trace()
:iabbrev ppython #!/usr/bin/env python <cr>#-*- coding: utf-8 -*-

let g:pymode_folding = 0
let g:pymode_lint_ignore = "E501,E261"
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
set number "" This is important to keep numbers.vim and other things from breaking!

filetype plugin indent on
syntax enable
set background=dark
autocmd! BufNewFile * silent! 0r ~/.vim/skel/tmpl.%:e
set laststatus=2 " Always show the statusline

set backspace=indent,eol,start  " backspace through everything in insert mode

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

"" Appearence
"colorscheme solarized
"colorscheme noctu
colorscheme gruvbox
if !has("gui_running")
   let g:gruvbox_italic=0
endif
"" Mappings
" use comma as <Leader> key instead of backslash
let mapleader=","
" double percentage sign in command mode is expanded
" to directory of current file - http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" Quickly edit/source .vimrc
noremap <leader>ve :edit ~/.vimrc<CR>
noremap <leader>vs :source ~/.vimrc<CR>

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

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
" Tell vim-bufferline to only show in statusline
let g:bufferline_echo = 0

let g:ctrlp_map = '<Leader>f'
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

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif

let g:go_highlight_methods = 1
let g:go_highlight_functions = 1
let g:go_highlight_structs = 1
