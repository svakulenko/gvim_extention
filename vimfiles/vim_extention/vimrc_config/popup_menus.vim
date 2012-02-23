
if v:version < 701 
  finish 
endif 

if has("gui_running")
"//--------------------------------------------------------------------
"STANDART MOUSE MENU, workaround to disable tearoff from popUp (popUp iherit
"this attribute, and only way to remove it - remove all menu and recreate
"without this attribute
"//--------------------------------------------------------------------
unmenu! PopUp
unmenu PopUp


"//--------------------------------------------------------------------
"Description: this menu inherit PopUp to be calling from right mouse click
"also, with others standart commands
"//--------------------------------------------------------------------

"Scripts.Directories"
amenu PopUp.&Bookmarks                       :call FWK_System_Fuf_browse('C:\programs\gVim\Notes\Common')<CR>
amenu PopUp.Bookmarks_&Home                  :call FWK_System_Fuf_browse(g:cfg_path)<CR>
"amenu PopUp.Bookmarks\ &Search               :cd C:\programs\gVim\Notes<CR>:LGrep -riI "" *<C-Left><C-Left><Right>
amenu PopUp.&Directories.&Mynotes            :call FWK_System_Fuf_browse(g:PLFM_VIM_NOTES)<CR>
amenu PopUp.&Directories.&VimFiles           :call FWK_System_Fuf_browse(g:cfg_path)<CR>
amenu PopUp.&Directories.&TfcSuite           :call FWK_System_Fuf_browse('C:\Program Files\Luxoft\tfc Suite')<CR>
amenu PopUp.&Directories.&Home_Desktop_Notes :call FWK_System_Fuf_browse('C:\programs\gVim\Notes\Common\Home')<CR>
amenu PopUp.&Directories.&Work_Desktop_Notes :call FWK_System_Fuf_browse('C:\programs\gVim\Notes\Common\Work')<CR>


"Scripts.Directories.Desktopnotes"

"Cmd"
amenu PopUp.&Cmd.&Sdb_GrphicInterface :call FWK_runCmd('D:\workspace\qt\RND\Glanass\Sdb_GrphicInterface')<CR>
amenu PopUp.&Cmd.&TfcSuite :call FWK_runCmd('C:\Program Files\Luxoft\tfc Suite')<CR>
amenu PopUp.&Cmd.&Django   :call FWK_runCmd('D:\workspace\django')<CR>

"Change\ Run\ Project"
"amenu PopUp.Change\ Run\ Project.&Sdb_GrphicInterface :map <a-r> :call ExecuteSelfFile( 'D:\workspace\qt\rnd\svn\email\gui\Sdb_GrphicInterface\Sdb_GrphicInterface.exe')<CR>
"amenu PopUp.Change\ Run\ Project.&TestProjectFsm :map <a-r>:call ExecuteSelfFile( 'D:\workspace\qt\rnd\test\04_fsm\debug\04_fsm.exe')<CR>


"File.Encoding"
amenu PopUp.&File.&Encoding.&View.&utf-8  :e ++enc=utf-8<CR>
amenu PopUp.&File.&Encoding.&View.&cp1251 :e ++enc=cp1251<CR>
amenu PopUp.&File.&Encoding.&Convert\ to.&utf-8  :e ++enc=cp1251<CR>:w ++enc=utf-8<CR>
amenu PopUp.&File.&Encoding.&Convert\ to.&cp1251 :e ++enc=utf-8<CR>:w ++enc=cp1251<CR>
"File.Open"
amenu PopUp.File.&Open  :browse confirm edit<CR
"File.Save
amenu PopUp.&File.&Save\ As :browse confirm sav<CR>
"File.Zoom"
amenu PopUp.&File.&Zoom.&In   :call FWK_fontZoomInOut(1)<CR>
amenu PopUp.&File.&Zoom.&Out  :call FWK_fontZoomInOut(-1)<CR>


"Projects"
amenu PopUp.&Projects.&Work :exe 'Project ' . g:PLFM_VIM_PROJECTS . g:PLFM_SL . 'luxoft_machine.vimp'<CR>
amenu PopUp.&Projects.&Home :exe 'Project ' . g:PLFM_VIM_PROJECTS . g:PLFM_SL . 'home_machine.vimp'<CR>


"Scripts.mybin"
amenu PopUp.Scrip&ts.&mybin\ scenarios :call FWK_System_Fuf_browse('c:\programs\mybin\scenarios')<CR>

