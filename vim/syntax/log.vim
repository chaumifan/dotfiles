" Vim syntax file
" Language:         Generic log files
" Maintainer:       Alex Dzyoba <avd@reduct.ru>
" Latest Revision:  2013-03-08
" Changes:          2013-03-08 Initial version

" Based on messages.vim - syntax file for highlighting kernel messages

if exists("b:current_syntax")
  finish
endif

"syn match log_error     '\c.*\<\(FATAL\|ERROR\|ERRORS\|FAIL\|FAILED\|FAILURE\).*'
syn match log_error     '.*\<\(FATAL\|ERROR\|ERRORS\|FAIL\|FAILED\|FAILURE\).*'
"syn match log_warning   '\c.*\<\(WARNING\|DELETE\|DELETING\|DELETED\|RETRY\|RETRYING\).*'
syn match log_warning   '.*\<\(WARNING\|DELETE\|DELETING\|DELETED\).*'
syn region log_string   start=/'/ end=/'/ end=/$/ skip=/\\./
syn region log_string   start=/"/ end=/"/ skip=/\\./
syn match log_number    '0x[0-9a-fA-F]*\|\[<[0-9a-f]\+>\]\|\<\d[0-9a-fA-F]*'

syn match   log_date '\(Jan\|Feb\|Mar\|Apr\|May\|Jun\|Jul\|Aug\|Sep\|Oct\|Nov\|Dec\) [ 0-9]\d *'
syn match   log_date '\d\{4}-\d\d-\d\d'

"syn match   log_time '\d\d:\d\d:\d\d\s*'
syn match   log_time '\d\d:\d\d:\d\d\(\.\d*\|,\d*\)'
syn match   log_time '\c\d\d:\d\d:\d\d\(\.\d\+\)\=\([+-]\d\d:\d\d\|Z\)'

" Match ip addresses including port number
syn match   log_ip   '\(\d\{1,3\}\.\)\{3\}\d\{1,3\}\(:\d*\)\?'
"syn match   log_ip   '\(\d\{1,3\}\.\)\{3\}\d\{1,3\}\(\(:\d\{4\}\)\|\(\/\d\{1,4\}\)\)\?'

syn match log_cluster_name '^irp\d\{3\}-c\d\{2\}.*'

" For help, :h group-name
hi def link log_string          String
hi def link log_number          Number
hi def link log_date            Constant
hi def link log_time            Type
hi def link log_ip              Special
hi def link log_error           ErrorMsg
hi def link log_warning         WarningMsg
hi def link log_cluster_name    Include


let b:current_syntax = "log"
