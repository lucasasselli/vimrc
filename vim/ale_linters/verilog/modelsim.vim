" Author: Luca Sasselli
" Description: Modelsim vcom linter for verilog

let g:ale_verilog_modelsim_options = get(g:, 'ale_verilog_modelsim_options', '')

function! ale_linters#verilog#modelsim#GetCommand(buffer) abort
    return 'vlog -work /tmp/vcom_lint/'
    \    . ' ' . ale#Escape(bufname(a:buffer))
    \    . ' ' . ale#Var(a:buffer, 'verilog_modelsim_options')
endfunction

function! ale_linters#verilog#modelsim#Handle(buffer, lines) abort
    let l:pattern = '^** \([^:]\+\): [^(]\+(\(\d\+\)): \(.\+\)$'
    let l:output = []

    for l:match in ale#util#GetMatches(a:lines, l:pattern)
        call add(l:output, {
        \ 'lnum': l:match[2] + 0,
        \ 'type': l:match[1] =~? 'Error' ? 'E' : 'W',
        \ 'text': l:match[3],
        \})
    endfor

    return l:output
endfunction

call ale#linter#Define('verilog', {
\    'name': 'modelsim',
\    'output_stream': 'stdout',
\    'executable': 'vlog',
\    'command_callback': 'ale_linters#verilog#modelsim#GetCommand',
\    'callback': 'ale_linters#verilog#modelsim#Handle',
\})
