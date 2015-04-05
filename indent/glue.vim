" Vim indent file
" Language: GlueLang
" Maintainer: Yoshihiro Tanaka <contact@cordea.jp>
" Last Change: 2015 Apr 5

if exists('b:did_indent')
    finish
endif
let b:did_indent=1

set comments=:#

setlocal noautoindent
setlocal indentexpr=GlueIndent(v:lnum)

setlocal indentkeys=0#,0=!>,0=\,!^F,o,O

setlocal expandtab
setlocal softtabstop=4
setlocal tabstop=4
setlocal shiftwidth=4
    
function! GlueIndent(lnum)
    let lnum = prevnonblank(a:lnum - 1)
    let nnum = prevnonblank(a:lnum)

    if lnum == 0
        return -1
    endif
   
    let defaultIndent  = &l:shiftwidth
    let diffIndent     = &l:shiftwidth * 2
    " line continuation
    let longLineIndent = &l:shiftwidth / 2
    let whereIndent    = 6 " len(where) + space

    let ind = indent(lnum)

    let lline = getline(lnum)
    let nline = getline(nnum)
   
    if nline =~# '^\s*\<!>\>\s*$'
        echo nline." : ".lline
        return ind - defaultIndent
    endif

    if     lline =~# '^\s*\<do\>\s*$' || lline =~# '^\s*\<!>\>\s\+.*\<do\>\s*$'
        return ind + defaultIndent
    elseif lline =~#  '^\s*\<proc\>\s\+\w\+\s\+=\s*'
        return CheckLine(nline, ind, defaultIndent)
    elseif lline =~# '^\s*\<diff\>\s\+\w\+\s\+\w\+\s*' 
        return CheckLine(nline, ind, diffIndent)
    elseif lline =~# '^\s\+\<where\>\s\+\w\+'
        return ind + whereIndent
    elseif lline =~# '\w\+\s\+\\\s*$'
        return ind + longLineIndent
    elseif lline =~# '^\s\+\w\+'
        return ind
    elseif lline =~# '.\+'
        return ind
    endif

    return -1
endfunction

function! CheckLine(nline, ind, addind)
    if a:nline =~# '^\s*#\s\+\w\+'
        return a:ind
    endif
    return a:ind + a:addind
endfunction
