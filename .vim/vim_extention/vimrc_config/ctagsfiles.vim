
"set default tags
let &tags  = g:PLFM_VIMCFG . g:PLFM_SL . 'tags'
let &tags .= ',' . g:PLFM_VIM_VIMFILES . g:PLFM_SL . 'tags'
"let &tags .= ',..\tags,tags'


    call FWK_genTagsMap('\th'
                \, 'g', g:PLFM_VIM_VIMFILES
                \, 'g', PLFM_VIMCFG
                \)

if has("gui_win32") || has("gui_win32s")

"multi-platform mapping, gs or g - gen+set ; s - set.

    "COMMON tags


    call FWK_genTagsMap('\tqb'
                \, 'g', 'C:\programs\qt\46\src'
                \)

    call FWK_genTagsMap('\tqr'
                \, 's', 'C:\programs\qt\46\src'
                \, 'g', 'D:\workspace\qt\RND\Glanass'
                \, 'g', 'D:\workspace\qt\RND\SDB_COMMON'
                \)

    call FWK_genTagsMap('\toc'
                \, 'g', 'C:\Program Files\Objective Caml\lib'
                \)

    call FWK_genTagsMap('\tfc'
                \, 'g', 'd:\workspace\vs\old_prj\tfc_traceClientConsumer\tfc_traceClientConsumer\src'
                \)


    
    "HOME MACHINE ?
    if g:PLFM_HOSTNAME == 'PPDLIVE-LAPTOP'
        "NO TAGS


    "WORK MACHINE ?
    elseif g:PLFM_HOSTNAME == 'SAVAKULENKO'

            call FWK_genTagsMap('\tf'
                        \, 'g', 'D:\workspace\visual_studio\tfc_traceClientConsumer\tfc_traceClientConsumer'
                        \)

            call FWK_genTagsMap('\tb'
                        \, 'g' , 'D:\P4\NBT_products\HU_HIGH\gen\api\nbt\conn\browser'
                        \, 'g' , 'D:\P4\NBT_products\HU_HIGH\gen\imp\nbt\conn\browser'
                        \, 'g' , 'D:\P4\NBT_products\HU_HIGH\gen\api\nbt\conn\datacom\common'
                        \, 'g' , 'D:\P4\NBT\deliveries\nbt\B069_C1\intel\api\sys\colibry\pf\containers\src'
                        \, 'g' , 'D:\P4\NBT\imp\nbt\conn\browser'
                        \, 'g' , 'D:\P4\NBT_products\HU_HIGH\gen\deliveries\nbt\B069_C1\intel\api\scp\intapp\pf\browserwk\src'
                        \, 'g' , 'D:\P4\NBT_products\HU_HIGH\gen\imp\nbt\conn\system\logdev\mlvehicle\interface'
                        \)
                        ""\, 'D:\P4\NBT\deliveries\nbt\B069_B1\intel\api\sys\colibry\pf\containers\src'
                        
            call FWK_genTagsMap('\tj'
                        \, 'g' , 'D:\workspace\Eclipse\notify_system\notifyer_client\src'
                        \, 'g' , 'D:\workspace\Eclipse\notify_system\notifier\src'
                        \)

            call FWK_genTagsMap('\tn'
                        \, 'g' , 'D:\workspace\Harman\plugin'
                        \)

            call FWK_genTagsMap('\tw'
                        \, 'g' , 'D:\P4\webkit_build\Source\HBASLauncher'
                        \)

            call FWK_genTagsMap('\ts'
                        \, 'g' , 'D:\P4\SARAS\Framework\Development\svcipc\trunk\src\ServiceIpcLibrary\src'
                        \, 'g' , 'D:\P4\SARAS\Framework\Development\svcipc\trunk\src\ServiceIpcLibrary\include\svcipc'
                        \)


    else

        "echo "Wrong hostname, no tags to enable"
    endif


else 
    " (7) ------------- LINUX  -------------//
    "set tags=/home/ppdlive/.vim/qttags
    "set tags=D:\workspace\libs\qt3\src\tags,D:\workspace\libs\mingw\include,D:\workspace\libs\mingw\include\boost\filesystem,..\tags,tags 

    call FWK_genTagsMap('\tg'
                \, 'g', '/home/svakulenko/depots/svn/trunk/generic/iap'
                \, 'g' , '/home/svakulenko/depots/svn/trunk/apps/Android/eclipse/workspace/WeatherStationClient/jni'
                \, 'g' , '/home/svakulenko/depots/svn/trunk/generic/netcom'
                \, 'g' , '/home/svakulenko/depots/svn/trunk/generic/dblib'
                \, 'g' , '/home/svakulenko/depots/svn/trunk/generic/newlib_tz'
                \)
                "\, 'g' , '/home/svakulenko/android-ndk-r7b/platforms/android-14/arch-x86/usr/include/jni.h'

endif



