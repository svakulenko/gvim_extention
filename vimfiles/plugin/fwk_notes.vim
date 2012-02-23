
"Name: fwk Notes 
"Version: 0.5
"Autor: Vakulenko Sergiy
"Description: this is Notes Agenda. With this script, you can control your activity workflow (write, read your notes, change their state).



"-------------------------------------------
"Variables Description:
"-------------------------------------------

"-------------------------------------------
"Variable: g:fwk_notes_notes_directory  (string)
"-------------------------------------------
"Description: Set path to notes directory. by default its will be in USERPROFILE/HOME or VIM paths + 'notes' (this is depend of your os system type

"-------------------------------------------
"Variable: g:fwk_notes_disable  (0|1)
"-------------------------------------------
"Description: 1 if you want to disable plugin. By default plugin is on

"-------------------------------------------
"Variable: g:fwk_notes_open_node_mode  (0|1|2)
"-------------------------------------------
"Description: strategy to open notes.
"--------------------------------------------------------------------
"Parameters:
"0 - window mode (will be opened in same window only if only 1 window in tab.
"otherwise open happens in split mode). This is default mode.
"1 - tab mode (will be opened in new tab).
"2 - split mode, will be opened in same tab, but in new window.


"--------------------------------------------------------------------
"Maps (only work in files with *.notes extention):
"\cd open daily tasks
"ctrl-Up - move to next task 
"ctrl-Down - move to previous task 
"

"Also, if you want to track some of your information (dictinnary per day, ...), you can you proper maps:

"if you want that fwk_notes plugin generate file each new day
"map \nv :FwkNoteDynamic Dictionnary<CR>
"map \nx :FwkNoteDynamic SpecialNotes<CR>
"....

"or if you want open only one/same file by map:
"map \nv :FwkNoteStatic Dictionnary<CR>
"map \nx :FwkNoteStatic SpecialNotes<CR>
"....

"Control keys:
"alt-d      - create task ( 1), 2), 3), ... )
"alt-a      - create subtask ( a), b), c), ...)
"alt-space  - create sub_sub_task ( -), -), -), ...)


"All notes are collect in 'fwk_notes_notes_directory' . Its mean that its
"simple to do search, to find your particular notes with grep.

"--------------------------------------------------------------------



if exists('g:fwk_notes_disable') || v:version < 701 
  finish 
endif 

if !exists('g:fwk_notes_notes_directory')
    let g:fwk_notes_notes_directory = g:relative_path . g:cr_slash . 'notes'
endif

if !exists('g:fwk_notes_open_node_mode')
    let g:fwk_notes_open_node_mode = 0 "window mode
endif


"MAPS
func FWK_Note_NotesMaps()

  "SPECIAL Maps for .notes extention"
  nnoremap <buffer> <silent> \cd :call FWK_Note_setColorMark('Done')<CR>
  vmap <buffer> <silent> \cd :call FWK_Note_setColorMark('Done')<CR>

  nnoremap <buffer> <silent> \cp :call FWK_Note_setColorMark('Skip')<CR>
  vmap <buffer> <silent> \cp :call FWK_Note_setColorMark('Skip')<CR>

  nnoremap <buffer> <silent> \ci :call FWK_Note_setColorMark('Important')<CR>
  vmap <buffer> <silent> \ci :call FWK_Note_setColorMark('Important')<CR>

  nnoremap <buffer> <silent> \c1 :call FWK_Note_setColorMark('Group1')<CR>
  vmap <buffer> <silent> \c1 :call FWK_Note_setColorMark('Group1')<CR>

  nnoremap <buffer> <silent> \c2 :call FWK_Note_setColorMark('Group2')<CR>
  vmap <buffer> <silent> \c2 :call FWK_Note_setColorMark('Group2')<CR>

  "not work it now
  nnoremap <buffer> <silent> \ce :call FWK_Note_setColorMark('Event')<CR>
  vmap <buffer> <silent> \ce :call FWK_Note_setColorMark('Event')<CR>



  nnoremap <buffer> <silent> <A-d> :call FWK_Note_Mark_Regex_w_new('\d')<CR>
  imap     <buffer> <silent> <A-d> <Esc>:call FWK_Note_Mark_Regex_w_new('\d')<CR>

  nnoremap <buffer> <silent> <A-a> :call FWK_Note_Mark_Regex_w_new('\a')<CR>
  imap     <buffer> <silent> <A-a> <Esc>:call FWK_Note_Mark_Regex_w_new('\a')<CR>

  map      <buffer> <silent> <A-t> :call FWK_Note_Mark_Regex_comment_new()<CR>A
  imap     <buffer> <silent> <A-t> <Esc>:call FWK_Note_Mark_Regex_comment_new()<CR>A

  map      <buffer> <silent> <A-Space> :call FWK_Note_Mark_Regex_Char('-')<CR>
  imap     <buffer> <silent> <A-Space> <Esc>:call FWK_Note_Mark_Regex_Char('-')<CR>

  vmap     <buffer> <silent> <A-r>      :call FWK_Note_addWildcardBeforeText(' • ')<CR>

  if &ft == 'notes'
      map      <buffer> <silent> <C-UP>   :call FWK_Note_Navigation(1)<CR>
      map      <buffer> <silent> <C-DOWN> :call FWK_Note_Navigation(-1)<CR>

      map      <buffer> <silent> <A-UP>   :call FWK_Note_MoveToTags(1) <CR>
      map      <buffer> <silent> <A-DOWN> :call FWK_Note_MoveToTags(-1)<CR>

      map      <buffer> <silent> \f :call FWK_Note_SetFeminine()<CR>
  endif
