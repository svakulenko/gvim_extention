func FWK_Perforce_command(cmd)

"example of working instructions:
"p4 -c CoC_Speech_Connectivity_WebKit_2_Development_SeVakulenko_SAVakulenko_share -u SeVakulenko -p 172.30.198.20:3510 edit -c default d:\P4\webkit_build\Source\HBASLauncher\graphics\graphics.cpp

    let client_workspace = "CoC_Speech_Connectivity_WebKit_2_Development_SeVakulenko_SAVakulenko_share"
    let host_and_port    = "172.30.198.20:3510"

    let cur_file = expand ("%:p")

    if a:cmd == 'diff'
        let $P4DIFF='gvim.exe -d +DiffPointMoveDown'
        let template = 'p4 -c ' . client_workspace . ' -u SeVakulenko -p ' . host_and_port . ' %P4CMD% ' . cur_file
    else
        let template = 'p4 -c ' . client_workspace . ' -u SeVakulenko -p ' . host_and_port . ' %P4CMD% -c default ' . cur_file
    endif

    let ex_str = FWK_System_FilTemplate( template, '%P4CMD%', a:cmd)

    "Decho('ex_str=' . ex_str)

    echo ex_str
    echo system(ex_str)

endfunc

map \pe :call FWK_Perforce_command('edit')<CR>
map \pr :call FWK_Perforce_command('revert')<CR>
map \pl :call FWK_Perforce_command('lock')<CR>
map \pu :call FWK_Perforce_command('unlock')<CR>
map \pa :call FWK_Perforce_command('add')<CR>
map \pd :call FWK_Perforce_command('diff')<CR>

