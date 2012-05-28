"----------------------------------- 
" Description: this func. enable custom french layout to avoid problem with using of
" accents in standart win32 fr layout(some Alt+Keys binded to accents, that
" why when you using standart accents in vim, he call function binded on these
" combinations). 
"----------------------------------- 
"//--------------------------------------------------------------------
"Accents mapping, workaround to print accents in vim
let g:FWK_Language_French_Mode_Variable = 0
func FWK_Language_French_Mode()

    let g:dict_french_layout =
                \{
                \  "[q" : "â" 
                \, "[e" : "ê"
                \, "[u" : "û"
                \, "[o" : "ô"
                \, "2"  : "é"
                \, "4"  : "'"
                \, "7"  : "è"
                \, "9"  : "ç"
                \, "0"  : "à"
                \, "'"  : "ù"
                \, "q"  : "a"
                \, "a"  : "q"
                \, ";"  : "m"
                \, ":"  : "M"
                \}

    if g:FWK_Language_French_Mode_Variable == 0
        let g:FWK_Language_French_Mode_Variable += 1
        echo "enable french layout"
    else
        let g:FWK_Language_French_Mode_Variable -= 1
        echo "disable french layout"
    endif

    if g:FWK_Language_French_Mode_Variable
        for item in items(g:dict_french_layout)
            let key = item[0]
            let value = item[1]
            let register_name = 'n'
            exe 'imap ' . key  . ' <c-o>:let @' . register_name . ' =' . '"' . value . '"' . '<CR>' . '<c-r><c-o>' . register_name
        endfor

    else
        for item in items(g:dict_french_layout)
            let key = item[0]
            exe 'iunmap ' . key
        endfor

    endif

endfunc

