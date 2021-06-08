" Vim Syntax File
" Language: M-Markdown
" Filenames: *.mmarkdown, *.mmd, *.markdown, *.md, *.txt
" Maintainer: Matþew T. Scarbrough <matthewtatescarbrough@tutanota.com>
" Last Change: 2021 April 16
" Version: 2.02
" Note: Bear in mind that Vim syntax files are read from               "
"       top-to-bottom, as is the actual syntax.                        "
"                                                                      "
"       Tabstop=4                                                      "
"       Linewidth=4                                                    "

"======================================================================"
" PREAMBLE                                                             "
"======================================================================"

	:syntax clear

"======================================================================"
" BLOCK FORMATTING                                                     "
"======================================================================"

	"------------------------------------------------------------------"
	" PARAGRAPH BLOCK                                                  "
	"------------------------------------------------------------------"

		:syntax match blockParagraph "\zs"
			"\ matchgroup=delimiterParagraph
			"\ start="^$\n"
			"\ end="^$"
			\ contains=@formattingsGeneral,@formattingsCustom,blockCode,
			\           blockQuote,blockList

		:syntax region blockComment
			\ matchgroup=delimiterComment
			\ start="/\*"
			\ end=  "\*/"
			\ contains=CommentKeysGeneral

		:syntax region blockList
			\ matchgroup=delimiterList
			\ start="^\n\+[-*+~] \|^\n\+\s\+[-*+~] "
			\ end=  "^\+$"
			\ contained contains=formatList,@formattingsGeneral,Line,
			\                    @formattingsCustom

		:syntax region blockList
			\ matchgroup=delimiterList
			\ start="^\n\+[0-9a-zA-Z]\. \|^\n\+\s\+[0-9a-zA-Z]\. "
			\ end=  "^\+$"
			\ contained contains=formatList,@formattingsGeneral,Line,
			\                    @formattingsCustom

		:syntax region blockList
			\ matchgroup=delimiterList
			\ start="^\n\+[0-9a-zA-Z][0-9a-zA-Z]\. \|^\n\+\s\+[0-9a-zA-Z][0-9a-zA-Z]\. "
			\ end=  "^\+$"
			\ contained contains=formatList,@formattingsGeneral,Line,
			\                    @formattingsCustom

		:syntax region blockCode
			\ matchgroup=delimiterCode
			\ start="^\n\t\|^\n    "
			\ skip= "^\t\|^    "
			\ end=  "^\+$"
			\ contained

		syntax region blockCode
			\ matchgroup=delimiterFormatting
			\ start="^\n\+^```\n"
			\ end=  "^```\n\+^\n"
			\ contained keepend

		"--------------------------------------------------------------"
		"                                                              "
		"  TODO: Figure out why skip will not identify `>` or `>>`.    "
		"                                                              "
		"--------------------------------------------------------------"

		:syntax region blockQuote
			\ matchgroup=delimiterQuote
			\ start="^\n>\|^\n>\s\+"
			\ end=  "^\+$"
			\ contained contains=blockQuoteNested,formatQuoteDelimiter

		:syntax region blockQuoteNested
			\ matchgroup=delimiterQuote
			\ start="^>>\s\+\|^>>\|^>\s\+>\s\+\|^>\s\+>"
			\ end=  "$"
			\ contained contains=formatQuoteDelimiter

"======================================================================"
" KEYWORDS                                                             "
"======================================================================"

	"------------------------------------------------------------------"
	" For everythighlightng forward, the case is not important.        "
	"------------------------------------------------------------------"

		:syntax case ignore

	"------------------------------------------------------------------"
	" Keywords for the meta tags:                                      "
	"------------------------------------------------------------------"

		:syntax region MetaTags
			\ matchgroup=delimiterMeta
			\ start="^%\|^%%\|^//"
			\ end=":"
			\ oneline contains=MetaTagsGeneral
			\ nextgroup=formatMetaData

		:syntax keyword MetaTagsGeneral
			\ title sub[title] cred[it] auth[or] date copy[right] draft[date]
			\ ver[sion] doc[ument] type documenttype
			\ contained

		:syntax match formatMetaData "\s\+.*$" contained

		:syntax match LineSep "^- - - -.*$"

		" Used for EN/EM dashes and fancy lines
		:syntax match Line "--\+"

	"------------------------------------------------------------------"
	" For everythighlightng forward, the case is important.            "
	"------------------------------------------------------------------"

		:syntax case match

	"------------------------------------------------------------------"
	" Keywords for the comments:                                       "
	"------------------------------------------------------------------"

		:syntax keyword CommentKeysGeneral
			\ TODO NOTE
			\ contained

