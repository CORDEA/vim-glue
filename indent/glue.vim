" Vim indent file
" Language: GlueLang
" Maintainer: Yoshihiro Tanaka <contact@cordea.jp>
" Last Change: 2015 Apr 5

if exists('b:did_indent')
    finish
endif
let b:did_indent=1

set comments=:#

setlocal nolisp
setlocal autoindent

setlocal indentexpr=GlueIndent(v:lnum)
setlocal indentkeys=0#,0=!>,0=\,!^F,o,O

function! GlueIndent(lnum)
    let lnum = prevnonblank(a:lnum - 1)

    if lnum == 0
        return -1
    endif

    let defaultIndent  = &l:shiftwidth

    let ind = indent(lnum)
    let lline = getline(lnum)
    let nline = getline(a:lnum)
   
    if nline =~# '^\s*\<!>\>\s*$'
        return ind - defaultIndent
    endif

    if lline =~# '^\s*\<do\>\s*$' || lline =~# '^\s*\<!>\>\s\+.*\<do\>\s*$'
        return ind + defaultIndent
    elseif lline =~# '^\s\+\<where\>\s\+\w\+'
        return ind + defaultIndent
    elseif lline =~# '^\s*\<while\>\s*$' || lline =~# '^.\+\s\+\<foreach\>\s*$'
        return ind + defaultIndent
    elseif lline =~# '^\s*\<proc\>\s\+\w\+\s\+=\s*'
        return CheckLine(nline, ind, defaultIndent)
    elseif lline =~# '^\s*\<diff\>\s\+\w\+\s\+\w\+\s*' 
        return CheckLine(nline, ind, diffIndent)
    elseif lline =~# '\w\+\s\+\\\s*$'
        return ind + defaultIndent
    endif

    return -1
endfunction

function! CheckLine(nline, ind, addind)
    if a:nline =~# '^\s*#\s\+\w\+'
        return a:ind
    endif
    return a:ind + a:addind
endfunction
