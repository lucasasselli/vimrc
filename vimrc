set nocompatible " be iMproved
filetype off " required!

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()
Plugin 'The-NERD-tree'
Plugin 'ervandew/supertab'
Plugin 'altercation/vim-colors-solarized'
Plugin 'majutsushi/tagbar'
filetype plugin indent on " required! 

" Tagbar
let g:tagbar_width = 30
let g:tagbar_autofocus = 1

" NerdTree 
let g:NERDTreeChDirMode = 1
let g:NERDTreeHijackNetrw = 1

" Theme and colors
syntax enable

if (has('gui_running'))
        
    set guifont=Droid\ Sans\ Mono\ Slashed\ for\ Powerline

    " Remove gvim GUI
    set guioptions-=m "remove menu bar
    set guioptions-=T "remove toolbar
    set guioptions-=r "remove right-hand scroll bar
    set guioptions-=L "remove left-hand scroll bar

    " Use Solarized theme
    set background=dark
    colorscheme solarized

endif

set wildmenu " Command line completion
set showcmd " Show partial commands
set ignorecase " Ignore case in searches...
set smartcase " ... Except if uppercase
set autoindent " If no indentation is specified, keep the indentation of the previous line
set ruler " Show cursor position in status
set laststatus=2 " Always display status
set confirm " If file must be saved to execute command, ask to the user insted of showing an error
set number " Show line number
set cursorline
set incsearch
set hlsearch

" Indentation setting
set shiftwidth=4
set softtabstop=4
set expandtab

" Fix backspace
set backspace=2
set backspace=indent,eol,start

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Key mappings
map <F1> :NERDTreeToggle<CR>
map <F2> :TagbarToggle<CR>
map <F3> :call QuickfixToggle()<CR>
map <F5> :w<CR>:make<CR>
map <F6> :cprev<CR>
map <F7> :cnext<CR>
map <F11> mz<bar> :call ClearWhitespace()<CR><bar> gg=G'z 
map <F12> :vimgrep TODO **/*.*<CR>:call QuickfixToggle()<CR> 
map <C-p> "+P
map <C-c> "+y

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Persistent undo
set undodir=~/.vim/undo/
set undofile
set undolevels=1000
set undoreload=10000

" VHDL
let g:vhdl_indent_genportmap=0
let g:tagbar_type_vhdl = {
            \ 'ctagstype': 'vhdl',
            \ 'kinds' : [
            \'e:entities',
            \'a:architectures',
            \'T:subtypes',
            \'t:types',
            \'c:constants',
            \'s:signals',
            \'x:processes',
            \'C:components',
            \'f:functions',
            \'v:variables',
            \]
            \}

" Functions
function ClearWhitespace()
    retab!
    %s![^ ]\zs \+! !g
endfunction

let g:quickfix_is_open = 0
function! QuickfixToggle()
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
    else
        copen
        let g:quickfix_is_open = 1
    endif
endfunction
