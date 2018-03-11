" PLUGIN {{{

set nocompatible " be iMproved
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'            " IDE like File explorer
Plug 'JPR75/vip'                      " VHDL entity/component/instance conversion
Plug 'vim-scripts/a.vim'              " C++ swap .h/.cpp
Plug 'sjl/badwolf'                    " Colorscheme
Plug 'godlygeek/tabular'              " Text alignment util
" Plug 'tpope/vim-fugitive'             " Git integration
Plug 'fatih/vim-go'                   " Go util bundle
let neocompleteok = 0
if(v:version >= 740)
    let neocompleteok = 1
    Plug 'Shougo/neocomplete.vim'     " On-the-go autocompletion
    Plug 'Shougo/neco-vim'            " Vim syntax completion
    Plug 'Shougo/neosnippet'          " Snippets engine
    Plug 'Shougo/neosnippet-snippets' " Snippets collection
    Plug 'davidhalter/jedi-vim'
endif
if(v:version >= 800)
    Plug 'w0rp/ale'                   " Linting engine
endif
Plug 'tpope/vim-commentary'           " Comments
Plug 'majutsushi/tagbar' 
" Plug 'Yggdroot/indentLine' 
Plug 'christoomey/vim-tmux-navigator'
Plug 'lervag/vimtex'
Plug 'rhysd/vim-grammarous'
" Plug 'itchyny/lightline.vim'
call plug#end()
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

filetype plugin indent on 
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
set mouse=a        " Enable better mouse support

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
set foldmethod=indent
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

" Tagbar
let g:tagbar_autofocus = 1
let g:tagbar_width = 30

" Netwrst
let g:netrw_banner = 0
let g:netrw_liststyle = 1
let g:netrw_browse_split = 3
let g:netrw_altv = 1
let g:netrw_winsize = 20
let g:netrw_dirhistmax=0

" Jedi
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0

" Neocomplete
set completeopt-=preview
if (neocompleteok)
    let g:neocomplete#enable_at_startup = 1                 " Enable Neocomplete
    let g:neocomplete#enable_smart_case = 1                 " Enable smart-case
    let g:neocomplete#sources#syntax#min_keyword_length = 3 " Keyword length

    " Define keyword.
    if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns['default'] = '\h\w*'

    if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
    endif

    let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
    let g:neocomplete#force_omni_input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::' 

    " Plugin key-mappings.
    inoremap <expr><C-g>     neocomplete#undo_completion()
    inoremap <expr><C-l>     neocomplete#complete_common_string()

    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
    " inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

    imap <expr><CR> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-y>" : "\<CR>"
endif

" Ale
highlight clear ALEErrorLine " Don't highlight line
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_fixers = { 'python': ['autopep8']}
let g:ale_python_flake8_options = '--max-line-length=180'
let g:ale_python_autopep8_options = '--max-line-length=180'

" Grammarous
let g:grammarous#use_vim_spelllang = 0
let g:grammarous#enable_spell_check = 0

let g:grammarous#hooks = {}
function! g:grammarous#hooks.on_check(errs) abort
    nmap <buffer><C-n> <Plug>(grammarous-move-to-next-error)
    nmap <buffer><C-p> <Plug>(grammarous-move-to-previous-error)
endfunction

function! g:grammarous#hooks.on_reset(errs) abort
    nunmap <buffer><C-n>
    nunmap <buffer><C-p>
endfunction

" }}}

" KEY MAPPINGS {{{

" Leader 
let mapleader="," " Leader
nnoremap <Leader><Tab> :NERDTreeToggle<CR>
nnoremap <leader>q :call QuickfixToggle()<CR> " Toggle quickfix window
nnoremap <leader>b :w<CR>:make<CR>            " Make
nnoremap <leader>a mz<bar> gg=G'z             " Indent all file
nnoremap <leader><space> :noh<CR>             " Clear search
nnoremap <leader>f :ALEFix<CR>                " ALEfix
nnoremap <leader>t :tabnew<CR>                " Tab new
nnoremap <leader>gc :GrammarousCheck<CR>
nnoremap <leader>gr <Plug>(grammarous-reset)
nnoremap <leader>gf <Plug>(grammarous-fixit)

" Sane line movement
nnoremap j gj
vnoremap j gj
nnoremap k gk
vnoremap k gk

" Fast split navigation
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>

" Tab movement
nnoremap <Left> :tabprevious<CR>
nnoremap <Right> :tabnext<CR>

" Arrow keys
nnoremap <Up> :<Up>
inoremap <Up> <Esc>:<Up>
nnoremap <Down> :
inoremap <Down> <Esc>:

" Others
nnoremap <F1> :NERDTreeToggle<CR>
inoremap <F1> <Esc>:NERDTreeToggle<CR>
nnoremap <F2> :TagbarToggle<CR>
nnoremap <Space> za " Open fold
nmap <C-n> :Cnext<CR>
nmap <C-m> :Cprev<CR>
" nnoremap <c-p> "+p  " xterm paste
" imap <c-p> <c-o>"+p 
" nnoremap <c-c> "+y  " xterm copy
" imap <c-c> <c-o>"+y
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
