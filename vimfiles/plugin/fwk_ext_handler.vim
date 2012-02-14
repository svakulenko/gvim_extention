if exists('g:fwk_ext_handler_disable') || v:version < 701 
  finish 
endif 

"""""""""""""""""""""""""""""""""""""" 
"function to execute current file or sent with argumment
"""""""""""""""""""""""""""""""""""""" 
"//--------------------------------------------------------------------------------- 
function ExecuteSelfFile(...)
    if g:fwk_gl_iswin32 == 1
        call ExecuteSelfFileMain('no_special', a:000)
    else
        call ExecuteSelfFileMainLinux('no_special', a:000)
    endif
endfunc

function ExecuteSelfFileSpecial(...)
    if g:fwk_gl_iswin32 == 1
        call ExecuteSelfFileMain('special', a:000)
    else
        call ExecuteSelfFileMainLinux('special', a:000)
    endif
endfunc

function! ExecuteSelfFileMainLinux(special_opt, ...) 
    let local_path   = getcwd()
    let full_cmd_os  = ''
    let COMMAND  = ''
    let BAT_CMD      = ''
    let full_cmd_os  = '!%COMMAND% %ARG1% & %BAT_CMD% ' "bg in unix os

    let const_wait_for_end = 'start cmd /c '
    let const_not_wait_end = 'start cmd /c start '

    let l:file_name = ''
    let l:file_ext = ''

    if a:0 == 3 "with bat option amd filename
        let BAT_CMD = a:1
        let l:file_name = a:2 "get file name
        try 
            let l:file_ext = split(a:2,'\.')[1] "get file_extention
        catch
            echo 'ExecuteSelfFile:exception happens'
            return
        endtry

    elseif a:0 == 2
        let l:file_name = a:1 "get file name
        try 
            let l:file_ext = split(a:1,'\.')[1] "get file_extention
        catch
            echo 'ExecuteSelfFile:exception happens'
            return
        endtry
    elseif a:0 == 1 "no values, use current file
        let l:file_name = expand("%:p") 
        let l:file_ext = expand("%:e")

        "suppl functions params"
        let l:file_name_no_ext = split(expand("%:t"),'\.')[0] "name without ext
        let l:file_dir = expand("%:p:h")

    endif

    if FWK_System_IsWin32Platform()

        let l:file_name = FWK_System_AddSlash(l:file_name) "add double slashes

        let l:file_dir  .= '\'
        let l:file_dir  = FWK_System_AddSlash(l:file_dir) "add double slashes

        if     l:file_ext == 'tscn'
            let COMMAND     = const_wait_for_end . 'tcmd.py'

        elseif     l:file_ext == 'ml' || l:file_ext == 'mli'
            let COMMAND = const_wait_for_end . 'ocaml < '

        elseif     l:file_ext == 'scm'
            if a:special_opt == 'no_special'
                let COMMAND = const_wait_for_end . 'biglooc.bat '
                let l:file_name = expand("%:t:r") "run test need without file_extention
            else
                let COMMAND = const_wait_for_end . 'bigloo -i  '
            endif


        elseif     l:file_ext == 'js'
            let COMMAND = const_wait_for_end . 'jsc  '

        elseif     l:file_ext == 'ml_gtk'
            let COMMAND     = const_wait_for_end . 'lablgtk2.bat'

        elseif l:file_ext == 'test' || l:file_ext == 'valid'
            cd c:\Program\ Files\Luxoft\tfc\ Suite\
            let COMMAND     = const_wait_for_end . 'tfc_traceClientConsumer.exe -fs -ctestscenarios.cfg'
            let l:file_name = expand("%:t:r") "run test need without file_extention

        elseif l:file_ext == 'bat'
            "let l:file_name = expand("%:t") "run bat file without path(from curr dir)
            "let l:file_name = expand("%:p") "run bat file without path(from curr dir)
            "let COMMAND = const_wait_for_end
            let COMMAND = const_wait_for_end

        elseif l:file_ext == 'py'
            let COMMAND = const_wait_for_end

        elseif l:file_ext == 'jpg'
            let BAT_CMD = 'exit' "exit from COMMAND after execution

        elseif l:file_ext == 'tex'
            if a:special_opt == 'no_special'
                let COMMAND     = const_wait_for_end . 'latex'
            else
                let COMMAND     = 'start ' . 'yap'
                let BAT_CMD = 'skip'
                let l:file_name = l:file_name_no_ext
            endif

            :lcd %:p:h
            "let COMMAND     = const_wait_for_end . 'pdflatex.bat'
            "let l:file_name = l:file_name_no_ext
            let BAT_CMD = 'exit' "exit from COMMAND after execution

        endif

        "for all others keys default values .....
        if COMMAND == 'skip'
            let COMMAND = ''

        elseif COMMAND == ''
            let COMMAND = const_not_wait_end

        endif

        if BAT_CMD == 'skip'
            let BAT_CMD = ''

        elseif BAT_CMD == ''
            let BAT_CMD = 'pause' "make pause after execution of cmd

        endif

    endif

    if l:file_name != ''
        let full_cmd_os = substitute(full_cmd_os, '%COMMAND%', COMMAND,'')
        let full_cmd_os = substitute(full_cmd_os, '%ARG1%'   , l:file_name,'')
        let full_cmd_os = substitute(full_cmd_os, '%BAT_CMD%', BAT_CMD,'')

        ""echo full_cmd_os
        "Decho('exec_str=' . full_cmd_os)
        exe full_cmd_os
    endif

    let &cd = local_path

