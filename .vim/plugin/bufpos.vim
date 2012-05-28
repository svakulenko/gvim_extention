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
"let g:BufPos_Activate_Buffer = 0 " tab mode
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

    let fr_hots = "&й\"'(-и_за"
    let fr_active = 0
    if fr_active == 0

        for i in range(1, 9) 
            let sb = ""
            "if fr_active == 1
            "    let sb = fr_hots[i]
            "else
                let sb = i
            "endif

            if g:BufPos_Activate_Buffer
                exe "map <A-" . sb . "> :silent call BufPos_ActivateBuffer(" . sb . ")<CR>"
            else
                exe "map <A-" . sb . "> :silent call TabPos_ActivateBuffer(" . sb . ")<CR>"
            endif

        endfor

        if g:BufPos_Activate_Buffer
            exe "map <M-0> :silent call BufPos_ActivateBuffer(10)<CR>"
        else
            exe "map <M-0> :silent call TabPos_ActivateBuffer(10)<CR>"
        endif
    else
        
            exe "map <A-&> :silent call TabPos_ActivateBuffer(1)<CR>"
            map <M-й> :silent call TabPos_ActivateBuffer(2)<CR>
            exe "map <A-\"> :silent call TabPos_ActivateBuffer(3)<CR>"
            exe "map <A-'> :silent call TabPos_ActivateBuffer(4)<CR>"
            exe "map <A-(> :silent call TabPos_ActivateBuffer(5)<CR>"
            exe "map <A--> :silent call TabPos_ActivateBuffer(6)<CR>"
            map <M-и> :silent call TabPos_ActivateBuffer(7)<CR>
            exe "map <A-_> :silent call TabPos_ActivateBuffer(8)<CR>"
            exe "map <A-з> :silent call TabPos_ActivateBuffer(9)<CR>"
            exe "map <A-а> :silent call TabPos_ActivateBuffer(10)<CR>"
    endif

    endfunction
command! -n=1 T       :call TabPos_ActivateBuffer('<args>')
"autocmd VimEnter * call BufPos_Initialize()
