  
if v:version < 701 
  finish 
endif 


"Global variables

if     has('win32') | let g:fwk_gl_iswin32 = 1 | else | let g:fwk_gl_iswin32 = 0 | endif
if !exists('g:cr_slash') && !exists('g:relative_path') "set global cross platform slash and path of vim
if     has('win32')                  | let g:cr_slash = '\' | let g:relative_path = $HOME        | 
elseif has('unix') || has('macunix') | let g:cr_slash = '/' | let g:relative_path = $HOME        |
else                                 | let g:cr_slash = '/' | let g:relative_path = $VIM         | endif | endif





"//--------------------------------------------------------------------

if !exists('g:regex_pattern_error_hbbl')  
    let g:regex_pattern_error_hbbl = "error:\\|warning:\\|undefined\ reference\\|(Permission\ denied)"
endif

"----------------------------------- 
" FUNCTIONS 
"----------------------------------- 
 
"--------------------------------------------------------------------
"Description: search register like vim-search-regex pattern
"--------------------------------------------------------------------
function! SearchRegisterLikePattern() 
    let l:searchVariable = @* 
    exe "/" . "\\\<" . l:searchVariable . "\\\>/\b" 
    "exe "normal b" 
endfunction 
"--------------------------------------------------------------------



"--------------------------------------------------------------------
"Description: File explorer tree wrapper, by <a-f> open/close nerd_tree 
"--------------------------------------------------------------------
if !exists('g:FileExplorerWrapperVariable') 
    let g:FileExplorerWrapperVariable = 0 
endif 

function! OpenCloseFileExporerFunction(variable) 

    exe "lcd %:p:h" 

    if a:variable == "NERD" 
        if g:FileExplorerWrapperVariable == 0 
            let g:FileExplorerWrapperVariable = 1 
            exec "NERDTree" 
            echo "nerd tree open" 
        else 
            let g:FileExplorerWrapperVariable = 0 
            exec "NERDTreeClose" 
            echo "nerd tree close" 
        endif 
    elseif a:variable == "VTREE" 
        if CloseBufferVTreeExplorer() == -1 
            exec "VSTreeExplore" 

            echo "VSTreeExplore opened" 
        else 
            echo "VSTreeExplore closed" 
        endif 

    endif 

endfunction 
"--------------------------------------------------------------------

"//--------------------------------------------------------------------------------- 
"""""""""""""""""""' 
"highlight EMPTY spaces by red line 
"""""""""""""""""""" 
if !exists('g:onOffTrigger') 
    let g:onOffTrigger = 0 
endif 
"//--------------------------------------------------------------------------------- 
function! ShowWrongSpaces () 
    highlight BadWhitespace ctermbg=red guibg=red 

    if g:onOffTrigger == 0 
        match BadWhitespace /^\t\+/ 
        match BadWhitespace /\s\+$/ 
        let g:onOffTrigger = 1 
        echo "show whitespaces on" 
    else 
        match BadWhitespace // 
        let g:onOffTrigger = 0 
        echo "show whitespaces off" 
    endif 

endfunction 
"//--------------------------------------------------------------------------------- 




"""""""""""""""""""""" 
"cool function. When i close buffer, he will go to prev buffer(in standart it 
"go to the first 
function! SwitchToNextBuffer(incr) 
    let help_buffer = (&filetype == 'help') 
    let current = bufnr("%") 
    let last = bufnr("$") 
    let new = current + a:incr 
    while 1 
        if new != 0 && bufexists(new) && ((getbufvar(new, "&filetype") == 'help') == help_buffer) 
            execute ":buffer ".new 
            break 
        else 
            let new = new + a:incr 
            if new < 1 
                let new = last 
            elseif new > last 
                let new = 1 
            endif 
            if new == current 
                break 
            endif 
        endif 
    endwhile 
endfunction 

"nnoremap <silent> <C-n> :call SwitchToNextBuffer(1)<CR> 
"nnoremap <silent> <C-p> :call SwitchToNextBuffer(-1)<CR> 

"""""""""""""""""""" 
" tab competition ?? 
function InsertTabWrapper() 
    let col = col('.') - 1 
    if !col || getline('.')[col - 1] !~ '\k' 
        return "\<tab>" 
    else 
        return "\<c-p>" 
    endif 
endfunction 
imap <tab> <c-r>=InsertTabWrapper()<cr> 

"""""""""""""""""""" 
"function to find buffer with Makefile or jamroot.jam 
"this is sub-function 
function! FindMakefileOrJamroot() 

    let l:fullPathToChange = "" 
    for i in range(1, bufnr("$")) 
        if buflisted(i) 
            if (fnamemodify(bufname(i),":t") == "Makefile" || fnamemodify(bufname(i),":t") == "jamroot.jam") 
                let l:fullPathToChange = fnamemodify(bufname(l:i),":p") 
                break 
            else 
                "echo "Not found Makefile or jamroot.jam" 
            endif 
        endif 
    endfor 
    return l:fullPathToChange 

endfunction 


"""""""""""""""""""" 
"find application files !ls -RAX
"ls -RAX|grep ".exe$" 
""""""""""""""""""""" 
" multiPattern search + color highlight 
function TwoMatchColor(first, second) 
    if a:first != "" 
        exe ":2match matchFirst /" . a:first . "/" 
    else 
        exe ":2match matchFirst //" 
    endif 

    if a:second != "" 
        exe ":3match matchSecond /" . a:second . "/" 
    else 
        exe ":3match matchSecond //" 
    endif 

