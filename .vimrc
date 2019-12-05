" _      __________  ________  _____
"\ \    / _   _    \/    __  \/  ___\
" \ \  / / | | | |\  /| |__|    |
"  \ \/ / _| |_| | \/ |  __  /| |___
"   \__/ |_______|    |_|  \_\\_____/

" BASIC CONFIGS:
	set nu relativenumber
	set encoding=utf-8
	set fileencoding=utf-8
	set incsearch
	set autoindent
	set spell!		"spell-checker use ]s and [s to go back and forth between spelling issues
				"and use ]S and [S to skip between errors beyond standardise vs standardize
				"us z= to get word suggestions

" CUSTOM CHARACTERS
	so ~/Documents/Vim/Alphabets/ipa.vim
	nm <F2> :call ToggleIPA()<CR>
	imap <F2><esc>:call ToggleIPA()<CR>a

" LOAD FILETYPES:
	au BufRead,BufNewFile *.fountain set filetype=fountain

execute pathogen#infect()
syntax on
filetype plugin indent on
