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

	" toggle goyo -- the logic is that it mimics ctrl+e for centerline
		
		map <leader>e :Goyo \| set linebreak<CR>

	" Shell Scripts

		map <leader>s :!clear && shellcheck %<CR>


" ===PLUGINS===

	call plug#begin('~/.config/nvim/plugged')

		Plug 'junegunn/goyo.vim'

"		Plug 'LaTeX-Box-Team/LaTeX-Box'

		Plug 'vimwiki/vimwiki'

	call plug#end()


" ===UNIVERSAL CONFIGS===

	" Line Numbers

		set nu relativenumber


	" File/Font Encoding

		set encoding=utf-8
		set fileencoding=utf-8


	" Columns and Wrapping

		set colorcolumn=114
	
		set wrap
		set linebreak


	" No auto-commenting
	
		autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o


	" Split Stuffs

		" remap direction
		set splitbelow splitright


	" Compiling, etc.

		map <leader>c :w! \| !compiler <c-r>%<CR><CR>
		"TODO: Get `previewer` to work
		"map <leader>p :!previewer <c-r>%<CR><CR>


" ===LINGDVORAK ALTS===

	set langmap=АБЦДЕФГЧИЙКЛМНОПЭРСТУВШХЫЗ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,ᚫBᛢDᛢFᚸHᚼJᛤLMᛝᛟᚦQRᛥTᚣVWXYᛠ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,абцдефгчийклмнопэрстувшхыз;abcdefghijklmnopqrstuvwxyz,ᚪᛒᚳᛞᛖᚠᚷᚻᛁᛄᛣᛚᛗᚾᚩᛈᛢᚱᛋᛏᚢᛥᚹᛉᚣᛢ;abcdefghijklmnopqrstuvwxyz


" ===FILETYPES===

	" Fountain

		au BufRead,BufNewFile *.fountain,*.ft,*.ftn,*.fount set filetype=fountain list noautoindent nocindent nosmartindent


	" LaTeX

		au BufRead,BufNewFile *.tex,*.pdf_tex,*.latex,*.ldf set filetype=tex spell! colorcolumn=127


	" Markdown

	"	au BufRead,BufNewFile *.md  set filetype=markdown syntax=mmarkdown


	" M-Markdown

		au BufRead,BufNewFile *.mmd,*.md set filetype=markdown syntax=mmarkdown


	" SILE

		au BufRead,BufNewFile *.sil,*.sile set filetype=sile syntax=tex expandtab
