let g:vhdl_indent_genportmap = 0

" Comment string
setlocal commentstring=--\ %s

" Xcelium/Incisive
set errorformat=%*[^\:]\:\ \*E\\,%*[^\ ]\ (%f\\,%l\|%c)\:\ %m

let b:ale_linters = ['cadence_make']
