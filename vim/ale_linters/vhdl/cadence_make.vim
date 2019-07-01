" Author: Luca Sasselli
" Description: Cadence make linter for vhdl

let g:ale_vhdl_cadence_make_options = get(g:, 'ale_vhdl_cadence_make_options', '')

function! ale_linters#vhdl#cadence_make#GetCommand(buffer) abort
   return 'make -C ' . getcwd()
endfunction

function! ale_linters#vhdl#cadence_make#Handle(buffer, lines) abort
    " let l:pattern = '[^:]\+: \*\(.\).[^ ]\+ (\([^,]\+\).\([^|]\+\)|\([^)]\+\)): \(.\+\)'
    let l:pattern = '[^:]\+: \*E.[^ ]\+ (\([^,]\+\).\([^|]\+\)|\([^)]\+\)): \(.\+\)'

    let l:output = []

    for l:match in ale#util#GetMatches(a:lines, l:pattern)
        call add(l:output, {
        \ 'filename': l:match[1],
        \ 'lnum': l:match[2] + 0,
        \ 'col': l:match[3] + 0,
        \ 'text': l:match[4],
        \})
    endfor

    return l:output
endfunction

call ale#linter#Define('vhdl', {
\    'name': 'cadence_make',
\    'output_stream': 'stdout',
\    'executable': 'make',
\    'command_callback': 'ale_linters#vhdl#cadence_make#GetCommand',
\    'callback': 'ale_linters#vhdl#cadence_make#Handle',
\})
