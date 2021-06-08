"----------------------------------------------------------------------"
"           _   _   _   _   _____   _    _   _____    _____            "
"          | \ | | | | | | |_   _| | \  / | |  __ \  /  _  \           "
"          |  \| | | | | |   | |   |  \/  | | |__) ) | | |_|           "
"          | \ \ | | | | |   | |   | \  / | |  _  /  | |  _            "
"          | |\  | \ \_/ /  _| |_  | |\/| | | | \ \  | |_| |           "
"          |_| \_|  \___/  |_____| |_|  |_| |_|  \_\ \_____/           "
"                                                                      "
"----------------------------------------------------------------------"

"======================================================================"
" ===VIM===                                                            "
"                                                                      "
" The idea here is that everything is laid out from the left-side of   "
" the screen to the right from a visual perspective.  Line numbers are "
" on the far-left, margins are on the far-right, and what is beyond a  "
" margin but that which is to be wrapped?                              "
"                                                                      "
" Everything in this section is considered things I should like across "
" all documents, regardless of type.  Any additional settings should   "
" be changed in their own relevent things elsewhere afterwise.         "
"======================================================================"

	"------------------------------------------------------------------"
	" Keymappings                                                      "
	"------------------------------------------------------------------"

		" Leader and Leader Functions
		:let mapleader=" "
		:map <leader>c :w! \| !compiler <c-r>%<CR><CR>

		" Keys
"""		:noremap gj j
"""		:noremap gk k
"""		:noremap j gj
"""		:noremap k gk
"""		:noremap q @
"""		:noremap @ q
	
		" Ling Dvorak lang mapping
		:set langmap=АБЦДЕФГЧИЙКЛМНОПЭРСТУВШХЫЗ;
		            \ABCDEFGHIJKLMNOPQRSTUVWXYZ,
		            \ᚫBᛢDᛢFᚸHᚼJᛤLMᛝᛟᚦQRᛥTᚣVWXYᛠ;
		            \ABCDEFGHIJKLMNOPQRSTUVWXYZ,
		            \абцдефгчийклмнопэрстувшхыз;
		            \abcdefghijklmnopqrstuvwxyz,
		            \ᚪᛒᚳᛞᛖᚠᚷᚻᛁᛄᛣᛚᛗᚾᚩᛈᛢᚱᛋᛏᚢᛥᚹᛉᚣᛢ;
		            \abcdefghijklmnopqrstuvwxyz

	"------------------------------------------------------------------"
	" Open splits in reverse directions                                "
	"------------------------------------------------------------------"

		:set splitbelow splitright

	"------------------------------------------------------------------"
	" Plugins and Plugin Settings                                      "
	"------------------------------------------------------------------"

"""		call plug#begin('~/.config/nvim/plugged')
"""			Plug 'junegunn/goyo.vim'
"""			Plug 'preservim/nerdtree'
"""			Plug 'tpope/vim-surround'
"""		call plug#end()
"""
"""		" Call and set `goyo`
"""		:map <leader>e :Goyo 72 \| set linebreak<CR>

	"------------------------------------------------------------------"
	" Printer Settings                                                 "
	"------------------------------------------------------------------"

		:set printfont=FreeMono
		:set printencoding=utf-8
		:set printoptions=paper:letter,syntax:a

	"------------------------------------------------------------------"
	" Set line numbers                                                 "
	"------------------------------------------------------------------"

		:set number relativenumber

	"------------------------------------------------------------------"
	" What does the actual text look like?                             "
	"------------------------------------------------------------------"

		:set tabstop=4 shiftwidth=4 noexpandtab

		:set encoding=utf-8 fileencoding=utf-8

		" No auto-comments
		:set formatoptions-=cro

	"------------------------------------------------------------------"
	" Set margins                                                      "
	"------------------------------------------------------------------"

		:highlight ColorColumn
			\ ctermfg=black guifg=black
			\ ctermbg=red   guibg=red

		:set colorcolumn=72,80,100

	"------------------------------------------------------------------"
	" Set wrapping and setting it to move whole words to next line.    "
	"------------------------------------------------------------------"

		:set wrap linebreak

"======================================================================"
" ===FILETYPE AUTOGROUPS===                                            "
"======================================================================"

	"------------------------------------------------------------------"
	" Fountain                                                         "
	"------------------------------------------------------------------"

		augroup FOUNTAIN
			autocmd BufRead,BufNewFile *.ftn,*.fountain
				\ set filetype=fountain
				\     noautoindent nosmartindent
		augroup END

	"------------------------------------------------------------------"
	" LaTeX                                                            "
	"------------------------------------------------------------------"

		augroup LATEX
			autocmd BufRead,BufNewFile *.tex,*.latex,*.pdf_tex,*.ldf,
									\  *.textemplate
				\ set filetype=fountain
				\     noautoindent nosmartindent
		augroup END

	"------------------------------------------------------------------"
	" Markdown                                                         "
	"------------------------------------------------------------------"

		augroup MARKDOWN
			autocmd BufRead,BufNewFile *.md,*.mmd,*.markdown
				\ set filetype=mmarkdown
				\     textwidth=72
		augroup END

	"------------------------------------------------------------------"
	" Gemini                                                           "
	"------------------------------------------------------------------"

		augroup GEMINI
			autocmd BufRead,BufNewFile *.gmi,*.gemini
				\ set syntax=mmarkdown
				\     colorcolumn=0
		augroup END