endfunction 

""""""""""""""""""""" 
"switch to source or header 
function! SwitchSourceHeader() 
    "update! 
    if (expand ("%:t") == expand ("%:t:r") . ".cpp") 
        "find %:t:r.hpp 
        find %:t:r.h* 
    else 
        find %:t:r.c* 
        "find %:t:r.cpp 
    endif 
endfunction 

nmap ,s :call SwitchSourceHeader()<CR> 



"simple compile without make files function 
""""""""""""""""""""""""""""""""""" 
func! CompileRunGcc() 
    exec "w" 
    exec "!g++ % -o %<" 
    exec "! %<" 
endfunc 

"function to format current string like upper or downed string 
func! FormatStringWithCloser(pattern) 

    if( line(".") != 0 || line(".") != line("$") ) 
        "{ 

        exe "normal" 'Y' 
        let currentLineStatus = stridx(@@, " ") 

        if( a:pattern == "Upper") 
            exe "normal 0\<Up>" 

        elseif( a:pattern == "ToDown") 
            exe "normal 0\<Down>" 

        else 
            echo "wrong argument pattern" 
            return 
        endif 

        exe "normal" 'Y' 
        let SecondLineStatus = stridx(@@, " ") 

        if ( SecondLineStatus == 0 ) 
            "{ 
            exe "normal" 'yw' 
            "} 
        endif 

        if( a:pattern == "Upper") 
            "{ 
            exe "normal 0\<Down>" 
            "} 
        elseif( a:pattern == "ToDown") 
            "{ 
            exe "normal 0\<Up>" 
            "} 
        endif 

        if ( SecondLineStatus == 0 && currentLineStatus == 0 ) 
            "{ 
            exe "normal" 'p' 
            exe "normal" 'dw' 
            "} 
        elseif ( SecondLineStatus == 0 && currentLineStatus != 0 ) 
            "{ 
            "put space 
            exe "normal"   'i ' 

            exe "normal" 'p' 

            "del space 
            exe "normal" 'dw' 
            "} 
        elseif ( SecondLineStatus != 0 && currentLineStatus == 0 ) 
            "{ 
            exe "normal" 'dw' 
            "} 
        else 
            "{ 
            echo "nothing to do" 
            "} 
        endif 

    else 
        "{ 
        echo "wrong current line" 
        "} 
    endif 
endfunc 

""""""""""""""" 
"file name 
func! FWK_get_Variable(pattern) 

    let l:file_name = ""
    if(a:pattern == "file_name") 
        let l:file_name = expand ("%:t") 

    elseif (a:pattern == "file_name_without_ext")  
        let l:file_name = split(expand("%:t"),'\.')[0]

    elseif (a:pattern == "path_only")  
        let l:file_name = expand ("%:p:h") 

    elseif (a:pattern == "path_only_rev")  
        let l:file_name = substitute(expand("%:p:h"),"\\","/","g")

    elseif (a:pattern == "absolute_path")
        let l:file_name = expand ("%:p")

    elseif (a:pattern == "absolute_path_rev")  
        let l:file_name = substitute(expand("%:p"),"\\","/","g")

    elseif (a:pattern == 'curr_dir')  
        let l:file_name = expand("%:p:h:t")

    elseif (a:pattern == 'GetTime')  
        let l:file_name = strftime("%d.%b.%Y")


    else 
        echo "Wrong pattern string" 
        return 
    endif 

    "let l:lPos = line(".")
    "call append((l:lPos-1), fileName)
    "execute ":" . (l:lPos)

    let @* = l:file_name 
    ""exe "normal" 'p' 
endfunc 
""""""""""""""""""""""""""""""""""" 
func! FormatScreen() 
    let l:whereWeBeenBeforePosition = line(".") 
    exe "normal" 'ggVG=' 
    execute ":" . l:whereWeBeenBeforePosition 

endfunc 

func! WordCopyPasteFunction(pattern) 

    let cur_word = expand('<cword>')
    if (a:pattern == 'Copy')
        "exe 'match Search /' . cur_word . '/'
        let @/ = '\<' . cur_word . '\>'
        execute 'normal ' . 'viw'

    elseif (a:pattern == 'Remove') 
        let cur_word = expand('<cword>')
        let @/ = '\<' . cur_word . '\>' "register for search
        let @* = cur_word               "register for standart clipboard
        "execute 'normal ' . 'viw' . "\<Del>"
        execute 'normal ' . 'ciw' 

    elseif (a:pattern == 'Paste') 
        execute 'normal ' . 'ciw'
        "execute "normal" "ciw\<c-o>\"*p"


    else 
        echo 'Wrong parameter!' 

    endif 
    "exe 'normal \<Esc>' 
    "exe 'normal \<S-Ins>' 
endfunc 

"//--------------------------------------------------------------------------------- 
"FUNCTION TO BLOCK ARROW MUVEMENT IF WE ARE NOT IN CENTRAL SPLIT WINDOW 
"(SPECIAL FOR MINIBufExplorer) 
"//--------------------------------------------------------------------------------- 
func! CursorBufferManipulation(cursorManipulation) 
    "//--------------------------------------------------------------------------------- 

    let l:whereisBufferMenu = bufwinnr(buffer_number("-MiniBufExplorer-")) 

    if l:whereisBufferMenu != -1 

        let l:whereWeAtWindow = winnr() 

        exe "silent ". l:whereisBufferMenu."wincmd w" 
        exe "silent ". "wincmd j" 

        if a:cursorManipulation == "LEFT" 
            exe "silent "."bp" 
            exe "silent ".l:whereWeAtWindow."wincmd w" 
        elseif a:cursorManipulation == "RIGHT" 
            exe "silent "."bn" 
            exe "silent ".l:whereWeAtWindow."wincmd w" 
        else 
            echo "Wrong argument!!!" 
        endif 
    else 
        echo "there is no buffer "."MiniBufExplorer" 
    endif 

