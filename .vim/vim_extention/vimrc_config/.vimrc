

"--------------------------------------------------------------------
"BEGIN OF FILE"
if v:version < 701 "vi options
  finish 

else

let PLFM_HOSTNAME = hostname()                  "hostname to differ work machines (home/work)

if has("gui_win32") || has("gui_win32s") "font config
    "FONTS#: in windows, install font before(control panel->fonts->install font)
    ",and you will can find it in guifont menu, after
    set guifont=Courier_New:h9:cANSI 
else "/* UNIX */
    if PLFM_HOSTNAME == 'blackbox' "laptop
        set guifont=DejaVu\ Sans\ Mono\ 8.5
    else
        set guifont=DejaVu\ Sans\ Mono\ 9
    endif
    "Using gvim with gtk2, I had a problem installing Proggy Clean. 
    "I couldn't get the pcf font registered by freetype/fontconfig. 
    "The result was that I could select Proggy Clean via "xfontsel",
    "but not with the gtk2 font selector. A gtk build probably would have worked.
    "Anyway, the ttf font works fine. 
    "Just copy ProggyCleanTT.ttf to ~/.fonts and run "fc-cache" once. 
    "This should work on every Unix system with fontconfig installed. 
endif



if !exists('g:cr_slash') && !exists('g:relative_path') "set global cross platform slash and path of vim
if     has('win32')
    let g:cr_slash = '\' | let g:cfg_path_main = $VIM | let g:cfg_path = cfg_path_main . g:cr_slash . 'vimfiles' 
else 
    let g:cr_slash = '/' | let g:cfg_path_main = $HOME | let g:cfg_path = cfg_path_main . g:cr_slash . '.vim'    | set runtimepath+=~/.vim/vimfiles "path were to place plugins in ubuntu
endif | endif

let PLFM_VIM_HOME_PATH=g:cfg_path               "main path specific for OS
let cr_slash= g:cr_slash                        "slash specific for platform


"attach extended path var's
exe "source " . PLFM_VIM_HOME_PATH . cr_slash . 'vim_extention' . cr_slash . 'vimrc_config' . cr_slash . 'fwk_extended_variables.vim'

"PLUG EXTENTION FILES
exe "source " . PLFM_VIMCFG . cr_slash . 'maps_regex.vim'
exe "source " . PLFM_VIMCFG . cr_slash . 'marks.vim'
exe "source " . PLFM_VIMCFG . cr_slash . 'set_variables.vim'
exe "source " . PLFM_VIMCFG . cr_slash . 'popup_menus.vim'
exe "source " . PLFM_VIMCFG . cr_slash . 'french_language_addon.vim'
exe "source " . PLFM_VIMCFG . cr_slash . 'ctagslogic.vim'
exe "source " . PLFM_VIMCFG . cr_slash . 'ctagsfiles.vim'
map \tc1 :call FWK_genTagsByPath(expand ("%:p:h"))<CR>
map \tc2 :call FWK_setTags(expand ("%:p:h"))<CR>

set encoding=utf-8      " utf enc added, it's important to set this value first

"if PLFM_HOSTNAME == 'dell-craventos'
    exe  "map ²o :OpenWindowSilent " . PLFM_VIMCFG . cr_slash . ".vimrc" . "<CR>"
    exe  "map ²c :OpenWindowSilent " . PLFM_VIMCFG . cr_slash . "ctagsfiles.vim" . "<CR>"
"else
    exe  "map `o :OpenWindowSilent " . PLFM_VIMCFG . cr_slash . ".vimrc" . "<CR>"
    exe  "map `c :OpenWindowSilent " . PLFM_VIMCFG . cr_slash . "ctagsfiles.vim" . "<CR>"
"endif

"""""""""""""""""""""""""""""""
"DISABLE KEYS
"""""""""""""""""""""""""""""""

"disable "Entering to Ex Mode
map Q <Nop> 

"--------------------------------------------------------------------
"DIFF KEYS
"--------------------------------------------------------------------
" \du - diffupdate
map \du :diffupdate<cr>
vmap \du :diffupdate<cr>
imap \du :diffupdate<cr>


"diff same file, to look undo changes using 'u'
map \dc  :call FWK_Diff_SameBuffer()<CR>


" \db - horizontal split/down
noremap \db :bo sp<CR>:exec('resize '.29)<CR>

" \dd - diff this file
noremap \dd :diffthis<CR>
vmap    \dd <Esc>:diffthis<CR>i
imap    \dd <Esc>:diffthis<CR>i

" \dq - disable diff to current file
map \dq  :diffoff!<CR>
vmap \dq :diffoff!<CR>
imap \dq :diffoff!<CR>


map \dr :silent call DiffTwoRegisters('h','j','ON')<CR>
map \dw :silent call DiffTwoRegisters('h','j','OFF')<CR>

"svn: diff current buffer

map \ds :call Fwk_diff_svn_current_file()<CR>


"//-- DIFF MODE SETTINGS -----------------------------------------------------------------
if &diff "only in diff mode

   "Description: move betweens diff points in file
   func DiffPointMove( direct )
      if a:direct == 'up'
         exe "normal " . '[c'
      elseif a:direct == 'down'
         exe "normal " . ']c'
      endif
      exe "normal " . 'zz'

   endfunc

   command! DiffPointMoveDown   :call DiffPointMove('down')
   command! DiffPointMoveUp     :call DiffPointMove('up')

    map <F1> :DiffPointMoveUp<CR>
    map <F2> :DiffPointMoveDown<CR>

    "exe ":1"
    "exe "DiffPointMoveDown"
    ":winpos 0 0
    ":set lines=100
    ":set columns=180
    map <space> :vertical resize<CR>
    "echo winwidth(0)

    "make full screen for diff
    if has('win32') && has("gui_running")
        set lines=200           " lines numbers in window
        set columns=800         " columns numbers in window
    endif

    "disable fuf in diff mode
    let g:fuf_modesDisable = [ 'mrufile', 'mrucmd', ]

else
    let g:fuf_modesDisable = [ 'mrufile', ]
    "let g:fuf_modesDisable = [ ]
"MOVE BETWEEN Functions, useful?
   "map <C-UP> ?\w\+\s*(<CR>:nohlsearch<CR>
   "vmap <C-UP> <ESC>?\w\+\s*(<CR>:nohlsearch<CR>

   "map <C-DOWN> /\w\+\s*(<CR>:nohlsearch<CR>
   "vmap <C-DOWN> <ESC>/\w\+\s*(<CR>:nohlsearch<CR>

endif
"--------------------------------------------------------------------
"Highlight options
"--------------------------------------------------------------------
hi matchFirst  guifg=#FFFF99 guibg=OliveDrab4 ctermfg=white ctermbg=darkblue cterm=underline term=underline

"--------------------------------------------------------------------
" mappings
"--------------------------------------------------------------------

"MAP PARAMETERS"

map \rc :rcline.py -osr -p/// .<C-Left><Left><Left><Left>
map <C-F9> :call FormatScreen()<cr>

