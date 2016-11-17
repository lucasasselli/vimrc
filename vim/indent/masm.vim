" Vim indent file
" Language: MASM
" Maintainer: Luca Sasselli
" Latest Revision: 2016-10-20

if exists("b:did_indent")
    finish
endif
let b:did_indent = 1

setlocal indentexpr=GetMasmIndent()
setlocal indentkeys+==AAA,=AAD,=AAM,=AAS,=ADC,=ADD,=AND,=CALL,=CBW,=CLC,=CLD,=CLI,=CMC,=CMP,=CMPSB,=CMPSW,=CWD,=DAA,=DAS,=DEC,=DIV,=HLT,=IDIV,=IMUL,=IN,=INC,=INT,=INTO,=IRET,=JA,=JAE,=JB,=JBE,=JC,=JCXZ,=JE,=JG,=JGE,=JL,=JLE,=JMP,=JNA,=JNAE,=JNB,=JNBE,=JNC,=JNE,=JNG,=JNGE,=JNL,=JNLE,=JNO,=JNP,=JNS,=JNZ,=JO,=JP,=JPE,=JPO,=JS,=JZ,=LAHF,=LDS,=LEA,=LES,=LODSB,=LODSW,=LOOP,=LOOPE,=LOOPNE,=LOOPNZ,=LOOPZ,=MOV,=MOVSB,=MOVSW,=MUL,=NEG,=NOP,=NOT,=OR,=OUT,=POP,=POPA,=POPF,=PUSH,=PUSHA,=PUSHF,=RCL,=RCR,=REP,=REPE,=REPNE,=REPNZ,=REPZ,=RET,=RETF,=ROL,=ROR,=SAHF,=SAL,=SAR,=SBB,=SCASB,=SCASW,=SHL,=SHR,=STC,=STD,=STI,=STOSB,=STOSW,=SUB,=TEST,=XCHG,=XLATB,=XOR

if exists("*GetMasmIndent")
    finish
endif

let s:cpo_save = &cpo
set cpo&vim

function GetMasmIndent()

    let instr_list = ['AAA', 'AAD', 'AAM', 'AAS', 'ADC', 'ADD', 'AND', 'CALL', 'CBW', 'CLC', 'CLD', 'CLI', 'CMC', 'CMP', 'CMPSB', 'CMPSW', 'CWD', 'DAA', 'DAS', 'DEC', 'DIV', 'HLT', 'IDIV', 'IMUL', 'IN', 'INC', 'INT', 'INTO', 'IRET', 'JA', 'JAE', 'JB', 'JBE', 'JC', 'JCXZ', 'JE', 'JG', 'JGE', 'JL', 'JLE', 'JMP', 'JNA', 'JNAE', 'JNB', 'JNBE', 'JNC', 'JNE', 'JNG', 'JNGE', 'JNL', 'JNLE', 'JNO', 'JNP', 'JNS', 'JNZ', 'JO', 'JP', 'JPE', 'JPO', 'JS', 'JZ', 'LAHF', 'LDS', 'LEA', 'LES', 'LODSB', 'LODSW', 'LOOP', 'LOOPE', 'LOOPNE', 'LOOPNZ', 'LOOPZ', 'MOV', 'MOVSB', 'MOVSW', 'MUL', 'NEG', 'NOP', 'NOT', 'OR', 'OUT', 'POP', 'POPA', 'POPF', 'PUSH', 'PUSHA', 'PUSHF', 'RCL', 'RCR', 'REP', 'REPE', 'REPNE', 'REPNZ', 'REPZ', 'RET', 'RETF', 'ROL', 'ROR', 'SAHF', 'SAL', 'SAR', 'SBB', 'SCASB', 'SCASW', 'SHL', 'SHR', 'STC', 'STD', 'STI', 'STOSB', 'STOSW', 'SUB', 'TEST', 'XCHG', 'XLATB', 'XOR']

    let ind = 0
    let line = getline(v:lnum)

    for instr in instr_list
        let query = '^\s*' . instr . '\s'
        if line =~ query
                    \ || line=~ '^\s*\.'
            let ind = &sw
            break
        endif
    endfor

    return ind
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save