endfunc 
"//--------------------------------------------------------------------------------- 
" 
"//--------------------------------------------------------------------------------- 
"REGISTER DIFF IN temporaryBuffers 
"//--------------------------------------------------------------------------------- 
func! DiffTwoRegisters(registerA, registerB, command) 

    if a:command == "ON" 
        exe "silent e diffBufferTemporary_LEFT" 
        exe "silent normal \"" . a:registerA . "p" 
        exe "silent diffthis" 
        exe "silent vs" 
        exe "silent wincmd w" 
        exe "silent e diffBufferTemporary_RIGHT" 
        exe "silent normal \"" . a:registerB . "p" 
        exe "silent diffthis" 
    elseif a:command == "OFF" 

        if bufexists("diffBufferTemporary_LEFT") 
            exe "silent bw! diffBufferTemporary_LEFT" 
        endif 
        if bufexists("diffBufferTemporary_RIGHT") 
            exe "silent bw! diffBufferTemporary_RIGHT" 
        endif 

    endif 
endfunc 




"//---------------------------------------------------------------------------------
"Visual Studio alignment when we close lower bracket }
"//--------------------------------------------------------------------------------- 
func! CSharpAlign() 

    let l:ourPos = line(".") 
    exe "normal %" 
    let l:UpperBraketPos = line(".") 
    let l:LinesToAlign = l:ourPos - l:UpperBraketPos 
    exe "normal ". l:LinesToAlign ."==" 
    exe "normal %" 

endfunc 
"//--------------------------------------------------------------------------------- 


