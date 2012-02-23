" BufPos:  Activate a buffer by its position number in the buffers
"          list
" Author:  Michele Campeotto <michele@campeotto.net>
" Date:    2007-04-25
" Version: 1.0
"
" This script provides a function to activate a vim buffer by passing it the
" position in the buffers list and maps it to <M-number> to easily switch
" between open buffers.
"
" This is best used togheter with the buftabs plugin:
"   http://www.vim.org/scripts/script.php?script_id=1664

"let g:BufPos_Activate_Buffer = 1 " buffer mode
"let g:BufPos_Activate_Buffer = 0 " buffer mode
let g:BufPos_Activate_Buffer=0

"//---------------------------------------------------------------------------------
if !exists('g:BufPos_Activate_Buffer') 
  let g:BufferReminder_removeNoNameBuffer = 1
endif

function! BufPos_ActivateBuffer(num)
    let l:count = 1
    for i in range(1, bufnr("$"))
        if buflisted(i) && getbufvar(i, "&modifiable") 
            if l:count == a:num
                exe "buffer " . i
                return 
            endif
            let l:count = l:count + 1
        endif
    endfor
    echo "No buffer!"
endfunction


function! TabPos_ActivateBuffer(num)

    if a:num <= tabpagenr("$")
	    silent exe 'tabnext ' . a:num
    endif

endfunc


function! BufPos_Initialize()
    for i in range(1, 9) 

    if g:BufPos_Activate_Buffer
        exe "map <M-" . i . "> :silent call BufPos_ActivateBuffer(" . i . ")<CR>"
    else
        exe "map <M-" . i . "> :silent call TabPos_ActivateBuffer(" . i . ")<CR>"
    endif

    endfor

    if g:BufPos_Activate_Buffer
        exe "map <M-0> :silent call BufPos_ActivateBuffer(10)<CR>"
    else
        exe "map <M-0> :silent call TabPos_ActivateBuffer(10)<CR>"
    endif

endfunction

autocmd VimEnter * call BufPos_Initialize()