"eclipse ctrl-space behavior
imap <C-Space> <C-x><C-o>


"TEMPORARY MAP'S"
map <F3> :exec("tag ".expand("<cword>"))<CR>
map <F4> :exec("tselect ".expand("<cword>"))<CR>

"map <F3> :let &syntax=""<CR>
map <F10> :set shiftwidth=3<CR>



"--------------------------------------------------------------------
"WINDOW MANIPULATIONS
"--------------------------------------------------------------------

"change window height to minimum
map \ws     :set lines=16<CR>

"change window height to middle
map \wm     :set lines=28<CR>

"change window height to maximum
map \wx     :set lines=200<CR>

"change windows pos in top of the screen
map \wt     :winpos 53 -2<CR>

"change windows pos in button of the screen
map \wb     :winpos 53 482<CR>

"make screen width half of ecran <--->
map \wh     :set columns=85<CR>

"make screen width maximum <------>
map \wf     :set columns=175<CR> 


"--------------------------------------------------------------------
""//--------------------------------------------------------------------
""//-- PLUGINS
""//--------------------------------------------------------------------

"disable plugin"
"let g:MMake_SettingsFile = PLFM_VIM_HOME_PATH . "/vim_extention/config/mmake_settings.cfg"

""""""""""""""""""""""""""""
"MRU""""""""""""""""""""""""
""""""""""""""""""""""""""""
let MRU_Max_Entries = 350
"let MRU_File = 'd:\myhome\_vim_mru_files'
let MRU_File = g:PLFM_VIM_TEMPDIR . g:cr_slash . 'vim_mru_files'

"""""""""""""""""""""""""""""""""
"OMNI COMPETITION""""""""""""""""
"""""""""""""""""""""""""""""""""
let OmniCpp_SelectFirstItem = 2
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_NamespaceSearch = 1
let OmniCpp_DisplayMode = 1
let OmniCpp_NamespaceSearch=1
"let OmniCpp_NamespaceSearch=2 "what diffrens?
let OmniCpp_ShowPrototypeInAbbr=1
"let OmniCpp_MayCompleteDot = 0      "disable autocomplite
"let OmniCpp_MayCompleteArrow = 0    "disable autocomplite
let OmniCpp_MayCompleteScope = 1    "enasable autocomplite


if has("autocmd")

    "Turn omni completion feature by put this in vimrc.
    autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
    autocmd FileType css set omnifunc=csscomplete#CompleteCSS
    autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
    autocmd FileType php set omnifunc=phpcomplete#CompletePHP
    autocmd FileType java set omnifunc=omni#cpp#complete#Main

    "JAVA
    autocmd Filetype java setlocal omnifunc=javacomplete#Complete
    autocmd Filetype java setlocal completefunc=javacomplete#CompleteParamsInfo
    inoremap <buffer> <C-X><C-U> <C-X><C-U><C-P>


    "pythoncomplite.vim
    autocmd FileType python set omnifunc=pythoncomplete#Complete

    "second plugin
    "let g:pydiction_location = $VIM . '/template/python/complete-dict'
    """"""""""""""""""""""""""""""""""

    "pop and add first item
    "autocmd FileType java   inoremap <buffer> <expr> . FWK_System_Dot_MayComplete(0) 

    "pop only
    "autocmd FileType python inoremap <buffer> <expr> . FWK_System_Dot_MayComplete(1) 

    "ACP: disable autocomplite for python (work not properly)
    let g:AutoComplPop_BehaviorPythonOmniLength = -1
    "let g:AutoComplPop_BehaviorPythonOmniLength = 1

    "Snippets
    autocmd FileType python set ft=python.django " For SnipMate
    autocmd FileType html set ft=htmldjango.html " For SnipMate

    autocmd FileType        vrun  call FWK_runScriptParse() "parse vrun file for make/build/log variables


    "add maps of fwk_notes for conf(txt) extention
    autocmd FileType        conf :FwkNoteApplyMaps "set maps for notes

    autocmd FileType        scheme,hop  exe 'source ' . g:cfg_path . '/syntax/RainbowParenthsis.vim'

    "enable suplementary syntax for files
    "autocmd FileType        conf call FWK_EnableSyntax(['notes.vim'])
    "autocmd FileType        conf call FWK_EnableSyntax(['notes.vim', 'xml.vim'])


    ""replace one quote on double
    "autocmd FileType python,java,html,php,c,cpp,cs,ocaml call FWK_pasteDoubleQuote_init_map('"', '"')
    ""autocmd FileType python,java,html,php,c,cpp,cs,ocaml call FWK_pasteDoubleQuote_init_map("'", "'")
    "autocmd  FileType java,html,php,c,cpp,cs,ocaml,tex call FWK_pasteDoubleQuote_init_map('(', ")")
    ""autocmd FileType python,java,html,php,cs,ocaml,tex call FWK_pasteDoubleQuote_init_map('(', ")")
    "autocmd FileType tex call FWK_pasteDoubleQuote_init_map('{', "}")
    "autocmd FileType tex call FWK_pasteDoubleQuote_init_map('$', "$")
    "autocmd FileType python,java,html,php,c,cpp,cs,ocaml call FWK_pasteDoubleQuote_init_map("[", "]")
    "autocmd FileType ocaml setlocal textwidth=102

    autocmd BufRead,BufNewFile *.txt		set filetype=conf


    "lablgtk"
    "autocmd FileType ml_gtk set ft=ml




function! TextEnableCodeSnip(filetype,start,end,textSnipHl) abort
  let ft=toupper(a:filetype)
  let group='textGroup'.ft
  if exists('b:current_syntax')
    let s:current_syntax=b:current_syntax
    " Remove current syntax definition, as some syntax files (e.g. cpp.vim)
    " do nothing if b:current_syntax is defined.
    unlet b:current_syntax
  endif
  execute 'syntax include @'.group.' syntax/'.a:filetype.'.vim'
  try
    execute 'syntax include @'.group.' after/syntax/'.a:filetype.'.vim'
  catch
  endtry
  if exists('s:current_syntax')
    let b:current_syntax=s:current_syntax
  else
    unlet b:current_syntax
  endif
  execute 'syntax region textSnip'.ft.'
  \ matchgroup='.a:textSnipHl.'
  \ start="'.a:start.'" end="'.a:end.'"
  \ contains=@'.group
  "\ start="'.a:start.'\s#.*$" end="'.a:end.'\s\s\s#.*$"
endfunction

