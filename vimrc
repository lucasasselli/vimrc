set nocompatible " be iMproved

" OS-dependent
if has('win32') || has ('win64')
    let $VIMHOME = $HOME."/vimfiles"
else
    let $VIMHOME = $HOME."/.vim"
endif

" PLUGIN {{{

silent! call plug#begin('~/.vim/plugged')
Plug 'godlygeek/tabular'              " Text alignment util
Plug 'tpope/vim-commentary'           " Insert comments
Plug 'tpope/vim-abolish'              " Naming converter
Plug 'christoomey/vim-tmux-navigator' " Tmux navigation integration
Plug 'vhda/verilog_systemverilog.vim' " Language: SystemVerilog
Plug 'junegunn/fzf'                   " Fuzzy file finder
Plug 'junegunn/fzf.vim'

if(v:version >= 800)
    Plug 'w0rp/ale'                   " Linting engine
endif
call plug#end()

" ALE
let g:ale_fix_on_save = 1                   " Only lint on save
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0

let g:ale_set_loclist = 0                   " Use quick fix window
let g:ale_set_quickfix = 1

let g:ale_open_list = 1                     " Open quick fix window
let g:ale_keep_list_window_open = 1

let g:ale_sign_error = '>>'                 " Ale error/Warning symbol
let g:ale_sign_warning = '--'

" }}}

" VIM SETTINGS {{{

filetype plugin indent on 
syntax enable             " syntax highlight enabled

set wildmenu              " Command line completion
set showcmd               " Show partial commands
set ignorecase            " Ignore case in searches...
set smartcase             " ... Except if uppercase
set autoindent            " If no indentation is specified, keep the indentation of the previous line
set laststatus=2          " Always display status line
set confirm               " If file must be saved to execute command, ask to the user insted of showing an error
set number                " Show line number
" set cursorline            " Highlight cursor line
" set incsearch             " Search as you type
set hlsearch              " Highlight search terms
set relativenumber        " Show line numer in a relative fashion
set mouse=niv             " Mouse enable in normal mode
set tabpagemax=100        " Maximum number of tabs
set autoread              " Reload the file if modified
set clipboard=unnamedplus " Use sytem clipboard
set ruler                 " Show cursor position in the status line
set noerrorbells          " Don't beep
set visualbell            

" Indentation setting
set shiftwidth=4
set softtabstop=4
set expandtab

" Fix backspace
set backspace=2
set backspace=indent,eol,start

" Persistent undo
set undodir=$VIMHOME/undo/
set undofile
set undolevels=1000
set undoreload=10000

" .swp in one folder
set directory=$VIMHOME/swap/

" Folding
set foldmethod=marker
set foldcolumn=3
set foldnestmax=10      " max 10 depth
set foldenable          " don't fold files by default on open
set foldlevel=0

" Completion
set shortmess+=c          " Shut off completion messages
set completeopt+=menuone  " Show menu even if only one result
set completeopt+=noselect " Don't select a result
if exists("+omnifunc")
    setlocal omnifunc=syntaxcomplete#Complete " Enable syntax omnicompletion
endif

" Netrw
let g:netrw_banner=0
let g:netrw_winsize = -25
let g:netrw_hide = 1

" Colorscheme
colorscheme desert

if (has('gui_running'))
    " Remove gvim GUI
    set guioptions-=m " Remove menu bar
    set guioptions-=T " Remove toolbar
    set guioptions-=r " Remove right-hand scroll bar
    set guioptions-=L " Remove left-hand scroll bar
    set guioptions+=c " Dialogs in prompt
endif

" Search tags file in parent folder
set tags=./tags;

" The Silver Searcher
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor\ --follow
endif

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" }}}

" KEY MAPPINGS {{{

" Leader 
let mapleader=","                             " Leader

nnoremap <leader>b :make<CR>                  " Make
nnoremap <leader>a mz<bar> gg=G'z             " Indent all file
nnoremap <leader><space> :noh<CR>             " Clear search
nnoremap <leader>t :tabe<CR>                  " New tab
nnoremap <leader>q :call QuickfixToggle()<CR>
nnoremap <silent> <leader>ev :e $MYVIMRC<CR>
nnoremap <silent> <leader>rv :so $MYVIMRC<CR>

" Sane line movement
nnoremap j gj
vnoremap j gj
nnoremap k gk
vnoremap k gk

" Tab navigation
nnoremap L  :tabnext<CR>
nnoremap H  :tabprev<CR>

" Fast split navigation
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>

" Fast indentation
noremap > >>
noremap < <<
vnoremap > >gv
vnoremap < <gv

" Others
nnoremap <Space> za       " Open fold
nnoremap <C-n> :Cnext<CR> " Next error
nnoremap <C-N> :Cprev<CR> " Prev error

" Special char shortcuts
inoremap <F5> `
inoremap <F6> ~

" Disable ex-mode
nmap Q <nop> 
" }}} 

" COMMANDS {{{

" View Hex
command! Hex %!xxd

" Search TODO in sub-folders (Slow)
command! Todo noautocmd vimgrep /TODO\|FIXME/j ** | cw

" Make Locationlist/Quickfix circular
command! Cnext try | cnext | catch | cfirst | catch | endtry
command! Cprev try | cprev | catch | clast | catch | endtry
command! Lnext try | lnext | catch | lfirst | catch | endtry
command! Lprev try | lprev | catch | llast | catch | endtry

"}}}

" OTHER {{{

" Open help horizontally
autocmd FileType help wincmd L

function! ClearWhitespace()
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

" }}}

" vim:ft=vim fdm=marker fdl=0
