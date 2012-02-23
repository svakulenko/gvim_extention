"//---------------------------------------------------------------------------------
"REGEX SECTION
"//---------------------------------------------------------------------------------


"map \sb :bufdo %s///g \| update<C-Left><C-Left><Left><Left><Left><Left>
map \sb :Bufdo %s///g \| update<C-Left><C-Left><Left><Left><Left><Left>
" search patterns, search and replace (part of word also
map \sp :%s///g<Left><Left><Left>
vmap \sp :s///g<Left><Left><Left>

" search and replace (only if first pattern is equal in 100%)
map \sg :%s/\<\>//g<Left><Left><Left><Left><Left>
vmap \sg :s/\<\>//g<Left><Left><Left><Left><Left>

" search and replace ^I
map \si :%s/^I/ /g<Left><Left><Left><Left><Left>

"reverse \ to / in current line
map \sr 0:s:\\:\/:g<CR>

map \se :.,$s/^[\ \t]*\n//g
" search and replace ^M
map \sm :%s/\r//g<Left><Left><Left><Left><Left>

"add " to each line from begginng
map \s' :1,$s/^/"/

" match by different colors two pattern, if no arg, they are deselected
map \s2 :call TwoMatchColor("","") <Left><Left><Left><Left><Left><Left>

"remove empty lines
map  \se :%s/^[\ \t]*\n//g
cmap \se :s/^[\ \t]*\n//g


"remove spaces on end of line
map  \sc :%s:\s\{1,\}$::g
cmap \sc :s:\s\{1,\}$::g




map <F2> :call CallFindPattern()<CR>
map <C-F2> :match Search //<CR>

func CallFindPattern()
    let l:value = @*
    exe "/" . l:value
    "exe "/\\<" . l:value . "\\>"
    exe ":match Search /" . l:value . "/"
endfunc

""""""""""""""
"SOME COMMANDS
""""""""""""""

"//---------------------------------------------------
"//------------ REGEX ------- COMMANDS ---BEGIN-------
"//---------------------------------------------------
"1)
"find lines start from (^) empty space or tab [\ \t] and this characters may
"repeats infinity times(*), and they ended by new line character (\n)
":%s/^[\ \t]*\n//g  "BY ONE WORD, REMOVE EMPTY LINES

"2)
"/^cat$  "find c-a-t word with start from ^ and after word only $ must be
"/[^123456789]"find characters all except digits

"3)
"/dab\|RU same as \(dab\|RU\)  "detailed: \( dab \| RU \)
"/3GP_\(dab\|RU\)/ - same, but 3GP_ before pattern must be

"4)
"/\(^Client\|yntax\) -search two pattern, only first begin from ^
"/^\(Client\|yntax\) - both patterns begins from ^
"/^\(Client\|yntax\)\c -  same, but ignore case (\c)
"5)
"/\<cat\> - begin of the word(\<), then is cont. by c-a-t, and it's ended by end of word (\>)

"6)
"\<\(4\|4th\)- not the same /\<\(4th\|4\) ,becouse in first varaint, vim skip
"4th highlight (4 first founded, that's why 4th is skipped)
"4\(th\)\? - this find 4 or 4 + th, this happened due to \? character(? mean:in one
"search time we can find only one occurance of pattern
"/4\(th\)* - found 4 (1 time) and th (N time), example :4thth "(th) may repeat many times


"REGEX IMPORTANT RULES (KVANTIFICATORS)
"? from 0 to one can be found
"* from 0 to inf may be found
"+ from 1 to inf may be found

"examples:
"/s\(df\)\? "after s , df may occur ones    (may not occur)
"/s\(df\)*  "after s , df may occur n times (may not occur)
"/s\(df\)\+ "after s , df may occur n times (must occur)

"example string:
"sfdfdf sdfdfdf

"? we must use if description search one hard pattern or part of pattern, but
"part of P must repeat nothing more than that one time
"* we must use if description search one hard pattern or part of pattern
"+ we must use if description search one hard pattern, and we need find only
"them or not found

"interesting exceptions:
" if we want to find C n times in line

"/C* - wrong result
"/C\\* - right, \\ before * is solution

