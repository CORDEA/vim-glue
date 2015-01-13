" Vim indent file
" Language: GlueLang
" Maintainer: Yoshihiro Tanaka <feria.primavera@gmail.com>
" Last Change: 2015 Jan 13

if exists('b:did_indent')
    finish
endif
let b:did_indent=1

set comments=:#

setlocal noautoindent
setlocal indentexpr=GlueIndent(v:lnum)

setlocal indentkeys=0<Bar>,0?,0#,0=\,!^F,o,O

setlocal noexpandtab
setlocal softtabstop=8
setlocal tabstop=8
setlocal shiftwidth=8
    
function! GlueIndent(lnum)
    let lnum = prevnonblank(a:lnum - 1)
    if lnum == 0
        return -1
    endif
   
    let ind = indent(lnum)
    let lline = getline(lnum)
   
    if getline(prevnonblank(a:lnum)) =~# '^\t*|'
        if   getline(prevnonblank(a:lnum)) =~# '\w\+'
            return ind + &l:shiftwidth
        else
            return ind - &l:shiftwidth
        endif
    endif

    if     lline =~# '^\t*[?|]\{1}\s\+\w\+'
        return ind + &l:shiftwidth
    elseif lline =~# '\<proc\>\s\+\w\+\s\+=\s*'
        return ind + &l:shiftwidth
    elseif lline =~# '\s\+=\s\+\<do\>\s*$'
        return ind + &l:shiftwidth
    elseif lline =~# '\w\+\s\+\\\s*$'
        return ind + &l:shiftwidth/2
    elseif lline =~# '^\t\+\w\+'
        return ind
    elseif lline =~# '.\+'
        return ind
    endif

    return -1
endfunction
