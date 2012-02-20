" Vim syntax file
" Language:	  Hop
" Maintainer: Sergiy Vakulenko
" Original author(original Scheme highlight):	Dirk van Deun <dirk@igwe.vub.ac.be>

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

if filereadable($VIMRUNTIME . '/syntax/scheme.vim')
    source $VIMRUNTIME/syntax/scheme.vim

    "added ; hop
    syn keyword schemeSyntax define-service module import
    syn keyword HopServer #!key $
    syn keyword HopClient with-hop ~

    "HOP server variables
    syn match hopServerSyntax "\$[a-zA-Z0-9-._/]\+"

    hi def link HopClient  		   ModeMsg
    hi def link HopServer          SpecialKey
    hi def link hopServerSyntax    SpecialKey

    let b:current_syntax = "hop"
else
    echo 'hop.vim: for use this plugin, you must install vim package with scheme.vim syntax file'
endif