"======================================================================"
" HEADINGS                                                             "
"======================================================================"

	"------------------------------------------------------------------"
	" HEADINGS 1                                                       "
	"------------------------------------------------------------------"

		:syntax region formatH1
			\ matchgroup=delimiterHeading
			\ start="^#\s\+\|^#"
			\ end="$\|#\+$\|\s\+#\+$"
			\ nextgroup=blockParagraph

		syntax match formatH1Alt "^.*$\n=\+$"
			\ nextgroup=blockParagraph

	"------------------------------------------------------------------"
	" HEADINGS 2                                                       "
	"------------------------------------------------------------------"

		:syntax region formatH2
			\ matchgroup=delimiterHeading
			\ start="^##\s\+\|^##"
			\ end="$\|#\+$\|\s\+#\+$"
			\ nextgroup=blockParagraph

		syntax match formatH2Alt "^.*$\n-\+$" contains=H2Sep
			\ nextgroup=blockParagraph

		syntax match H2Sep "^-\+$" contained

	"------------------------------------------------------------------"
	" HEADINGS 3                                                       "
	"------------------------------------------------------------------"

		:syntax region formatH3
			\ matchgroup=delimiterHeading
			\ start="^###\s\+\|^###"
			\ end="$\|#\+$\|\s\+#\+$"
			\ nextgroup=blockParagraph

		syntax match formatH3Alt "^.*$\n\~\+$"
			\ nextgroup=blockParagraph

	"------------------------------------------------------------------"
	" HEADINGS 4                                                       "
	"------------------------------------------------------------------"

		:syntax region formatH4
			\ matchgroup=delimiterHeading
			\ start="^####\s\+\|^####"
			\ end="$\|#\+$\|\s\+#\+$"
			\ nextgroup=blockParagraph

	"------------------------------------------------------------------"
	" HEADINGS 5                                                       "
	"------------------------------------------------------------------"

		:syntax region formatH5
			\ matchgroup=delimiterHeading
			\ start="^#####\s\+\|^#####"
			\ end="$\|#\+$\|\s\+#\+$"
			\ nextgroup=blockParagraph

	"------------------------------------------------------------------"
	" HEADINGS 6                                                       "
	"------------------------------------------------------------------"

		:syntax region formatH6
			\ matchgroup=delimiterHeading
			\ start="^######\s\+\|^######"
			\ end="$\|#\+$\|\s\+#\+$"
			\ nextgroup=blockParagraph

"======================================================================"
" GENERAL FORMATTING                                                   "
"======================================================================"

	"------------------------------------------------------------------"
	" SIMPLE FORMATTINGS:                                              "
	"------------------------------------------------------------------"

		syntax cluster formattingsGeneral
			\ contains=formatOblique,formatBold,formatItalics,
			\          formatComment,formatCode,formatStrike,formatLink,
			\          formatObscure,formatSuper,formatReference,
			\          formatEscape,Hyperlink

	"------------------------------------------------------------------"
	" SIMPLE FORMATTINGS:                                              "
	"------------------------------------------------------------------"

		:syntax region formatItalics
			\ matchgroup=delimiterFormatting
			\ start="\S\@<=_\|_\S\@<="
			\ skip= "\\_"
			\ end=  "\S\@<=_\|_\S\@<="
			\ contained keepend oneline

		:syntax region formatItalics
			\ matchgroup=delimiterFormatting
			\ start="\S\@<=\*\|\*\S\@<="
			\ skip= "\\\*"
			\ end=  "\S\@<=\*\|\*\S\@<="
			\ contained keepend oneline

		:syntax region formatOblique
			\ matchgroup=delimiterFormatting
			\ start="_\*\*\<\|\*\*\*\<"
			\ skip= "\\\*\|\\_"
			\ end=  "\>\*\*_\|\>\*\*\*"
			\ contained keepend oneline

		:syntax region formatBold
			\ matchgroup=delimiterFormatting
			\ start="\*\*\<\|_\*\<"
			\ skip= "\\\*\|\\_"
			\ end=  "\>\*\*\|\>\*_"
			\ contained keepend oneline

		:syntax region formatComment
			\ matchgroup=delimiterComment
			\ start="^//\|^\s\+//\|%%\|^\s\+$"
			\ skip= "\\\*"
			\ end=  "$"
			\ contained oneline keepend oneline

		:syntax region formatCode
			\ matchgroup=delimiterFormatting
			\ start="\S\@<=`\|`\S\@<="
			\ skip= "\\`"
			\ end=  "\S\@<=`\|`\S\@<="
			\ contained keepend oneline

		"--------------------------------------------------------------"
		"                                                              "
		"  NOTE: This is how most extensions to Markdown implement     "
		"  these.  The Alternative one is how it is done in Org mode.  "
		"                                                              "
		"--------------------------------------------------------------"

		:syntax region formatStrike
			\ matchgroup=delimiterFormatting
			\ start="\S\@<=\~\~\|\~\~\S\@<="
			\ skip= "\\\~"
			\ end=  "\S\@<=\~\~\|\~\~\S\@<="
			\ contained keepend oneline

