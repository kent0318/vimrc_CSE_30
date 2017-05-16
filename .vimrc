function FileHeading()
	let s:line=line(".")
	call setline (s:line,   "/*")
	call append  (s:line,   " * Filename: " .expand("%"))
	call append  (s:line+1, " * Author: Yikuan Xia")
	call append  (s:line+2, " * Userid: cs30xhl")
	call append  (s:line+3, " * Description: ")
	call append  (s:line+4, " * Date: " .strftime("%b %d %Y"))
	call append  (s:line+5, " * Sources of Help:")
	call append  (s:line+6, " */")
	unlet s:line
endfunction

 imap <F5> <ESC>mz:execute FileHeading()<CR>

function FunctionHeading()
	let s:line = line(".")
	let line = getline(line('.')+1)
	call setline (s:line,		"/*")
	call append  (s:line,		" * Function name: ".split(split(line, "(")[0])[-1]."()")
	call append  (s:line+1,		" * Function prototype: ".split(line, " {")[0].";")
	call append  (s:line+2, 	" * Description: ")
	let param =  split(line, "( ")
	let i = 3
	if len(param) <= 1
		call append  (s:line+i, 	" * Parameters: None")
		let i += 1
	else 
		let param = split(split(param[1], " )")[0], ", ")
		call append  (s:line+i, 	" * Parameters: ".param[0]." -- ")
		call remove  (param, 0)
		let i = 4
		for each in param
			call append (s:line+i, 	" *             ".each." -- ")
			let i += 1
		endfor
	endif
	call append  (s:line+i, 	" * Side Effects: ")
	call append  (s:line+i+1, 	" * Error Conditions: ")
	call append  (s:line+i+2,	" * Return Value: ")
	call append  (s:line+i+3, 	" */")
	unlet s:line
	unlet line
	unlet param
	unlet i
endfunction
 imap <F6> <ESC>mz:execute FunctionHeading()<CR>

function Append(content)
	call append(line("$"), a:content)
endfunction

function TestFileTemplate()
	let tobeTest = split(split(expand("%"), "test")[0], "\\.c")[0]
	let pa = split(system("ls pa?.h"), "\n")[0]
	call Append	("#include \"".pa."\"")
	call Append	("#include \"test.h\"")
	call Append	("")
	call Append	("/*")
	call Append	(" * Unit test for ".tobeTest."()")
	call Append	(" *")
	let prototype = split(split(system("grep -n ".tobeTest." ".pa), ":")[1], "\n")[0]
	let line = split(system("grep -n ".tobeTest." ".pa), ":")[0]
	call Append	(" * ".prototype)
"	while( prototype
	call Append	(" *")
	call Append	(" * The ".tobeTest." routine should")
	call Append	(" *")
	call Append	(" * Purpose:")
	call Append	(" */")
	call Append	("")
	call Append	("void test".tobeTest."() {")
	call Append	("  (void) printf( \"Testing ".tobeTest."()\\n\" );")
	call Append	("  /* TODO */ ")
	call Append	("  (void) printf( \"Finished running tests on ".tobeTest."()\\n\" );")
	call Append	("}")
	call Append	("")
	call Append	("/*")
	call Append	(" * Function name: main()")
	call Append	(" * Function prototype: int main();")
	call Append	(" * Description: C main driver which calls C and test ".tobeTest." routine")
	call Append	(" * Parameters: None")
	call Append	(" * Side Effects: Outputs result of each testing")
	call Append	(" * Error Conditions: None.")
	call Append	(" * Return Value: 0")
	call Append	(" */")
	call Append	("int main() {")
	call Append	("  test".tobeTest."();")
	call Append	("  return 0")
	call Append	("}")
	unlet tobeTest
	unlet prototype
	unlet line
	unlet pa
endfunction
 imap <F7> <ESC>mz:execute TestFileTemplate()<CR>

