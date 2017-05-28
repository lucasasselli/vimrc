" Vim filetype plugin file
" Language:         Tcl (dc_shell)

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

" Make sure the continuation lines below do not cause problems in
" compatibility mode.
let s:cpo_save = &cpo
set cpo-=C

setlocal comments=:#
setlocal commentstring=#%s
setlocal formatoptions+=croql

" Change the browse dialog on Windows to show mainly Tcl-related files
if has("gui_win32")
    let b:browsefilter = "Tcl Source Files (.tcl)\t*.tcl\n" .
                \ "Tcl Test Files (.test)\t*.test\n" .
                \ "All Files (*.*)\t*.*\n"
endif

"-----------------------------------------------------------------------------

" Undo the stuff we changed.
let b:undo_ftplugin = "setlocal fo< com< cms< inc< inex< def< isf< kp<" .
	    \	      " | unlet! b:browsefilter"

" Restore the saved compatibility options.
let &cpo = s:cpo_save
unlet s:cpo_save

if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns.dctl = '[.-]\h\w*\|\h\w*'

" vim: set et ts=4 sw=4 tw=78:
