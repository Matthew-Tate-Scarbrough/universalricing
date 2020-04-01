"  _   _   _   _   _____   _    _   _____    _____
" | \ | | | | | | |_   _| | \  / | |  __ \  /  _  \
" |  \| | | | | |   | |   |  \/  | | |__) ) | | |_|
" | \ \ | | | | |   | |   | \  / | |  _  /  | |  _
" | |\  | \ \_/ /  _| |_  | |\/| | | | \ \  | |_| |
" |_| \_|  \___/  |_____| |_|  |_| |_|  \_\ \_____/
" 
"
" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" ===LEADER AND ITS FOLLOWS===

	let mapleader =";"

"	" toggle goyo -- the logic is that it mimics ctrl+e for centerline
"		
"		map <leader>e :Goyo \| set linebreak<CR>
"
"	" Shell Scripts
"
"		map <leader>s :!clear && shellcheck %<CR>


" ===PLUGINS===

"	call plug#begin('~/.config/nvim/plugged')
"
"		Plug 'junegunn/goyo.vim'
"
"		Plug 'LaTeX-Box-Team/LaTeX-Box'
"
"		Plug 'vimwiki/vimwiki'
"	call plug#end()


" ===UNIVERSAL CONFIGS===

	" Line Numbers

		set nu relativenumber


	" File/Font Encoding

		set encoding=utf-8
		set fileencoding=utf-8


	" Columns and Wrapping

		set colorcolumn=113
	
		set wrap
		set linebreak


	" No auto-commenting
	
		autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o


	" Split Stuffs

		" remap direction
		set splitbelow splitright

		" split navigation
"		map <C-h> <C-w>h
"		map <C-j> <C-w>j
"		map <C-k> <C-w>k
"		map <C-l> <C-w>l


	" Compiling, etc.

		map <leader>c :w! \| !compiler <c-r>%<CR><CR>
"		map <leader>p :!pdf <c-r>%<CR><CR>


" ===FILETYPES===

	" Fountain

		au BufRead,BufNewFile *.fountain,*.ft,*.ftn,*.fount set filetype=fountain list noautoindent nocindent nosmartindent


	" LaTeX

		au BufRead,BufNewFile *.tex,*.pdf_tex,*.latex set filetype=tex spell!


	" Markdown

		au BufRead,BufNewFile *.md,*.txt set filetype=markdown syntax=markdown
