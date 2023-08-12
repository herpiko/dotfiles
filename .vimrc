set runtimepath^=~/.vim/bundle/ctrlp.vim
set runtimepath^=~/.vim/bundle/vim-multiple-cursors
set runtimepath^=~/.vim/bundle/vim-commentary
set runtimepath^=~/.vim/bundle/nerdtree
set runtimepath^=~/.vim/bundle/vim-airline
set runtimepath^=~/.vim/bundle/vim-prettier
set runtimepath^=~/.vim/colors/distinguished.vim
set runtimepath^=~/.vim/bundle/vim-go

"### Color
set background=dark
set t_Co=256
set mouse=a
syntax enable
set re=0

"### Multiple Cursor
let g:multi_cursor_use_default_mapping=1

"### Backup
set noswapfile

"### User Interface
set number              " show line numbers
set showcmd             " show command in bottom bar
set cursorline          " highlight current line
filetype indent on      " load filetype-specific indent files
set wildmenu            " visual autocomplete for command menu
set lazyredraw          " redraw only when we need to.
set showmatch           " highlight matching [{()}]

"### Searching
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

"### Folding
set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
" space open/closes folds
nnoremap <space> za
set foldmethod=indent   " fold based on indent level

"### CtrlP settings
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn|node_modules|bower_components)$'

"### Backup
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

"### Filetype
augroup configgroup
    autocmd!
    autocmd BufWritePre *.php,*.py,*.txt,*.hs,*.md :call <SID>StripTrailingWhitespaces()
    autocmd VimEnter * highlight clear SignColumn
    autocmd FileType java setlocal list
    autocmd FileType java setlocal formatprg=par\ -w80\ -T4
    autocmd FileType php setlocal list
    autocmd FileType php setlocal formatprg=par\ -w80\ -T4
    autocmd FileType ruby setlocal commentstring=#\ %s
    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh
augroup END

" toggle between number and relativenumber
function! ToggleNumber()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunc

" strips trailing whitespace at the end of files. this
" is called on buffer write in the autogroup above.
function! <SID>StripTrailingWhitespaces()
    " save last search & cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction

" Disable replace mode
function s:ForbidReplace()
    if v:insertmode isnot# 'i'
        call feedkeys("\<Insert>", "n")
    endif
endfunction
augroup ForbidReplaceMode
    autocmd!
    autocmd InsertEnter  * call s:ForbidReplace()
    autocmd InsertChange * call s:ForbidReplace()
augroup END

" Always show statusline
set laststatus=2

" air-line
let g:airline_powerline_fonts = 1

set noshowmode
set cmdheight=0

command Paste r !parcellite -c
set clipboard=unnamedplus

"### sudo!
cmap w!! w !sudo tee > /dev/null %<CR>

" I should have put this line of conf since the first day I fall'n love with vim. :(
vnoremap u <nop>

"### Indentation
autocmd FileType python set tabstop=8|set shiftwidth=2|set expandtab
autocmd FileType make set noexpandtab
autocmd FileType javascript set tabstop=2|set softtabstop=0|set expandtab|set shiftwidth=2|set smarttab
autocmd FileType json set copyindent|set preserveindent|set tabstop=2|set softtabstop=0|set expandtab|set shiftwidth=2|set smarttab
autocmd FileType jsx set copyindent|set preserveindent|set tabstop=2|set softtabstop=0|set expandtab|set shiftwidth=2|set smarttab
autocmd FileType yml set copyindent|set preserveindent|set tabstop=2|set softtabstop=0|set expandtab|set shiftwidth=2|set smarttab
autocmd FileType html set copyindent|set preserveindent|set tabstop=2|set softtabstop=0|set expandtab|set shiftwidth=2|set smarttab
autocmd FileType css set copyindent|set preserveindent|set tabstop=2|set softtabstop=0|set expandtab|set shiftwidth=2|set smarttab
autocmd FileType proto set copyindent|set preserveindent|set tabstop=2|set softtabstop=0|set expandtab|set shiftwidth=2|set smarttab
autocmd FileType go set copyindent|set preserveindent|set tabstop=2|set expandtab
au BufNewFile,BufRead *.go setlocal noet ts=2 sw=2 sts=2

" This configurations below is needed since VIM 8.2
" Allow yank
if system('uname -s') == "Darwin\n"
  set clipboard=unnamed "OSX
else
  set clipboard=unnamedplus "Linux
endif
" Allow backspace
set backspace=indent,eol,start  " more powerful backspacing

"### Disable middle mouse
nnoremap <MiddleMouse> <Nop>
nnoremap <2-MiddleMouse> <Nop>
nnoremap <3-MiddleMouse> <Nop>
nnoremap <4-MiddleMouse> <Nop>
inoremap <MiddleMouse> <Nop>
inoremap <2-MiddleMouse> <Nop>
inoremap <3-MiddleMouse> <Nop>
inoremap <4-MiddleMouse> <Nop>

"### NERDTree
let g:NERDTreeDirArrows=1
let NERDTreeShowHidden=1
" "pen automatically at startup
function! StartUp()
    if 0 == argc()
        NERDTree
    end
endfunction
autocmd VimEnter * call StartUp()



"### Linter
let g:prettier#config#single_quote = 'true'
let g:prettier#config#trailing_comma = 'all'

"### Golang related
let g:go_fmt_command = "goimports"
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_highlight_diagnostic_errors = 1
let g:go_highlight_diagnostic_warnings = 1
"au filetype go inoremap <buffer> . .<C-x><C-o>
imap <C-c> <Esc>

"### Vim-Plug
call plug#begin(expand('~/nvim/plugged'))
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'crusoexia/vim-monokai'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-gocode.vim'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }
Plug 'Exafunction/codeium.vim'
call plug#end()

colorscheme monokai


