set nocompatible " be iMproved

filetype off " required!

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()
Plugin 'VundleVim/Vundle.vim'
Plugin 'The-NERD-tree'
Plugin 'JPR75/vip'
Plugin 'vim-scripts/a.vim'
Plugin 'vandew/supertab'
Plugin 'chriskempson/base16-vim'
Plugin 'godlygeek/tabular'
Plugin 'lervag/vimtex'
Plugin 'tpope/vim-fugitive'
filetype plugin indent on " required! 

"--------------------------------------------------
" AUTO COMMANDS
"--------------------------------------------------

autocmd GUIEnter * silent! lcd %:p:h                                           " Fix working dir when using GUI
autocmd FileType help wincmd L                                                 " Open new help window horizontally
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o " Disable auto comment insertion
autocmd BufNewFile,Bufread *.ASM,*.asm set ft=masm                             " masm filetype

"--------------------------------------------------
" PLUGIN SETTINGS
"--------------------------------------------------

" NerdTree 
let g:NERDTreeChDirMode = 1
let g:NERDTreeHijackNetrw = 1

" SuperTab
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabContextDefaultCompletionType = "<c-n>"

"--------------------------------------------------
" VIM SETTINGS
"--------------------------------------------------

syntax enable " syntax highlight enabled

set wildmenu       " Command line completion
set showcmd        " Show partial commands
set ignorecase     " Ignore case in searches...
set smartcase      " ... Except if uppercase
set autoindent     " If no indentation is specified, keep the indentation of the previous line
set laststatus=2   " Always display status line
set confirm        " If file must be saved to execute command, ask to the user insted of showing an error
set number         " Show line number
set cursorline
set incsearch
set hlsearch
set relativenumber " Show line numer in a relative fashion

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
map <F2> :call QuickfixToggle()<CR>
map <F5> :w<CR>:make<CR>
map <F6> :cprev<CR>
map <F7> :cnext<CR>
map <F12> mz<bar> gg=G'z 
map <C-p> "+p
map <C-c> "+y

" Commands
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>

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

" .swp in one folder
set directory=~/.vim/swap/

" Enable syntax completion
if exists("+omnifunc")
    setlocal omnifunc=syntaxcomplete#Complete
endif

command Todo noautocmd vimgrep /TODO\|FIXME/j ** | cw

"--------------------------------------------------
" GUI SETTINGS
"--------------------------------------------------

if (has('gui_running'))
    " Set font
    " TODO: check if font exists!
    set guifont=Droid\ Sans\ Mono\ Slashed\ for\ Powerline

    " Remove gvim GUI
    set guioptions-=m " Remove menu bar
    set guioptions-=T " Remove toolbar
    set guioptions-=r " Remove right-hand scroll bar
    set guioptions-=L " Remove left-hand scroll bar
    set guioptions+=c " Dialogs in prompt

    let base16colorspace=256
    colorscheme base16-ocean
else
    " Only set color scheme if terminal supports truecolor
    if $COLORTERM == 'truecolor'
        let base16colorspace=256
        colorscheme base16-ocean
    endif
endif

"-------------------------------------------------- 
" FUNCTIONS
"-------------------------------------------------- 

function ClearWhitespace()
    retab!
    %s/^\s*//ge
    %s/\s\s\+/ /ge
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
