
"Name: Buffer reminder Remix version
"Version: 0.8
"Autor: Vakulenko Sergiy
"Description: I rewrite this plugin because prev. version of plugin not work properly with tabs/windows.
"
"Versions change log
"0.7
"- load from file regex pattern was updated by '+' and '-' symbols
"- added restore view of main window (help lines)
"
"0.8 - add save vim instance width
"    - add winx winy position of windows
"      Attention! vim (win32) on getwinposx|y return always -1 :( . Gvim and
"      vi works fine.
"    - Also, I detect that if you run vim with vim file.ext, last opened
"      buffer will be loaded last. Need to something do with that
"      1. for exemple run vim standalone. 
"      2. create shell script and use it to add opened buffer to exist vim session 
"      !#/bin/sh
"      gvim --remote-tab-silent +tabmove999 $1
"      ou
"      gvim --remote-silent $1
"0.9 - Fix reset of viewport of last window and split views.
"      Also, I fix restore of last tab.
   

"I recommend use vim tab concept with this plugin.
"I tested more then 3 month this plugin before submit it. It's works perfectly. For you i hope too.

"Sorry for this "soft" type of documentation. Next time i will create vim doc file.
"Also you can mail me if you have supplementary questions about options.
"
"





"-------------------------------------------
"VARIABLES DESCRIPTION:
"-------------------------------------------

"-------------------------------------------
"Variable: g:BuffReminderRMX_SkipLoadBuffersOnArgc 0|1
"-------------------------------------------
"Description: if vim was called with arguments (vim file1.ext ... ), by default (1), we
"skip loading of persistency.

"-------------------------------------------
"Variable: g:BuffReminder_enablePlugin (bool)
"-------------------------------------------
"Description: - by default - plugin is disabled. To make it work set BuffReminder_enablePlugin:
"let g:BuffReminder_enablePlugin = 1

"-------------------------------------------
"Variable: g:BuffReminderRMX_OpenFirstTabByDefault (bool)
"-------------------------------------------
"Description: - open first tab by default

"-------------------------------------------
"Variable: g:BuffReminderRMX_ProjectFiles ( [] )
"-------------------------------------------
"Description: this variable is list of project files. Need to add
"they to this list to make them treater by the right way (this file's will be
"opened with 'Project ' <project_file>; also to skip project split 
"Example:
"let g:BuffReminderRMX_ProjectFiles          = ['C:\programs\gvim\vim_extention\projects\work_machine.projectfile'
                                            "\, 'C:\programs\gvim\vim_extention\projects\home_machine.projectfile']

"-------------------------------------------
"Variable: g:BufReminderRMX_ignoreFilesList ( [] )
"-------------------------------------------
"Description: check if buff_name in ignore file list, and if yes, skip it

"-------------------------------------------
"Variable: g:BuffReminderRMX_Disable_Hidden ( bool )
"-------------------------------------------
"Description: if this option is enabled - all 'hidden' buffers (which isn't
"showed in windows) will be skipped in save procedure

"-------------------------------------------
"Variable: g:BuffReminderRMX_Default_SplitMode ( string ('split' or 'vsplit' ) )
"-------------------------------------------
"Description: when page contain many split window with differents
"possitions/size - on save - we can't decide what split mode was used. That why, the 'simplest' solution was to define window default split mode.
"todo: add algorithm which decide split option according to all windows columns/rows size in tab.

"-------------------------------------------
"Variable: g:BuffReminder_persistency_file ( string )
"-------------------------------------------
"Description: this is path and name of persistency file. You can it redefine if default isn't good for you.


if v:version < 700 || &diff "skip load plugin if diff mode
    finish
endif


if exists('g:BuffReminder_enablePlugin') && g:BuffReminder_enablePlugin == 0  "plugin not enabled 
        finish
endif

"enable plugin by default
let g:BuffReminder_enablePlugin = 1




"//- SET GLOBAL VARIABLES -------------------------------------------------------------------
let g:BuffReminder_skip_NoNameBuffer        = 1


