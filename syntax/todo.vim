" File:        todo.txt.vim
" Description: Todo.txt syntax settings
" Author:      Leandro Freitas <freitass@gmail.com>
" License:     Vim license
" Website:     http://github.com/freitass/todo.txt-vim
" Version:     0.3

if exists("b:current_syntax")
    finish
endif

syntax  match  TodoDone       '^[xX]\s.\+$'
syntax  match  TodoPriorityA  '^([aA])\s.\+$'             contains=TodoDate,TodoProject,TodoContext,OverDueDate
syntax  match  TodoPriorityB  '^([bB])\s.\+$'             contains=TodoDate,TodoProject,TodoContext,OverDueDate
syntax  match  TodoPriorityC  '^([cC])\s.\+$'             contains=TodoDate,TodoProject,TodoContext,OverDueDate
syntax  match  TodoPriorityD  '^([dD])\s.\+$'             contains=TodoDate,TodoProject,TodoContext,OverDueDate
syntax  match  TodoPriorityE  '^([eE])\s.\+$'             contains=TodoDate,TodoProject,TodoContext,OverDueDate
syntax  match  TodoPriorityF  '^([fF])\s.\+$'             contains=TodoDate,TodoProject,TodoContext,OverDueDate
syntax  match  TodoPriorityG  '^([gG])\s.\+$'             contains=TodoDate,TodoProject,TodoContext,OverDueDate
syntax  match  TodoPriorityH  '^([hH])\s.\+$'             contains=TodoDate,TodoProject,TodoContext,OverDueDate
syntax  match  TodoPriorityI  '^([iI])\s.\+$'             contains=TodoDate,TodoProject,TodoContext,OverDueDate
syntax  match  TodoPriorityJ  '^([jJ])\s.\+$'             contains=TodoDate,TodoProject,TodoContext,OverDueDate
syntax  match  TodoPriorityK  '^([kK])\s.\+$'             contains=TodoDate,TodoProject,TodoContext,OverDueDate
syntax  match  TodoPriorityL  '^([lL])\s.\+$'             contains=TodoDate,TodoProject,TodoContext,OverDueDate
syntax  match  TodoPriorityM  '^([mM])\s.\+$'             contains=TodoDate,TodoProject,TodoContext,OverDueDate
syntax  match  TodoPriorityN  '^([nN])\s.\+$'             contains=TodoDate,TodoProject,TodoContext,OverDueDate
syntax  match  TodoPriorityO  '^([oO])\s.\+$'             contains=TodoDate,TodoProject,TodoContext,OverDueDate
syntax  match  TodoPriorityP  '^([pP])\s.\+$'             contains=TodoDate,TodoProject,TodoContext,OverDueDate
syntax  match  TodoPriorityQ  '^([qQ])\s.\+$'             contains=TodoDate,TodoProject,TodoContext,OverDueDate
syntax  match  TodoPriorityR  '^([rR])\s.\+$'             contains=TodoDate,TodoProject,TodoContext,OverDueDate
syntax  match  TodoPriorityS  '^([sS])\s.\+$'             contains=TodoDate,TodoProject,TodoContext,OverDueDate
syntax  match  TodoPriorityT  '^([tT])\s.\+$'             contains=TodoDate,TodoProject,TodoContext,OverDueDate
syntax  match  TodoPriorityU  '^([uU])\s.\+$'             contains=TodoDate,TodoProject,TodoContext,OverDueDate
syntax  match  TodoPriorityV  '^([vV])\s.\+$'             contains=TodoDate,TodoProject,TodoContext,OverDueDate
syntax  match  TodoPriorityW  '^([wW])\s.\+$'             contains=TodoDate,TodoProject,TodoContext,OverDueDate
syntax  match  TodoPriorityX  '^([xX])\s.\+$'             contains=TodoDate,TodoProject,TodoContext,OverDueDate
syntax  match  TodoPriorityY  '^([yY])\s.\+$'             contains=TodoDate,TodoProject,TodoContext,OverDueDate
syntax  match  TodoPriorityZ  '^([zZ])\s.\+$'             contains=TodoDate,TodoProject,TodoContext,OverDueDate

syntax  match  TodoDate       '\d\{2,4\}-\d\{2\}-\d\{2\}' contains=NONE
syntax  match  TodoProject    '\(^\|\W\)+[^[:blank:]]\+'  contains=NONE
syntax  match  TodoContext    '\(^\|\W\)@[^[:blank:]]\+'  contains=NONE

" Other priority colours might be defined by the user
highlight  default  link  TodoDone       Comment
highlight  default  link  TodoPriorityA  Constant
highlight  default  link  TodoPriorityB  Statement
highlight  default  link  TodoPriorityC  Identifier
highlight  default  link  TodoDate       PreProc
highlight  default  link  TodoProject    Special
highlight  default  link  TodoContext    Special

if exists('g:todo_load_python') && g:todo_load_python
    if has('python')
        let b:curdir = expand('<sfile>:p:h')
        let s:script_dir = b:curdir . "/python/"
        execute "pyfile " . s:script_dir. "todo.py"
    elseif has('python3')
        let b:curdir = expand('<sfile>:p:h')
        let s:script_dir = b:curdir . "/python/"
        execute "py3file " . s:script_dir. "todo.py"
    else
        echom "Your version of vim has no python support. Overdue dates won't be highlighted"
    endif
endif

" Lifted from https://github.com/plasticboy/vim-markdown/blob/master/syntax/markdown.vim
let s:conceal = ''
let s:concealends = ''
if has('conceal')
  let s:conceal = ' conceal'
  let s:concealends = ' concealends'
endif

hi default link TodoInlineURL Underlined
hi default link TodoURL Underlined
hi default link TodoDelimiter NonText
hi default link TodoLink Special
hi default link mkdLink Special

" Autolink without angle brackets
syn match  TodoInlineURL /https\?:\/\/\(\w\+\(:\w\+\)\?@\)\?\([A-Za-z0-9][-_0-9A-Za-z]*\.\)\{1,}\(\w\{2,}\.\?\)\{1,}\(:[0-9]\{1,5}\)\?[^] \t]*/
" Autolink with parenthesis
syn region TodoInlineURL matchgroup=TodoDelimiter start="(\(https\?:\/\/\(\w\+\(:\w\+\)\?@\)\?\([A-Za-z0-9][-_0-9A-Za-z]*\.\)\{1,}\(\w\{2,}\.\?\)\{1,}\(:[0-9]\{1,5}\)\?[^] \t]*)\)\@=" end=")"
" Autolink with angle brackets
syn region TodoInlineURL matchgroup=TodoDelimiter start="\\\@<!<\ze[a-z][a-z0-9,.-]\{1,22}:\/\/[^> ]*>" end=">"

" [link](url)
execute 'syn region TodoLink matchgroup=TodoDelimiter  start="\\\@<!!\?\[\ze[^]\n]*\n\?[^]\n]*\][[(]" end="\]" contains=@TodoNonListItem,@Spell nextgroup=TodoURL,TodoID skipwhite' . s:concealends
execute 'syn region TodoID matchgroup=TodoDelimiter    start="\["    end="\]" contained oneline' . s:conceal
execute 'syn region TodoURL matchgroup=TodoDelimiter   start="("     end=")"  contained oneline' . s:conceal
execute 'syn region TodoLink matchgroup=TodoDelimiter  start="\\\@<!!\?\[\ze[^]\n]*\n\?[^]\n]*\][[(]" end="\]" contains=@TodoNonListItem,@Spell nextgroup=TodoURL,TodoID skipwhite' . s:concealends

let b:current_syntax = "todo"