"""		" Alternative Strike
"""		:syntax region formatStrike
"""			\ matchgroup=delimiterFormatting
"""			\ start="\S\@<=[+~]\|[+~]\S\@<="
"""			\ skip= "\\+"
"""			\ end=  "\S\@<=+\|+\S\@<="
"""			\ contained keepend oneline

		:syntax region formatLink
			\ matchgroup=delimiterFormatting
			\ start="<\<"
			\ end=  "\>>"
			\ contained oneline keepend

		"--------------------------------------------------------------"
		"                                                              "
		"  NOTE: Obscure is used in both Reddit and Discord.  `>!!<`   "
		"  is Reddit and `||...||` is Discord.  It is also called      "
		"  'Spoilers'.                                                 "
		"                                                              "
		"--------------------------------------------------------------"

		:syntax region formatObscure
			\ matchgroup=delimiterFormatting
			\ start=">!\|||"
			\ end=  "!<\|||"
			\ contained oneline keepend

		:syntax match formatSuper "\^."
			\ contained oneline

		:syntax region formatSuper
			\ matchgroup=delimiterFormatting
			\ start="\^("
			\ end=  ")"
			\ contained oneline keepend

		:syntax match formatReference "\[[0-9a-zA-Z]\+\]"
			\ contained oneline keepend

		"--------------------------------------------------------------"
		"                                                              "
		"  NOTE: Borrowed from `markdown.vim`.                         "
		"                                                              "
		"--------------------------------------------------------------"

		:syntax match formatEscape "\\[][\\`*_{}()<>#+.!-~=]"

		:syntax match formatHyperlink "\[[\.]\+\]([\.]\+)"
			
	"------------------------------------------------------------------"
	" CUSTOM FORMATTING                                                "
	"------------------------------------------------------------------"

		:syntax cluster formattingsCustom
			\ contains=formatUnderline

	"------------------------------------------------------------------"
	" CUSTOM FORMATTINGS                                               "
	"------------------------------------------------------------------"

		:syntax region formatUnderline
			\ matchgroup=delimiterFormatting
			\ start="__\|=\<"
			\ end=  "__\|\>="
			\ contained oneline keepend

		"--------------------------------------------------------------"
		"                                                              "
		"  NOTE: These three go together---it is good to comment what  "
	    "  they would conflict with out.                               "
		"                                                              "
		"--------------------------------------------------------------"

"""		" Alternative Underlining
"""		:syntax region formatUnderline
"""			\ matchgroup=delimiterFormatting
"""			\ start="\S\@<=_\|_\S\@<="
"""			\ skip= "\\_"
"""			\ end=  "\S\@<=_\|_\S\@<="
"""			\ contained keepend
"""	
"""		" Alternative Oblique
"""		:syntax region formatOblique
"""			\ matchgroup=delimiterFormatting
"""			\ start="\*\*\*\<"
"""			\ skip= "\\\*"
"""			\ end=  "\>\*\*\*"
"""			\ contained keepend
"""	
"""		" Alternative Underlined Bold
"""		:syntax region formatUnderline
"""			\ matchgroup=delimiterFormatting
"""			\ start="_\*\*\<"
"""			\ skip= "\\_"
"""			\ end=  "\>\*\*_"
"""			\ contained keepend

	"------------------------------------------------------------------"
	" SPECIAL FORMATTING                                               "
	"------------------------------------------------------------------"

		:syntax region formatList
			\ matchgroup=delimiterList
			\ start="^[-*+~] \|^\s\+[-*+~] "
			\ end=  "$"
			\ contained
			\ oneline
			\ keepend
			\ contains=@formattingsGeneral,Line

		"--------------------------------------------------------------"
		"                                                              "
		"  NOTE: The letters for lists are custom---there are not too  "
		"  many situations I am aware of where the syntax error this   "
		"  causes becomes annoying.                                    "
		"                                                              "
		"--------------------------------------------------------------"

		:syntax region formatList
			\ matchgroup=delimiterList
			\ start="^[0-9a-zA-Z]\. \|^\s\+[0-9a-zA-Z]\. "
			\ end=  "$"
			\ contained
			\ oneline
			\ keepend
			\ contains=@formattingsGeneral,Line

		:syntax region formatList
			\ matchgroup=delimiterList
			\ start="^[0-9a-zA-Z][0-9a-zA-Z]\. \|^\s\+[0-9a-zA-Z][0-9a-zA-Z]\. "
			\ end=  "$"
			\ contained
			\ oneline
			\ keepend
			\ contains=@formattingsGeneral,Line

		:syntax match formatQuoteDelimiter "^>\|^>\s\+\|^>>\|^>>\s\+"
		:syntax match formatQuoteDelimiter "^>>\|^>>\s\+\|> >\|> >\s\+"

