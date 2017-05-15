" Indentation settings
set shiftwidth=8
set softtabstop=8

" Highlight
let g:go_highlight_functions = 1  
let g:go_highlight_methods = 1  
let g:go_highlight_structs = 1  
let g:go_highlight_operators = 1  
let g:go_highlight_build_constraints = 1

" Shortcuts
autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>d  <Plug>(go-doc)
autocmd FileType go nmap <leader>l  <Plug>(go-lint)

" Other
let g:go_fmt_autosave = 0 " Disable fmt on save