if !exists('g:BuffReminderRMX_SkipLoadBuffersOnArgc')
    let g:BuffReminderRMX_SkipLoadBuffersOnArgc = 1
endif


if !exists('g:BuffReminderRMX_OpenFirstTabByDefault')
    let g:BuffReminderRMX_OpenFirstTabByDefault = 0
endif


if !exists('g:BufReminderRMX_ignoreFilesList')
    let g:BufReminderRMX_ignoreFilesList        = []
endif

if !exists('g:BuffReminderRMX_ProjectFiles')
    let g:BuffReminderRMX_ProjectFiles        = []
endif

if !exists('g:BuffReminderRMX_Disable_Hidden')
    let g:BuffReminderRMX_Disable_Hidden        = 0
endif

if !exists('g:BuffReminderRMX_Default_SplitMode')
    let g:BuffReminderRMX_Default_SplitMode        = 'split'
endif

if !exists('g:BuffReminder_persistency_file')
    let bufRemiderPersFile = 'vim_bufReminder.cfg'
    let bifRemiderPersPath = ''

    if has('win32')
        let bifRemiderPersPath = $USERPROFILE . '\'
    else
        if has('unix') || has('macunix')
            let bifRemiderPersPath = $HOME . '/'
        else
            let bifRemiderPersPath = $VIM .  '/'
        endif
    endif
    let g:BuffReminder_persistency_file = bifRemiderPersPath . bufRemiderPersFile
endif


let g:buf_info_lst = []

let s:buf_default_view_pos =
            \{
            \ 'tabid'     :1
            \,'win'       :1  
            \,'win_h'     :0
            \,'win_w'     :0
            \,'win_pos_x' :9999
            \,'win_pos_y' :9999
            \}




"//- FUNCTIONS DECLARATION -------------------------------------------------------------------
func! BufReminderRMX_GetActualfBuffInfo()

    for i in range(tabpagenr('$')) "iterate tabs

        let isEditBufferWasOpened = 0
        "get buffers of tab. Important: index of each iterations is WINDOW INDEX!!!
        let buff_index_list = tabpagebuflist(i+1) 
        "Decho("tabid=" + (i+1))
        "exe 'OpenTabsSilent ' . (i+1)
        exe 'tabnext ' . (i+1)
        if !empty(buff_index_list) "is list empty ?

            let buf_info_list = []
            let win_index = 1 "windows index 0 == 1, that why starts from 1
            let winrestcmd_str = ''
            for buf_id in buff_index_list

                if g:BuffReminder_skip_NoNameBuffer "not save NoName buffers
                    if empty(bufname(buf_id))
                        continue
                    endif
                endif
                let buff_info = {}
                let buff_info['buf_name']   = fnamemodify(bufname(buf_id), ':p') "get full path to buff/file name 
                let buff_info['win_id']     = win_index
                let buff_info['win_width']  = winwidth(win_index)
                let buff_info['win_height'] = winheight(win_index)
                "let buff_info['tab_id']     = (i+1)

                    let buff_info['split_opt'] = 'edit'

                    if BufReminderRMX_isItemInList(g:BuffReminderRMX_ProjectFiles, buff_info['buf_name'])
                        let buff_info['split_opt']  = 'project'
                    else

                        if isEditBufferWasOpened
                            if winwidth(win_index) < &columns
                                let buff_info['split_opt']  = 'vsplit'
                            else
                                let buff_info['split_opt']  = 'split'
                            endif

                        endif
                        let isEditBufferWasOpened = 1
                    endif

                call add( buf_info_list, buff_info ) "add item in global list with buff info

                "generate for buff resize str
                let winrestcmd_str .= BufReminderRMX_winrestcmd(win_index, buff_info['win_height'], buff_info['win_width'])

                let win_index  += 1 
            endfor

            let tab_id = (i+1)
            call BufReminderRMX_SaveElementInList(tab_id, buf_info_list, winrestcmd_str)

        endif

    endfor

endfunc

func! BufReminderRMX_getTab0_CurrentTabPos()
    let currTabPos = '0' . ' (' . tabpagenr() . ',' .  winnr() . ',' . &lines . ',' . &columns . ',' . getwinposx() . ',' . getwinposy() .')'
    return currTabPos
