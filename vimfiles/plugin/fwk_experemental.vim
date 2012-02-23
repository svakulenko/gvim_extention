if v:version < 701
  finish
endif

let g:FWK_File_prevCD = 'hello'


"//--------------------------------------------------------------------
"Description: run cmd in another process
"//--------------------------------------------------------------------
func FWK_runCmd(path_to_file)

    call FWK_File_SavePrevCD()

    exe "cd " . a:path_to_file
    exe '!start cmd'

    call FWK_File_RestorePrevCD()

endfunc

"//--------------------------------------------------------------------
"Description: save previous dir in global variable
"//--------------------------------------------------------------------
func FWK_File_SavePrevCD()
    silent let g:FWK_File_prevCD = expand("%:h")
endfun

"//--------------------------------------------------------------------
"Description: restore previous dir from global variable
"//--------------------------------------------------------------------
func FWK_File_RestorePrevCD()
    silent exe "cd " . g:FWK_File_prevCD
endfun

