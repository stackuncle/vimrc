" bowen's vim settings
" encoding
language messages zh_CN.utf-8
set helplang=cn
set fileencodings=utf-8,gb2312,gbk,gb18030
set termencoding=utf-8
set fileformats=unix
set encoding=utf-8

set hlsearch
set incsearch
set laststatus=2
set ignorecase
set smartcase
set nobackup
set hidden
set showcmd
set showmode
set title
set t_Co=256

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
set autoread
set nu
set ruler
set clipboard=unnamed
inoremap jj <esc>

" highlight setting
highlight Search term=standout ctermfg=0 ctermbg=11 guifg=Blue guibg=Yellow
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/
set cursorline
set cursorcolumn

" switch windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" enable folding
set foldmethod=indent
set foldlevel=99
" enable using space to open folds
nnoremap <space> za 

" make backspaces more powerfull
set backspace=indent,eol,start

" Folding based on indentation:
autocmd FileType python set foldmethod=indent
" Auto add head info
" .py file into add header
function HeaderPython()
    call setline(1, "#!/usr/bin/env python")
    call append(1, "# -*- coding: utf-8 -*-")
    normal G
    normal o
endf
autocmd bufnewfile *.py call HeaderPython()
"----------Stop settings for python --------------

" ---------- Start Vundle ----------
set nocompatible              " required
filetype off                  " required
set titlestring=%f
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

"------------Start settings for Python----------------
" python with virtualenv support---------------
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF

" spaces for indents
au BufNewFile,BufRead *.py,*pyw
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=120 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |

au BufNewFile,BufRead *.js,*.html,*.css
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |

" Use the below highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red
" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
" Wrap text after a certain number of characters
au BufRead,BufNewFile *.py,*.pyw, set textwidth=100
" Use UNIX (\n) line endings.
au BufNewFile *.py,*.pyw,*.c,*.h set fileformat=unix

" for full syntax highlighting:
let python_highlight_all=1
syntax on

" keep indentation level from previous line:
autocmd FileType python set autoindent

call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)
Plugin 'tpope/vim-fugitive' "git wrapper
Plugin 'bling/vim-airline' "better then powerline
set ttimeoutlen=50
let g:airline_symbols = {}
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_enable_fugitive=1
let g:airline_section_b='%{fugitive#statusline()}'
let g:airline_section_c="%t"
let g:airline_section_x="%y"
let g:airline_section_y='BN: %{bufnr("%")}'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = 'L'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.whitespace = 'Ξ'
" let g:airline#extensions#whitespace#enabled = 0

Plugin 'scrooloose/nerdtree' "filesystem plugin
" autocmd VimEnter * NERDTree
nnoremap <silent> <F2> :NERDTree<CR>
map <S-m> <plug>NERDTreeTabsToggle<CR>
let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.pyc$', '\.pyo$', '\.obj$', '\.o$', '\.so$', '\.egg$', '^\.git$', '^\.svn$', '^\.hg$', '\.lnk$']

Plugin 'jistr/vim-nerdtree-tabs'