endfunc
function! ExecuteSelfFileMain(special_opt, ...) 

    "!start cmd /c C:\programs\gVim\Notes\Common\Work\most\most_chain_of_calls_from_to_browser.jpg & exit
    "!start cmd /c start C:\programs\gVim\Notes\Common\Work\most\most_chain_of_calls_from_to_browser.jpg
    "Decho("special_opt=" . a:special_opt)


    let local_path   = getcwd()
    let full_cmd_os  = ''
    let COMMAND  = ''
    let BAT_CMD      = ''
    let full_cmd_os  = '!%COMMAND% %ARG1% & %BAT_CMD% ' "bg in unix os

    let const_wait_for_end = 'start cmd /c '
    let const_not_wait_end = 'start cmd /c start '

    let l:file_name = ''
    let l:file_ext = ''

    if a:0 == 3 "with bat option amd filename
        let BAT_CMD = a:1
        let l:file_name = a:2 "get file name
        try 
            let l:file_ext = split(a:2,'\.')[1] "get file_extention
        catch
            echo 'ExecuteSelfFile:exception happens'
            return
        endtry

    elseif a:0 == 2
        let l:file_name = a:1 "get file name
        try 
            let l:file_ext = split(a:1,'\.')[1] "get file_extention
        catch
            echo 'ExecuteSelfFile:exception happens'
            return
        endtry
    elseif a:0 == 1 "no values, use current file
        let l:file_name = expand("%:p") 
        let l:file_ext = expand("%:e")

        "suppl functions params"
        let l:file_name_no_ext = split(expand("%:t"),'\.')[0] "name without ext
        let l:file_dir = expand("%:p:h")

    endif

    if FWK_System_IsWin32Platform()

        let l:file_name = FWK_System_AddSlash(l:file_name) "add double slashes

        let l:file_dir  .= '\'
        let l:file_dir  = FWK_System_AddSlash(l:file_dir) "add double slashes

        if     l:file_ext == 'tscn'
            let COMMAND     = const_wait_for_end . 'tcmd.py'

        elseif     l:file_ext == 'ml' || l:file_ext == 'mli'
            let COMMAND = const_wait_for_end . 'ocaml < '

        elseif     l:file_ext == 'scm'
            if a:special_opt == 'no_special'
                let COMMAND = const_wait_for_end . 'biglooc.bat '
                let l:file_name = expand("%:t:r") "run test need without file_extention
            else
                let COMMAND = const_wait_for_end . 'bigloo -i  '
            endif


        elseif     l:file_ext == 'js'
            let COMMAND = const_wait_for_end . 'jsc  '

        elseif     l:file_ext == 'ml_gtk'
            let COMMAND     = const_wait_for_end . 'lablgtk2.bat'

        elseif l:file_ext == 'test' || l:file_ext == 'valid'
            cd c:\Program\ Files\Luxoft\tfc\ Suite\
            let COMMAND     = const_wait_for_end . 'tfc_traceClientConsumer.exe -fs -ctestscenarios.cfg'
            let l:file_name = expand("%:t:r") "run test need without file_extention

        elseif l:file_ext == 'bat'
            "let l:file_name = expand("%:t") "run bat file without path(from curr dir)
            "let l:file_name = expand("%:p") "run bat file without path(from curr dir)
            "let COMMAND = const_wait_for_end
            let COMMAND = const_wait_for_end

        elseif l:file_ext == 'py'
            let COMMAND = const_wait_for_end

        elseif l:file_ext == 'jpg'
            let BAT_CMD = 'exit' "exit from COMMAND after execution

        elseif l:file_ext == 'tex'
            if a:special_opt == 'no_special'
                let COMMAND     = const_wait_for_end . 'latex'
            else
                let COMMAND     = 'start ' . 'yap'
                let BAT_CMD = 'skip'
                let l:file_name = l:file_name_no_ext
            endif

            :lcd %:p:h
            "let COMMAND     = const_wait_for_end . 'pdflatex.bat'
            "let l:file_name = l:file_name_no_ext
            let BAT_CMD = 'exit' "exit from COMMAND after execution

        endif

        "for all others keys default values .....
        if COMMAND == 'skip'
            let COMMAND = ''

        elseif COMMAND == ''
            let COMMAND = const_not_wait_end

        endif

        if BAT_CMD == 'skip'
            let BAT_CMD = ''

        elseif BAT_CMD == ''
            let BAT_CMD = 'pause' "make pause after execution of cmd

        endif

    endif

    if l:file_name != ''
        let full_cmd_os = substitute(full_cmd_os, '%COMMAND%', COMMAND,'')
        let full_cmd_os = substitute(full_cmd_os, '%ARG1%'   , l:file_name,'')
        let full_cmd_os = substitute(full_cmd_os, '%BAT_CMD%', BAT_CMD,'')

        ""echo full_cmd_os
        "Decho('exec_str=' . full_cmd_os)
        exe full_cmd_os
    endif

    let &cd = local_path

endfunction 
"//--------------------------------------------------------------------------------- 


"MAPS
"//--------------------------------------------------------------------
"run buffer which is focused
map <A-p> :call ExecuteSelfFile()<CR>
"run buffer which is focused: second variant of functionality of this func.
map <S-A-p> :call ExecuteSelfFileSpecial()<CR>


