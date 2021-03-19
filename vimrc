" bowen's vim settings

" 字符编码
language messages zh_CN.utf-8
set helplang=cn
set fileencodings=utf-8,gb2312,gbk,gb18030
set termencoding=utf-8
set fileformats=unix
set encoding=utf-8

let mapleader=";"  " 定义快捷键的前缀，即<Leader>

" 让配置变更立即生效
autocmd BufWritePost $MYVIMRC source $MYVIMRC

set hlsearch  " 搜索高亮
set incsearch  " 开启实时搜索功能
set ignorecase  " 搜索时大小写不敏感

set laststatus=2  " 总是显示状态栏

set smartcase
set nobackup
set hidden
set showcmd
set showmode
set title
set t_Co=256

set tabstop=4  " 设置编辑时制表符占用空格数
set shiftwidth=4  " 设置格式化时制表符占用空格数
set softtabstop=4  " 让 vim 把连续数量的空格视为一个制表符
" 将制表符扩展为空格
" set expandtab

set autoindent
set autoread

set nu  " 开启行号显示
set cursorline  " 高亮显示当前行/列
set cursorcolumn
set ruler  " 显示光标当前位置

set clipboard=unnamed
inoremap jj <esc>

" 单行超过121个字符提示
highlight Search term=standout ctermfg=0 ctermbg=11 guifg=Blue guibg=Yellow
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%121v.\+/

syntax enable  " 开启语法高亮功能
syntax on  " 允许用指定语法高亮配色方案替换默认方案
filetype on  " 开启文件类型侦测
filetype plugin on  " 根据侦测到的不同类型加载对应的插件
filetype indent on  " 自适应不同语言的智能缩进

" 退出插入模式指定类型的文件自动保存
au InsertLeave *.go,*.sh,*.py write

" 窗口切换快捷键 映射
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


" ---------- Start plug ----------
set nocompatible              " required
" filetype off                  " required
set titlestring=%f
" set the runtime path to include plug and initialize
set rtp+=~/.vim/autoload/plug.vim

" plug 管理的插件列表必须位于 plug#begin() 和 plug#end() 之间
call plug#begin('~/.vim/bundle')

Plug 'tpope/vim-fugitive' "git wrapper
Plug 'bling/vim-airline' "better then powerline
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

Plug 'scrooloose/nerdtree' "filesystem plugin
" autocmd VimEnter * NERDTree
nnoremap <silent> <F2> :NERDTree<CR>
map <S-m> <plug>NERDTreeTabsToggle<CR>
let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.pyc$', '\.pyo$', '\.obj$', '\.o$', '\.so$', '\.egg$', '^\.git$', '^\.svn$', '^\.hg$', '\.lnk$']

Plug 'jistr/vim-nerdtree-tabs'

Plug 'kien/ctrlp.vim' " ctrl-p into file find mode
let g:ctrlp_map = '<c-p>'
"let g:ctrlp_cmd = 'CtrlP' " conflict with ctrl-v
let g:ctrlp_working_path_mode = 'ra'
" exclude files and directories using Vim's wildignore
set wildignore+=*/tmp/*,*/lib/*,*/bin/*,*.so,*.swp,*.zip,*.png,*.jpg,*.jpeg,*.gif " MacOSX/Linux
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

Plug 'dyng/ctrlsf.vim' " like Ctrl-Shift-F in sublime
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

Plug 'junegunn/fzf'
" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

Plug 'haya14busa/incsearch.vim'
let g:incsearch#auto_nohlsearch = 1
map /  <Plug>(incsearch-forward)
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

Plug 'rking/ag.vim' "faster than ack
let g:ackprg = 'ag --nogroup --nocolor --column'

Plug 'vim-scripts/EasyGrep' "smart grep
let g:EasyGrepRecursive=1
let g:EasyGrepMode=2

Plug 'easymotion/vim-easymotion' " a much simpler way to use some motions
let g:EasyMotion_leader_key = 'f'

Plug 'vim-scripts/OmniCppComplete' "support class and function's autocompletion
set nocp
filetype plugin on

Plug 'vim-scripts/Tagbar' "show functions, classes, vars
let g:tagbar_width=35
let g:tagbar_autofocus=1
nmap tb :TagbarToggle<CR>
autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.sh,*.py call tagbar#autoopen()

Plug 'vim-scripts/SuperTab' "tab autocompletion and hint

Plug 'brookhong/cscope.vim' "a smart cscope helper for vim
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

Plug 'vim-scripts/taglist.vim'
let Tlist_Auto_open=1 " default open taglist
let Tlist_Show_One_File=1 " only show current file's tags
let Tlist_Exit_OnlyWindow=1 " exit vim if taglist is the last window
let Tlist_Compart_Format = 1

Plug 'vim-scripts/winmanager'
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

Plug 'tmhedberg/SimpylFold' "fold help
let g:SimpylFold_docstring_preview=1

" Python plugins
Plug 'nathanaelkane/vim-indent-guides'
Plug 'vim-scripts/indentpython.vim' "auto indent
Plug 'nvie/vim-flake8' "code style check
Plug 'w0rp/ale' "syntax check plugin

" Golang plugins
Plug 'fatih/vim-go'

Plug 'luochen1990/rainbow' "colorful ()
let g:rainbow_active = 1

" Plug 'vim-scripts/c.vim'

" All of your Plugs must be added before the following line
call plug#end()            " required
filetype plugin indent on    " required
" ---------- Stop plug ----------
"
if exists('$TMUX')
   set term=screen-256color
endif