endfunc


let g:FWK_Note_Mark_Regex_Increment_SymbolDict =
            \{
            \ 'a':'b'
            \,'b':'c'
            \,'c':'d'
            \,'d':'e'
            \,'e':'f'
            \,'f':'g'
            \,'g':'h'
            \,'h':'i'
            \,'i':'j'
            \,'j':'k'
            \,'k':'l'
            \,'l':'m'
            \,'m':'n'
            \,'n':'o'
            \,'o':'p'
            \,'p':'q'
            \,'q':'r'
            \,'r':'s'
            \,'s':'t'
            \,'t':'u'
            \,'u':'v'
            \,'v':'w'
            \,'w':'x'
            \,'x':'y'
            \,'y':'z'
            \,'z':'a'
            \}

let g:FWK_Note_Calendrier_Dict =
            \{
            \  1:'Jan'
            \, 2:'Feb'
            \, 3:'Mar'
            \, 4:'Apr'
            \, 5:'May'
            \, 6:'Jun'
            \, 7:'Jul'
            \, 8:'Aug'
            \, 9:'Sep'
            \,10:'Oct'
            \,11:'Nov'
            \,12:'Dec'
            \}




"Description: add wildcard '-' before selected text
func FWK_Note_addWildcardBeforeText(strToPut)

    if match(getline("."), '\(\s*\)\?' . a:strToPut . '\(\w*\)') != -1
        "echo 'such pattern exist'
        exe 's/\(\s*\)\?\(' . a:strToPut . '\)\(\w*\)/\1\3/'

    else
        exe 's/\(\s*\)\?\(\w*\)/\1' . a:strToPut .  '\2/'
    endif
endfunc
func FWK_Note_LoadNotes(...)

    for s in a:000 "massive of var args
        if     s == 'change_static'  | call FWK_Note_create_static(s)
        elseif s == 'change_dynamic' | call FWK_Note_create_dynamic(s)
        elseif s == 'change_special' | call FWK_Note_create_special(s)
        endif
    endfor

endfunc

"//--------------------------------------------------------------------
func FWK_Note_create_static(type)
    return FWK_Note_create(a:type, 'static')
endfunc
"//--------------------------------------------------------------------
func FWK_Note_create_dynamic(type)
    return FWK_Note_create(a:type, 'dynamic')
endfunc
"//--------------------------------------------------------------------
func FWK_Note_create_special(type)
    return FWK_Note_create(a:type, 'special')
endfunc
"//--------------------------------------------------------------------