autocmd FileType conf,notes call TextEnableCodeSnip(  'c'        , '@begin=c@'      , '@end=c@'         , 'SpecialComment')
autocmd FileType conf,notes call TextEnableCodeSnip('cpp'        , '@begin=cpp@'    , '@end=cpp@'       , 'SpecialComment')
autocmd FileType conf,notes call TextEnableCodeSnip('scheme'     , '@begin=scheme@' , '@end=scheme@'    , 'SpecialComment')
autocmd FileType conf,notes call TextEnableCodeSnip('xml'        , '@begin=xml@'    , '@end=xml@'       , 'SpecialComment')
autocmd FileType conf,notes call TextEnableCodeSnip('python'     , '@begin=py@'     , '@end=py@'        , 'SpecialComment')
autocmd FileType conf,notes call TextEnableCodeSnip('asm'        , '@begin=asm@'    , '@end=asm@'       , 'SpecialComment')
autocmd FileType conf,notes call TextEnableCodeSnip('javascript' , '@begin=js@'     , '@end=js@'        , 'SpecialComment')
autocmd FileType conf,notes call TextEnableCodeSnip('java'       , '@begin=java@'   , '@end=java@'      , 'SpecialComment')
autocmd FileType conf,notes call TextEnableCodeSnip('make'       , '@begin=make@'   , '@end=make@'      , 'SpecialComment')
autocmd FileType conf,notes call TextEnableCodeSnip('notes'      , '@begin=notes@'  , '@end=notes@'     , 'SpecialComment')
autocmd FileType conf,notes call TextEnableCodeSnip('sh'         , '@begin=sh@'     , '@end=sh@'        , 'SpecialComment')
autocmd FileType conf,notes call TextEnableCodeSnip('html'       , '@begin=html@'   , '@end=html@'      , 'SpecialComment')
autocmd FileType conf,notes call TextEnableCodeSnip('css'       , '@begin=css@'   , '@end=css@'      , 'SpecialComment')

endif

""""""""""""""""""""""""
"TAGLIST""""""""""""""""
""""""""""""""""""""""""
let Tlist_Inc_Winwidth = 1
let Tlist_Use_Right_Window = 1
let Tlist_WinWidth = 34
let Tlist_Compact_Format = 1
let Tlist_Auto_Highlight_Tag = 1
let Tlist_Auto_Update = 1               "if param disable, taglist not work! this is not make work more slow?
"let Tlist_Close_On_Select = 1          "close taglist window on select
let Tlist_Enable_Fold_Column = 0        "make split colon between windows more tin
"let Tlist_Exit_OnlyWindow = 1          "close if taglist is only window
"let Tlist_File_Fold_Auto_Close = 1     "close tags for inactive buffer
let Tlist_GainFocus_On_ToggleOpen = 1   "jump to taglist window on open
let Tlist_Use_SingleClick = 1
let TlistHighlightTag = 1               "EXPER
let Tlist_Highlight_Tag_On_BufEnter = 1 "EXPER
"added
let Tlist_Show_One_File = 1


""""""""""""""""""""""
"GREP"""""""""""""""""
""""""""""""""""""""""
"let Grep_Default_Filelist = '*.hpp *.cpp *.h *.c *.cs *.aspx *.py'
"let Grep_Skip_Files = '*.hpp *.bak *~' 
"grep -rw "class" */*[c,h,p]*


""""""""""""""""""""""
"PROJECT""""""""""""""
""""""""""""""""""""""
let g:proj_window_width=34

"""""""""""""""""""""""
"BUFFER REMINDER Local"
"""""""""""""""""""""""
"let g:BuffReminder_enablePlugin             = 1
"let g:BuffReminder_skip_NoNameBuffer        = 1
"let g:BufReminderRMX_ignoreFilesList        = []
let g:BuffReminder_persistency_file         = g:PLFM_VIM_TEMPDIR . g:cr_slash . 'bufReminder_persistency.cfg'
let g:BuffReminderRMX_ProjectFiles          = ['C:\programs\gvim\vimfiles\vim_extention\projects\home_machine.vimp'
                                            \, 'C:\programs\gvim\vimfiles\vim_extention\projects\luxoft_machine.vimp'
                                            \, '/home/svakulenko/.vim/vim_extention/projects/luxoft_machine.vimp' 
                                            \, '/home/sergey/Dropbox/private/share_files/.vim/vim_extention/projects/home_machine.vimp' 
                                            \, '/home/svakulenko/Dropbox/private/share_files/.vim/vim_extention/projects/luxoft_machine.vimp' 
                                            \]

let g:BuffReminderRMX_OpenFirstTabByDefault = 0
let g:BuffReminderRMX_Disable_Hidden        = 1


"""""""""""""""""""""""
"MMake Pro Local"
"""""""""""""""""""""""

"set makeprg=make
"set makeef=erroutput.log
"set makeef=c:\erroutput.log

" \cq qmake script 
nmap \cq :!mqm<cr>

"map <C-]>:call FWK_open_tag_in_split()
map <A-]> :sp <CR>:exec("tag ".expand("<cword>"))<CR>

"SET LABELS (variables)
"map \csm :MMakeBuild
"map \csr :MMakeRun D:\workspace\qt\rnd\test\04_fsm\debug\04_fsm.exe
"map \cm : call MMake_MakeFunc()<CR>
"map \cr :silent call MMake_RunFunc()<CR>
"map \gh :silent call MMake_GoToProject()<CR>

"map <a-r> :call ExecuteSelfFile( 'D:\workspace\qt\RND\test\09_adress_book\debug\09_adress_book.exe')<CR>


"NBT"
"map <A-m> : call FWK_open_quick_fix_not_jump()<CR>
"map <A-m> :lcd %:p:h<CR>:cd ..<CR>:!make<CR>
"map <A-m> :lcd %:p:h<CR>:cd ..<CR>:!..\debug\01_HW.exe<CR>
"map <A-m> :!..\debug\01_HW.exe<CR>
"map <A-m> :!..\debug\01_HW.exe<CR>
"
"
"map \gb :call MMake_GetTemplate(PLFM_VIM_TEMPLATES . cr_slash . 'Makefile'   , 'Makefile'   )<CR>
"map \gm :call MMake_GetTemplate(PLFM_VIM_TEMPLATES . cr_slash . 'jamroot.jam', 'jamroot.jam')<CR>



map \gr :call FWK_copyTemplate('config.vrun', 'config.vrun', '' )<CR>

"cpf - display last error in list

"grep make output by 'error' pattern
"set makeprg=bjam\ \\\|\ grep\ error
set makeprg=bjam
"map <F1> :call MMake_QuickFixErrorHandler()<CR>

