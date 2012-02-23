"""""""""""""""""""""""""
"""""""REGISTERS"""""""""
"""""""""""""""""""""""""
"add second clipboard ,register k, copy
"map <C-Home> "kyy
"add second clipboard ,register k, paste
"map <S-Home> "kpg^



"map <C-K> :call RegisterManipulator("vmapCopy","k")
"map <A-k> :call RegisterManipulator("vmapPaste","k")

"""""""""""""""""""""""""
"MAPPING of registers
"""""""""""""""""""""""""
"copy to register h
"map <C-H> "hyy
"imap <C-H> <Esc>"hyya
"vmap <C-H> "hy
""paste from register h
"map <A-h> "hp
"imap <A-h> <Esc>"hpa

func SetRigsterCopyPaste(alpha)
"copy to register
exe  'map <C-' . a:alpha . '> "'      . a:alpha . 'yy'
exe 'imap <C-' . a:alpha . '> <Esc>"' . a:alpha . 'yya'
exe 'vmap <C-' . a:alpha . '> "'      . a:alpha . 'y'

"paste to register
exe  'map <A-' . a:alpha . '> "'          . a:alpha . 'p'
exe 'imap <A-' . a:alpha . '> <Esc>"'     . a:alpha . 'p'
exe 'cmap <A-' . a:alpha . '> <C-R><C-O>' . a:alpha

endfunc


":call SetRigsterCopyPaste('k')
":call SetRigsterCopyPaste('u')
":call SetRigsterCopyPaste('i')
""copy to register j
"map <C-U> "jyy
"imap <C-U> <Esc>"jyya
"vmap <C-U> "jy
""paste from rfgister j
"map <A-j> "jp
"imap <A-j> <Esc>"jpa
"cmap <A-k> <C-R><C-O>j



""copy to register k
"map <C-K> "kyy
"imap <C-K> <Esc>"kyya
"vmap <C-K> "ky


""paste from register k
"map <A-k> "kp
"imap <A-k> <Esc>"kpa
"cmap <A-k> <C-R><C-O>k

""copy to register m
"map <C-M> "myy
"imap <C-M> <Esc>"myya
"vmap <C-M> "my
""paste from register m
"map <A-m> "mp
"imap <A-m> <Esc>"mpa

""copy to register n
"map <C-N> "nyy
"imap <C-N> <Esc>"nyya
"vmap <C-N> "ny
""paste from register n
"map <A-n> "np
"imap <A-n> <Esc>"npa


"debug register
   
"
"let @r="printf(\"DBG STATE : \\n\"); "
let @r="BPC_DBG_D( CPBrowserGlobal::BPC_CONNECTION,\" \");"
map <A-d> o<Esc>"rp==f"a
imap <A-d> <Esc>o<Esc>"rp==f"a


"""""""REGISTERS"""""""""

" :reg     - show named registers and what's in them
" @k       - execute recorded edits (macro)
" @@       - repeat last one
" 5@@      - repeat 5 times
" "kp      - print macro k   (e.g., to edit or add to .vimrc)

" "kd      - replace register k with what cursor is on
" qk       - records edits into register k (q again to stop recording)
"<ctrl-R>k - display contents of register k (insert mode)

"let @/ = '\<' . cur_word . '\>' "register for search
"let @* = cur_word               "register for standart clipboard


"There never seem to be enough spare keys for maps.
"It's possible however to preload Vim's registers in vimrc with your frequent commands, for example:
"let @m=":'a,'bs/"
"let @s=":%!sort -u"
"Here's a twisted one
"let @y='yy@"'