func FWK_Note_create(type, mode)

    let l:fileToOpen = ''
    let l:notes_path = g:fwk_notes_notes_directory
    "let g:fwk_template_path = PLFM_VIM_HOME_PATH . '/vim_extention/templates/'

    let l:anne_dir = l:notes_path . strftime("%Y")
    if !isdirectory(l:anne_dir)
        call  mkdir(l:anne_dir, "p")
    endif

    let l:mois_dir = l:notes_path . strftime("%Y") . g:cr_slash . strftime("%m_%b")
    if !isdirectory(l:mois_dir)
        call  mkdir(l:mois_dir, "p")
    endif

    let l:timeString = strftime("%d.%b.%Y")

    if     (a:mode == 'static')
        let l:fileToOpen = l:notes_path . a:type . '.notes'

    elseif (a:mode == 'dynamic')
        let l:fileToOpen = l:mois_dir . g:cr_slash . l:timeString . "_" . a:type . ".notes"

    elseif (a:mode == 'special')
        echo 'what you want to do ? ...'
        "if     a:type == 'ObjectifsPrincipale' 
            "let l:fileToOpen = l:notes_path . a:type . '.notes'
        "endif

    else
        echo 'uknown mode, exit'
        return

    endif

    if filereadable(l:fileToOpen) != 1      

        let l:mDictPatterns = { 'date': l:timeString ,'type':'' }

        "modification des patterns
        if a:type     == 'Daily'
            let l:mDictPatterns['type'] = 'Objectfs du jour'
            call FWK_copyTemplate('template_notes_daily.notes', l:fileToOpen, l:mDictPatterns )
        else 
            let l:mDictPatterns['type'] = a:type
            call FWK_copyTemplate('template_notes_common.notes', l:fileToOpen, l:mDictPatterns )
        endif


    endif

        call OpenTabSilentFunctionByType(l:fileToOpen, g:fwk_notes_open_node_mode)

        "des commands qui peuvent s'executer apres
        if a:type == 'Daily'
            call search('To\ Do')
        else
            exe ':5'
        endif

endfunc


func FWK_Note_setColorMark(mark_type)

   "let pat_main = '\s\w\+)\s'
   let pat_main = '\s[0-9A-Za-z_-]\+)\s'

   "let pat_supl_time = '\(\s\+\d\d\.\a\a\a\.\d\{4\}\.\d\d\:\d\d\)\?'
   "let pat_supl_time = '\(\d\d\s\a\a\a\s\d\d\d\d\s\d\d\s\d\d\)\?'

   "date/time pattern
   let pat_supl_time_check = '\d\d\.\d\d\.\d\{4\}\.\d\d\:\d\d' 
   let pat_supl_time = '\(' . pat_supl_time_check . '\)\?'
   let lsign = ''
   if     a:mark_type == 'Done'
      let lsign = '!Dn'

   elseif a:mark_type == 'Skip'
      let lsign = '!Sp'

   elseif a:mark_type == 'Important'
      let lsign = '!Im'

   elseif a:mark_type == 'Group1'
      let lsign = '!G1'

   elseif a:mark_type == 'Group2'
      let lsign = '!G2'

   elseif a:mark_type == 'Event'
      let lsign = '!Ev'

   else
      echo 'FWK_Note_setColorMark: unknown sign, exit'
      return

   endif



   if match(getline("."), pat_main) != -1

      if a:mark_type == 'Event'
         let isLineWithTime = match(getline("."), pat_supl_time_check)
         let ltime = '' 
         if isLineWithTime == -1
            let ltime = input("event time: ", strftime("%d.%m.%Y.%H:%M"))
            if ltime == ""
               echo 'FWK_Note_setColorMark: input aborted, exit'
               return
            endif
         else
            let ltime = substitute(getline("."), '\s!\w\+' . '\s\+' . pat_supl_time .'.*','\1','')
         endif

         let mes   = substitute(getline("."), '.*\d)','','')
         "Decho('let ltime#else=' . "'" . ltime . "'")
         "Decho('let mes#else  =' . "'" . mes   . "'")
         call FWK_Note_Notifyer_Wrapper(mes, ltime)

         let lsign .= FWK_CSpace(4) . ltime

     elseif a:mark_type == 'Done'
         let isLineWithTime = match(getline("."), pat_supl_time_check)
         let ltime = '' 
         if isLineWithTime == -1
            let ltime = strftime("%d.%m.%Y.%H:%M")
         else
            let ltime = substitute(getline("."), '\s!\w\+' . '\s\+' . pat_supl_time .'.*','\1','')
         endif

         "let mes   = substitute(getline("."), '.*\d)','','')
         ""Decho('let ltime#else=' . "'" . ltime . "'")
         ""Decho('let mes#else  =' . "'" . mes   . "'")
         "call FWK_Note_Notifyer_Wrapper(mes, ltime)

         let lsign .= FWK_CSpace(4) . ltime

      endif


      let lsign     = ' ' . lsign
      let lsign_len = len(lsign)
      let lsign     = substitute(lsign,'[\.:]','\\&','g') "add \\ before each . and :, becouse otherwise 's:::' command will not work
      let lsign_alt = ' ' . '!\w\+'
      "Decho('let lsign#final=' . "'" . lsign . "'")

      let pat_local_remove            = '^' . '\(' . lsign     . '\s\{0,\}' . '\)'. pat_supl_time  
      let pat_local_remove_universal  = '^' . '\(' . lsign_alt . '\s\{0,\}' . '\)'. pat_supl_time 
      "Decho('let pat_local_remove          =' . "'" . pat_local_remove . "'")
      "Decho('let pat_local_remove_universal=' . "'" . pat_local_remove_universal . "'")

      if match( getline("."), pat_local_remove) != -1
         let len_prev_sign = len(substitute(getline("."), pat_local_remove . '.*' , '\1\2','')) "len of prev sign
         exe 's:' . pat_local_remove . ':' . FWK_CSpace(len_prev_sign) . ':'
         "Decho('let len_prev_sign#1=' . "'" . len_prev_sign . "'")

      else
         if match( getline("."), pat_local_remove_universal) != -1 "remove previous sign, and put new in one operation
            let len_prev_sign = len(substitute(getline("."), pat_local_remove_universal . '.*', '\1\2','')) "len of prev sign
            exe 's:' . pat_local_remove_universal . ':' . FWK_CSpace(len_prev_sign) . ':'
            "Decho('let len_prev_sign#2=' . "'" . len_prev_sign . "'")

         endif

         exe 's:^' . FWK_CSpace(lsign_len) . ':' . ':'
         exe 's:^:' . lsign . ':'

      endif


      exe 'normal 0'
   else
      echo 'no mark to comment, action skipped'
      return
   endif

