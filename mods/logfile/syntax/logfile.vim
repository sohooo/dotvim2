" Vim syntax file
" Language:     Logfiles
" Maintainer:   Sven Sporer <sohooo@intothespirit.com>
" Filenames:    *.log
" Last Change:	2014-03-14

if exists("b:current_syntax")
    finish
endif

syn case match

" our keywords include the ':' character
" default keywords are digits, chars, /, @, _
setlocal iskeyword+=:


syn region logFatal       start=/\s\+FATAL /        end=/$/
syn region logError       start=/\s\+ERROR /        end=/$/
syn region logError       start="^\(ORA\|RMAN\)-\d\{4,\}:"    end="$"
syn region logWarn        start=/\s\+WARN /         end=/$/
syn region logInfo        start=/\s\+INFO /         end=/$/
syn region logDebug       start=/\s\+DEBUG /        end=/$/
syn region logSummary     start=/\s\+SUMMARY /      end=/$/

hi Folded ctermfg=069

" tdp hana codes
syn region tdpComment       start=/\s*#\(SOFTWAREID\|PIPE\) /         end=/$/
syn region tdpInfo        start=/\s*BKI\d\+I/     end=/$/
syn region tdpError       start=/\s*BKI\d\+E/     end=/$/
syn region tdpInfoHi       start=/\s*#SAVED./     end=/$/
syn region tdpInfoHi       start=/\s*BKI0024I/     end=/$/
"ANS
syn region tdpInfo        start=/\s*ANS\d\+I/     end=/$/
syn region tdpError       start=/\s*ANS\d\+E/     end=/$/
"#ERROR
syn region logError       start=/\s*#ERROR /        end=/$/

"see :hi for colorz
hi link logFatal          Error
hi link logError          Error
hi link logWarn           Debug
hi link logInfo           String
hi link logDebug          Comment
hi link logSummary        Todo

hi link tdpError          ErrorMsg
hi link tdpInfo           Statement
hi link tdpSpecial        SpecialComment
hi link tdpInfoHi         DiffText
hi link tdpComment        SpecialKey


let b:current_syntax = "logfile"

" vim:set sts=2 sw=2:
