set nocompatible " be iMproved 
filetype off " required!

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()
Plugin 'VundleVim/Vundle.vim'       " Package manager
Plugin 'The-NERD-tree'              " File manager
Plugin 'JPR75/vip'                  " VHDL entity/component/instance conversion
Plugin 'vim-scripts/a.vim'          " C++ swap .h/.cpp
Plugin 'chriskempson/base16-vim'    " Colorscheme collection
Plugin 'godlygeek/tabular'          " Text alignment util
Plugin 'tpope/vim-fugitive'         " Git integration
Plugin 'fatih/vim-go'               " Go util bundle
Plugin 'Shougo/neocomplete.vim'     " On-the-go autocompletion
Plugin 'Shougo/neosnippet'          " Snippets engine
Plugin 'Shougo/neosnippet-snippets' " Snippets collection
Plugin 'w0rp/ale'                   " Linting engine
filetype plugin indent on " required!

"--------------------------------------------------
" AUTO COMMANDS
"--------------------------------------------------

autocmd GUIEnter * silent! lcd %:p:h                                           " Fix working dir when using GUI
autocmd FileType help wincmd L                                                 " Open new help window horizontally
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o " Disable auto comment insertion
autocmd BufNewFile,Bufread *.ASM,*.asm set ft=masm                             " masm filetype

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

" Make Locationlist/Quickfix circular
command! Cnext try | cnext | catch | cfirst | catch | endtry
command! Cprev try | cprev | catch | clast | catch | endtry
command! Lnext try | lnext | catch | lfirst | catch | endtry
command! Lprev try | lprev | catch | llast | catch | endtry

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Key mappings
nmap <leader>f :NERDTreeToggle<CR>
nmap <leader>q :call QuickfixToggle()<CR>
nmap <leader>b :w<CR>:make<CR>
nmap <C-n> :Cnext<CR>
nmap <C-N> :Cprev<CR>
nmap <leader>a mz<bar> gg=G'z 
" nmap <C-p> "+p
" imap <C-p> <C-o>"+p
" nmap <C-c> "+y
" imap <C-c> <C-o>"+y

" Commands
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>

" Command shortcuts
cnoreabbrev <expr> te getcmdtype() == ":" && getcmdline() == 'te' ? 'tabedit' : 'te'

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
" NOTE: useless with neocomplete
" if exists("+omnifunc")
"    setlocal omnifunc=syntaxcomplete#Complete
" endif

command Todo noautocmd vimgrep /TODO\|FIXME/j ** | cw

"--------------------------------------------------
" PLUGIN SETTINGS
"--------------------------------------------------

" NerdTree 
let g:NERDTreeChDirMode = 1
let g:NERDTreeHijackNetrw = 1

" Neocomplete
let g:neocomplete#enable_at_startup = 1
set completeopt-=preview

" Neosnippets
imap <expr><CR> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Tab> pumvisible() ? "\<Down>" : "\<Tab>"

" Ale
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1

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
    colorscheme base16-monokai
else
    let base16colorspace=256
    colorscheme base16-monokai
    set termguicolors
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