endfunc

func! BufReminderRMX_getHiddenBuffers()
    let buff_info_list = []

    "here we collect hidden buffers, 
    for buffr in range(1, bufnr('$'))
        if BufHidden( buffr ) && buflisted( buffr )
            let buff_info = {}
            let buff_info['buf_name']   = fnamemodify(bufname(buffr), ':p') "get full path to buff/file name 
            let buff_info['win_id']     = 0
            let buff_info['win_width']  = 0
            let buff_info['win_height'] = 0
            let buff_info['split_opt']      = 'hide'
            call add(buff_info_list, buff_info)
        endif
    endfor

    return buff_info_list
endfunc

"//---------------------------------------------------------------------------------
func! BufReminderRMX_saveHiddenBuffers()
"//---------------------------------------------------------------------------------

    "let's save curr pos in tab 0, because this number not used in vim native buff list
    let tab0_Pos = BufReminderRMX_getTab0_CurrentTabPos()
    let buff_info_list = []

    if g:BuffReminderRMX_Disable_Hidden == 0 "save hidden buffers ?
        let buff_info_list = BufReminderRMX_getHiddenBuffers()
    endif

    "if !empty(buff_info_list)
    call BufReminderRMX_SaveElementInList(tab0_Pos, buff_info_list, '')
    "endif

endfunc

"custom function for window index"
func! BufReminderRMX_winrestcmd(win_index, height, width)
    let str  = ''
    let str .=           a:win_index . 'resize ' . a:height . '|'
    let str .= 'vert ' . a:win_index . 'resize ' . a:width .  '|'
    return str
endfunc

func! BufReminderRMX_isItemInList(lst, buff_name)
    if !empty(a:lst) &&  index( a:lst, a:buff_name ) != -1
        return 1
    endif
    return 0
endfunc
func! BufReminderRMX_BuffNameFilter(buff_name)

    let ret_value = -1

    "open it with 'Project.vim' if buff_name in 'project' files list
    if BufReminderRMX_isItemInList(g:BuffReminderRMX_ProjectFiles, a:buff_name)
        exe 'Project ' .  a:buff_name
        exe 'wincmd w'
        let ret_value = 1
        "Decho("here#1")
    endif

    "check if buff_name in ignore file list, and if yes, skip it
    if BufReminderRMX_isItemInList(g:BufReminderRMX_ignoreFilesList, a:buff_name)
        let ret_value = 1
        "Decho("here#2")
    endif

    return ret_value

endfunc

func! BufReminderRMX_OpenBuffersInList()
    "g:buf_info_lst[0]['tab_info']
    for buf_and_tab_info in g:buf_info_lst "buff info list

        if buf_and_tab_info['tab_id'] > 1 "create new tab if this is not first tab and not zero(hidden buffers)
            exe 'tabnew'
        endif

        for buff_info in buf_and_tab_info['buff_info']

            if BufReminderRMX_BuffNameFilter(buff_info['buf_name']) != -1
                continue
            endif

            call BufReminderRMX_OpenBuffer(buff_info)
            "call BufReminderRMX_OpenBuffer(buff_info['buf_name'], buff_info['split_opt'], buff_info['win_id'])
        endfor

        if !empty(buf_and_tab_info['tab_wins_info']) "some of viewport's can be empty, like for hidden buffers
            exe buf_and_tab_info['tab_wins_info']
        endif

    endfor
    "finally, go to first window (default)
    exe '1wincmd w'

    "if g:BuffReminderRMX_OpenFirstTabByDefault "go to first tab
        "exe 'tabnext 1'
    "endif
endfunc

func! BufReminderRMX_SaveElementInList(tab_id, buff_info, tab_wins_info)
    let buf_and_tab_info = {}
    let buf_and_tab_info['tab_id']         = a:tab_id
    let buf_and_tab_info['buff_info']      = a:buff_info
    let buf_and_tab_info['tab_wins_info']  = a:tab_wins_info

    call add(g:buf_info_lst, buf_and_tab_info)