Plugin 'kien/ctrlp.vim' " ctrl-p into file find mode
let g:ctrlp_map = '<c-p>'
"let g:ctrlp_cmd = 'CtrlP' " conflict with ctrl-v
let g:ctrlp_working_path_mode = 'ra'
" exclude files and directories using Vim's wildignore
set wildignore+=*/tmp/*,*/lib/*,*/bin/*,*.so,*.swp,*.zip,*.png,*.jpg,*.jpeg,*.gif " MacOSX/Linux
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

Plugin 'dyng/ctrlsf.vim' " like Ctrl-Shift-F in sublime
let g:ctrlsf_default_root = 'src'
let g:ctrlsf_open_left = 1
let g:ctrlsf_ackprg = 'ack-grep'
nmap     Ff <Plug>CtrlSFPrompt
vmap     Ff <Plug>CtrlSFVwordPath
vmap     FF <Plug>CtrlSFVwordExec
nmap     Fn <Plug>CtrlSFCwordPath
nmap     Fp <Plug>CtrlSFPwordPath
nnoremap Fo :CtrlSFOpen<CR>
nnoremap Ft :CtrlSFToggle<CR>
inoremap Ft <Esc>:CtrlSFToggle<CR>

Plugin 'haya14busa/incsearch.vim'
let g:incsearch#auto_nohlsearch = 1
map /  <Plug>(incsearch-forward)
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

Plugin 'rking/ag.vim' "faster than ack
let g:ackprg = 'ag --nogroup --nocolor --column'

Plugin 'vim-scripts/EasyGrep' "smart grep
let g:EasyGrepRecursive=1
let g:EasyGrepMode=2

Plugin 'easymotion/vim-easymotion' "a much simpler way to use some motions
let g:EasyMotion_leader_key = 'f'

Plugin 'vim-scripts/OmniCppComplete' "support class and function's autocompletion
set nocp
filetype plugin on

Plugin 'vim-scripts/Tagbar' "show functions, classes, vars
let g:tagbar_width=35
let g:tagbar_autofocus=1
nmap tb :TagbarToggle<CR>
autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.sh,*.py call tagbar#autoopen()

Plugin 'vim-scripts/SuperTab' "tab autocompletion and hint

Plugin 'brookhong/cscope.vim' "a smart cscope helper for vim
nnoremap <leader>fa :call CscopeFindInteractive(expand('<cword>'))<CR>
nnoremap <leader>l :call ToggleLocationList()<CR>
" s: Find this C symbol
nnoremap  <leader>fs :call CscopeFind('s', expand('<cword>'))<CR>
" g: Find this definition
nnoremap  <leader>fg :call CscopeFind('g', expand('<cword>'))<CR>
" d: Find functions called by this function
nnoremap  <leader>fd :call CscopeFind('d', expand('<cword>'))<CR>
" c: Find functions calling this function
nnoremap  <leader>fc :call CscopeFind('c', expand('<cword>'))<CR>
" t: Find this text string
nnoremap  <leader>ft :call CscopeFind('t', expand('<cword>'))<CR>
" e: Find this egrep pattern
nnoremap  <leader>fe :call CscopeFind('e', expand('<cword>'))<CR>
" f: Find this file
" nnoremap  <leader>ff :call CscopeFind('f', expand('<cword>'))<CR>
" i: Find files #including this file
" nnoremap  <leader>fi :call CscopeFind('i', expand('<cword>'))<CR>

Plugin 'vim-scripts/taglist.vim'
let Tlist_Auto_open=1 " default open taglist
let Tlist_Show_One_File=1 " only show current file's tags
let Tlist_Exit_OnlyWindow=1 " exit vim if taglist is the last window
let Tlist_Compart_Format = 1

Plugin 'vim-scripts/winmanager'
let g:AutoOpenWinManager = 1
let g:NERDTree_title="[NERDTree]"  
let g:winManagerWindowLayout="NERDTree|TagList"  
  
function! NERDTree_Start()  
    exec 'NERDTree'  
endfunction  
function! NERDTree_IsValid()  
    return 1  
endfunction  
nmap wm :WMToggle<CR> 

Plugin 'tmhedberg/SimpylFold' "fold help
let g:SimpylFold_docstring_preview=1

" Plugin 'davidhalter/jedi-vim'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'vim-scripts/indentpython.vim' "auto indent for python
Plugin 'nvie/vim-flake8' "code style check for python
Plugin 'w0rp/ale' "syntax check plugin

Plugin 'tomasr/molokai' "theme
let g:molokai_original = 1
colorscheme molokai

Plugin 'luochen1990/rainbow' "colorful ()
let g:rainbow_active = 1

Plugin 'terryma/vim-multiple-cursors'
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'
highlight multiple_cursors_cursor term=reverse cterm=reverse gui=reverse
highlight link multiple_cursors_visual Visual

Plugin 'pangloss/vim-javascript'
Plugin 'vim-scripts/c.vim'
Plugin 'mattn/emmet-vim'
" enable just for html/css
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

" Plugin 'Valloric/YouCompleteMe'
" let g:ycm_autoclose_preview_window_after_completion=1
" map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" ---------- Stop Vundle ----------
"
if exists('$TMUX')
   set term=screen-256color
endif
