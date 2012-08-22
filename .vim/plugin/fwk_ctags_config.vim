"call FWK_ctags_applicate_cfg('/home/sergey/Dropbox/private/share_files/.vim/plugin/ctags_config_work.cfg')

"if has('win32')
    "echo 'fwk_ctags: this is win, skip'
"else 
    "call FWK_ctags_applicate_cfg('/home/sergey/Dropbox/private/share_files/.vim/plugin/ctags_config_work.cfg')
"endif
    


""set default tags
"let &tags  = g:PLFM_VIMCFG . g:PLFM_SL . 'tags'
"let &tags .= ',' . g:PLFM_VIM_VIMFILES . g:PLFM_SL . 'tags'
""let &tags .= ',..\tags,tags'


""COMMON TAGS MAPS 
    "call FWK_genTagsMap('\th'
                "\, 'g', g:PLFM_VIM_VIMFILES
                "\, 'g', PLFM_VIMCFG
                "\)
    
    

"if has("gui_win32") || has("gui_win32s")

""multi-platform mapping, gs or g - gen+set ; s - set.

    ""COMMON tags




    "call FWK_genTagsMap('\tqb'
                "\, 'g', 'C:\programs\qt\46\src'
                "\)

    "call FWK_genTagsMap('\tqr'
                "\, 's', 'C:\programs\qt\46\src'
                "\, 'g', 'D:\workspace\qt\RND\Glanass'
                "\, 'g', 'D:\workspace\qt\RND\SDB_COMMON'
                "\)

    "call FWK_genTagsMap('\toc'
                "\, 'g', 'C:\Program Files\Objective Caml\lib'
                "\)

    "call FWK_genTagsMap('\tfc'
                "\, 'g', 'd:\workspace\vs\old_prj\tfc_traceClientConsumer\tfc_traceClientConsumer\src'
                "\)


    
    ""HOME MACHINE ?
    "if g:PLFM_HOSTNAME == 'PPDLIVE-LAPTOP'
        ""NO TAGS


    ""WORK MACHINE ?
    "elseif g:PLFM_HOSTNAME == 'SAVAKULENKO'

            "call FWK_genTagsMap(
                        "\  'm' , '\tf'
                        "\, 'g' , 'D:\workspace\visual_studio\tfc_traceClientConsumer\tfc_traceClientConsumer'
                        "\)

            "call FWK_genTagsMap(
                        "\  'm' , '\tb'
                        "\, 'g' , 'D:\P4\NBT_products\HU_HIGH\gen\api\nbt\conn\browser'
                        "\, 'g' , 'D:\P4\NBT_products\HU_HIGH\gen\imp\nbt\conn\browser'
                        "\, 'g' , 'D:\P4\NBT_products\HU_HIGH\gen\api\nbt\conn\datacom\common'
                        "\, 'g' , 'D:\P4\NBT\deliveries\nbt\B069_C1\intel\api\sys\colibry\pf\containers\src'
                        "\, 'g' , 'D:\P4\NBT\imp\nbt\conn\browser'
                        "\, 'g' , 'D:\P4\NBT_products\HU_HIGH\gen\deliveries\nbt\B069_C1\intel\api\scp\intapp\pf\browserwk\src'
                        "\, 'g' , 'D:\P4\NBT_products\HU_HIGH\gen\imp\nbt\conn\system\logdev\mlvehicle\interface'
                        "\)
                        """\, 'D:\P4\NBT\deliveries\nbt\B069_B1\intel\api\sys\colibry\pf\containers\src'
                        
            "call FWK_genTagsMap(
                        "\  'm' ,'\tj'
                        "\, 'g' , 'D:\workspace\Eclipse\notify_system\notifyer_client\src'
                        "\, 'g' , 'D:\workspace\Eclipse\notify_system\notifier\src'
                        "\)

            "call FWK_genTagsMap('\tn'
                        "\, 'g' , 'D:\workspace\Harman\plugin'
                        "\)

            "call FWK_genTagsMap(
                        "\  'm' , '\tw'
                        "\, 'g' , 'D:\P4\webkit_build\Source\HBASLauncher'
                        "\)

            "call FWK_genTagsMap(
                        "\  'm' ,'\ts'
                        "\, 'g' , 'D:\P4\SARAS\Framework\Development\svcipc\trunk\src\ServiceIpcLibrary\src'
                        "\, 'g' , 'D:\P4\SARAS\Framework\Development\svcipc\trunk\src\ServiceIpcLibrary\include\svcipc'
                        "\)


    "else

        ""echo "Wrong hostname, no tags to enable"
    "endif


"else "LINUX 
        "let objective_c_flags  = ' --langdef=objc'
        "let objective_c_flags .= ' --langmap=objc:.m.h'
        "let objective_c_flags .= ' ' . shellescape('--regex-objc=/^[[:space:]]*[-+][[:space:]]*\([[:alpha:]]+[[:space:]]*\*?\)[[:space:]]*([[:alnum:]]+):[[:space:]]*\(/\1/m,method/')
        "let objective_c_flags .= ' ' . shellescape('--regex-objc=/^[[:space:]]*[-+][[:space:]]*\([[:alpha:]]+[[:space:]]*\*?\)[[:space:]]*([[:alnum:]]+)[[:space:]]*\{/\1/m,method/')
        "let objective_c_flags .= ' ' . shellescape('--regex-objc=/^[[:space:]]*[-+][[:space:]]*\([[:alpha:]]+[[:space:]]*\*?\)[[:space:]]*([[:alnum:]]+)[[:space:]]*\;/\1/m,method/')
        "let objective_c_flags .= ' ' . shellescape('--regex-objc=/^[[:space:]]*\@property[[:space:]]+.*[[:space:]]+\*?(.*);$/\1/p,property/')
        "let objective_c_flags .= ' ' . shellescape('--regex-objc=/^[[:space:]]*\@implementation[[:space:]]+(.*)$/\1/c,class/')
        "let objective_c_flags .= ' ' . shellescape('--regex-objc=/^[[:space:]]*\@interface[[:space:]]+(.*)[[:space:]]+:.*{/\1/i,interface/')

    "call FWK_genTagsMap(
                "\  'm' ,'\tg'
                "\, 'd' , 'Netatmo WS JNI'
                "\, 'g' , '/home/svakulenko/depots/svn/trunk/generic/iap'
                "\, 'g' , '/home/svakulenko/depots/svn/trunk/apps/Android/eclipse/workspace/WeatherStationClient/jni'
                "\, 'g' , '/home/svakulenko/depots/svn/trunk/generic/netcom'
                "\, 'g' , '/home/svakulenko/depots/svn/trunk/generic/dblib'
                "\, 'g' , '/home/svakulenko/depots/svn/trunk/generic/newlib_tz'
                "\, 'g' , '/home/svakulenko/depots/svn/trunk/apps/iOS/weatherstation/weatherstation/Classes/NAAPI'
                "\ )
                ""\, 'g' , '/home/svakulenko/android-ndk-r7b/platforms/android-14/arch-x86/usr/include/jni.h'

                    
    "call FWK_genTagsMap(
                "\  'm', '\tm'
                "\, 'd', 'Netatmo Ios'
                "\, 'g', '/home/svakulenko/depots/svn/trunk/apps/iOS'
                "\, 'p', objective_c_flags
                "\ )
    
    "call FWK_genTagsMap(
                "\  'm', '\tp'
                "\, 'd', 'Python Django AppEngine ppdlive'
                "\, 's', '/usr/lib/python2.7/dist-packages/django'
                "\, 'g', '/home/sergey/workspace/appEngine/vppdlive/ppdlive'
                "\ )


"endif