"7)
"<\(\ \)*HR\(\ \)*SIZE\(\ \)*=\(\ \)*[0-9]\{2\}\(\ \)*>
"comments:
"[0-9]\{2\}  is equal to [0-9][0-9] only,others above (pas moins que deux fois)
"[0-9]\{1,3\}  is equal to [0-9] or [0-9][0-9] or [0-9][0-9][0-9]

"8)
"%s/\/\/.*//g
"find lines started with // and remove them

"9)
"/_[Cc][0-9]\+
"search like this :
"_C02

" search and replace (only if first pattern is equal in 100%)
"map \s4 /one\|two\|three\|four



"SOME SEARCH HINTS
"/\.\/ - find ./
"/\^I  - find ^I
"/\r - find ^M
"%s/\r//g - find ^M and remove
"/\(.*\):\(.*\)/\2 : \1/  : reverse fields separated by :

"/main.*\.hpp -- find main*****.hpp
"count of words
"[I - occurence of word in all file
"I] - occurence of word in all file, start counting from curpos to down

"//---------------------------------------------------
"//------------ REGEX ------- COMMANDS ---END  -------
"//---------------------------------------------------


" put to text incriment numbers
"
" command: put =range(11,15)
" output:
"11
"12
"13
"14
"14


"command: for i in range(1,10) | put ='192.168.0.'.i | endfor
"output:
"192.168.0.1
"192.168.0.2
"192.168.0.3
"192.168.0.4
"192.168.0.5
"192.168.0.6
"192.168.0.7
"192.168.0.8
"192.168.0.9
"192.168.0.10
"