"\e<CompilationMode(R/D)><errorLevel(Warnings/Errors)>
map \ere :OpenTabsSilent D:\P4\NBT_products\HU_HIGH\DetailedLog.hbbl<CR>:silent setlocal nobuflisted<CR>:e!<CR>gg/error:\\|undefined\ reference\\|(Permission\ denied)\\|don't\ know\ how\ to\ make<CR>
"map \ere :OpenTabsSilent U:\_products\x86-qnx-m641-4.3.3-osp-trc-rel\DetailedLog.hbbl<CR>:silent setlocal nobuflisted<CR>:e!<CR>gg/error:\\|undefined\ reference\\|(Permission\ denied)\\|don't\ know\ how\ to\ make<CR>
map \erw :OpenTabsSilent U:\_products\x86-qnx-m641-4.3.3-osp-trc-rel\DetailedLog.hbbl<CR>:silent setlocal nobuflisted<CR>:e!<CR>gg/error:\\|warning:\\|undefined\ reference\\|(Permission\ denied)\\|don't\ know\ how\ to\ make<CR>
map \ede :OpenTabsSilent U:\_products\x86-qnx-m641-4.3.3-osp-trc-dbg\DetailedLog.hbbl<CR>:silent setlocal nobuflisted<CR>gg/error:\\|undefined\ reference\\|(Permission\ denied)\\|don't\ know\ how\ to\ make<CR>
map \edw :OpenTabsSilent U:\_products\x86-qnx-m641-4.3.3-osp-trc-dbg\DetailedLog.hbbl<CR>:silent setlocal nobuflisted<CR>gg/error:\\|warning:\\|undefined\ reference\\|(Permission\ denied)\\|don't\ know\ how\ to\ make<CR>

"qt error log analys
map \eqb :OpenTabsSilent D:\workspace\log\sdb_interface.txt<CR>:silent setlocal nobuflisted<CR>:e!<CR>gg/error:\\|undefined\ reference\\|(Permission\ denied)\\|don't\ know\ how\ to\ make<CR>
map \eqr :OpenTabsSilent D:\workspace\log\qt_debug_output.txt<CR>:silent setlocal nobuflisted<CR>:e!<CR>G<CR>

"map \eqr :call FWK_show_patterns_in_file('qt_test', 'D:\workspace\log\sdb_interface.txt')<CR>

map \etw :OpenTabsSilent D:\P4\NBT_Flash_products\HU_HIGH\DetailedLog.hbbl<CR>:silent setlocal nobuflisted<CR>gg/error:\\|warning:\\|undefined\ reference\\|(Permission\ denied)\\|don't\ know\ how\ to\ make<CR>
map \ete :OpenTabsSilent D:\P4\NBT_Flash_products\HU_HIGH\DetailedLog.hbbl<CR>:silent setlocal nobuflisted<CR>gg/error:\\|undefined\ reference\\|(Permission\ denied)\\|don't\ know\ how\ to\ make<CR>


map \ete :OpenTabsSilent /tmp/log.log<CR>:silent setlocal nobuflisted<CR>gg/error\\|warning<CR>

"map <F11> :call FWK__open_log_file()<CR>
map <F12> :call FWK_openlink_log_openErrorfile()<CR>

"//---------------------------------------------------------------------------------
" CONTROL HOTKEYS FEATURES----------
"//---------------------------------------------------------------------------------

"map \r :call FormatStringWithCloser("Upper")<CR>   "align line with upper line
"map \f :call FormatStringWithCloser("ToDown")<CR>  "align line with downed line

"COPY/PASTE WORD
map <A-c> viw<Esc>
map <A-c> <Esc>viw
map <A-v> ciw<C-R>+<Esc>
imap <A-v> <Esc>ciw<C-R>+
map <A-x> ciw
imap <A-x> <Esc>viw

"map <A-c> :call WordCopyPasteFunction('Copy')<cr>
"imap<A-c>  <Esc>:call WordCopyPasteFunction('Copy')<cr>
"imap <A-v> :call WordCopyPasteFunction('Paste')<cr>i
"imap<A-v>  :call WordCopyPasteFunction('Paste')<cr>i
"map <A-x>  :call WordCopyPasteFunction('Remove')<cr>
"imap<A-x>  <Esc>:call WordCopyPasteFunction('Remove')<cr>a
"vmap<A-x>  <Del>

"map<Home>  :exe "normal gg"<CR>
"map<End>   :exe "normal G"<CR>

"select blocks
map  <A-b> vip
imap <A-b> <Esc>vip

""""""""""""""
"set autochdir
""""""""""""""
"autocmd BufEnter,TabEnter * lcd %:p:h

""""""""""""""""""""""""""""""""""""
"FOLDING""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""
"enable folding, we can manipulate by zM zR zE
"set foldmethod=marker
"map <A--> :FoldLocalCommands 0<CR>
"map <A-=> :FoldLocalCommands 1<CR>


"set foldmethod=indent
"setlocal autoindent
"make {} fold
"map \zz zf%

"""""""""""""""""""
"MKVIEW
"""""""""""""""""""
"Auto restore mkview silently / folding
"au BufWinLeave *.c,*.cpp,*.cs, mkview
"au BufWinEnter *.c,*.cpp,*.cs, silent loadview



"function FoldBrace()
  "if getline(v:lnum+1)[0] == '{'
    "return '>1'
  "endif
  "if getline(v:lnum)[0] == '}'
    "return '<1'
  "endif
  "return foldlevel(v:lnum-1)
"endfunction
"set foldexpr=FoldBrace()
"set foldmethod=expr


"Description: func to fold all c functions (with java style brakets also )
function FoldBrace()
  if getline(v:lnum+1)[0] == '{'
    return 1
  endif
  if getline(v:lnum) =~ '{'
    return 1
  endif
  if getline(v:lnum)[0] =~ '}'
    return '<1'
  endif
  return -1
endfunction

"set foldexpr=FoldBrace()
"set foldmethod=expr
""""""""""""""""""""""""""""""""""""
"reformating string (tab forward or backward)
vmap < <gv
vmap > >gv

"""""""""""""""""""""""""""""""
"MAIN HOTKEYS
"""""""""""""""""""""""""""""""
" save ctl-s
nmap <C-s> :w<cr>
vmap <C-s> <esc>:w<cr>
imap <C-s> <esc>:w<cr>

" save Alt-s
nmap <A-s> :w!<cr>
vmap <A-s> <esc>:w!<cr>
imap <A-s> <esc>:w!<cr>

"cntrl del remove white spaces
map <C-Del> :exe "normal dw"<CR>
imap <C-Del> <Esc><Right>dwi

"no remap do it before map <C-W>
"move from first split window to another
"noremap `` <C-W>w



"<C-W><Up>

"remove buffer
"map <C-W> :bw<cr>
"call <SID>Bclose('<bang>', '<args>',"-")
"map <C-w> :bw<CR>
"map <A-w> :bw!<CR>

"close window if more then one buffer opened, or wipe buffer if only one buffer
"map <C-w> :call FWK_CloseBufferSafe(bufnr("%"))<CR>
"map <A-w> :call FWK_CloseBufferSafe(bufnr("%"),"!")<CR>
"imap <C-w> <Esc>:call FWK_CloseBufferSafe(bufnr("%"))<CR>
"imap <A-w> <Esc>:call FWK_CloseBufferSafe(bufnr("%"),"!")<CR>

"map  <C-q> :q<cr>
"map  <A-q> :q!<cr>

"copen/ccl open/close error window
nmap `1 :call PpdfunctionQuick()<cr>

" \e2 - errPrev
map  `2 :cprev<cr>
vmap `2 <esc>:cprev<cr>
imap `2 <esc>:cprev<cr>

