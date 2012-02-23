let PLFM_SL=g:cr_slash                    "slash specific for platform
let PLFM_HOSTNAME = hostname()    "hostname to differ work machines (home/work)

let PLFM_EXTDIR               = "" "main extention dir
let PLFM_VIM_NOTES            = "" "dynamic notes path
let PLFM_VIM_NOTES_GEN        = "" "all notes path
let PLFM_VIM_TEMPLATES        = "" "templates path
let PLFM_VIMCFG = "" "mains configuration files for this distro
let PLFM_VIM_VIMFILES         = "" "standart vim plugins dir
let PLFM_VIM_PROJECTS         = "" "standart vim projects dir
let PLFM_VIM_TEMPDIR          = "" "temp files storage
let PLFM_VIM_LOGS             = "" "logging information


    let PLFM_EXTDIR               = PLFM_VIM_HOME_PATH . PLFM_SL . 'vim_extention'
    let PLFM_VIM_VIMFILES         = g:cfg_path 

    let PLFM_VIM_TEMPLATES        = g:cfg_path  . PLFM_SL . 'templates'

if has('win32')
    let PLFM_VIM_NOTES_GEN        = $VIM . PLFM_SL . 'Notes'
else
    let PLFM_VIM_NOTES_GEN        = $HOME . PLFM_SL . 'Notes'
endif
    let PLFM_VIM_NOTES            = PLFM_VIM_NOTES_GEN . PLFM_SL . 'dynamic'

    let PLFM_VIMCFG               = PLFM_EXTDIR . PLFM_SL . 'vimrc_config'
    let PLFM_VIM_PROJECTS         = PLFM_EXTDIR . PLFM_SL . 'projects'

    let PLFM_VIM_TEMPDIR          = PLFM_EXTDIR . PLFM_SL . 'tempdir'

    let PLFM_VIM_LOGS             = PLFM_EXTDIR . PLFM_SL . 'logs'
