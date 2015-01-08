" Vim syntax file
" Language: GlueLang
" Maintainer: Yoshihiro Tanaka <feria.primavera@gmail.com>
" Last Change: 2015 Jan 8

if exists("b:current_syntax")
    finish
endif

syntax case match

setlocal iskeyword+=? 
setlocal iskeyword+=\| 
setlocal iskeyword+=> 
setlocal iskeyword+== 

syntax keyword glueImport import
syntax keyword glueStatement ? \| as do case of
syntax keyword gluePipe >>=

syntax region glueString start=/'/ end=/'/

syntax match glueComment /#.*/
syntax match glueNumber /'[0-9]'/

highlight link glueImport Include
highlight link glueStatement Statement
highlight link glueComment Comment
highlight link glueString String
highlight link glueNumber Number
highlight link gluePipe Operator