" \e3 - errNext
map  `3 :cnext<cr>
vmap `3 <esc>:cnext<cr>
imap `3 <esc>:cnext<cr>

" \e4 - close split window
map  `4 :cclose<cr>
vmap `4 <esc>:cclose<cr>
imap `4 <esc>:cclose<cr>


"FR lastyout

nmap ²& :call PpdfunctionQuick()<cr>
" \e2 - errPrev
map  ²é :cprev<cr>
vmap ²é <esc>:cprev<cr>
imap ²é <esc>:cprev<cr>

" \e3 - errNext
map  ²" :cnext<cr>
vmap ²" <esc>:cnext<cr>
imap ²" <esc>:cnext<cr>

" \e4 - close split window
map  ²' :cclose<cr>
vmap ²' <esc>:cclose<cr>
imap ²' <esc>:cclose<cr>


map ²' :call FWK_CloseBufferSafe(bufnr("%"))<CR>
map ²- :call FWK_CloseBufferSafe(bufnr("%"),"!")<CR>

""tabedit

"--------------------------------------------------------------------
"fwk notes plugin
"--------------------------------------------------------------------
let g:fwk_notes_notes_directory = g:PLFM_VIM_NOTES

"Daily; this main note type; Anyway, its belong to dynamic notes 
"map \nd :FwkNoteDaily<CR>

"dynamic notes, they changes everyday
map \nv :FwkNoteDynamic Dictionnary<CR>
map \nx :FwkNoteDynamic myOthersNotes<CR>

"static notes, they creates only once
map \nf :FwkNoteStatic France_Jorney<CR>
map \nc :FwkNoteStatic Calendrier<CR>
map \nm :FwkNoteStatic ObjectifsPrincipale<CR>
map \nl :FwkNoteStatic Paroles_Lyrics<CR>
map \nk :FwkNoteStatic Connaissances<CR>
map \nt :FwkNoteStatic CommonTasks<CR>
map \nb :FwkNoteStatic Bourse<CR>
map \na :FwkNoteStatic Connaissances_Archive<CR>
map \no :FwkNoteStatic Copernic<CR>
map \np :FwkNoteStatic requis_pour_stl<CR>
map \ns :FwkNoteStatic 4x4_carre_Site<CR>
map \nb :FwkNoteStatic Buts<CR>


"--------------------------------------------------------------------















"""""""""""""""""""""""""""""""
"----NERD EXTENTION-----
"""""""""""""""""""""""""""""""
" uncomment block of code
map ,[ vi},cuvi}=

" comment   block of code
map ,] vi}O,cm


