" VUNDLE {{{

set nocompatible " be iMproved
filetype off     " required!

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()
Plugin 'VundleVim/Vundle.vim'           " Package manager
Plugin 'scrooloose/nerdtree'            " IDE like File explorer
Plugin 'JPR75/vip'                      " VHDL entity/component/instance conversion
Plugin 'vim-scripts/a.vim'              " C++ swap .h/.cpp
Plugin 'sjl/badwolf'                    " Colorscheme
Plugin 'godlygeek/tabular'              " Text alignment util
Plugin 'tpope/vim-fugitive'             " Git integration
Plugin 'fatih/vim-go'                   " Go util bundle
Plugin 'Shougo/neocomplcache.vim'       " On-the-go autocompletion
if(v:version >= 740)
    Plugin 'Shougo/neosnippet'          " Snippets engine
    Plugin 'Shougo/neosnippet-snippets' " Snippets collection
endif
if(v:version >= 800)
    Plugin 'w0rp/ale'                   " Linting engine
endif
Plugin 'tpope/vim-commentary'           " Comments
filetype plugin indent on " required!

"}}}

" AUTO COMMANDS  {{{
 
autocmd GUIEnter * silent! lcd %:p:h                                           " Fix working dir when using GUI
autocmd FileType help wincmd L                                                 " Open new help window horizontally
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o " Disable auto comment insertion

" Cursor line highlight for selected window
augroup BgHighlight
    autocmd!
    autocmd WinEnter * set cul
    autocmd WinLeave * set nocul
augroup END

" }}}

" VIM SETTINGS {{{

syntax enable " syntax highlight enabled

set wildmenu       " Command line completion
set showcmd        " Show partial commands
set ignorecase     " Ignore case in searches...
set smartcase      " ... Except if uppercase
set autoindent     " If no indentation is specified, keep the indentation of the previous line
set laststatus=2   " Always display status line
set confirm        " If file must be saved to execute command, ask to the user insted of showing an error
set number         " Show line number
set cursorline     " Highlight cursor line
set incsearch      " Search as you type
set hlsearch       " Highlight search terms
set relativenumber " Show line numer in a relative fashion

" Indentation setting
set shiftwidth=4
set softtabstop=4
set expandtab

" Fix backspace
set backspace=2
set backspace=indent,eol,start

" Persistent undo
set undodir=~/.vim/undo/
set undofile
set undolevels=1000
set undoreload=10000

" .swp in one folder
set directory=~/.vim/swap/

" Folding
set foldmethod=indent   " fold based on indent level
set foldnestmax=10      " max 10 depth
set foldenable          " don't fold files by default on open
set foldlevelstart=10   " start with fold level of 1

" Enable syntax omnicompletion
if exists("+omnifunc")
    setlocal omnifunc=syntaxcomplete#Complete
endif
" }}}

" PLUGIN SETTINGS {{{

" Nerdtree
let g:NERDTreeChDirMode = 1
let g:NERDTreeHijackNetrw = 1

" Netwrst
let g:netrw_banner = 0
let g:netrw_liststyle = 1
let g:netrw_browse_split = 3
let g:netrw_altv = 1
let g:netrw_winsize = 20
let g:netrw_dirhistmax=0

" Neocomplcache/Neosnippets
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.python = '\h\w*\.\?'

let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_min_syntax_lenght = 3
set completeopt-=preview

inoremap <expr> <Tab> pumvisible() ? "\<Down>" : "\<Tab>"

if(v:version >= 740)
    imap <expr><CR> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-y>" : "\<CR>"
else
    inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
endif
    

" Ale
highlight clear ALEErrorLine " Don't highlight line
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_fixers = { 'python': ['autopep8']}

" }}}

" KEY MAPPINGS {{{

" Leader 
let mapleader="," " Leader

nnoremap <Leader><Tab> :NERDTreeToggle<CR>
nnoremap <leader>q :call QuickfixToggle()<CR> " Toggle quickfix window
nnoremap <leader>b :w<CR>:make<CR>            " Make
nnoremap <leader>a mz<bar> gg=G'z             " Indent all file
nnoremap <leader><space> :noh<CR>             " Clear search

" Sane line movement
nnoremap j  gj
nnoremap k  gk

" Arrow keys
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
nnoremap <Up> :<Up>
inoremap <Up> <Esc>:<Up>
nnoremap <Down> :
inoremap <Down> <Esc>:

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Others
nnoremap <F1> :NERDTreeToggle<CR>
inoremap <F1> <Nop>
" nmap K O<Esc>j      " Add line above
" nmap J o<Esc>k      " Add line below
nnoremap <Space> za " Open fold
nmap <C-n> :Cnext<CR>
nmap <C-p> :Cprev<CR>
" nnoremap <C-p> "+p
" imap <C-p> <C-o>"+p
" nnoremap <C-c> "+y
" imap <C-c> <C-o>"+y
nnoremap <silent> <leader>ev :e $MYVIMRC<CR>
nnoremap <silent> <leader>rv :so $MYVIMRC<CR>

" Commands
nnoremap ,cd :cd %:p:h<CR>:cwd<CR>

" Command shortcuts
cnoreabbrev <expr> te getcmdtype() == ":" && getcmdline() == 'te' ? 'tabedit' : 'te'

" Make Locationlist/Quickfix circular
command! Cnext try | cnext | catch | cfirst | catch | endtry
command! Cprev try | cprev | catch | clast | catch | endtry
command! Lnext try | lnext | catch | lfirst | catch | endtry
command! Lprev try | lprev | catch | llast | catch | endtry

command! Todo noautocmd vimgrep /TODO\|FIXME/j ** | cw

" }}} 

" GUI SETTINGS {{{

" Wrapper for main colorscheme configuration
function! SetColorScheme()
    colorscheme badwolf
endfunction

" Wrapper for fallback colorscheme configuration
function! SetFallbackCS()
    colorscheme murphy
endfunction

if (has('gui_running'))
    " Is GUI
    " Set font
    " TODO: check if font exists!
    set guifont=Droid\ Sans\ Mono\ Slashed\ for\ Powerline

    " Remove gvim GUI
    set guioptions-=m " Remove menu bar
    set guioptions-=T " Remove toolbar
    set guioptions-=r " Remove right-hand scroll bar
    set guioptions-=L " Remove left-hand scroll bar
    set guioptions+=c " Dialogs in prompt

    call SetColorScheme()
elseif ($COLORTERM == 'truecolor')
    " Terminal has truecolor mode
    call SetColorScheme()
    set termguicolors
else
    if(&t_Co == 256)
        call SetColorScheme()
    else
        call SetFallbackCS()
    endif
endif

" }}}

" FUNCTIONS {{{

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
