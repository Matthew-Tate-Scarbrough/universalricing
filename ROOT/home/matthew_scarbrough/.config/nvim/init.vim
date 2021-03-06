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

	let mapleader =" "

	" toggle goyo -- the logic is that it mimics ctrl+e for centerline
		
		map <leader>e :Goyo \| set linebreak<CR>

	" Shell Scripts

		map <leader>s :!clear && shellcheck %<CR>


" ===NU VIM===

""" source $HOME/.config/nvim/nuvim.vim
""" noremap h h
""" noremap H ^
""" noremap <C-h> N
""" noremap t gj
""" noremap <C-t> J
""" noremap T H
""" noremap n gk
""" noremap N L
""" noremap <C-n> k$J
""" noremap s l
""" noremap S $
""" noremap <C-s> n
""" noremap <C-o> J
""" noremap q @
""" noremap @ q
	noremap gj j
	noremap gk k
	noremap j gj
	noremap k gk
    noremap q q
    noremap @ @


" ===PLUGINS===

   	call plug#begin('~/.config/nvim/plugged')
   	
   		Plug 'junegunn/goyo.vim'
   	
"""		Plug 'vimwiki/vimwiki'

		Plug 'preservim/nerdtree'
   	
   	call plug#end()


" ===UNIVERSAL CONFIGS===

	" Line Numbers

		set number
        set relativenumber


	" File/Font Encoding

		set encoding=utf-8
		set fileencoding=utf-8


	" Tab Stop

"""		set expandtab
		set tabstop=4
		set shiftwidth=4


	" Columns and Wrapping

"""		set colorcolumn=114
		set colorcolumn=72
	
		set wrap
		set linebreak


	" No auto-commenting
	
		autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o


	" Split Stuffs

		" remap direction
		set splitbelow splitright


    " Print Options

        set printfont=FreeMono
        set printencoding=utf-8
        set printoptions=paper:letter,syntax:a


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

		au BufRead,BufNewFile *.tex,*.pdf_tex,*.latex,*.ldf set filetype=tex spell!
		au BufRead,BufNewFile *.tex,*.pdf_tex,*.latex,*.ldf set tabstop=4    shiftwidth=4
		au BufRead,BufNewFile *.tex,*.pdf_tex,*.latex,*.ldf set expandtab


	" HTML

		au BufRead,BufNewFile *.htm,*.html set tabstop=2 shiftwidth=2


	" Markdown

"""		au BufRead,BufNewFile *.md  set filetype=markdown syntax=mmarkdown


	" M-Markdown

		au BufRead,BufNewFile *.mmd,*.md set filetype=markdown syntax=mmarkdown
		au BufRead,BufNewFile *.mmd,*.md set tabstop=4         shiftwidth=4
"""		au BufWrite           *.mmd,*.md set expandtab


	" SILE

		au BufRead,BufNewFile *.sil,*.sile set filetype=sile syntax=tex expandtab


""" " ANYTHING
"""
""" 	au BufRead,BufNewFile * set syntax=off


	" VIM

"""		au BufRead,BufNewFile *.vim set filetype=vim syntax=vim expandtab!