endfunc

"Description: load saved buffers persistency information
func! BufReminderRMX_LoadPersistency() 

    if filereadable(g:BuffReminder_persistency_file) "check if persistency file exist

        "Decho('here#1')
        let FileLinesList  = readfile(g:BuffReminder_persistency_file)
        call BufReminderRMX_RemovePersFile()

        if !empty(FileLinesList)
            "Decho('here#2')

            let regex_persistency   = 'buff_info:\([a-zA-Z0-9: \\_\/\.\-\+]\+\)\s\([a-z_]\+\)\s\(\d\+\)\s\(\d\+\)\s\(\d\+\)'
            let regex_tab_id_values = 'tab_id:\(\d\+\)\(\s(\(\d\+\),\(\d\+\),\(\d\+\),\(\d\+\),\([-]\?\d\+\),\([-]\?\d\+\))\)\?'
            let tab_id = 0
            let buf_info_list = []
            let tab_wins_info = ''
            for line in FileLinesList
                if match(line, 'tab_id:') != -1

                    let tab_id  = substitute(line,regex_tab_id_values,'\1','')      "tab id

                    "this case if we want to reload same view ( last tab, last win positions ) 
                    if match( line, 'tab_id:\d\+\s(.*)' ) != -1 && g:BuffReminderRMX_OpenFirstTabByDefault == 0
                        let s:buf_default_view_pos['tabid'] = substitute(line,regex_tab_id_values ,'\3', '' ) "last tab
                        let s:buf_default_view_pos['win'] = substitute(line,regex_tab_id_values ,'\4', '' ) "last win
                        let s:buf_default_view_pos['win_h'] = substitute(line,regex_tab_id_values ,'\5', '' ) "last win lines (main window height)
                        let s:buf_default_view_pos['win_w'] = substitute(line,regex_tab_id_values ,'\6', '' ) "last win lines (main window width)
                        let s:buf_default_view_pos['win_pos_x'] = substitute(line,regex_tab_id_values ,'\7', '' ) "winposx
                        let s:buf_default_view_pos['win_pos_y'] = substitute(line,regex_tab_id_values ,'\8', '' ) "winposy
                    endif


                elseif match(line, 'buff_info:') != -1
                    let buff_info = {}
                    let buff_info['buf_name']   = substitute(line, regex_persistency, '\1','')
                    let buff_info['split_opt']  = substitute(line, regex_persistency, '\2','')
                    let buff_info['win_id']     = substitute(line, regex_persistency, '\3','')
                    let buff_info['win_width']  = substitute(line, regex_persistency, '\4','')
                    let buff_info['win_height'] = substitute(line, regex_persistency, '\5','')
                    call add(buf_info_list, buff_info)

                elseif match(line, 'viewport:') != -1
                    let tab_wins_info = substitute(line,'viewport:','','')

                elseif match(line, '---end of tab data---') != -1
                    call BufReminderRMX_SaveElementInList(tab_id, buf_info_list, tab_wins_info)
                    let buf_info_list = []
                endif
            endfor

        endif

    endif

endfunc

func! BufReminderRMX_RemovePersFile()
    if filereadable(g:BuffReminder_persistency_file) "remove previus persistency file, if it exist
        call delete(g:BuffReminder_persistency_file)
    endif
endfunc

func! BufReminderRMX_SavePersistency() "function to save buffers persistency information

    let file_lines_list = []

    for buf_and_tab_info in g:buf_info_lst

        call add (file_lines_list,   'tab_id:' . buf_and_tab_info['tab_id'] )

        for buf_info in buf_and_tab_info['buff_info']
            let pers_line   =  buf_info['buf_name']   . ' '
            let pers_line  .=  buf_info['split_opt']  . ' '
            let pers_line  .=  buf_info['win_id']     . ' '
            let pers_line  .=  buf_info['win_width']  . ' '
            let pers_line  .=  buf_info['win_height']
            call add (file_lines_list, 'buff_info:' . pers_line)
        endfor
        call add (file_lines_list,   'viewport:' . buf_and_tab_info['tab_wins_info'])
        call add (file_lines_list,   '---end of tab data---')
    endfor

    if !empty(g:buf_info_lst)
        call writefile(file_lines_list, g:BuffReminder_persistency_file)
    endif

