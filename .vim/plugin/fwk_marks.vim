if exists('g:fwk_bookmarks_enable') || v:version < 701 
  finish 
endif 
let g:fwk_bookmarks_enable = 01 " Version 

let g:fwk_bookmarks_marks_dictionary = 
         \{
         \  'a_file':''
         \, 'a_pos':'' 
         \, 'b_file':'' 
         \, 'b_pos':'' 
         \, 'c_file':'' 
         \, 'c_pos':'' 
         \, 'd_file':'' 
         \, 'd_pos':'' 
         \, 'e_file':'' 
         \, 'e_pos':'' 
         \, 'f_file':'' 
         \, 'f_pos':'' 
         \, 'g_file':'' 
         \, 'g_pos':'' 
         \, 'h_file':'' 
         \, 'h_pos':'' 
         \, 'i_file':'' 
         \, 'i_pos':'' 
         \, 'j_file':'' 
         \, 'j_pos':'' 
         \, 'k_file':'' 
         \, 'k_pos':'' 
         \, 'l_file':'' 
         \, 'l_pos':'' 
         \, 'm_file':'' 
         \, 'm_pos':'' 
         \, 'n_file':'' 
         \, 'n_pos':'' 
         \, 'o_file':'' 
         \, 'o_pos':'' 
         \, 'p_file':'' 
         \, 'p_pos':'' 
         \, 'q_file':'' 
         \, 'q_pos':'' 
         \, 'r_file':'' 
         \, 'r_pos':'' 
         \, 's_file':'' 
         \, 's_pos':'' 
         \, 't_file':'' 
         \, 't_pos':'' 
         \, 'u_file':'' 
         \, 'u_pos':'' 
         \, 'v_file':'' 
         \, 'v_pos':'' 
         \, 'w_file':'' 
         \, 'w_pos':'' 
         \, 'x_file':'' 
         \, 'x_pos':'' 
         \, 'y_file':'' 
         \, 'y_pos':'' 
         \, 'z_file':'' 
         \, 'z_pos':'' 
         \}

function s:Fwk_bookmarks_marks_saveMark(mark)
let mark_file = a:mark . "_file"
let mark_pos  = a:mark . "_pos"

"getpos(".")
"setpos(".",valval)
let g:fwk_bookmarks_marks_dictionary[mark_file] = expand ("%:p")
let g:fwk_bookmarks_marks_dictionary[mark_pos]  = getpos(".")
"let g:fwk_bookmarks_marks_dictionary[a:mark] = { expand ("%:p") : getpos(".") }

endfunction

function s:Fwk_bookmarks_marks_loadMark(mark, mode)
    let mark_file = a:mark . "_file"
    let mark_pos  = a:mark . "_pos"

    let lfile = g:fwk_bookmarks_marks_dictionary[mark_file]
    let lpos  = g:fwk_bookmarks_marks_dictionary[mark_pos]


	if lfile != ""

	   "open file only if it not in same window
	   if expand("%:p") != lfile 
		  "buffer mode
		  if     (a:mode == 1)
			 exe ":e " . g:fwk_bookmarks_marks_dictionary[mark_file]
			 "tab mode
		  elseif (a:mode == 2)
			 exe ":OpenTabsSilent " . g:fwk_bookmarks_marks_dictionary[mark_file]
		  endif

	   endif

	   call setpos(".", lpos)

	else
        echo "SuperMark not set, skipped"
    endif

    "echo g:fwk_bookmarks_marks_dictionary[mark_file]
    "echo g:fwk_bookmarks_marks_dictionary[mark_pos]

endfunction

command! -n=1 SetSuperMark  :call s:Fwk_bookmarks_marks_saveMark('<args>')
command! -n=1 GetSuperMarkB :call s:Fwk_bookmarks_marks_loadMark('<args>', 1)
command! -n=1 GetSuperMarkT :call s:Fwk_bookmarks_marks_loadMark('<args>', 2)