endfunc




func FWK_Note_Mark_getNumbLine ( symbol, pattern )

    let l:numb = 0
    let l:isDigit = 1
        if a:pattern ==  '\a'
        let l:isDigit = 0
    endif

    if a:symbol != '' "let's incrimate

        "Decho('l:isDigit=' . l:isDigit)

    let strToPaste      = ' '

    if l:isDigit == 1
            let l:numb = eval(a:symbol)
        let l:numb += 1
        let l:numb = string(l:numb)

    else
            let l:numb = substitute(a:symbol,'[\ ]','','g')
        let l:numb = g:FWK_Note_Mark_Regex_Increment_SymbolDict[l:numb]

    endif

    else "let's give first characters
        if l:isDigit == 1
            let l:numb = '1'
        else
            let l:numb = 'a'
        endif
    endif

    "Decho('l:numb=' . l:numb)
    let str_to_append = FWK_Forme_String_With_Spaces(l:numb, a:pattern)
    "Decho('str_to_append=' . str_to_append )
    return str_to_append
endfunc


func FWK_Note_Mark_Regex_w_new_recours_search(pat, direction)

        let netxIter = a:direction
        "recourse search, to descend to the bottom line in which we can found 'x)' part
        while match( getline(line(".") + netxIter + 1), a:pat)  != -1
            let netxIter += a:direction
        endwhile

        return (netxIter - a:direction)
endfunc

"aller à haut/bas tag 
func FWK_Note_MoveToTags(direction)

    let pat = '-#.*-#'
    if a:direction == 1
        call search(pat,'b')

    elseif a:direction == -1
        call search(pat)

    else
        echo 'wrong function value'
        return

    endif

    "exe ':' . ( line(".") + 1)

endfunc
"function de Vocabulaire  pour mettre (f) dans la phrase
func FWK_Note_SetFeminine()

    if match(getline("."),'[-—]')
        call search('[-—]')
        exe 'normal ' . 'hi (f)'
        exe 'normal ' . '0'
    endif

endfunc

