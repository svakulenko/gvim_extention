"SET PARAMETERS"
""//--------------------------------------------------------------------
"set statusline=\ %{g:buftabs_list}%=%{&encoding}\ %l,%c\ 
"set v:lang=EN
"set langmenu=menu_en_gb.latin1
"set langmenu=menu_fr_fr.utf-8
"set langmenu=menu_fr.utf-8

"winpos 0 0              " window position

"if has("gui_running") && has('win32')
    "set lines=200              " lines numbers in window
    "set columns=800            " columns numbers in window
    "endif
"GENERAL
set paste
set fileformats=unix,dos "set default fformat for end of file (try unix, if can't -> try dos (^M))
filetype on
filetype plugin on
set statusline=%<%f\ %h%m%r%=%-14.(%{&encoding}\ %l,%c%V%)\ %P\ (%L)
language C                      " lang to show, default english
set fileformat=unix             " default coding for current file
set fileformats=unix            " default coding for files (possible)
set laststatus=2                " show line status

syntax enable                   " enable syntax
set nocompatible                " vi noncomtable
colorscheme desert              " alt theme
set history=200                 " how many history steps remember
set undolevels=250              " how many changes can be undone
set nostartofline               " leave cursor when scrolling
set autoread                    " auto refresh files reload
set wm=2                        " To automatically wrap words in Vim

"COPY/PASTE
"go == guioptions
set guioptions=                 " reset options
set guioptions+=a               " Selected text is available for pasting in vim and other app.
set guioptions+=e               " Add tab pages when indicated with 'showtabline'. 'guitablabel' can be used (ctdire enable gui tabs)
set guioptions+=c               " transform dialogs to console!
"set guioptions+=M              " The system menu "$VIMRUNTIME/menu.vim" is not sourced
"set guioptions+=f              " foreground: don'r use fork???
"set formatoptions=tcqn         " how automatic formatting is to be done
"formatoptions=tcqnablM
set mouse=a                     " drag n drop in unix
"set mouse=n                    " drag n drop in unix
set mousemodel=popup_setpos     " add popup 

"copy buffer on select for Linux
"http://stackoverflow.com/questions/9166328/how-to-copy-selected-lines-to-clipboard-in-vim
"if has("gui_win32") || has("gui_win32s")
    "set clipboard=              " in win32, with guioptions+=a  all works fine
"else
    "set clipboard=unnamedplus   " from vim 7.3 in X windows, place yanked text into the global clipboard
"endif




"
set hidden                      " disable move-block when buffer is modified
set hlsearch                    " find result's highlight


behave mswin                    " +shift for visual mode
    if has("autocmd") | filetype indent on | endif "Vim load indentation rules according to the detected filetype.
"set cindent                    " Works more cleverly than the other two and is configurable to different indenting styles
if has("gui_win32") || has("gui_win32s") "font config
    set autoindent                  " take indent for new line from previous line
    set smartindent                 " is like 'autoindent' but also recognizes some C syntax
    set cindent                   " For linux only, otherwise paste with Ctrl + impossible
    set cinoptions=i0               " some special options of ident
else
    set autoindent                  " take indent for new line from previous line
    "if has("autocmd") | filetype indent on | endif "Vim load indentation rules according to the detected filetype.

endif


set formatoptions=
set formatoptions+=t            "   Auto-wrap text using textwidth
"set formatoptions+=q           "   Allow formatting of comments with "gq".
""set formatoptions+=w           "  Trailing white space indicates a paragraph continues in the next line
"set formatoptions+=a           " Automatic formatting of paragraphs
""set formatoptions+=n           " When formatting text, recognize numbered lists
"set formatoptions+=a           " Automatic formatting of paragraphs
""set formatoptions+=l           " Long lines are not broken in insert mode
"set formatoptions+=B           " When joining lines, don't insert a space
"between two multi-byte
""set formatoptions+=r           " Automatically insert the current comment leader after hitting <Enter> in Insert mode
"set nopaste                     " !defend from pasting reformat  // "set paste  ???

"else
    "set indentexpr=
    "set nocindent                   " For linux only, otherwise paste with Ctrl + impossible
    "set cinoptions=
    "set formatoptions=
