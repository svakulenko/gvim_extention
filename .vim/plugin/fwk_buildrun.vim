if v:version < 701 
  finish 
endif 


"hot keys to map
"a-m - make
"a-r - execute file

let g:FWK_ScriptVarList = [
                        \   'FWK_MODE='
                        \,  'FWK_MAKE_LOG='
                        \,  'FWK_RUN_LAST_CMD='
                        \,  'FWK_MAKE='
                        \,  'FWK_RUN='
            \]











"let g:FWK_ScriptVarMap = [
                        "\  ['FWK_MAKE_LOG=' : '']
                        "\  ['FWK_RUN_LAST_CMD=' : '']
                        "\  ['FWK_MAKE=' : '']
                        "\  ['FWK_RUN=' : '']
                        "\  ['FWK_MODE=' : '']
                        "\]

function FWK_runScriptParse()

    let l:vrunMode         = '' "make, bat
    let l:app_run          = ''
    let l:app_make_dir         = ''
    let l:app_makeLog      = ''
    let l:app_run_last_cmd = 'pause'


    for var in g:FWK_ScriptVarList

        if search(var) == 0
            continue
        endif

        let l:line = getline(".")

        "FWK_MODE
        if match(g:FWK_ScriptVarList[0], var) != -1 "FWK_MODE most important, to decide which make/bat or something else we must use
            let l:vrunMode = substitute(l:line, g:FWK_ScriptVarList[0],'','')
            "Decho('applog=' . l:app_makeLog)

        "FWK_MAKE_LOG
        elseif match(g:FWK_ScriptVarList[1], var) != -1 "makeLog, must be before 'make' (next block)
            let l:path = substitute(l:line, g:FWK_ScriptVarList[1],'','')
            if l:path != '' && l:vrunMode == 'make' 
               let l:app_makeLog = '> ' . l:path . ' 2>&1' . "\\|" . 'tail -f ' . l:path
            endif
            "Decho('applog=' . l:app_makeLog)

        "FWK_RUN_LAST_CMD
        elseif match(g:FWK_ScriptVarList[2], var) != -1
            let l:app_run_last_cmd = substitute(l:line, g:FWK_ScriptVarList[2],'','')


        "FWK_MAKE
        elseif match(g:FWK_ScriptVarList[3], var) != -1 "make block
            let l:app_make_dir = substitute(l:line, g:FWK_ScriptVarList[3],'','')
            "Decho('l:app_make_dir=' . l:app_make_dir)
            if l:vrunMode == 'make'
                exe "map <a-m> :let restorePos = &cd<CR>: cd " . l:app_make_dir . "<CR>: !start cmd /c make " . l:app_makeLog . "<CR>let &cd = restorePos<CR>"
            elseif l:vrunMode == 'bat'
                exe "map <a-m> :let restorePos = &cd<CR>: cd " . l:app_make_dir . "<CR>: !start cmd /c " .  'compile.bat' . ' & ' . l:app_run_last_cmd ." <CR>let &cd = restorePos<CR>"

        elseif l:vrunMode == 'py'
            exe "map <a-m> : call ExecuteFileWithArg('" . l:app_make_dir . "')<CR>"

            endif

        "FWK_RUN
    elseif match(g:FWK_ScriptVarList[4], var) != -1
        let l:app_run = substitute(l:line, g:FWK_ScriptVarList[4],'','')
        call FWK_File_SavePrevCD()
        if l:vrunMode == 'make'
            exe "map <a-r> : call ExecuteSelfFile('" l:app_run_last_cmd . "', '" . l:app_run . "')<CR>"
        elseif l:vrunMode == 'bat'
            exe "map <a-r> :" . "!start cmd /c " . 'run.bat' . ' & ' . l:app_run_last_cmd ."<CR>"
        elseif l:vrunMode == 'py'
            exe "map <a-r> : call ExecuteFileWithArg('" . l:app_run . "')<CR>"

        endif
        call FWK_File_RestorePrevCD()
    endif

    endfor
endfunc


