let PLFM_SL=g:cr_slash                    "slash specific for platform
let PLFM_HOSTNAME = hostname()    "hostname to differ work machines (home/work)

let PLFM_EXTDIR               = PLFM_VIM_HOME_PATH . PLFM_SL . 'vim_extention'      "main extention dir
let PLFM_VIM_VIMFILES         = g:cfg_path                                          "standart vim plugins dir

if has('win32')
    let PLFM_VIM_NOTES_GEN        = $VIM . PLFM_SL . 'Notes'                        "mains configuration files for this distro
else
    let PLFM_VIM_NOTES_GEN        = $HOME . PLFM_SL . 'Notes'
endif

let PLFM_VIM_NOTES            = PLFM_VIM_NOTES_GEN . PLFM_SL . 'dynamic'            "dynamic notes path
let PLFM_VIMCFG               = PLFM_EXTDIR . PLFM_SL . 'vimrc_config'              "mains configuration files for this distro
let PLFM_VIM_PROJECTS         = PLFM_EXTDIR . PLFM_SL . 'projects'                  "standart vim projects dir
let PLFM_VIM_TEMPDIR          = PLFM_VIM_HOME_PATH . PLFM_SL . 'tempdir'            "temp files storage
let PLFM_VIM_LOGS             = PLFM_EXTDIR . PLFM_SL . 'logs'                      "logging information

