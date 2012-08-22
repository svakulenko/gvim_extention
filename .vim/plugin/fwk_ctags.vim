"fwk_ctags Plugin, Manage your ctags configurations simple and efficent under Vim
"Copyright (C) 2011-2012  Sergey Vakulenko
"s vakulenko at gmail point com
"
"This program is free software: you can redistribute it and/or modify
"it under the terms of the GNU General Public License as published by
"the Free Software Foundation, either version 3 of the License, or
"(at your option) any later version.

"This program is distributed in the hope that it will be useful,
"but WITHOUT ANY WARRANTY; without even the implied warranty of
"MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
"GNU General Public License for more details.

"You should have received a copy of the GNU General Public License
"along with this program.  If not, see <http://www.gnu.org/licenses/>.

"
"
"last modification: 10.Aug.2012
"(c) Sergey Vakulenko 
"version: 0.6

"Description: this function map tags on 'map_keys'
"<project:<your description>   - description. if set, map also will be genered for popUp menu with description 
"set  - set tags paths
"gen  - gen tags path
"map  - map hotkey
"pref - user preferences 
"


if exists('g:fwk_ctags_config_to_load') "if no config was set - stop the plugin execution ...
    
"default path to menu, you can change it
if !exists('g:fwk_ctags_popup_menu_root_path')
    let g:fwk_ctags_popup_menu_root_path = 'PopUp.&Tags'
endif

if !exists('g:fwk_ctags_default_flags')
    let g:fwk_ctags_default_flags = '-R --c++-kinds=+p --ocaml-kinds --fields=+iaS --extra=+q'
endif 



let g:fwk_ctags_private_gen_sup_map = '1'
let g:fwk_ctags_private_set_sup_map = '2'
"--------------------------------------------------------------------
"Description: make map for gen/set tags
func FWK_genTagsMap(mydict)

    
    let arg_set   = ''
    let arg_gen   = ''
    
    
    if !empty(a:mydict['l_gen'])
        let arg_gen    = "'" . join(a:mydict['l_gen'], "','") . "'"
        let arg_set    = arg_gen
    endif
    
    if !empty(a:mydict['l_set'])
        if !empty(arg_set)
            let arg_set .= ','
        endif
        let arg_set   .= "'" . join(a:mydict['l_set'], "','") . "'"
    endif

    
    let arg_descr = a:mydict['desc']
    let arg_map   = a:mydict['map']
    
    let arg_user_preferences = "'" . "'"
    
    if !empty(a:mydict['l_pref'])
        let arg_user_preferences  = '"' . "'" . join(a:mydict['l_pref'], "' '") . "'" . '"'
    endif
 
    

    let popup_path  = 'PopUp.&Tags.'
    
    let fun_call_gen_tags       = ':call FWK_genTagsByPath(' . arg_user_preferences . ',' .  arg_gen . ')<CR>'
    let fun_call_set_tags       = ':call FWK_setTags('       . arg_set              .                  ')<CR>'
    "echo 'arg_set:' . arg_set
    let fun_call_stub           = ':call FWK_genStub()<CR>'
    
    
    let eval_gen_map  = 'nmap ' . arg_map . g:fwk_ctags_private_gen_sup_map . ' ' 
    let eval_set_map  = 'nmap ' . arg_map . g:fwk_ctags_private_set_sup_map . ' '
    
    
    if arg_gen != ''  | let eval_gen_map .= fun_call_gen_tags  | else | let eval_gen_map .= fun_call_stub | endif
    if arg_set != ''  | let eval_set_map .= fun_call_set_tags  | else | let eval_set_map .= fun_call_stub | endif
    
    "for popup_menu
    if arg_descr != ''
        let hotkey_tip = substitute(' ( ' . arg_map .' ) ' , '\\' , '\\\\' , 'g')
        let arg_descr = substitute (arg_descr . hotkey_tip , '\ ', '\\ ', 'g') . '.'
        "echo arg_descr
        if arg_set != ''
            let eval_str_popup_set = 'amenu ' . popup_path . arg_descr . '&Set ' . fun_call_set_tags
            exe eval_str_popup_set
            
            let g:fwk_ctags_private_maps_storage['smenu'] = add(g:fwk_ctags_private_maps_storage['smenu'], popup_path . arg_descr . '&Set')
        endif
        
        if arg_gen != ''
            let eval_str_popup_gen = 'amenu ' . popup_path . arg_descr . '&Generate ' . fun_call_gen_tags . fun_call_set_tags
            exe eval_str_popup_gen
            let g:fwk_ctags_private_maps_storage['gmenu'] = add(g:fwk_ctags_private_maps_storage['gmenu'], popup_path . arg_descr . '&Generate' )
        endif
        
    endif

    if !empty(arg_map)
        exe eval_set_map
        exe eval_gen_map
        
        let g:fwk_ctags_private_maps_storage['smap'] = add(g:fwk_ctags_private_maps_storage['smap'], arg_map . g:fwk_ctags_private_set_sup_map)
        let g:fwk_ctags_private_maps_storage['gmap'] = add(g:fwk_ctags_private_maps_storage['gmap'], arg_map . g:fwk_ctags_private_gen_sup_map)
    endif
 

    