function ReadmeFileTemplate()
	let pa = split(system("ls pa?.h"), ".h\n")[0]
	call Append	("----------------------[ ".pa." README ]-----------------------")
	call Append	("")
	call Append	("Author: TODO")
	call Append	("Userid: TODO")
	call Append	("")
	call Append	("Date: " .strftime("%b %d %Y"))
	call Append	("")
	call Append	("----------------------[  DESCRIPTION  ]-------------------------")
	call Append	("TODO - High level descrption of what your program does")
	call Append	("")
	call Append	("----------------------[  COMPILATION  ]-------------------------")
	call Append	("    To compile this program, simply navigate to the directory containing the")
	call Append	("source files for ".pa." (which should include the Makefile) and tyle 'make'")
	call Append	("")
	call Append	("    To run the program, type the executable name followed by ______")
	call Append	("")
	call Append	("For example:")
	call Append	("")
	call Append	("")
	call Append	("----------------------[ SAMPLE OUTPUT ]-------------------------")
	call Append	("    Normal output is printed to stdout. An example of normal output would be")
	call Append	("the following:")
	call Append	("")
	call Append	("    Abnormal output is printed to stderr. This can occur if_______")
	call Append	("")
	call Append	("For example:")
	call Append	("")
	call Append	("----------------------[    TESTING    ]-------------------------")
	call Append	("This program was tested using the sample ".pa."test executable that was")
	call Append	("provdied. Both programs were run with the same input and their outputs were")
	call Append	("redirected to two different files (this program to ____ and ".pa."test to ___)")
	call Append	("These outputs were then comapred using the command line tool 'diff'. When there")
	call Append	("were no differences in the output for numerous test cases, it indicated that my")
	call Append	("program was functioning properly.")
	call Append	("")
	call Append	("Furthermore, the ____ function was unit tested to ensure that it returns")
	call Append	("the proper value (_____). Test inputs included ___________________")
	call Append	("_____TODO_____")
	call Append	("")
	call Append	("")
	call Append	("")
	call Append	("")
	call Append	("----------------------[   QUESTIONS   ]-------------------------")
	call Append	("TODO")
	call Append	("")
	unlet pa
endfunction
 imap <F4> <ESC>mz: execute ReadmeFileTemplate()<CR> 
	
" ~/.vimrc
" Lisa McCutcheon
" Wed Feb 07, 2007

" **************************************
" * VARIABLES
" **************************************
set nocompatible		" get rid of strict vi compatibility!
set nu				" line numbering on
set autoindent			" autoindent on
set noerrorbells		" bye bye bells :)
set modeline			" show what I'm doing
set showmode			" show the mode on the dedicated line (see above)
set nowrap			" no wrapping!
set ignorecase			" search without regards to case
set backspace=indent,eol,start	" backspace over everything
set fileformats=unix,dos,mac	" open files from mac/dos
set exrc			" open local config files
set nojoinspaces		" don't add white space when I don't tell you to
set ruler			" which line am I on?
set showmatch			" ensure Dyck language
set incsearch			" incremental searching
set nohlsearch			" meh
set bs=2			" fix backspacing in insert mode
set bg=light
set colorcolumn=80

" Expand tabs in C files to spaces
au BufRead,BufNewFile *.{c,h,java} set expandtab
au BufRead,BufNewFile *.{c,h,java} set shiftwidth=2
au BufRead,BufNewFile *.{c,h,java} set tabstop=2

" Do not expand tabs in assembly file.  Make them 8 chars wide.
au BufRead,BufNewFile *.s set noexpandtab
au BufRead,BufNewFile *.s set shiftwidth=8
au BufRead,BufNewFile *.s set tabstop=8

" Show syntax
syntax on

" This is my prefered colorscheme, open a file with gvim to view others
:colors elflord

" For switching between many opened file by using ctrl+l or ctrl+h
map <C-J> :next <CR>
map <C-K> :prev <CR>

" Spelling toggle via F10 and F11
map <F10> <Esc>setlocal spell spelllang=en_us<CR>
map <F11> <Esc>setlocal nospell<CR>

" setlocal textwidth=80		" used for text wrapping