" créer/continuer l'arbre alpha) ou digital) 
"
func FWK_Note_Mark_Regex_Char(symbol)
    let currLine                = line(".")
    let line_to_put = FWK_Forme_String_With_Spaces( a:symbol, a:symbol )
    call append(currLine, line_to_put)
    call FWK_Note_Mark_moveCursOneLine(1)
    startinsert!


endfunc
func FWK_Note_Mark_Regex_w_new(pattern)

    let pat_init_search         = '\s' . a:pattern . ')\s'
    let pat_get_last_symb       =  '.*\s\(' . a:pattern .'\)).*' 
    let pat_digit_search        =  '.*\s\('  . '\d'      .'\)).*' 

    "let pat_init_search         = '\s' . a:pattern . '\?)\s'
    "let pat_get_last_symb       =  '.*\s\(' . a:pattern .'\?\)).*' 
    "let pat_digit_search        =  '.*\s\('  . '\d'      .'\?\)).*' 

    let currLine                = line(".")
    let lineToCheck             = 0
    let last_symbol             = ''
    let canWe_Break_Alpha_Chain = 0

    "Decho('pat_init_search=' . pat_init_search)
    "Decho('pat_get_last_symb=' . pat_get_last_symb)
    "Decho('currLine =' . currLine )

    while lineToCheck <= currLine
        let line_to_check = getline(lineToCheck)

        "Decho('line=' . lineToCheck )
        "Decho('line_to_check=' . line_to_check )

        if match ( line_to_check, pat_init_search) != -1
            let last_symbol  = substitute(line_to_check, pat_get_last_symb,'\1','')
            "Decho ('line=' . line(".") . 'last_symbol=' . last_symbol )
            let canWe_Break_Alpha_Chain = 0
        endif

        if a:pattern == '\a' "we must know, can we break a chain of enumeration of alpha's
			"Decho('ici')
            if match ( line_to_check, pat_digit_search) != -1
                let canWe_Break_Alpha_Chain = 1
            endif
        endif

        let lineToCheck += 1
    endwhile
        
        
        let line_to_put = ''
        
        if canWe_Break_Alpha_Chain "can we break chain of alpha's ?
            let line_to_put = FWK_Note_Mark_getNumbLine( '', a:pattern )

        elseif last_symbol != ''
            let line_to_put = FWK_Note_Mark_getNumbLine ( last_symbol, a:pattern )

        else
            let line_to_put = FWK_Note_Mark_getNumbLine( '', a:pattern )

        endif

        "Decho('line_to_put=' . line_to_put)
        call append(currLine, line_to_put)
        call FWK_Note_Mark_moveCursOneLine(1)

    startinsert!

endfunc

func FWK_Forme_String_With_Spaces(symbol, pattern)
        "Decho('a:symbol=' . a:symbol)
        let l:tab = '    '
        let first_symbol = l:tab . l:tab . l:tab . l:tab . l:tab . l:tab . l:tab . l:tab
        if a:pattern == '\d'
            let first_symbol .= a:symbol
        let first_symbol .= ') '
        elseif a:pattern == '\a'
            let first_symbol .= l:tab . a:symbol
        let first_symbol .= ') '
        elseif a:pattern == '-'
            let first_symbol .= l:tab . a:symbol
        let first_symbol .= ') '

        else
            "Decho( 'FWK_Forme_String_With_Spaces: pattern wrong, exit')
            return
        endif
        return first_symbol

endfunc

func FWK_Note_Mark_Regex_comment_new()
       exe "normal 0"
       exe "normal " . "i#----------# \<Space>"
endfunc

func FWK_Note_Mark_Regex_new_part()
    startinsert! "start insert mode, like A
       exe "normal \<Enter>-"
endfunc


func FWK_Note_Navigation_search_in_month(path_bgn, cur_local_day, path_end, action_type)
    let max_day = 31
    let min_day = 1
    let local_day = a:cur_local_day

    if isdirectory(a:path_bgn)
        "Decho('path_bgn = ' . a:path_bgn)
        while local_day >= min_day && local_day <= max_day

            let local_day = FWK_Note_Navigation_convert_numb_to_twobyte(local_day)

            let new_note_file = a:path_bgn  . local_day . a:path_end
            "Decho('local day=' . local_day)
            "Decho('new_note_file = ' . new_note_file)

            if filereadable(new_note_file)
                return new_note_file
            endif

            let local_day += a:action_type

        endwhile

    endif

    return ''
