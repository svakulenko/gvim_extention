if version < 600
  syntax clear
"elseif exists("b:current_syntax")
  "finish
endif

if filereadable($VIMRUNTIME . '/syntax/conf.vim')
    source $VIMRUNTIME/syntax/conf.vim




"SYNTAX COLOR
"--------------------------------------------------------------------
hi FWK_Note_Col_SpecialWord_Comment         guifg=SkyBlue
hi FWK_Note_Col_SpecialWord_All             guifg=tomato2
hi FWK_Note_Col_SpecialWord_Example         guifg=LightSalmon3
"SYNTAX CONSTRUCTS
"--------------------------------------------------------------------
syn match FWK_Note_Syn_SpecialWord_All          "\(Section\|Sub\ Section\|Note\|Tips\|Definition\|Def\|Question\|Answer\): "
syn match FWK_Note_Syn_SpecialWord_Example      "\(Example\|Code\|Resource\|HomeWork\):"
"syn cluster Comment contains=FWK_Note_Syn_SpecialWord_SpecialWords
syn match FWK_Note_Syn_SpecialWord_Comment     "^#.*$"       contains=FWK_Note_Syn_SpecialWord_All,FWK_Note_Syn_SpecialWord_Example


"SYNTAX ASSOC.
"--------------------------------------------------------------------
hi link FWK_Note_Syn_SpecialWord_Comment            FWK_Note_Col_SpecialWord_Comment
hi link FWK_Note_Syn_SpecialWord_All                FWK_Note_Col_SpecialWord_All
hi link FWK_Note_Syn_SpecialWord_Example            FWK_Note_Col_SpecialWord_Example

else
    echo 'vimfiles/conf.vim: for use this plugin, you must install vim package with conf.vim syntax file'
endif

"set hlsearch
"set spell spelllang=fr
"hi CursorLine cterm=NONE ctermfg=0 ctermbg=123
"hi Search     cterm=NONE ctermfg=0 ctermbg=222
"hi SpellBad cterm=underline ctermfg=red
"hi SpellCap cterm=underline ctermfg=red
"hi SpellLocal cterm=underline ctermfg=red
