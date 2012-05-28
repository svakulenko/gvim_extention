if exists('g:fwk_project_addon') || v:version < 701 
  finish 
endif 
let g:fwk_project_addon = 01 " Version 


"//--------------------------------------------------------------------
"Description: recreate all project by one key (i map it to <F4> in
"project.vim). Standart function only refresh files in created dirs.
"//--------------------------------------------------------------------
function FWK_Project_Addon_refresh_path()

    
    let pos = FWK_getCurrPos()
    "let prev_pos = getpos(".")

    "let prev_fold_state =  foldclosed(line("."))

	"close all folds
    "try
	"if foldclosed(getline(".")) == -1
        "Decho('here#1')
        "exe "normal zC"
        
        "call search('\s*\w\+=.*\s\+CD','b')
	"endif
    "catch /.*/
        "echo 'there is no fold'
        "return
    "endtry
    
        exe "normal zM"
        call FWK_Move_Operation(0, 1) "press up
        call FWK_Move_Operation(0,-1) "press down
        call FWK_Move_Operation(0, 0) "press enter

	let recourse         = 1
	let project_vim_name = ""
	let cd_value         = ""
	let filter_value     = ""
	let project_vim_path = ""

    let sub_pat = '["\ ]*\(\w\+\)=\(.*\)\s\+CD=\(.*\)\s\+filter="\(.*\)"\s\+{'
    let cur_line= getline(".")

	if match(cur_line,'\s*\w\+=.*\s\+CD') == -1
		return FWK_Error("no path or name, exit")

    elseif match(cur_line,'CD=') == -1
		return FWK_Error("no CD, exit")

    elseif match(cur_line,'filter=') == -1
		return FWK_Error("no filter, exit")

    endif



    
    "test string
    "create_web_app_with_py=D:\workspace\django\create_web_app_with_py CD=. filter="*.py *.html *.txt" {

        let project_vim_name = substitute(cur_line, sub_pat,'\1','')

        let project_vim_path = substitute(cur_line, sub_pat,'\2','')
        let project_vim_path = substitute(project_vim_path, '"', '', 'g') "remove \"

        let cd_value         = substitute(cur_line, sub_pat,'\3','')
        let filter_value     = substitute(cur_line, sub_pat,'\4','')

        "Decho('project_vim_name=' . project_vim_name)
        "Decho('project_vim_path=' . project_vim_path)
        "Decho('cd_value=' . cd_value)
        "Decho('filter_value=' . filter_value)
	"remove curr string
    call FWK_Move_Operation(0, 0) "press enter, close fold
	exe "normal D"

	"create new fold tree
	call CreateEntriesFromDir(recourse, project_vim_name, project_vim_path, cd_value, filter_value)

	"exe ":" . (line(".")-1) . "d"

		exe "normal zM"
        "exe "normal zO"
        "call search('\s*\w\+=.*\s\+CD','b')

        let pos[1] += 1 
        call FWK_setCurrPos(pos)
    "setpos(".", prev_pos)
endfunc
