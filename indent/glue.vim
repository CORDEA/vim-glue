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

    let pind = indent(lnum)
    let pline = getline(lnum)
    let cline = getline(a:lnum)
   
    if cline =~# '^\s*\<!>\>\s*$'
        return pind - &sw
    endif

    if pline =~# '^\s*\<do\>\s*$' || pline =~# '^\s*\<!>\>\s\+.*\<do\>\s*$'
        return pind + &sw
    elseif pline =~# '^\s\+\<where\>\s\+\w\+'
        return pind + &sw
    elseif pline =~# '^\s*\<while\>\s*$' || pline =~# '^.\+\s\+\<foreach\>\s*$'
        return pind + &sw
    elseif pline =~# '^\s*\<proc\>\s\+\w\+\s\+=\s*'
        return CheckLine(cline, pind, defaultIndent)
    elseif pline =~# '^\s*\<diff\>\s\+\w\+\s\+\w\+\s*'
        return CheckLine(cline, pind, diffIndent)
    elseif pline =~# '\w\+\s\+\\\s*$'
        return pind + &sw
    endif

    return -1
endfunction

function! CheckLine(cline, ind, addind)
    if a:cline =~# '^\s*#\s\+\w\+'
        return a:ind
    endif
    return a:ind + a:addind
endfunction
