" Vim syntax file
" Language: GlueLang
" Maintainer: Yoshihiro Tanaka <feria.primavera@gmail.com>
" Last Change: 2015 Jan 18

if exists("b:current_syntax")
    finish
endif

syntax case match

setlocal iskeyword+=? 
setlocal iskeyword+=\| 
setlocal iskeyword+=> 
setlocal iskeyword+== 

syntax keyword glueImport import
syntax keyword glueType str file diff
syntax keyword glueStatement ? \| as do
syntax keyword glueSpecial where
syntax keyword gluePipe >>=
syntax keyword glueAnd >>

syntax region glueString start=/'/ end=/'/
syntax region glueFunction matchgroup=glueFunctionStatement start=/\<proc\>\s\+/ matchgroup=null end=/\s\+=/
syntax region glueArg matchgroup=null start=/\<argv\>\[/ end=/\]/

syntax match glueComment /#.*/
syntax match glueNumber /'[0-9]\+'/

highlight link glueImport Include
highlight link glueType Include
highlight link glueStatement Statement
highlight link glueFunctionStatement Statement
highlight link glueComment Comment
highlight link glueString String
highlight link glueSpecial Special
highlight link glueNumber Number
highlight link glueArg Number
highlight link gluePipe Operator
highlight link glueAnd Operator
highlight link glueFunction Function
