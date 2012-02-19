" Vim syntax file
" Language:	Scheme (R5RS + some R6RS extras)
" Last Change:	2009 Nov 27
" Maintainer:	Sergey Khorev <sergey.khorev@gmail.com>
" Original author:	Dirk van Deun <dirk@igwe.vub.ac.be>

" This script incorrectly recognizes some junk input as numerals:
" parsing the complete system of Scheme numerals using the pattern
" language is practically impossible: I did a lax approximation.
 
" MzScheme extensions can be activated with setting is_mzscheme variable

" Suggestions and bug reports are solicited by the author.

" Initializing:

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
  au BufNewFile,BufRead * source $VIMRUNTIME/syntax/scheme.vim
elseif exists("b:current_syntax")
  finish
endif

source $VIMRUNTIME/syntax/scheme.vim

"added ; hop
syn keyword schemeSyntax define-service module import
syn keyword HopServer #!key $
syn keyword HopClient with-hop ~

"HOP server variables
syn match hopServerSyntax "\$[a-zA-Z0-9-._/]\+"
if version >= 508 || !exists("did_scheme_syntax_inits")
  if version < 508
    let did_scheme_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink HopClient  		ModeMsg
  HiLink HopServer          SpecialKey
  HiLink hopServerSyntax    SpecialKey
endif

let b:current_syntax = "hop"