"//---------------------------------------------------------------------------------
"FUNCTION FOLDING
"//---------------------------------------------------------------------------------
func s:FoldLocalCommands(options)
    "remove function marker
    if a:options == 0
        exe "normal zd" 
        ""add function marker
    elseif a:options == 1
        let l:ourPos = line(".") 
        :/{
        exe "normal %" 
        let l:DownBracket = line(".") 
        let l:LinesToChange  = l:DownBracket - l:ourPos
        exe "normal zf" . l:LinesToChange . "\<Up>"
    endif
endfunc
"//---------------------------------------------------------------------------------
command! -n=1 FoldLocalCommands :call s:FoldLocalCommands('<args>')

func s:ScrollRotateFunction(options)
    
    "rotate Up
    if a:options == 0
        exe "normal " . winheight("%") . "\<Up>"
    "rotate Down 
    elseif a:options == 1
        exe "normal " . winheight("%") . "\<Down>"
    endif
    exe "normal z."

    
endfunc
command! -n=1 ScrollRotateFunction :call s:ScrollRotateFunction('<args>')





"//---------------------------------------------------------------------------------
"FWK FRAMEWORK
"//---------------------------------------------------------------------------------


let g:FWK_file_ext_dictionary =
    \{
    \ 'cpp'  :['h', 'hpp']
    \,'hpp'  :['c', 'cpp', 'm']
    \,'c'    :['h', 'hpp']
    \,'m'    :['h']
    \,'h'    :['c', 'cpp', 'm']
    \,'test' :['valid']
    \,'valid':['test']
    \,'mll'  :['mly']
    \,'mly'  :['mll']
    \}

"//--------------------------------------------------------------------
"Description: switch files extentions according to  g:FWK_file_ext_dictionary values
"//--------------------------------------------------------------------
func FWK_Extention_Switch(mode)
    let dict_ext_key = expand ("%:e")

    if dict_ext_key != ''
        let extList = split(dict_ext_key) "centralize same file, split to create list

        if has_key(g:FWK_file_ext_dictionary, dict_ext_key) "have special extentions ? let's replace by them
            let extList = g:FWK_file_ext_dictionary[dict_ext_key]
        endif

            let file_name = split(expand("%:t"),'\.')[0]

            if a:mode == 'current_dir_switch' "switch file by ext, in same dir

                let prevPath = &cd "save path
                lcd %:p:h

                for ext in extList
                    if filereadable(file_name . '.' . ext )
                       exe 'e ' . file_name . '.' . ext
                       break
                    endif
                endfor

                let &cd = prevPath "restore path

            elseif a:mode == 'simple_switch' "switch file, if he is loaded before
                for ext in extList

                    let l:bufNumber = bufnr(file_name . '.' . ext)

                    if l:bufNumber != -1
                        exe 'b ' . l:bufNumber
                        return
                    endif

                endfor

                echo "FWK_Extention_Switch: file wasn't loaded before, skipped ..."

            elseif a:mode == 'project_switch' "switch to file in a 'Project'

                let l:fileBarWindow = winnr()

                if (g:proj_window_number != 0) "switch to 'Project' window
                    execute g:proj_window_number . "wincmd w"
                else
                    echo 'FWK_Extention_Switch var g:proj_window_number not set, in the begin launch Project'
                    return
                endif

                let search_result = 0
                let last_ext = ''
                for ext in extList

                    let last_ext = ext
                    let search_result = search('\<' . file_name . '.' . ext  . '\>')
                    "Decho('file=' . file_name . '.' . ext)
                    if  search_result != 0
                        break
                    endif

                endfor

                if search_result == 0
                    echo 'FWK_Extention_Switch: cant find file=' . file_name . ', extention=' . last_ext . ', in Project, skipped.'
                    return
                endif


                "centralize
                exe "normal " . "zz"

                "open all folds 
                exe "normal " . "zO"

                "highlight
                exe ":2match ProjectBarFindFile /" . file_name . '.' . ext . "/" 

                "enter
                exe "normal " . "\<CR>"

                "if it was fold, push ENTER one more time"
                if winnr() != l:fileBarWindow 
                    exe "normal " . "\<CR>"
                endif

                "let project_Name_loc = "bpc_project.prj"
                "exe "b " . bufnr(project_Name_loc)
            else
                echo 'FWK_Extention_Switch: wrong mode, please try another'

            endif



    "else
        "echo 'FWK_Extention_Switch: there is no such extention in dictionary'
    "endif

else 
    echo "FWK_Extention_Switch: this file haven't extention, skipped ..."
endif

endfunc
"//---------------------------------------------------------------------------------
" CHANGE HEADER TO CPP, AND INVERSE, DEPRICATED!
"//---------------------------------------------------------------------------------
func FWK_SwitchFromHeaderToCpp(mode)

    let l:bufName = expand("%:t:r")

    let l:bufExt  = expand("%:t:e")
    "expand("%:e")

    "C++"
    if l:bufExt == "hpp"
        let l:bufName = l:bufName . ".c"
    elseif l:bufExt == "cpp"
        let l:bufName = l:bufName . ".h"

    "C"
    elseif l:bufExt == "h"
        let l:bufName = l:bufName . ".c"
    elseif l:bufExt == "c"
        let l:bufName = l:bufName . ".h"

    else
        echo "this is C++ sources?"
        return
    endif

    let l:bufNumber = bufnr(l:bufName)
    "echo "name:" . l:bufName
    "echo "numb:" . l:bufNumber

    if a:mode == "simple"
        if l:bufNumber != -1
            exe "b " . l:bufNumber
        else
            echo "no such file " . l:bufName
        endif


    elseif a:mode == "project"

            let l:fileBarWindow = winnr()

            if (g:proj_window_number != 0)
                execute g:proj_window_number . "wincmd w"
            else
                echo "var g:proj_window_number not set, in the begin launch 'Project'"
            endif
            "exe "normal " . "`\<Left>"
            call search('\<' . l:bufName)
            "centralize
            exe "normal " . "zz"
            "open all folds 
            exe "normal " . "zO"
            exe ":2match ProjectBarFindFile /" . l:bufName . "/" 

            exe "normal " . "\<CR>"

                "if it was fold, push ENTER one more time"
                if winnr() != l:fileBarWindow 
                    exe "normal " . "\<CR>"
                endif

                "let project_Name_loc = "bpc_project.prj"
                "exe "b " . bufnr(project_Name_loc)
            endif
endfunc




"DEPRICATED
func FWK_generateCtags(project_t)

    let l:ctagsPattern = ''
    let l:ctags_file_path   = ''

    if a:project_t == 'NBT'

        let l:path1 = 'U:\_products\x86-qnx-m641-4.3.3-osp-trc-rel\gen\api\nbt\conn\browser'
        let l:path2 = 'U:\_products\x86-qnx-m641-4.3.3-osp-trc-rel\gen\imp\nbt\conn\browser'
        let l:path3 = 'U:\imp\nbt\conn\browser'

        let l:ctagsPattern    = l:path1 . ' ' . l:path2 . ' ' . l:path3
        let l:ctags_file_path = 'U:\imp\nbt\conn\browser'

    elseif a:project_t == 'NBT_D'

        let l:path1 = 'D:\P4\NBT\_products\x86-qnx-m641-4.3.3-osp-trc-rel\gen\api\nbt\conn\browser'
        let l:path2 = 'D:\P4\NBT\_products\x86-qnx-m641-4.3.3-osp-trc-rel\gen\imp\nbt\conn\browser'
        let l:path3 = 'D:\P4\NBT\imp\nbt\conn\browser'

        let l:ctagsPattern    = l:path1 . ' ' . l:path2 . ' ' . l:path3
        let l:ctags_file_path = 'D:\P4\NBT\imp\nbt\conn\browser'

    elseif a:project_t == 'VIMHOME'
        let l:ctagsPattern    = g:PLFM_VIM_VIMFILES . ' ' . g:PLFM_VIMCFG
        let l:ctags_file_path = g:PLFM_VIMCFG

    elseif a:project_t == 'CURENT_DIR'
        let l:ctagsPattern    = '.'
        let l:ctags_file_path = expand ("%:p:h")

    elseif a:project_t == 'TFC_CONSUMER'
        let l:ctagsPattern    = 'D:\workspace\visual_studio\tfc_traceClientConsumer\tfc_traceClientConsumer'
        let l:ctags_file_path = 'D:\workspace\visual_studio\tfc_traceClientConsumer\tfc_traceClientConsumer'

    else
        echo 'unknown project! Please specify it name correctly!'
    endif

    "execute '!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q ' . ctagsPattern
    "execute '!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q' . ' -f ' . l:ctags_file_path . g:PLFM_SL . 'tags' . ' '. ctagsPattern
    echo system('ctags -R --c++-kinds=+p --fields=+iaS --extra=+q' . ' -f ' . l:ctags_file_path . g:PLFM_SL . 'tags' . ' '. ctagsPattern)
    "endif
endfunc
""//--------------------------------------------------------------------

""""""""""""""""""" 
"GET SOME SNIPPET
function FWK_get_defined_patterns(pattern) 

    if ( a:pattern == "predef_if_not_def_define" ) 

        let l:ext   = (expand ("%:e"))
        let l:dir_reg_pattern   = ".*" . g:PLFM_SL
        let l:filen_reg_pattern = "["   . g:PLFM_SL . ".]"

        let l:dir   = substitute( toupper(expand ("%:p:h")), l:dir_reg_pattern   ,"" ,"")
        let l:filen = substitute( toupper(expand ("%:t"))  , l:filen_reg_pattern ,"_","g")
        "same"
        "let l:dir   = substitute( toupper(expand ("%:p:h")), ".*\\","","")
        "let l:filen = substitute( toupper(expand ("%:t")), "[\\.]","_","g")

        if ( l:ext == "hpp" || l:ext == "cpp" || l:ext == "c"   || l:ext == "h"   )
            call append( 0        , ("#define  " . "__"  . l:dir . "_" . l:filen . "__" ))
            call append( 0        , ("#ifndef  " . "__"  . l:dir . "_" . l:filen . "__" ))
            call append( line('$'), ("#endif //" . "__"  . l:dir . "_" . l:filen . "__" ))
        else
            echo "this is C/C++ file?"
        endif

    elseif ( a:pattern == "comment_sexy" ) 
        let l:sexyComment = "--------------------------------------------------------------------" 
        call append(line('.'), l:sexyComment )
        execute ":" . (line(".") + 1)
        exe "normal " . "\\cc"

    elseif ( a:pattern ==  "comment_variable" ) 
        let l:varComment = "//-------------   -------------//" 
        call append(line('.'), l:varComment )
        execute ":" . ( line(".") + 1 )
        call search(" ")

    elseif (a:pattern == 'config.vrun')
        call append(line('.'), '' )
        call append(line('.'), 'FWK_APP_RUN=' )
        call append(line('.'), 'FWK_APP_MAKE=' )
        call append(line('.'), '#Run script' )

    else 
        echo "Wrong Pattern" 
        return 
    endif 
endfunction 


function FWK__open_log_file()

    let l:lLogPath = "D:\\P4\\NTG5_Car_products\\x86-qnx-m641-4.3.3-osp-trc-rel\\"
    let l:lLogFile = "DetailedLog.hbbl"

    "let l:lLogPath = "d:\\"
    "let l:lLogFile = "log.exmp"

    let l:win_size = "10"
    "let l:window_position = "bel"
    let l:window_position = "bo"

    if(bufnr(l:lLogFile) == -1 )
        execute l:window_position . " " . l:win_size . " sp " . l:lLogPath . l:lLogFile 
        "silent setlocal nobuflisted
        execute "normal " . "gg"
    else
        let l:BufWin = bufwinnr(l:lLogFile)
        "no window?"
        if (l:BufWin == -1)
            execute l:window_position . " " . l:win_size . " sp " . l:lLogPath . l:lLogFile 
        else
            execute l:BufWin . 'wincmd w'
        endif

    endif

    "silent setlocal nobuflisted
    if ( search(g:regex_pattern_error_hbbl) != 0 )
        execute ":match Search /" . g:regex_pattern_error_hbbl . "/"
    else
        echohl Question | echo " no warning | error found" | echohl Non 
    endif

"map <F11> :OpenTabsSilent d:\log.exmp<CR>:silent setlocal nobuflisted<CR>gg/error:\\|warning:<CR>
endfunc

"//--------------------------------------------------------------------
"OPEN HBBL REFERENCE TO FILE 
"//--------------------------------------------------------------------
function FWK_openlink_log_openErrorfile()

   "same regex = s@\(.*\:.*[^0-9]\):\(\d\+\).*@\1@
   "second substitute uses for change all \\ to \ (for example U:\\ -> U:\)"

   " make double \, example of escape function
   "   let SearchP_file = escape('\(.*\:.*[^0-9]\)\:\(\d\+\).*', '\')
   
   "echo substitute(getline("."), '\("\=\a\=:\=[a-zA-Z\\]*\):\ error:.*','\1','')
   "let pattErrorStringPattern = '\(.*\:.*[^0-9]\)\:\-\?\(\d\+\).*'



   "Test STRINGS
    "U:\_products\x86-qnx-m641-4.3.3-osp-trc-dbg\gen/api/sys/oscar/pf/onoffcontroller/src/private/DSIOnOffLifeCycleInfoTypesStream.hpp:14:129: error: eliveries/nbt/B069_B1/intel/api/sys/oscar/prj/nbt/onoffcontroller/src/private/DSIOnOffLifeCycleInfoNBTTypesStream.hpp: No such file or directory
    "U:\\imp\nbt\conn\browser\application\bookmarkmgr\src\private\CBookmarkMgr.cpp:400: error: 'f' was not declared in this scope
    "U:\\imp\nbt\conn\browser\application\bpc\tools\BrowserApp\private\BrowserApp.hbac:-1: error: Workflow interrupted. Reason: Errors during validatiom.
    "U:\/imp/nbt/conn/browser/application/bpc/src/private/CCfgCtrl.hpp:23:81: error: imp/nbt/conn/browser/application/bpc/src/private/CSPTAStartUpCtrl.hpp: No such file or directory

"U:\_products\x86-qnx-m641-4.3.3-osp-trc-rel\gen/api/sys/oscar/pf/onoffcontroller/src/private/DSIOnOffLifeCycleInfoTypesStream.hpp:14:129: error: eliveries/nbt/B069_B1/intel/api/sys/oscar/prj/nbt/onoffcontroller/src/private/DSIOnOffLifeCycleInfoNBTTypesStream.hpp: No such file or directoryhbjam:-1: error: ...failed C++ U:\_products\x86-qnx-m641-4.3.3-osp-trc-rel\bin\deliveries\nbt\B069_B1\intel\api\sys\oscar\prj\nbt\onoffcontroller\src\DSIDSYSNBTLifecycleInfoStream.o ...

"U:\imp\nbt\conn\bmwpool\prj\thirdparty\openssl\include\openssl\idea.h(65): Error 309: #error IDEA is disabled.



   "get raw line
   let file_to_open = ''
   let line_to_open = ''
   let raw_str = substitute(getline("."),'\(.*\)\s\(error\|Issue\|Note\).*','\1',"")

   if match(raw_str,'.*\.o:') != -1 "in begin of string (QT pars) we see <path>/<file>.o:, remove it

        "./build_win32/obj/EmlControlWidget.o:d:\workspace\qt\rnd\svn\email\gui\Sdb_GrphicInterface/../ViewEmailClient/EmlControlWidget.cpp:361: undefined reference to `EmlNewMsg::EmlNewMsg(QWidget*)'
        
       let raw_str = substitute(raw_str,'.*\.o:','',"")
       let raw_str = substitute(raw_str,':\sundefined\sreference.*','','') "remove all after 'undefined ref...'
       let file_to_open = substitute(raw_str,'\(.*\):\(\d\+\)','\1','')
       let line_to_open = substitute(raw_str,'\(.*\):\(\d\+\)','\2','')

   "three ():
   elseif match(raw_str, '(\d\+):') != -1
       let file_to_open = substitute(raw_str,'\(.*\)(\(\d\+\)):','\1','')
       let line_to_open = substitute(raw_str,'\(.*\)(\(\d\+\)):','\2','')

   elseif match(raw_str, ':\d\+:\d\+:') != -1 "three :::
       let file_to_open = substitute(raw_str,'\(.*\):\(\d\+\):\(\d\+\):','\1','')
       let line_to_open = substitute(raw_str,'\(.*\):\(\d\+\):\(\d\+\):','\2','')


   elseif match(raw_str, ':\d\+:'     ) != -1 "three ::
       let file_to_open = substitute(raw_str,'\(.*\):\-\?\(\d\+\):','\1','')
       let line_to_open = substitute(raw_str,'\(.*\):\(\d\+\):','\2','')


   else
       echo 'wrong time of error string, skipped'
       return

   endif

   let file_to_open  = substitute(file_to_open, '\\\\\|\\\/','\\','d')

   "':\d\+:\d\+:'

   "search \\ or \/ patterns 
   "let pattDoubleBackSlash =  '\\\\\|\\\/'
   "let fileToOpen  = substitute(getline("."),pattErrorStringPattern,'\1',"")
   "let lineToOpen  = substitute(getline("."), pattErrorStringPattern,'\2','')
   
   "check filter extention"
   if (match(file_to_open,".*.hbsm:") == -1 && match(file_to_open,"hbjam:") == -1 && match(file_to_open,"BuildCentral:") == -1)

       """there is column to open?"
       if (match(line_to_open,"[0-9]") != -1)
           execute "18 sp " . file_to_open
           execute ":" . line_to_open
       else
           echo "wrong column of file, skip open file " . file_to_open
       endif

       "disable highlight"
       execute "match Search //"
   else
        echohl ErrorMsg | echo "Wrong file type, skip: " . file_to_open | echohl Non 
   endif

endfunc

function FWK_show_patterns_in_file(filter_type, path_to_log)


    if a:path_to_log == ""
        echo 'FWK_show_patterns_in_file: wrong path to log file, exit'
        return
    endif

    if a:filter_type == ""
        echo 'FWK_show_patterns_in_file: filter type is empty, exit'
        return
    endif

    let l:filter = ''

    if a:filter_type  == 'mocca_buildcentral_error'
        let l:filter = "error:\\|undefined\ reference\\|(Permission\ denied)\\|don't\ know\ how\ to\ make"

    elseif a:filter_type == 'qt_makefile'
        let l:filter = "error:\\|undefined\ reference\\|(Permission\ denied)\\|don't\ know\ how\ to\ make"

    elseif a:filter_type == 'qt_test'
        let l:filter = 'Sdb_GrphicInterface'

    else
        echo 'FWK_show_patterns_in_file: wrong filter type'
    endif

    exe 'OpenTabsSilent ' . a:path_to_log
    silent setlocal nobuflisted

    exe "normal " . 'gg'
    let @/ = l:filter
    let @* = l:filter
    "exe "normal " . '/' . @*
    exe "/" . @*
    exe "normal n"

    "strange highlight, 
    "not released after nohighlight
    "need to write to google vim community
    exe 'match Search /' . @/ . '/'


endfunc

function FWK_open_tag_in_split()
    exe "sp"
    exe "tag " . expand("<cword>")
endfunc

func FWK_open_quick_fix_not_jump()
    exe "lcd %:p:h" 
    "set makeprg=buildcentral.bat
    exe "make!"
    :cw 
    exe "lcd %:p:h" 
    if(getbufvar(bufnr("%"), "&filetype") == "qf")
        call search(g:regex_pattern_error_hbbl)
    else
        echohl Question | echo "no warning|error found" | echohl Non 
        call input("press any dict_pattern_key ... ") 
    endif
endfunc

func FWK_Book_Mode(mode)
    if ( a:mode == "on" )
        :colorscheme default
        :set guifont=Courier_New:h13:cANSI
        :set wrap
        :map <C-Up>   :let g:FWK_smooth_cur_p = getpos(".")<CR>:call SmoothPageScrollUp()<CR>:call setpos(".",g:FWK_smooth_cur_p)<CR>
        :map <C-Down>   :let g:FWK_smooth_cur_p = getpos(".")<CR>:call SmoothPageScrollDown()<CR>: call setpos(".",g:FWK_smooth_cur_p)<CR>
        :map <Up> gk
        :map <Down> gj
        :map <PageUp> gk5
        :map <PageDown> gj5
        

        :let g:smooth_page_scroll_delay = 15
        :set linebreak
        :set guicursor+=a:blinkon0
        :set number
    endif

endfunc

func FWK_fontZoomInOut(number)

    
    "TWO SUBMATCH, VERY COOL
    "echo substitute(getline("."),'\(.*\)\(\d\)\(.*\)','\=submatch(1). (submatch(2)+1)','')
    
    
    let outPutMessage = ''
    let numberToAdd = eval(a:number)

    let font_string = &guifont
    let number      = substitute(font_string,'\(\w*\)\(:\w\)\(\d\+\)\(.*\)','\=submatch(3) + '. eval(numberToAdd),'')
    let font_string = substitute(font_string,'\(\w*\)\(:\w\)\(\d\+\)\(.*\)','\1\2' . number .'\4','')

    if number > 2 && number < 25
        let &guifont    = font_string
    else
        let outPutMessage = outPutMessage . 'FWK_fontZoomInOut: number = ' . number . ' is out of boarders, skip action \n'
    endif

    set lines=200
    set columns=800

    let outPutMessage = outPutMessage . &guifont

    echohl Title | echo outPutMessage | echohl Non
    call input("Pres any key ...")


    "set guifont
    "Courier_New:h10:cANSI
    "echo substitute(font_string,'\(\w*\)\(:\w\)\(\d\+\)\(.*\)','\=submatch(3) + 1','')
    "echo substitute(font_string,'\(\w*\)\(:\w\)\(\d\+\)\(.*\)','\=submatch(3)+1. "=" . submatch(0)','')
    "echo substitute(font_string,'\(\w*\)\(:\w\)\(\d\+\)\(.*\)','\=submatch(3)+1 . submatch(1)','')
    "
    "question to vim.org
    "echo substitute(font_string,'\(\w*\)\(:\w\)\(\d\+\)\(.*\)','\=submatch(3)+1 . submatch(3) + eval(10)','')

endfunc







func FWK_ExampleRegExPlusIncrement()
    let l:searchResult = 1
    let l:currentLine  = 0

    let l:searchPattern = '<ID>[-]\?\d*<\/ID>'
    
    "let l:searchPattern  = "hello"
    "let l:replacePattern = "mambo"

    let l:incr = 1

    while l:searchResult > 0

        let l:searchResult = search(l:searchPattern)

        if l:currentLine >= line(".")
            break 
            echo "parsing is over, exit"
        else
            let l:currentLine = line(".")
            "search in file repeats, exit"
        endif


        if l:searchResult != 0
            "let s:words_matcher = "s:" . l:searchPattern . ":" . l:replacePattern  . l:incr . ":"
            let s:words_matcher = "s:" . l:searchPattern . ":" . '<ID>' . l:incr . '<\/ID>' . ":"
            "Decho("s:words_matcher=" . s:words_matcher)
            exe s:words_matcher
        endif
        let l:incr += 1

    endwhile

endfunc



"if !exists('g:FWK_Grep_exclude') 
    "let g:FWK_Grep_exclude = '' 
"endif 


"func FWK_GrepWrapper(...)

    ""Decho('FWK_GrepWrapper: a:1' . a:1)
    ""Decho('FWK_GrepWrapper: a:2' . a:2)
    ""Decho('FWK_GrepWrapper: a:3' . a:3)

    "let exludeStr = ''
    "for exlude in split(g:FWK_Grep_exclude, '\ ')
        "let exludeStr = exludeStr . '--exclude-dir=' . exlude . ' '
    "endfor

    ""a:1 - flags
    ""a:2 - search pattern
    ""a:3 - files ext
    "echo  'Grep ' . a:1 . ' ' . exludeStr . a:2 . ' ' . a:3
    "exe   'Grep ' . a:1 . ' ' . exludeStr . a:2 . ' ' . a:3



"endfunc

"command -n=* GrepW   call FWK_GrepWrapper(<f-args>) 
"command -n=* -complete=file GrepW   call FWK_GrepWrapper('<f-args>') 

func FWK_CSpace(numb)
    let space_str = ''
    for i in range(1, a:numb)
        let space_str .= ' '
    endfor
    "Decho('space_str="' . space_str . '"')
    return space_str
endfunc

function FWK_Buf_Substitute(pat)
   exe a:pat
endfunc

func FWK_System_AddSlash(variable)
    return substitute(a:variable,'\\','\\\\','g')
endfunc

func FWK_System_AddSlashToSpace(variable)
    return substitute(a:variable,' ','\\\\\ ','g')
endfunc

func FWK_System_Fuf_browse(path_to_open)
    exe "cd " . a:path_to_open
    exe "FufFileWithFullCwd"
endfunc

func FWK_System_Dot_MayComplete()
    "Decho("FWK_System_Dot_MayComplete called")
    let pre_last_char = strpart(getline("."),col(".")-2, 1) "get pre . character
    if pre_last_char =~ '[a-zA-Z0-9(]'
        "c-x c-o -- standart omni complete, c-n -- choose first item"
        return ".\<C-X>\<C-O>\<C-N>" 
        
    endif
    return '.'
endfunc

function FWK_System_IsWin32Platform()
if has('win32')
    return 1
endif
    return 0
endfunc

function FWK_System_FilTemplate(template, mark_name, mark_value)
    return substitute(a:template, a:mark_name, a:mark_value,'')
endfunc

function FWK_Error(message)
    echo a:message
    return 1
endfunc


"//--------------------------------------------------------------------
"Description: use cursor movement.
"x>0 - right
"x<0 - left
"y>0 - up
"y<0 - down
"x=0 && y=0 - enter
"//--------------------------------------------------------------------
func FWK_Move_Operation(x, y)

    let x_action = ''
    let y_action = ''
    let x_y_action = ''

    if a:x > 0
        let x_action = "\<Right>"
    elseif a:x < 0
        let x_action = "\<Left>"
    endif 

    if a:y > 0
        let y_action = "\<Up>"
    elseif a:y < 0
        let y_action = "\<Down>"
    endif 


    if a:x == 0 &&  a:y  == 0
        exe "normal \<Enter>"
    else
        if  a:x != 0
            exe "normal" . x_action 
        endif 

        if a:y != 0
            exe "normal" . y_action
        endif 

    endif 




endfunc

func FWK_getCurrPos()
    return getpos(".")
endfunc

func FWK_setCurrPos(fwk_pos)
    call setpos(".", a:fwk_pos)
endfunc



"//--------------------------------------------------------------------
"Description: make any symbol double (for example " -> ""; ' -> '' and so on )
"//--------------------------------------------------------------------
func FWK_pasteDoubleQuote_init_map(t_symbol_open, t_symbol_close)
    if a:t_symbol_open != "'"
        exe 'imap ' . "<buffer> " . a:t_symbol_open. ' <Esc>:call FWK_pasteDoubleQuote(' . "'" . a:t_symbol_open . "'" . ',' . "'" . a:t_symbol_close . "'" . ')<CR>'
    else
        exe 'imap '  . "<buffer> " . a:t_symbol_open. ' <Esc>:call FWK_pasteDoubleQuote(' . '"' . a:t_symbol_open . '"' . ','. '"' . a:t_symbol_close . '"' . ')<CR>'
    endif
endfunc


func FWK_pasteDoubleQuote(t_symbol_open, t_symbol_close)

    "un map 'symbol' pour éviter loop (otherwise, this function will be called inf times (ex# n ? paste n; n ? paste n ....)
    
   
    exe 'iunmap <buffer>' . a:t_symbol_open

    let l_insertmode = 'a'
    if FWK_IsBeginOfLine()
        let l_insertmode = 'i'
    endif

    "past symbols
    exe "normal " . l_insertmode . a:t_symbol_open . a:t_symbol_close

    "map symbol
    call FWK_pasteDoubleQuote_init_map(a:t_symbol_open, a:t_symbol_close )

    "experemental function, to get in center of two spaces ( |Here| )
    if len(a:t_symbol_close) > 1
        call FWK_Move_Operation( -1, 0)
    endif

    startinsert "start insert mode
endfunc


"//--------------------------------------------------------------------
"Description: get information, is this is begin ( zero pos ) of line (to decide, use insert mode
"'i' or 'a'
"//--------------------------------------------------------------------
func FWK_IsBeginOfLine()
    "if  getpos(".")[2] == 1
    if  virtcol(".") == 1
        return 1
    endif

    return 0
endfunc
    

"//--------------------------------------------------------------------
"Description: function to enable syntax for file
"Parameters: syn_types ( 'i'| 'a') 
"//--------------------------------------------------------------------
func FWK_EnableSyntax(syn_types)
    for i in a:syn_types
        if exists('b:current_syntax')
            unlet b:current_syntax
        endif
     exe 'runtime! syntax/' . i
    endfor
endfunc




"--------------------------------------------------------------------
"Description: save curr path (where we are)
"--------------------------------------------------------------------
let g:fwk_current_path_global = ''


func FWK_save_curr_path()
    let g:fwk_current_path_global = getcwd()
endfunc

"--------------------------------------------------------------------
"Description: restore saved 'g:fwk_current_path_global' path
"--------------------------------------------------------------------
func FWK_restore_curr_path()
    if g:fwk_current_path_global != ''
        exe 'cd ' . g:fwk_current_path_global
    endif
endfunc

"--------------------------------------------------------------------
"Description: change path to current dir
"--------------------------------------------------------------------
func FWK_change_curr_path()
    exe 'cd %:p:h'
endfunc