endfunc

"--------------------------------------------------------------------
"Description: this function generate tags for all paths. Tag file will be
"created by path taked from last variable of massive
"--------------------------------------------------------------------
func FWK_setTags(...)
    "let &tags  = g:PLFM_VIMCFG . g:PLFM_SL . 'tags'
    "let &tags .= ',' . g:PLFM_VIM_VIMFILES . g:PLFM_SL . 'tags'
    "let &tags .= ',..\tags,tags'


    let &tags = ''
    for s in a:000
        "if match(&tags,substitute(s,'\\','\\\\','g')) == -1
        if len(a:000) > 1
            let &tags .= ','
        endif
            "let &tags .= s . g:PLFM_SL . 'tags'
            let &tags .= substitute(s,'\ ','\\ ','g')  . g:PLFM_SL . 'tags'

        "endif
    endfor

endfunc

"Description: stub for maps
fun FWK_genStub()
    echo 'there is nothing to do for this map'
endfunc

"--------------------------------------------------------------------
"Description: this function generate tags for all paths. Tag file will be
"created by path taked from last variable of array
"--------------------------------------------------------------------
func FWK_genTagsByPath(ctags_advanced_options,...)

    if a:0 == 0
        return
    endif

    for s in a:000
        
        let ctags_flags = g:fwk_ctags_default_flags . ' ' . a:ctags_advanced_options
        
        let ctag_file   =  '"' . s . g:PLFM_SL . 'tags' .  '"'
        let ctag_path   =  '"' . s . '"'
        
        let exe_str     = 'ctags'. ' ' . ctags_flags . ' ' . '-f' . ' ' . ctag_file . ' ' . ctag_path
        
        "Decho ( exe_str )
        echo exe_str
        echo system(exe_str)
    endfor

endfunc


"not used 
func FWK_ctags_parse_config_check_end(p, line)
    let pat_prj_end_ocas = '/\([\ \n]*[}]+\)\?'
    let end_pattern = a:p 
    let is_end = substitute(a:line, end_pattern,'\2','')
    if !empty(is_end)
        echo 'this is end line: is_end:' . is_end
        echo 'this is end line: first:' . substitute(a:line, end_pattern,'\1','')
    endif
    
endfunc
"--------------------------------------------------------------------
"Description: parse configuration file and return dictioner of configuration
"--------------------------------------------------------------------
func FWK_ctags_parse_config(file)
    "let file = 'some_file.txt'
    let M = 'FWK_ctags_parse_config'
    
    "regex patterns


    "TODO: parse all file line one content, and no many lines. Otherwise, its
    "impossible parse proj bgn and proj end in same lines as other pattern
    
    

    let pat_sp_or_nl = '/\(\s\|$\)+' "not used 
    let pat_prj_end_ocas = pat_sp_or_nl . '\([\ \n]*[}]+\)\?' "not used 
    
    
    let pat_symbol   = '\([0-9a-zA-Z\\\/\ _-]\+\)'
    let pat_prj_bgn  = '^\s*'. pat_symbol . '\n*' .'{'
    let pat_prj_end  = '^\s*}\s*$'
    let pat_prj_map  = '^\s*map:'  . pat_symbol . '$'
    let pat_prj_gen  = '^\s*gen:'  . pat_symbol
    let pat_prj_set  = '^\s*set:'  . pat_symbol
    let pat_prj_pref = '^\s*pref:' . '\([0-9a-zA-Z@;,{}()$^:\.=?\[\]*+\\\/\ _-]\+\)' . '$'
    
    let patterns     = [ pat_prj_bgn, pat_prj_map, pat_prj_gen, pat_prj_set, pat_prj_pref]
    
    "'\([0-9a-zA-Z?\[\]*+\\\/\ _-]\+\)'
    if !filereadable(a:file) "check if persistency file exist
        echo M . ' file:' . a:file . ' is not reachable. please check it path again'
        return
    endif
    
    let file_content  = readfile(a:file)
    "echo join(file_content,'')
    if empty(file_content)
        echo M . 'configuration file:' . a:file . ' is empty, skip action ...'
        return
    endif
    
    let l_prjs = []
    
    let dict_el= {} "temp vars
    let l_gen  = []
    let l_set  = []
    let l_pref = []
    
    for line in file_content

        for p in patterns
        endfor
        
        if line =~ pat_prj_bgn
            let dict_el['desc'] = substitute(line,pat_prj_bgn,'\1','')
            let l_gen   = []
            let l_set   = []
            let l_pref  = []
            "echo 'bgn:' . line
           
        elseif line =~ pat_prj_map
            let dict_el['map'] = substitute(line,pat_prj_map,'\1','')
            
        elseif line =~ pat_prj_gen
            call add(l_gen,substitute(line,pat_prj_gen,'\1',''))
            "call FWK_ctags_parse_config_check_end(pat_prj_gen, line)
            "echo 'gen:' . line
            
        elseif line =~ pat_prj_set
            call add(l_set,substitute(line,pat_prj_set,'\1',''))
            "echo 'set' . line
            
        elseif line =~ pat_prj_pref
            call add(l_pref,substitute(line,pat_prj_pref,'\1',''))

        elseif line =~ pat_prj_end
            "call FWK_ctags_parse_config_check_end(pat_prj_end, line)
            let dict_el['l_gen']  = l_gen
            let dict_el['l_set']  = l_set
            let dict_el['l_pref'] = l_pref
            
            call add(l_prjs,dict_el)
            let dict_el = {}
            "echo 'end:' . line

        endif
        
        "echo line
    endfor

    "echo 'projects:' . join(l_prjs,'|')

    return l_prjs

    