endfunc

"func BufReminderRMX_OpenBuffer(fName, mode, win_id)
"
"call BufReminderRMX_OpenBuffer(, buff_info['split_opt'], buff_info['win_id'])
func BufReminderRMX_OpenBuffer(buff_info)

    let l:mode = a:buff_info['split_opt']
    if l:mode == 'edit'
        exe 'edit ' a:buff_info['buf_name']

    elseif l:mode == 'split' || l:mode == 'vsplit'
        exe g:BuffReminderRMX_Default_SplitMode
        
        "move to window with win_id
        exe a:buff_info['win_id'] 'wincmd w' 
        exe 'edit ' a:buff_info['buf_name']

    elseif l:mode == 'hide'
        exe 'edit ' a:buff_info['buf_name']
        "exe 'hide' "hide buffer ( h flag )
        "
    else
        Decho("BufReminderRMX_OpenBuffer error unknown options! opt=" . l:mode)

    endif

endfunc

fun! BufReminderRMX_reloadLastTabView() 
    "restore last tab
    exe 'tabnext ' . s:buf_default_view_pos['tabid'] 

    "restore last wnd
    exe s:buf_default_view_pos['win'] . 'wincmd w'

    
endfunc

fun! BufReminderRMX_reloadVimViewPort()

    "restore height of prev. vim instance; skip if this values is empty
    if s:buf_default_view_pos['win_h'] != 0
        let &lines=s:buf_default_view_pos['win_h']
    endif

    "restore weight of prev. vim instance
    if s:buf_default_view_pos['win_w'] != 0
        let &columns=s:buf_default_view_pos['win_w']
    endif


    "Decho("win_h" . s:buf_default_view_pos['win_h'])
    "Decho("win_w" . s:buf_default_view_pos['win_w'])

    "win pos x y (start coordinates);
    "Attention!: vim on getwinposx|y return always -1 :( .
    if s:buf_default_view_pos['win_pos_x'] != 9999 && s:buf_default_view_pos['win_pos_y'] != 9999 
        exe 'winpos ' . s:buf_default_view_pos['win_pos_x'] . ' ' . s:buf_default_view_pos['win_pos_y']
    endif
endfunc

func! BufReminderRMX_SaveEvent()
    call BufReminderRMX_saveHiddenBuffers() "get all hiden buffers
    call BufReminderRMX_GetActualfBuffInfo() "get information about current opened buffers
    call BufReminderRMX_RemovePersFile()
    call BufReminderRMX_SavePersistency()
endfunc

func! BufReminderRMX_LoadEvent()
    "if vim was called with arguments (vim file1.ext ... ), by default, we
    "skip loading of persistency.
    if g:BuffReminderRMX_SkipLoadBuffersOnArgc == 0 || (argc() == 0)
        call BufReminderRMX_LoadPersistency()

        call BufReminderRMX_reloadVimViewPort() "Attention: you must restore view of all window before restore viewport of each buffer

        call BufReminderRMX_OpenBuffersInList()

        call BufReminderRMX_CentrilizeWindow()

        call BufRemionderRMX_ClearList()

        call BufReminderRMX_reloadLastTabView()
    endif
endfunc

func! BufRemionderRMX_ClearList()
    let g:buf_info_lst = [] "clear list
endfunc

func! BufReminderRMX_CentrilizeWindow()
    exe "normal " . "zz"
endfunc

function BufHidden(bufnr)
    return empty(filter(map(range(1, tabpagenr('$')),
                \'tabpagebuflist(v:val)'),
                \'index(v:val, a:bufnr)!=-1'))
endfunction

"//- EVENT DECLARATION -------------------------------------------------------------------
autocmd VimLeavePre *        call BufReminderRMX_SaveEvent()
autocmd VimEnter    * nested call BufReminderRMX_LoadEvent()
"//---------------------------------------------------------------------------------

