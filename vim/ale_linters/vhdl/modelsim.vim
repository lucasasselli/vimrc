" Author: Luca Sasselli
" Description: Modelsim vcom linter for vhdl

let g:ale_vhdl_modelsim_options = get(g:, 'ale_vhdl_modelsim_options', '')

function! ale_linters#vhdl#modelsim#GetCommand(buffer) abort
    return 'vcom -work /tmp/vcom_lint/'
    \    . ' ' . ale#Escape(bufname(a:buffer))
    \    . ' ' . ale#Var(a:buffer, 'vhdl_modelsim_options')
endfunction

function! ale_linters#vhdl#modelsim#Handle(buffer, lines) abort
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

call ale#linter#Define('vhdl', {
\    'name': 'modelsim',
\    'output_stream': 'stdout',
\    'executable': 'vcom',
\    'command_callback': 'ale_linters#vhdl#modelsim#GetCommand',
\    'callback': 'ale_linters#vhdl#modelsim#Handle',
\})
