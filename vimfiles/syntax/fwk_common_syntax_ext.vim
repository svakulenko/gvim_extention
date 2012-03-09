if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

hi BracesVague gui=bold guifg=tomato3
hi BracesRond gui=bold guifg=goldenrod3
hi BracesCarre gui=bold guifg=goldenrod4







"highligh braces
syn match       BracesVague         "[{}]"
syn match       BracesRond          "[()]"
syn match       BracesCarre         "[[]]"

" Highlight Class and Function names
syn match    cCustomFunc     "\w\+\s*(" contains=BracesVague,BracesRond,BracesCarre
hi def link cCustomFunc  Function

