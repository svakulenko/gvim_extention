
""//--------------------------------------------------------------------
"Description: this function map tags on 'map_keys'
""//--------------------------------------------------------------------
func FWK_genTagsMap(map_keys, ...)

    if a:0 == 0
        return 
        echo 'no enough arguments'
    endif

    let isFirstAddGen= 1
    let isFirstAddSet= 1
    let isAdd_to_gen = 0

    let argsGen = ''
    let argsSet = ''

    for s in a:000 "massive of var args

        if s == 'g' "add to list of tags that will be generate and set 
            let isAdd_to_gen = 1
            continue
        elseif s == 's' "only set tag variable
            let isAdd_to_gen = 0
            continue
        endif


        if isAdd_to_gen

            if isFirstAddGen "skip first append of ',' for gen list
                let isFirstAddGen = 0
            else
                let argsGen .= ', '
            endif
            let argsGen .= "'" . s . "'"

        endif

        if isFirstAddSet "skip first append of ',' for set list
            let isFirstAddSet = 0
        else
            let argsSet .= ', '
        endif
        let argsSet .= "'" . s . "'"


    endfor

    let gen_sup_map = '1'
    let set_sup_map = '2'
    "Decho('args=' . l:args)
    let varGenMap  = 'map ' . a:map_keys . gen_sup_map .' '
    let varGenMap .= ':call FWK_genTagsByPath(' . argsGen . ')<CR>'
    let varGenMap .= ':call FWK_setTags('       . argsSet . ')<CR>'

    let varSetMap  = 'map ' . a:map_keys . set_sup_map . ' '
    let varSetMap .= ':call FWK_setTags('       . argsSet . ')<CR>'
    exe varGenMap
    

    exe varSetMap

endfunc

""//--------------------------------------------------------------------
"Description: this function generate tags for all paths. Tag file will be
"created by path taked from last variable of massive
""//--------------------------------------------------------------------
func FWK_setTags(...)
    let &tags  = g:PLFM_VIMCFG . g:PLFM_SL . 'tags'
    let &tags .= ',' . g:PLFM_VIM_VIMFILES . g:PLFM_SL . 'tags'
    let &tags .= ',..\tags,tags'


    for s in a:000
        if match(&tags,substitute(s,'\\','\\\\','g')) == -1
            let &tags .= ','
            let &tags .= s . g:PLFM_SL . 'tags'
        endif
    endfor

endfunc
""//--------------------------------------------------------------------
"Description: this function generate tags for all paths. Tag file will be
"created by path taked from last variable of massive
""//--------------------------------------------------------------------
func FWK_genTagsByPath(...)

    if a:0 == 0
        return
    endif

    for s in a:000
        let ctags_flags= '-R --c++-kinds=+p --ocaml-kinds --fields=+iaS --extra=+q'
        let ctag_file  =  '"' . s . g:PLFM_SL . 'tags' .  '"'
        let ctag_path  =  '"' . s . '"'
        let exe_str = 'ctags'. ' ' . ctags_flags . ' ' . '-f' . ' ' . ctag_file . ' ' . ctag_path
        "let exe_str = 'ctags -R --c++-kinds=+p --ocaml-kinds --fields=+iaS --extra=+q' . ' -f ' . s . g:PLFM_SL . 'tags . ' . s

        "let exe_str = 'ctags -R --c++-kinds=+p --fields=+iaS --extra=+q' . ' -f ' . '"' . s . g:PLFM_SL . 'tags' .  '"' . ' . '  . s
        "
        "let exe_str = 'ctags -R --c++-kinds=+p --fields=+iaS --extra=+q' . ' -f ' . ctag_file . ' . '  . s
        "Decho ( exe_str )
        echo system(exe_str)
    endfor

endfunc