" comment /*
map  ,cq i/*<Left><Esc>
imap ,cq /*<Left><Left>

" open taglist menu
map <C-TAB> :TlistToggle<cr>

"nerd tree open/close
"map <A-f> :call OpenCloseFileExporerFunction("NERD")<cr>
"map <A-f> :call OpenCloseFileExporerFunction("VTREE")<cr>


"""""""""""""""""""""""""""
"NAVIGATION BETWEEN WINDOWS
"""""""""""""""""""""""""""
"if PLFM_HOSTNAME == 'dell-craventos' "pc with fr keyboard
    " move to select area to down window
    noremap ²<Down> <C-W><Down>
    "move to select area to up window
    noremap ²<Up> <C-W><Up>
    " move to select area to right window
    noremap ²<Right> <C-W>l
    " move to select area to left window
    noremap ²<Left> <C-W>h
"else


    noremap `<Down> <C-W><Down>
    "move to select area to up window
    noremap `<Up> <C-W><Up>
    " move to select area to right window
    noremap `<Right> <C-W>l
    " move to select area to left window
    noremap `<Left> <C-W>h

"endif

noremap <F11> <C-W><C-X>

map <C-B> :ScrollRotateFunction 0<CR>
map <C-F> :ScrollRotateFunction 1<CR>


map <S-w> :call FWK_Extention_Switch('simple_switch')<CR>
map <S-s> :call FWK_Extention_Switch('project_switch')<CR>
map <S-A-s> :call FWK_Extention_Switch('current_dir_switch')<CR>


"find what in buffer
"map <A-n> :"exe normal /" . "map"<CR>
map <A-n> :call SearchRegisterLikePattern()<CR>

" set path to current directory
map `p :lcd %:p:h<CR>
map ²p :lcd %:p:h<CR>

"run cmd
if has("gui_win32") || has("gui_win32s") "font config
    map  <A-\>      :!start cmd<cr>
else
    map  <A-\>      :!xterm -fg white -bg black -xrm 'XTerm*VT100.translations: #override <Btn1Up>: select-end(PRIMARY, CLIPBOARD, CUT_BUFFER0)': &<cr>
endif 
"run cmd in vim folder
map  <S-A-\>      :exe 'cd ' . PLFM_VIM_HOME_PATH<CR>:!start cmd<cr>




" ctrl+/ - disable current hl search
map  <A-/> :nohlsearch<cr>
vmap <A-/> <esc>:nohlsearch<cr>
imap <A-/> <esc>:nohlsearch<cr>




"""""""""""""""""""""""""""""""
"BUFFER KEYS
"""""""""""""""""""""""""""""""
" ALT-LEFT - prev buffer
map <a-Left> :tabp<cr>
"vmap <a-Left> <esc>:tabp<cr>
"imap <a-Left> <esc>:tabp<cr>

" ALT+RIGHT - next buffer
map <a-Right> :tabn<cr>
"vmap <a-Right> <esc>:tabn<cr>
"imap <a-Right> <esc>:tabn<cr>

"map <C-LEFT> :exe "normal b"<CR>
"map <C-RIGHT> :exe "normal w"<CR>



"if PLFM_HOSTNAME == 'dell-craventos'
    "map  ²v  :vs<CR>:wincmd w<CR>
    ""horizontal split
    "noremap ²h :sp<CR>
    vmap <C-Insert> "+y
    vmap <C-c> "+y

    "new tab
    map ²t  :tabnew<CR>:tabmove999<CR>
    imap ²t <Esc>:tabnew<CR>:tabmove999<CR>

"else
    "vert split
    "map  `v  :vs<CR>:wincmd w<CR>
    ""horizontal split
    "noremap `h :sp<CR>

    "new tab
    map `t  :tabnew<CR>:tabmove999<CR>
    imap `t <Esc>:tabnew<CR>:tabmove999<CR>

"endif


"map search key to space
"map <Space> /

"maping in / mode, very interesting
"cmap <Space> <CR>

"map  <A-'> :silent call ShowWrongSpaces()<CR>

"""""""""""""""""""""""""""""""
"FUZZY FINDER
"""""""""""""""""""""""""""""""
"map <Space>  :FuzzyFinderBuffer<cr>
"map <Space>  :FuzzyFinderBuffer<cr>
"map <A-e>    :FuzzyFinderFile<cr>
"map <A-d>    :FuzzyFinderDir<cr>
"map  <A-l>   :FuzzyFinderMruFile<cr>

"map <A-`> :FufBuffer<CR>
map <Space> :FufBuffer<CR>
map <A-f>   :FufFileWithCurrentBufferDir<CR>
"map <A-l>   :FufMruFile<CR>
"history with vim (not cool)
"nnoremap ; q:i

"history with fuf (nice!)
map <C-h>   :FufMruCmd<CR>

let g:fuf_infoFile = g:PLFM_VIM_TEMPDIR . cr_slash . '.vim-fuf'
"Grep plugin GARBAGE
"//--------------------------------------------------------------------
"grep -r --include=*.cs class *
"map \gr :Grep -r --include=*.[achp]* "" * <C-Left><Left><Left>
"map \gr :Grep -riI --exclude="*\.svn*" "" * <C-Left><Left><Left>
"map \gr :Grep -riI --exclude-dir=.svn "" * <C-Left><Left><Left>
"map \gw :Grep -riIw --exclude-dir=.svn "" * <C-Left><Left><Left>
"
"in what search
"let Grep_Skip_Files = '*.cpp'
"let Grep_Skip_Dirs = '.svn'
"let Grep_Default_Filelist ='*.cpp'
"map \gf :Grep -riI "" *<Left><Left><Left>
"map \gf :Grep -riI --exclude-dir=.svn --exclude=*.hbac --exclude=*.hbsm --exclude=*.hbcm --exclude=*.xml --exclude=*.uml --exclude=tags --exclude=*.svg "" *<C-Left><C-Left><Right>
"//--------------------------------------------------------------------

let g:FWK_Grep_exclude_files = 'tags *.svg *.hbac *.hbsm *.hbcm *.xml *.uml *.valid *.test *.uxf *.d'
let g:FWK_Grep_exclude_dir   = '.svn .metadata'

". ' LGrep -riI "" *<C-Left><C-Left><Right>'
if has("gui_win32") || has("gui_win32s")
    map \gf :LGrep -riI "" *<C-Left><C-Left><Right>
    exe 'map \gb :' . 'cd ' . PLFM_VIM_NOTES_GEN . '<CR>:' . 'LGrep -riI ' . '"' . '"' . ' *' . "<C-Left><C-Left><Right>"
else
    map \gf :LGrep -riI  *<C-Left><Left>
    exe 'map \gb :' . 'cd ' . PLFM_VIM_NOTES_GEN . '<CR>:' . 'LGrep -riI ' . ' *' . "<C-Left><C-Left>"
endif

"let g:FWK_Grep_Options_Added = '--exclude-dir=.svn --exclude=*.hbac --exclude=*.hbsm --exclude=*.hbcm --exclude=*.xml --exclude=*.uml --exclude=tags --exclude=*.svg'
"map \gw :Grep -riIw "" * <C-Left><Left><Left>
"map \gf :Grep -riI "" *<C-Left><C-Left><Right>

"map \gg :GrepW -riI "" *<C-Left><Left><Left>
"map \gw :Grep -rw --include=*.[achp]* "" * <C-Left><Left><Left>
"map \gw :Grep -r -w "" *.hpp *.cpp *.h *.c *.cs *.aspx *.py<Home><S-Right><S-Right><S-Right><S-Right><Left>

""""""""""""""""""""""""""""""""
""MRU
""""""""""""""""""""""""""""""""
"map  <a-l>      :MRU<cr>
"vmap <a-l> <esc>:MRU<cr>
"imap <a-l> <esc>:MRU<cr>


"""""""""""""""""""""""""""""""
"VTREE EXPLORER
"""""""""""""""""""""""""""""""
"let g:treeExplVertical=1
"let g:treeExplWinSize=35
"let g:treeExplHidden=1
"let g:treeExplDirSort=1

"""""""""""""""""""""""""""""""
"GET VARIABLES FUNCTIONS
"""""""""""""""""""""""""""""""
" \gp - get path; get file; get absolute path
map  \gvf  :call FWK_get_Variable('file_name')<cr>
map  \gvs  :call FWK_get_Variable('file_name_without_ext')<cr>
map  \gvd  :call FWK_get_Variable('path_only')<cr>
map  \gva  :call FWK_get_Variable('absolute_path')<cr>
map  \gvrd :call FWK_get_Variable('path_only_rev')<cr>
map  \gvra :call FWK_get_Variable('absolute_path_rev')<cr>

map  \gvt :call FWK_get_Variable('GetTime')<cr>


" get ifndef in file
map \gi :silent call FWK_get_defined_patterns("predef_if_not_def_define")<CR>
"map \gr :silent call FWK_get_defined_patterns('config.vrun')<CR>
map \gs :silent call FWK_get_defined_patterns("comment_sexy")<CR>
map \gp :silent call FWK_get_defined_patterns("comment_variable")<CR>


"//---------------------------------------------------------------------------------
"TABS EXPEREMENT
"//---------------------------------------------------------------------------------
set tabpagemax=5
"remap C-] for USE TO OPEN TABS
"map <C-]> :GFforTabs<CR>
"noremap gf <C-W>gf
"map gf :tabe <cfile><CR>

noremap <silent> <A-PageUp> :exe "silent! tabmove " . (tabpagenr() - 2)<CR>
noremap <silent> <A-PageDown> :exe "silent! tabmove " . tabpagenr()<CR>
noremap <silent> <A-Up> :bn<CR>
noremap <silent> <A-Down> :bp<CR>

"nn <silent> <A-PageUp> :if tabpagenr() == tabpagenr("$")\|tabm 0\|el\|exe "tabm ".tabpagenr()\|en<CR>
"nn <silent> <A-PageDown> :if tabpagenr() == 1\|exe "tabm ".tabpagenr("$")\|el\|exe "tabm ".(tabpagenr()-2)\|en<CR>


set guitablabel=%{GuiTabLabel()}
set guitabtooltip=%{GuiTabToolTip()} 





"//---------------------------------------------------------------------------------
"MINI SCRIPTS
"//---------------------------------------------------------------------------------

""""""""""""""""""""""""""""""""""
" Uncomment the following to have Vim jump to the last position when reopening a file
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
		\| exe "normal g'\"" | endif
endif

"Vim load indentation rules according to the detected filetype.
"""""""""""""""""""""""""""""""""""
if has("autocmd")
    filetype indent on
endif

set noea
map <c-X> <Del>


"hex/HEX EDIT
	augroup Binary
	  au!
	  au BufReadPre  *.bin,*.exe,*.doc,*.zip let &bin=1
	  au BufReadPost *.bin,*.exe,*.doc,*.zip if &bin | %!xxd
	  au BufReadPost *.bin,*.exe,*.doc,*.zip set ft=xxd | endif
	  au BufWritePre *.bin,*.exe,*.doc,*.zip if &bin | %!xxd -r
	  au BufWritePre *.bin,*.exe,*.doc,*.zip endif
	  au BufWritePost *.bin,*.exe,*.doc,*.zip if &bin | %!xxd
	  au BufWritePost *.bin,*.exe,*.doc,*.zip set nomod | endif
	augroup END



    exe "source " . PLFM_VIM_HOME_PATH . '/vim_extention/vimrc_config/' . 'registers.vim'
endif "ENDIF OF FILE"


"vmap <F7> :exe "'<,'>s/\\d*:\\d*\\s*\\d\\+\\s*//"<CR>
"vmap <F7> :call RemoveBgnTraceGrabage()<CR>