"======================================================================"
" HIGHLIGHTING                                                         "
"======================================================================"

	"------------------------------------------------------------------"
	" BLOCKS                                                           "
	"------------------------------------------------------------------"

		:highlight def link delimiterComment Comment
		:highlight def link BlockComment Comment
		:highlight def link CommentKeysGeneral Todo
		:highlight def link blockCode formatCode
		:highlight def blockQuote
			\ ctermfg=magenta
		:highlight def blockQuoteNested
			\   cterm=inverse
			\ ctermfg=magenta
		:highlight def delimiterList
			\ ctermfg=lightgreen
		:highlight def link delimiterCode Delimiter
		:highlight def link delimiterQuote Delimiter

	"------------------------------------------------------------------"
	" META DATA                                                        "
	"------------------------------------------------------------------"

		:highlight def link MetaTagsGeneral Identifier
		:highlight def link delimiterMeta Identifier
		:highlight def link formatMetaData PreProc

		:highlight def LineSep
			\   cterm=strikethrough
			\ ctermfg=yellow

		:highlight def Line
			\   cterm=strikethrough

	"------------------------------------------------------------------"
	" HEADINGS                                                         "
	"------------------------------------------------------------------"

		"--------------------------------------------------------------"
		" Delimiter                                                    "
		"--------------------------------------------------------------"

			:highlight def link delimiterHeading Delimiter

		"--------------------------------------------------------------"
		" H1                                                           "
		"--------------------------------------------------------------"

			:highlight def formatH1
				\   cterm=bold,underline
				\ ctermfg=magenta

			:highlight def formatH1Alt
				\   cterm=bold
				\ ctermfg=magenta

		"--------------------------------------------------------------"
		" H2                                                           "
		"--------------------------------------------------------------"

			:highlight def formatH2
				\   cterm=bold,underline
				\ ctermfg=yellow

			:highlight def formatH2Alt
				\   cterm=bold
				\ ctermfg=yellow

			:highlight def H2Sep
				\   cterm=bold,strikethrough
				\ ctermfg=yellow

		"--------------------------------------------------------------"
		" H3                                                           "
		"--------------------------------------------------------------"

			:highlight def formatH3
				\   cterm=bold,underline
				\ ctermfg=cyan

			:highlight def formatH3Alt
				\   cterm=bold
				\ ctermfg=cyan

		"--------------------------------------------------------------"
		" H4                                                           "
		"--------------------------------------------------------------"

			:highlight def formatH4
				\   cterm=bold,underline
				\ ctermfg=lightgreen

			:highlight def formatH4Alt
				\   cterm=bold
				\ ctermfg=lightgreen

		"--------------------------------------------------------------"
		" H5                                                           "
		"--------------------------------------------------------------"

			:highlight def formatH5
				\   cterm=bold,underline
				\ ctermfg=red

			:highlight def formatH5Alt
				\   cterm=bold
				\ ctermfg=red

		"--------------------------------------------------------------"
		" H6                                                           "
		"--------------------------------------------------------------"

			:highlight def formatH6
				\   cterm=bold,underline
				\ ctermfg=blue

			:highlight def formatH6Alt
				\   cterm=bold
				\ ctermfg=blue

	"------------------------------------------------------------------"
	" GENERAL FORMATTING                                               "
	"------------------------------------------------------------------"

		"--------------------------------------------------------------"
		" DELIMITER                                                    "
		"--------------------------------------------------------------"

			:highlight def link delimiterFormatting Delimiter
			:highlight def delimiterReference
				\ ctermfg=lightgreen

		"--------------------------------------------------------------"
		" SIMPLE FORMATTINGS                                           "
		"--------------------------------------------------------------"

			:highlight def formatItalics
				\   cterm=italic
				\ ctermfg=lightyellow

			:highlight def formatBold
				\   cterm=bold
				\ ctermfg=lightyellow

			:highlight def formatOblique
				\   cterm=bold,italic
				\ ctermfg=lightyellow

			:highlight def link formatComment Comment

			:highlight def formatCode
				\ ctermfg=lightblue

			:highlight def formatStrike
				\ cterm=strikethrough

			:highlight def link formatLink Underlined

			:highlight def formatUnderline
				\   cterm=underline

			:highlight def formatObscure
				\ ctermfg=yellow
				\ ctermbg=darkgrey

			:highlight def formatEscape
				\ ctermfg=yellow

			:highlight def link formatSuper formatEscape

			:highlight def link formatReference delimiterReference

			:highlight def formatHyperilnk ctermfg=red