endfunc


func FWK_Note_Navigation_convert_numb_to_twobyte(variable)

    if len(string(a:variable)) == 1
        return  '0' . string(a:variable)
    else
        return a:variable
    endif

endfunc
func FWK_Note_Navigation(action_type)

    let notes_path_pat           = '\(.*\)\(\d\{4\}\)\(\\\)\(\d\{2\}\)\(_\w\+\)'
    let notes_file_name_pat      = '\(\d\+\)\(\.\)\(\u\l\+\)\(\.\)\(\d\{4\}\)\(_\)\(\w*\)\(\.\)\(\l\+\)'

    let notes_file_name          = expand ("%:t")
    let local_day                = substitute(notes_file_name, notes_file_name_pat, '\1','')
    let notes_type               = substitute(notes_file_name, notes_file_name_pat,'\7','')

    let notes_path               = expand ("%:p:h")
    let path_bgn                 = substitute(notes_path,notes_path_pat,'\1','')
    let slash                    = substitute(notes_path,notes_path_pat,'\3','')
    let local_year               = substitute(notes_path,notes_path_pat,'\2','')
    let local_month              = substitute(notes_path,notes_path_pat,'\4','')

    let max_month                = 12
    let min_month                = 1


    if a:action_type == -1 || a:action_type == 1

        while 1

            let path_coller_bgn = path_bgn . local_year . g:cr_slash . local_month . '_' . g:FWK_Note_Calendrier_Dict[eval(local_month)] . g:cr_slash
            let reste_string    = '.' . g:FWK_Note_Calendrier_Dict[eval(local_month)] . '.' . local_year . '_' . notes_type . '.notes'


                let file_to_open    = FWK_Note_Navigation_search_in_month(path_coller_bgn , (local_day+a:action_type), reste_string, a:action_type)

            if file_to_open == ''

                let answer = ''
                let answer_echo = 
                            \'No files found in notes type ' . notes_type .
                            \', in month '                   . g:FWK_Note_Calendrier_Dict[eval(local_month)] . 
                            \', in year '                    . local_year

                if  (local_month + a:action_type) > max_month 
                            \|| (local_month + a:action_type) < min_month
                    let answer = input(answer_echo . '. Continue search in next year (y/n)?')

                    if  answer == 'y' || answer == 'Y' 
                        let local_year += a:action_type

                        if a:action_type == 1
                            let local_month = 0
                        else
                            let local_month = 13
                        endif

                    endif

                else
                    let answer = input(answer_echo . '. Continue search in next month (y/n)?')
                endif

                if  answer == 'y' || answer == 'Y' 
                    let local_month += a:action_type

                    let local_month = FWK_Note_Navigation_convert_numb_to_twobyte(local_month)

                    if a:action_type == 1
                        let local_day = 0
                    else
                        let local_day = 32
                    endif
                else
                    break
                endif

            else
                exe 'e ' . file_to_open
                break

            endif


        endwhile


    else
        echo 'FWK_Note_Navigation: wrong function arguments, skipped'
    endif



endfunc
            

func FWK_Note_Notifyer_Wrapper(message, time)
    "call FWK_Note_Notifyer_Wrapper("hello From Vim", '22.02.2011.33:33')
    "echo 'time_to_propose"' . time_to_propose .'"'
    "if time_to_propose != ""
        let ex_str ='nc.bat' . ' "-m' . a:message . '" -d' . a:time 
        echo ex_str
        echo system(ex_str)
    "endif


    "return time_to_propose

endfunc

"map \nh :call FWK_Note_LoadNotes
            "\(
            "\  'change_static', 'CommonTasks'
            "\, 'change_dynamic', 'Daily', 'Vocabulaire'
            "\)<CR>


command! -n=1 FwkNoteStatic  :call FWK_Note_create_static('<args>')
command! -n=1 FwkNoteDynamic :call FWK_Note_create_dynamic('<args>')
command! -n=0 FwkNoteDaily   :call FWK_Note_create_dynamic('Daily')


"INIT GLOBAL
autocmd BufRead,BufNewFile *.notes		set filetype=notes
autocmd FileType        notes,conf call FWK_Note_NotesMaps() "set maps for notes