"endif
"set cinoptions={0,1s,t0,n-2,p2s,(03s,=.5s,>1s,=1s,:1s
"set makeef=make.err    " Name of the errorfile for the |:make

set helplang=en                 " lang of help messages
set novisualbell                " no sound
set t_vb=                       " disable bells
"set indentexpr=func()          " Expression which is evaluated to obtain the proper indent for a line
set nobackup                    " nobackup, disab;e swp files ?
set showcmd                     " Show (partial) command in status line.
set showmatch                   " Show matching brackets ({[ ]}).

"SEARCH
set ignorecase                  " Do case insensitive matching
set smartcase                   " when small - ignore case, when with upper alp - search by case
set incsearch                   " Incremental search


set autowrite                   " Automatically save before commands like :next and :make
set nomousehide                 " not hide mouse cursor when typing. If not disable feature, its looks like bug
set complete=""                 " clean complite string
set complete+=.                 " from curr buffer
set complete+=b                 " from other buffers
set complete+=k                 " from dictionary
set wildmenu                    " When 'wildmenu' is on, command-line completion operates in an enhanced mode

"original error format
"set errorformat=%f(%l)\ :\ %t%*\\D%n:\ %m,%*[^\"]\"%f\"%*\\D%l:\ %m,%f(%l)\ :\ %m,%*[^\ ]\ %f\ %l:\ %m,%f:%l:%c:%m,%f(%l):%m,%f:%l:%m,%f\|%l\|\ %m
"set shellpipe=2>&1\ \|\ tee

"BUILD CENTRAL / NBT
set errorformat=%f:%l:\ %m
set switchbuf=useopen
"set switchbuf=split                " split window on event (error after make for example)
"set complete+=t                    " from tags
"imap } }<Esc>:call CSharpAlign()<CR>a
set backspace=indent,eol,start      " backspace on
"set completeopt=menu,menuone       " A comma separated list of options for Insert mode completion
set completeopt=longest,menu
"set nowrap                          " disable long lines wrap (hbts lines trouble
set wrap                            " enable long lines wrap (hbts lines trouble

set nrformats=octal,hex,alpha   " agrandissement de types de l'incrément"
set history=80                  " agrandissement des lignes journalisés
set diffopt=filler,iwhite       " iwhite - ignore spaces on diff





"http://vim.wikia.com/wiki/Word_wrap_without_line_breaks


"SPELL
set nospell                     " disable spell checker 
"set spell                      " enable spell checker
set spelllang=en_us             " spell checker lang

"TEXT FORMAT
set nolinebreak                 "disable break lines in vim window is small
set nolist                      " list disables linebreak
set textwidth=0                 "this is important if we want disable line break
set wrapmargin=0                "this is important if we want disable line break

set list                        " whitespace characters are made visible
set listchars=                  " clean all values 
"set listchars+=eol:$           " end of line
set listchars+=tab:t_           " tabs
set listchars+=trail:_          " Character to show for trailing spaces
set listchars+=nbsp:%           " Character to show for a non-breakable space (character 0xA0, 160)

set tabstop=4                   " extend tap to 4 symbols and spaces instead tab
set shiftwidth=4                " tab stop for > , <
set softtabstop=4               " when pres tab, how many space is move
"retab                          " make all tabs to spaces in file
set expandtab                   " change tab to N of spaces


"//---------------------------------------------------------------------------------
"//---------------------------------------------------------------------------------

"//---------------------------------------------------------------------------------
"SPECIFIC OPTIONS-------------------
"//---------------------------------------------------------------------------------

"match ErrorMsg '\%>170v.\+'    "show lines wich more then 170 characters

""""""""""""""""
"CURSOR OPTIONS"
""""""""""""""""
"set gcr=a:blinkwait0,a:block-cursor    "disable blinking cursor
"highlight Cursor guifg=white guibg=black
"highlight iCursor guifg=white guibg=steelblue
"set guicursor=n-v-c:block-Cursor       "experemental
"set guicursor+=i:ver100-iCursor        "experemental
"set guicursor+=n-v-c:blinkon0-Cursor   "experemental
"set guicursor+=i:blinkwait20-iCursor   "experemental


exe "set backupdir=" . PLFM_VIM_TEMPDIR
exe "set directory=" . PLFM_VIM_TEMPDIR