function CreateTestRegexString()
    let regexStr = ""
    let ListStr = @*
    "remove empty lines
    let ListStr = substitute(ListStr,'\n','|','g')

    "remove comments
   let ListStr = substitute(ListStr,'/\*[^\*]*\*/','','g')

    ""remove \+ '|' character
    let ListStr = substitute(ListStr, '|\{2,\}','|','g')

    "remove | from begining and end
    let ListStr = substitute(ListStr, '\(^|\||$\)','','g')

    let @* = ListStr

endfunc

function FWK_Execute_LinesList()
    let regexStr = ""
    let strings_list = @*
    "replace \ to 
    let strings_list = substitute(strings_list,'\(\n\|\\\)','','g')
    "let strings_list = substitute(strings_list,'\\','\\\\','g')

    ""remove comments
   "let ListStr = substitute(ListStr,'/\*[^\*]*\*/','','g')

    """remove \+ '|' character
    "let ListStr = substitute(ListStr, '|\{2,\}','|','g')

    ""remove | from begining and end
    "let ListStr = substitute(ListStr, '\(^|\||$\)','','g')

    let @* = strings_list

    "           call FWK_genTagsMap('\tq',
    "                    \'C:\programs\qt\46\include'
    "                    \)


endfunc


let g:FWK_Diff_SameBuffer_enable = 0
function FWK_Diff_SameBuffer()

    if g:FWK_Diff_SameBuffer_enable == 0
        let g:FWK_Diff_SameBuffer_enable = 1
        "add event
        "autocmd  CursorMoved <buffer> diffupdate
        map <buffer> u :u<CR>:diffupdate<CR>
        map <buffer> <C-r> :redo<CR>:diffupdate<CR>
    else
        let g:FWK_Diff_SameBuffer_enable = 0
        "remove event
        "autocmd! CursorMoved <buffer>
        unmap <buffer> u
        unmap <buffer> <C-r>
    endif


    if g:FWK_Diff_SameBuffer_enable == 1 
        let syntax_value = &syntax
        let file_to_diff = expand('%:p') 
        setlocal splitright              "set split direction to right
        exe "vs " . tempname()

        "fill tmp file with file_to_diff
        exe "r " . file_to_diff

        "disable vim warning when we will try to close file
        set bt=nofile

        let &syntax = syntax_value

        diffthis
        wincmd p
        diffthis


    elseif g:FWK_Diff_SameBuffer_enable == 0
        diffoff
        wincmd p
        diffoff
        "close tmp file
        exe "bw" 

    else
        echo 'FWK_Diff_SameBuffer: wrong option'

    endif

endfunction

"//--------------------------------------------------------------------
"line regex operations

"remove timesheet
vmap     \rv :call FWK_Buf_Substitute( 's:.*\t::')<CR>
map     \rv :call FWK_Buf_Substitute( 's:.*\t::')<CR>


"remove notes status
vmap     \rn :call FWK_Buf_Substitute( 's/^.*\w)\s//g' )<CR>
map     \rn :call FWK_Buf_Substitute( 's/^.*\w)\s//g' )<CR>
"remove c style comments
vmap     \rc :call FWK_Buf_Substitute( 's:\/\*\(.*\)\*\/:\1:' )<CR>
map     \rc :call FWK_Buf_Substitute( 's:\/\*\(.*\)\*\/:\1:' )<CR>

"make regex string for traceClient
vmap \rt :call CreateTestRegexString()<CR>

"execute strings list
vmap \re :call FWK_Execute_LinesList()<CR>

"//--------------------------------------------------------------------

"map \ere :OpenTabsSilent U:\_products\x86-qnx-m641-4.3.3-osp-trc-rel\DetailedLog.hbbl<CR>:silent setlocal nobuflisted<CR>:e!<CR>gg/error:\\|undefined\ reference\\|(Permission\ denied)\\|don't\ know\ how\ to\ make<CR>

map \erw :silent call FWK_search_in_file_by_pat('U:\_products\x86-qnx-m641-4.3.3-osp-trc-rel\DetailedLog.hbbl', 'error:\\|warning:\\|undefined\ reference\\|(Permission\ denied)\\|don' . "'" . 't\ know\ how\ to\ make')<CR>
"map \erw :FWK_SearchPatInFile U:\_products\x86-qnx-m641-4.3.3-osp-trc-rel\DetailedLog.hbbl gg/error:\\|undefined\ reference\\|(Permission\ denied)\\|don't\ know\ how\ to\ make"<CR>

            "\,'error:\\|warning:\\|undefined\ reference\\|(Permission\ denied)\\|don't\ know\ how\ to\ make'


func FWK_search_in_file_by_pat(filename, pattern)
    "Decho('FWK_search_in_file_by_pat: filename=' . a:filename)
    "Decho('FWK_search_in_file_by_pat: pattern=' . a:pattern)

    exe 'OpenTabsSilent ' . a:filename
    setlocal nobuflisted
    :e!
    exe 'normal ' . 'gg'
    call search(a:pattern)
    let @/ = a:pattern
    let @* = a:pattern

    "match Search 'api'
endfunc

map `f :call FWK_Language_French_Mode()<CR>
imap `f <c-o>:call FWK_Language_French_Mode()<CR>


"Events
"change path to current on enter
"autocmd BufEnter * lcd %:p:h
"autocmd BufWinEnter * lcd %:p:h

" Execute file being edited with <Shift> + e:
"map <buffer> <S-e> :w<CR>:!/usr/bin/env python % <CR>


map <C-j> :call FWK_Lingvo_Join_LinesFromButtom()<CR>

"//--------------------------------------------------------------------
"Description: function to join two lines from button, useful when copy from
"lingvo 'search expression' and past in vocabulaire.notes file
"//--------------------------------------------------------------------
func FWK_Lingvo_Join_LinesFromButtom()
    let l:line = line(".") - 1
    exe ':' . l:line . 'j2'
endfunc

func FWK_BufDo_Log(cmd)
    
    let currBuff=bufnr("%")

    let l:file = g:PLFM_VIM_LOGS .  g:cr_slash . 'bufdo' . strftime("%Y_%d_%b.\%H_%M_%S") . '.log'
    exe 'redir! >' . l:file
    exe 'bufdo ' . a:cmd
    exe 'redir END'

    exe 'buffer ' . currBuff

endfunc
com! -nargs=+ -complete=command Bufdo call FWK_BufDo_Log(<q-args>)

"autocmd FileType djangohtml,html,xhtml,xml source ~/.vim/plugin/closetag.vim

"set env var, depricated in this piece of code
"let $PYTHONPATH='D:\workspace\django\create_web_app_with_py\mysite'

"WORKED: this is only solution to make django autocomplite in vim
if has("python")
    python import sys,os
    python sys.path.append('/home/sergey/workspace/django')
    python os.environ['DJANGO_SETTINGS_MODULE'] = 'ppdlive.settings'
endif
"python sys.path.append('D:/workspace/django/create_web_app_with_py/mysite')

"ADDED by Me


"//--------------------------------------------------------------------
map \pv :call FWK_SetDjangoVariable()<CR>

"//--------------------------------------------------------------------
"Description: function to set DJANGO_SETTINGS_MODULE and PYTHONPATH variables to current
"django project.
"THIS FUNC NOT WORK!!! BECAUSE SET OF VAR IS ACTUAL ONLY ON VIM START
"//--------------------------------------------------------------------
function FWK_SetDjangoVariable()
    if !has('python')
        echo "Error: Required vim compiled with +python"
        finish
    endif

    let prj_path = getcwd() "get cd path (project)
    let django_mod_var = substitute(expand("%:p"), FWK_System_AddSlash(prj_path), '','') "remove intersections
    let django_mod_var = substitute(django_mod_var,'\\\(\w\+\).*','\1','') . '.settings' "get project dir name
    exe "py set_main_django_variables('" . prj_path . "', '" . django_mod_var . "')"
endfunc

if has("python")
python << EOF
def set_main_django_variables(full_path, django_set_module_str):
    import sys,os

    #look for var in sys.path
    isFound_full_path = False
    for var in sys.path:
        if var == full_path:
            isFound_full_path = True
            break

    if not isFound_full_path:
        #add current project path to python path
        sys.path.append(full_path)

    if not os.environ.has_key('DJANGO_SETTINGS_MODULE') or\
        django_set_module_str != str(os.environ['DJANGO_SETTINGS_MODULE']):
        #change django var to curr prj var
        os.environ['DJANGO_SETTINGS_MODULE'] = django_set_module_str 
EOF
"//--------------------------------------------------------------------
endif

    "omap <silent> iw <Plug>CamelCaseMotion_iw
    "xmap <silent> iw <Plug>CamelCaseMotion_iw
    "omap <silent> b <Plug>CamelCaseMotion_b
    "xmap <silent> b <Plug>CamelCaseMotion_b
    "omap <silent> ie <Plug>CamelCaseMotion_ie
    "xmap <silent> ie <Plug>CamelCaseMotion_ie


"autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

"exe "normal \<C-S-Right>"
"noremap W w

let &viminfo =&viminfo . ',n' . g:PLFM_VIM_TEMPDIR . g:cr_slash . '_viminfo'




"html formating
"need to install tidy
"exe 'setlocal equalprg=tidy\ -quiet\ -f\ '.&errorfile
"setlocal makeprg=tidy\ -quiet\ -e\ %
"
"remove <s-down/up> mappings
map <F9> :call Format_html()<CR>

"change vim 'scroll page' to 'move one line'
vmap <s-up> k
vmap <s-down> j

"change vim 'scroll page' to 'move one line'
"imap <a-;> <
"imap <a-:> >

"format by myself
func Format_html()
    :%s/”/"/ge "replace non unicode brakets
    "align text in file
    retab
    %s/\ \{2,\}/\ /ge "replaces 2 and more spaces on one space

    if &ft == 'css'
        :%s/}/&\r/g
        ":%s/{\_.\{-}}/\=substitute(submatch(0), '\n', '', 'g')/ "select { 'inclusive' } and make it in one line (remove all \n )
        ":%s/\({\|;\)/&\r/g "set \n after each { or ;
        ":%s/}/&\r/g "set \n after each }

    else "html

       :%s/</\r&/g "add new line after each <
       :%s/\s$//g "remove spaces on end of line


       ":%s/\(\s\|\t\)/\r/g "replace spaces and tabs on \r
       ":%s/\n$//g          "remove empty lines
       ":%s/<\_.\{-}>/\=substitute(submatch(0), '\n', '', 'g')/
       ":%s/.*$/&\r/g       "add \n after each line



    endif

    %s/^\n\{2,\}/\r/ge "leave only one space
    exe "normal " . 'ggVG=' 

endfunc


"css format
"csstidy.exe style.css --silent=true style.css

"VARIABLES"
"get window variables"
"echo keys(w:)
"
func CustomFastGrep(search_arg)

	let old_efm = &efm
	set efm=%f\:%l:%m "grep format

    let cmd = 'grep -n ' . a:search_arg . ' *'
    ""    c:\programs\gvim\Notes\dynamic\2011\10_Oct
	"let tmpfile = tempname()
	let tmpfile = 'res2.txt'
    let output = system(cmd)

    if output == ""
        echohl WarningMsg | 
        \ echomsg "Error: Pattern " . search_arg . " not found" | 
        \ echohl None
        return
	endif

    exe '!' . cmd . ' > ' . tmpfile
	exe "silent! cfile " . tmpfile
    "Decho('output=' . output)
    "Decho('cmd=' . cmd)

	let &efm = old_efm
    call delete(tmpfile)

	"endif
	"if exists("a:3")
		"let cmd = cmd . " " . a:3
	"endif
	"let cmd_output = system(cmd)


	"let tmpfile = tempname()
	"let curfile = expand("%")

	"if &modified && (!&autowrite || curfile == "")
		"let jumperr = 0
	"endif

	"exe "redir! > " . tmpfile
	"if curfile != ""
		"silent echon curfile . " dummy " . line(".") . " " . getline(".") . "\n"
		"silent let ccn = 2
	"else
		"silent let ccn = 1
	"endif
	"silent echon cmd_output
	"redir END

	"" If one item is matched, window will not be opened.
""	let cmd = "wc -l < " . tmpfile
""	let cmd_output = system(cmd)
""	exe "let lines =" . cmd_output
""	if lines == 2
""		let openwin = 0
""	endif

	"let old_efm = &efm
	"set efm=%f\ %*[^\ ]\ %l\ %m

	"exe "silent! cfile " . tmpfile
	"let &efm = old_efm

	"" Open the cscope output window
	"if openwin == 1
		"botright copen
	"endif

	"" Jump to the first error
	"if jumperr == 1
		"exe "cc " . ccn
	"endif

	"call delete(tmpfile)
endfunc
command! -n=1 GG  :call CustomFastGrep('<args>')



"DISABLE ZIP BROWSE
let g:loaded_zipPlugin= 1
let g:loaded_zip      = 1

"map <S-Insert> <MiddleMouse>
"map! <S-Insert> <MiddleMouse>
if has("gui_running")
    map <silent> <S-Insert> "+p
    cmap <S-Insert> <C-R>+
    imap <silent> <S-Insert> <Esc>"+pa
endif