endfunc

func FWK_ctags_reset_old_maps_storage()
    let g:fwk_ctags_private_maps_storage = {}
    let g:fwk_ctags_private_maps_storage['smap']  = []
    let g:fwk_ctags_private_maps_storage['gmap']  = []
    let g:fwk_ctags_private_maps_storage['smenu'] = []
    let g:fwk_ctags_private_maps_storage['gmenu'] = []
endfunc    

func FWK_ctags_remove_old_maps()
    "unmap all previous maps, if we call refresh (to not have 'dead' maps
    "after refresh)
        for i in g:fwk_ctags_private_maps_storage['smap']  | exe 'nunmap '  .  i | endfor 
        for i in g:fwk_ctags_private_maps_storage['gmap']  | exe 'nunmap '  .  i | endfor 
        for i in g:fwk_ctags_private_maps_storage['smenu'] | exe 'aunmenu ' .  i | endfor 
        for i in g:fwk_ctags_private_maps_storage['gmenu'] | exe 'aunmenu ' .  i | endfor 

        call FWK_ctags_reset_old_maps_storage()
endfunc    

"--------------------------------------------------------------------
"Description: main function for fwk_ctags: use it to run parse processing and
"finally to get maps as hotkeys and item in popup menu
func FWK_ctags_applicate_cfg(file)
    let M = 'FWK_ctags_applicate_cfg: '
    

    if !filereadable(a:file) "check if persistency file exist
        echo M . ' file:' . a:file . ' is not reachable. please check it path again'
        return
    endif

    let config_menu_item     = '.Open\ Ctags\ Config '
    let config_menu_item_refresh = '.Refresh\ Ctags\ Config '
    let default_menu_item = 'amenu ' . g:fwk_ctags_popup_menu_root_path .  config_menu_item . ':e ' . g:fwk_ctags_config_to_load . '<CR>'
    exe default_menu_item

    let default_menu_item = 'amenu ' . g:fwk_ctags_popup_menu_root_path .  config_menu_item_refresh . ':call FWK_ctags_applicate_cfg(' . "'" . g:fwk_ctags_config_to_load . "')" . '<CR>'
    exe default_menu_item

    call FWK_ctags_remove_old_maps()
    ""unmap all previous maps, if we call refresh (to not have 'dead' maps
    ""after refresh)
    "if !empty(g:fwk_ctags_private_maps_storage)
        "for i in g:fwk_ctags_private_maps_storage
            "let set_map = i . g:fwk_ctags_private_set_sup_map
            "let gen_map = i . g:fwk_ctags_private_gen_sup_map
            "if !empty(maparg(set_map, 'n'))
                ""Decho('unset set' . set_map)
                "exe 'nunmap ' . set_map
            "endif
            "if !empty(maparg(gen_map, 'n'))
                ""Decho('unset gen' . gen_map)
                "exe 'nunmap ' . gen_map
            "endif
        "endfor 
        "let g:fwk_ctags_private_maps_storage = []
    "endif
            
    
    for mydict in FWK_ctags_parse_config(a:file)
        call FWK_genTagsMap(mydict)
    endfor
    
    

endfunc

"run plugin processing of cfg ...
if !empty(g:fwk_ctags_config_to_load) " if var is exist but empty - user will call plugin later. just stop execution 
    
    "variable for save maps and menu, to have possibilite unset them
    call FWK_ctags_reset_old_maps_storage()
    
	call FWK_ctags_applicate_cfg(g:fwk_ctags_config_to_load)

endif

"default path to menu map for this file (open it quickly to edit)
if filereadable(g:fwk_ctags_config_to_load) 
endif
"



endif
