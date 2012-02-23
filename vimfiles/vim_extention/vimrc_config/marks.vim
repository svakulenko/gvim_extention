"-----------------------------------
"NOREMAP HOTKEYS
"-----------------------------------
"" remark set
"noremap mq mQ
"noremap mw mW
"noremap me mE
"noremap ma mA
"noremap ms mS
"noremap md mD
"noremap mz mZ
"noremap mx mX
"noremap mc mC

"" remark get
"noremap 'a 'A
"noremap 'q 'Q
"noremap 'w 'W
"noremap 'e 'E
"noremap 'a 'A
"noremap 's 'S
"noremap 'd 'D
"noremap 'z 'Z
"noremap 'x 'X
"noremap 'c 'C

"map ma :call Fwk_bookmarks_marks_saveMark("A")<CR>
"map 'a :call Fwk_bookmarks_marks_loadMark("A")<CR>


"SET MARKS
map mq :SetSuperMark q<CR>
map mw :SetSuperMark w<CR>
map me :SetSuperMark e<CR>
map ma :SetSuperMark a<CR>
map ms :SetSuperMark s<CR>
map md :SetSuperMark d<CR>
map mz :SetSuperMark z<CR>
map mx :SetSuperMark x<CR>
map mc :SetSuperMark c<CR>

map mr :SetSuperMark r<CR>
map mt :SetSuperMark t<CR>
map my :SetSuperMark y<CR>
map mf :SetSuperMark f<CR>
map mg :SetSuperMark g<CR>
map mh :SetSuperMark h<CR>
map mv :SetSuperMark v<CR>
map mb :SetSuperMark b<CR>
map mn :SetSuperMark n<CR>


"GET MARKS ; open in buffer mode
map 'q :GetSuperMarkB q<CR>
map 'w :GetSuperMarkB w<CR>
map 'e :GetSuperMarkB e<CR>
map 'a :GetSuperMarkB a<CR>
map 's :GetSuperMarkB s<CR>
map 'd :GetSuperMarkB d<CR>
map 'z :GetSuperMarkB z<CR>
map 'x :GetSuperMarkB x<CR>
map 'c :GetSuperMarkB c<CR>

map 'r :GetSuperMarkB r<CR>
map 't :GetSuperMarkB t<CR>
map 'y :GetSuperMarkB y<CR>
map 'f :GetSuperMarkB f<CR>
map 'g :GetSuperMarkB g<CR>
map 'h :GetSuperMarkB h<CR>
map 'v :GetSuperMarkB v<CR>
map 'b :GetSuperMarkB b<CR>
map 'n :GetSuperMarkB n<CR>


"GET MARKS ; open in tab mode
map 'Q :GetSuperMarkT q<CR>
map 'W :GetSuperMarkT w<CR>
map 'E :GetSuperMarkT e<CR>
map 'A :GetSuperMarkT a<CR>
map 'S :GetSuperMarkT s<CR>
map 'D :GetSuperMarkT d<CR>
map 'Z :GetSuperMarkT z<CR>
map 'X :GetSuperMarkT x<CR>
map 'C :GetSuperMarkT c<CR>

map 'R :GetSuperMarkT r<CR>
map 'T :GetSuperMarkT t<CR>
map 'Y :GetSuperMarkT y<CR>
map 'F :GetSuperMarkT f<CR>
map 'G :GetSuperMarkT g<CR>
map 'H :GetSuperMarkT h<CR>
map 'V :GetSuperMarkT v<CR>
map 'B :GetSuperMarkT b<CR>
map 'N :GetSuperMarkT n<CR>