"REGEX NEW"
" s: - substitute
" g: - global
"
" s:\(\w\+\)\(\s\+\)\(\w\+\):\3\2\1: replace first word with last
"
" example
" before: se renconter
" after : renconter se
" comments:
" where \1 holds the first word,
" \2 - any number of spaces or tabs in between and
" \3 - the second word.
" How to decide what number holds what pair of  \(\) ? - count opening "\(" from the left.
" s:\(\w\+\)\(\s\+\)\(\w\+\):\3\ \1:g -
"
" s:\(\s\+\):\ :g  replace many spaces on one space (process only one line)
" s/\(\s\+\)/\ /g alternative syntax, same meaning (process only one line)
" %s/\(\s\+\)/\ /g alternative syntax, same meaning (process all file)
" before:  2)   se  renconter avec     Anna
" after :  2) se renconter avec Anna
"
"
" g/\serror/ - search spaces and 'error'
" g/\serror/ . w! >> d:\errors3.txt    same, but copy founded result to file
" search text:
"# WHAT TO DO
"    1) regex, approvondir des connaissances
"    2) se  renconter avec     Anna
"
"    error: strange
"    error: nothing
"    error: exit
"    error: failure
"
" execution result:
":g/\serror/
"    error: strange
"    error: nothing
"    error: exit
"    error: failure

" g/\serror:/ copy $ | s /error/copy of the error/  - find space and 'error',
", copy it to the end, and substitute 'error' to 'copy of the error'
"before:
"    error: strange
"    error: nothing
"    error: exit
"    error: failure
" after:
"    error: strange
"    error: nothing
"    error: exit
"    error: failure
"    copy of the error: strange
"    copy of the error: nothing
"    copy of the error: exit
"    copy of the error: failure

" g/\serror:/ s /\serror/copy of the error/ | copy $    same as before, but
" make substitute before"
" after:
"   copy of the error: strange
"   copy of the error: nothing
"   copy of the error: exit
"   copy of the error: failure
"   copy of the error: strange
"   copy of the error: nothing
"   copy of the error: exit
"   copy of the error: failure
"
"differents regex , no comments
"y/pattern/
"c/pattern/
"c/pattern/e
"d/pattern/
"http://rayninfo.co.uk/vimtips.html - many interesting hits
"
"help & - a lot of new information
"
""

" example: U:\programm\files\lala\file.hpp:503: error wrong register

"#after pattern  s@\(.*\:.*[^0-9]\):\(\d\+\).*@\1@
"U:\programm\files\lala\file.hpp

"#after pattern  s@\(.*\:.*\):\(\d\+\).*@\1@
"503


" Substitute flags descriptions:
" s: - substitute
" d: - delete
" i: - ignorecase
" g – change all instances in a line
" e – avoid an error when the pattern doesn’t exist in a buffer

"REGEX TWO SUBMATCH IN ONE SUBSTITUTE (VERY COOL)
"echo substitute(getline("."),'\(.*\)\(\d\)\(.*\)','\=submatch(1). (submatch(2)+1)','')
"before: \{-}       matches 0 or more of the preceding atom, as few as possible
"after : \{-}       matches 1
"
"
"
"
"map <C-F8> :call FWK_ExampleRegExPlusIncrement()<CR>

" before:
"< --- hello --- >
"< --- hello --- >
"
"< --- hello --- >
"< --- hello --- >
"< --- hello --- >
"< --- hello --- >
"
"
"
"
"< --- hello --- >
"< --- hello --- >
"< --- hello --- >
"< --- hello --- >
"
"< --- hello --- >
"< --- hello --- >
"< --- hello --- >
"< --- hello --- >
"< --- hello --- >
"< --- hello --- >
"< --- hello --- >
"< --- hello --- >

"after:
"< --- mambo1 --- >
"< --- mambo2 --- >
"
"< --- mambo3 --- >
"< --- mambo4 --- >
"< --- mambo5 --- >
"< --- mambo6 --- >
"
"
"
"
"< --- mambo7 --- >
"< --- mambo8 --- >
"< --- mambo9 --- >
"< --- mambo10 --- >
"
"< --- mambo11 --- >
"< --- mambo12 --- >
"< --- mambo13 --- >
"< --- mambo14 --- >
"< --- mambo15 --- >
"< --- mambo16 --- >
"< --- mambo17 --- >
"< --- mambo18 --- >

"regex command to do something in all tabs
"tabdo %s/foo/bar/g
":argdo %s/foo/bar/e          : выполнить на всех файлах в :args
":bufdo %s/foo/bar/e
":windo %s/foo/bar/e

"cool
":h sub-replace-\=

"Qestion: Is there a way to somehow do one global substitution? Similar to:
":%s/\(a\|b\|c\|d\|e\|f\)/INSERT_REPLACEMENT_LIST/



"Answer: You can use a dictionary of items mapped to their replacements, then use that in the right side of the search/replace.
"
":let r={'a':'A', 'b':'B', 'c':'C', 'd':'D', 'e':'E'}
":%s/\v(a|b|c|d|e)/\=r[submatch(1)]/g
"
"See :h sub-replace-\= and :h submatch(). If you want to cram that into one line, you could use a literal dictionary.
"
":%s/\v(a|b|c|d|e)/\={'a':'A','b':'B','c':'C','d':'D','e':'E'}[submatch(1)]/g
"
"The specific example you gave of uppercasing letters would be more simply done as
"
":%s/[a-e]/\U\0/g
"
"doc
"1. The unnamed register ""
"2. 10 numbered registers "0 to "9
"3. The small delete register "-
"4. 26 named registers "a to "z or "A to "Z
"5. four read-only registers ":, "., "% and "#
"6. the expression register "=
"7. The selection and drop registers "*, "+ and "~
"8. The black hole register "_
"9. Last search pattern register "/
"
"
"
"
"\_. Matches any single character or end-of-line.
" Careful: "\_.*" matches all text to the end of the buffer!

"select this parag
"/{\_.\{-}}
"
"
"body
"{
"    text-align:
"    center;
"}
"
":%s/{\_.\{-}}/\=substitute(submatch(0), '\n', '', 'g')/
"
"\_. matches any character, including a newline, and
"\{-} is the non-greedy version of *, so
"{\_.\{-}} matches everything between a matching pair of curly braces, inclusive.

"The \= allows you to substitute the result of a vim expression, which we here use to strip out all the newlines '\n' from the matched text (in submatch(0)) using the substitute() function.

"The inverse (converting the one-line version to multi-line) can also be done as a one liner:

":%s/{\_.\{-}}/\=substitute(submatch(0), '[{;]', '\0\r', 'g')/
"
"
"
"
"search in vim buffer with ignore case (\c)
"/\cpattern
"?\cpattern
"
"
"
"
"
" \@! Matches with zero width if the preceding atom does NOT match at the
"    current position. |/zero-width| {not in Vi}
"    Like '(?!pattern)" in Perl.
"    Example         matches ~
"    foo\(bar\)\@!       any "foo" not followed by "bar"
"    a.\{-}p\@!      "a", "ap", "app", etc. not followed by a "p"
"    if \(\(then\)\@!.\)*$   "if " not followed by "then"
"
"
