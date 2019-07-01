let g:verilog_syntax_fold_lst="function,class,task"
let g:verilog_disable_indent_lst = "preproc,module"

" Xcelium/Incisive
set errorformat=%*[^\:]\:\ \*E\\,%*[^\ ]\ (%f\\,%l\|%c)\:\ %m

let b:ale_linters = ['cadence_make']