"ViewMode"
amenu PopUp.&ViewMode.&BookReader :call PopUp.ook_Mode("on")<CR>
"amenu PopUp.PopUp.Hello :call hello<CR>

"Window
amenu PopUp.&Window.&Small     :set lines=16<CR>
amenu PopUp.&Window.&Medium    :set lines=28<CR>
amenu PopUp.&Window.&Large     :set lines=200<CR>




"// part of menu.vim, changed according to my taste :)
"//--------------------------------------------------------------------
"//--------------------------------------------------------------------
"//--------------------------------------------------------------------
func! <SID>SelectAll()
  exe "norm gg" . (&slm == "" ? "VG" : "gH\<C-O>G")
endfunc
" The popup menu
an PopUp.Copy_Paste.&Undo           u
an PopUp.Copy_Paste.-SEP1-          <Nop>
vnoremenu PopUp.Copy_Paste.Cu&t     "+x
vnoremenu PopUp.Copy_Paste.&Copy        "+y
cnoremenu PopUp.Copy_Paste.&Copy        <C-Y>
nnoremenu PopUp.Copy_Paste.&Paste       "+gP
cnoremenu PopUp.Copy_Paste.&Paste       <C-R>+
exe 'vnoremenu <script> PopUp.Copy_Paste.&Paste ' . paste#paste_cmd['v']
exe 'inoremenu <script> PopUp.Copy_Paste.&Paste ' . paste#paste_cmd['i']
vnoremenu PopUp.Copy_Paste.&Delete      x
an PopUp.Copy_Paste.-SEP2-          <Nop>
vnoremenu PopUp.Copy_Paste.Select\ Blockwise    <C-V>

"nnoremenu PopUp.Copy_Paste.Select\ &Word   vaw
"onoremenu PopUp.Copy_Paste.Select\ &Word   aw
"vnoremenu PopUp.Copy_Paste.Select\ &Word   <C-C>vaw
"inoremenu PopUp.Copy_Paste.Select\ &Word   <C-O>vaw
"cnoremenu PopUp.Copy_Paste.Select\ &Word   <C-C>vaw

nnoremenu PopUp.Copy_Paste.Select\ &Sentence    vas
onoremenu PopUp.Copy_Paste.Select\ &Sentence    as
vnoremenu PopUp.Copy_Paste.Select\ &Sentence    <C-C>vas
inoremenu PopUp.Copy_Paste.Select\ &Sentence    <C-O>vas
cnoremenu PopUp.Copy_Paste.Select\ &Sentence    <C-C>vas

nnoremenu PopUp.Copy_Paste.Select\ Pa&ragraph   vap
onoremenu PopUp.Copy_Paste.Select\ Pa&ragraph   ap
vnoremenu PopUp.Copy_Paste.Select\ Pa&ragraph   <C-C>vap
inoremenu PopUp.Copy_Paste.Select\ Pa&ragraph   <C-O>vap
cnoremenu PopUp.Copy_Paste.Select\ Pa&ragraph   <C-C>vap

"nnoremenu PopUp.Copy_Paste.Select\ &Line   V
"onoremenu PopUp.Copy_Paste.Select\ &Line   <C-C>V
"vnoremenu PopUp.Copy_Paste.Select\ &Line   <C-C>V
"inoremenu PopUp.Copy_Paste.Select\ &Line   <C-O>V
"cnoremenu PopUp.Copy_Paste.Select\ &Line   <C-C>V

"nnoremenu PopUp.Copy_Paste.Select\ &Block  <C-V>
"onoremenu PopUp.Copy_Paste.Select\ &Block  <C-C><C-V>
"vnoremenu PopUp.Copy_Paste.Select\ &Block  <C-C><C-V>
"inoremenu PopUp.Copy_Paste.Select\ &Block  <C-O><C-V>
"cnoremenu PopUp.Copy_Paste.Select\ &Block  <C-C><C-V>

noremenu  <script> <silent> PopUp.Copy_Paste.Select\ &All   :<C-U>call <SID>SelectAll()<CR>
inoremenu <script> <silent> PopUp.Copy_Paste.Select\ &All   <C-O>:call <SID>SelectAll()<CR>
cnoremenu <script> <silent> PopUp.Copy_Paste.Select\ &All   <C-U>call <SID>SelectAll()<CR>
an PopUp.Copy_Paste.-SEP3-          <Nop>

"//--------------------------------------------------------------------
"//--------------------------------------------------------------------
"//--------------------------------------------------------------------





map \m :popup! PopUp<CR>

endif
