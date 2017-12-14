" Author: Lucas Kolstad <lkolstad@uw.edu>
" Description: gcc linter for or1kasm files

let g:ale_or1kasm_gcc_options = get(g:, 'ale_asm_gcc_options', '-Wall')

function! ale_linters#or1kasm#gcc#GetCommand(buffer) abort
    return 'or1k-elf-gcc -x assembler -fsyntax-only '
    \    . '-iquote ' . ale#Escape(fnamemodify(bufname(a:buffer), ':p:h'))
    \    . ' ' . ale#Var(a:buffer, 'or1kasm_gcc_options') . ' -'
endfunction

function! ale_linters#or1kasm#gcc#Handle(buffer, lines) abort
    let l:pattern = '^.\+:\(\d\+\): \([^:]\+\): \(.\+\)$'
    let l:output = []

    for l:match in ale#util#GetMatches(a:lines, l:pattern)
        call add(l:output, {
        \ 'lnum': l:match[1] + 0,
        \ 'type': l:match[2] =~? 'error' ? 'E' : 'W',
        \ 'text': l:match[3],
        \})
    endfor

    return l:output
endfunction

call ale#linter#Define('or1kasm', {
\    'name': 'gcc',
\    'output_stream': 'stderr',
\    'executable': 'or1k-elf-gcc',
\    'command_callback': 'ale_linters#or1kasm#gcc#GetCommand',
\    'callback': 'ale_linters#or1kasm#gcc#Handle',
\})
