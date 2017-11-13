" Vim indent file
" Language: Open RISC 1200 Asm
" Maintainer: Luca Sasselli
" Latest Revision: 2016-10-20

if exists("b:did_indent")
    finish
endif
let b:did_indent = 1

setlocal indentexpr=GetOR1KAsmIndent()
setlocal indentkeys+==l.,=lf.

if exists("*GetOr1kAsmIndent")
    finish
endif

let s:cpo_save = &cpo
set cpo&vim

function GetOR1KAsmIndent()

    let instr_list = ['l\.', 'lf\.']

    let ind = 0
    let line = getline(v:lnum)

    for instr in instr_list
        let query = '^\s*' . instr . '.*'
        if line =~ query || line=~ '^\s*\.'
            let ind = &sw
            break
        endif
    endfor

    return ind
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save
