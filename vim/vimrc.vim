set nocompatible
source ~/dotfiles/vim/bundle/vim-pathogen/autoload/pathogen.vim
let mapleader = " "

""" Plugins
execute pathogen#infect()

" Ctrlp use rg
set runtimepath^=~/.vim/bundle/ctrlp.vim
if executable('rg')
    set grepprg=rg\ --color=never
    let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
    let g:ctrlp_use_caching = 0
endif

set rtp+=~/.fzf

" Shows full path in statusline for vim-airline
let g:airline_section_c = '%<%F%m %#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#'

map <C-n> :NERDTreeToggle<CR>

nnoremap <leader>l :IndentLinesToggle <CR>
let g:indentLine_char = '│'
set list lcs=tab:\│\ 

" YCM
let g:ycm_use_clangd = 0            " Don't use clangd
let g:ycm_confirm_extra_conf = 0    " Suppress extra conf message
let g:ycm_show_diagnostics_ui = 0   " Suppress complaints about 3rd party APIs
nnoremap <C-]> :YcmCompleter GoTo<CR>
nnoremap <leader>g :YcmCompleter GoToReferences<CR>
" Don't close quickfix list after selection
autocmd User YcmQuickFixOpened autocmd! ycmquickfix WinLeave


" vim-go
" Don't delete folds on save for .go files
" autocmd BufWritePost *.go normal! zv
let g:go_fmt_experimental = 1
" set rtp+=$GOROOT/misc/vim
" let g:go_version_warning = 0
let g:go_fmt_command = "goimports"
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['vet', 'golint']
let g:go_metalinter_deadline = "5s"

" turn to next or previous errors, after open location list
nmap <leader>j :lnext<CR>
nmap <leader>k :lprevious<CR>

" let g:go_autodetect_gopath = 0
" autocmd BufWritePost *.go :silent GoBuild
" autocmd BufWritePost *_test.go :silent GoTestFunc


""" Default vim
set viminfo='100,<1000,s100,h

"mouse highlight and scrollwheel
"set mouse=a
nnoremap <C-Y> 5<C-Y>
nnoremap <C-E> 5<C-E>
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>

set tabstop=4    " number of visual spaces per TAB
set shiftwidth=4 " number of spaces in TAB when editing
set expandtab    " TABs are spaces
set smarttab     " TAB goes to next indent location if at beginning of line
set ai           " auto-indent
set cc=80        " Add line to show 80 line text
set cursorline   " Show horizontal line for cursor
" Cursorline only on active buffer
augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END

"set cindent
"colorscheme default

" Move up/down editor lines if it extends past a line unless using a number ie 5j
nnoremap <expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'

set number relativenumber " show absolute and relative line number

" toggling relative and regular line number
nnoremap <leader>p
                \ :set relativenumber! <CR>
                \ :set number! <CR>
                \ :IndentLinesToggle <CR>
nnoremap <leader>c :set relativenumber! <CR>
nnoremap <leader>v :set number! <CR>
nnoremap <leader>a
                \ : if exists("syntax_on") <BAR>
                \    syntax off <BAR>
                \ else <BAR>
                \    syntax enable <BAR>
                \ endif<CR>

" Turns relative line number off when in insert or alternate buffer
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

syntax on          " syntax check
set ruler          " shows line num, col num, virtual col num, and relative position

set laststatus=2   " Always show status line
set statusline+=%F " show full path to current file name
set statusline+=%= " Switch to right side
set statusline+=%l " show current line
set statusline+=/  " Separator
set statusline+=%L " show total lines

:hi Comment ctermfg=blue " change comment color from dark blue
:hi Search ctermfg=black " change search highlight color

set incsearch  " search as you type
set hlsearch   " highlight matches
set ignorecase " do case insensitive search ...
set smartcase  " ...unless capital letters are used
" n always searches forward, center view on search result, and show search #
nnoremap <silent><expr> n (v:searchforward ? 'n' : 'N')
nnoremap <silent><expr> N (v:searchforward ? 'N' : 'n')
set shortmess-=S

set backspace=indent,eol,start " make backspace work like most other apps

" selects highlighted text by pressing '//'
vnoremap // y/<C-R>"<CR>

set wildmenu      " show all files from :e
set wildmode=full " complete longest common string
set scrolloff=1   " always show one line below cursor

" Easier navigation between splits
"nnoremap <C-J> <C-W><C-J>
"nnoremap <C-K> <C-W><C-K>
"nnoremap <C-L> <C-W><C-L>
"nnoremap <C-H> <C-W><C-H>
set splitbelow    " make splits appear below
set splitright    " make splits appear on right

" jump to the last position when reopening a file
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal! g`\"" | endif
endif

" highlight trailing whitespace in red
" have this highlighting not appear whilst you are typing in insert mode
" have the highlighting of whitespace apply when you open new buffers
" highlight ExtraWhitespace ctermbg=red guibg=red
" match ExtraWhitespace /\s\+$/
" autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
" autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
" autocmd InsertLeave * match ExtraWhitespace /\s\+$/
" autocmd BufWinLeave * call clearmatches()

" ctags, C-\ open in new tab, Alt-] open in vertical split
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" Open quickfix list automatically after using vimgrep
augroup myvimrc
    autocmd!
    autocmd FileType qf wincmd J " Open quickfix list as entire horizontal split
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost l*    lwindow
augroup END

" Fold settings
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=4

" Open entry in quickfix list in previous buffer
autocmd FileType qf nnoremap <cr> :exe 'wincmd p \| '.line('.').'cc'<cr>
" Call Flake8 linter on save
autocmd BufWritePost *.py call Flake8()

" Slow connection
set lazyredraw
set nottyfast

" gruvbox
let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox
set background=dark

filetype plugin indent on
