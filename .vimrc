" .vimrc
" Use Utf-8 enconding
set encoding=UTF-8

autocmd VimEnter * echo "(>^.^<) 🦁 ¯\_(ツ)_/¯"
syntax enable

syntax on
set autoread
set nu
set rnu
set autowrite
set autoindent
set si "smart indent
set ruler

" turn off backup, swap...
set nobackup
set nowb
set noswapfile
set backupdir=~/tmp,/tmp
set backupcopy=yes
set backupskip=/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*
set directory=/tmp

filetype on
filetype indent on
" Yank copy working when use unnamed
if system('uname -s') == "Darwin\n"
  set clipboard=unnamed "OSX
else
  set clipboard=unnamedplus "Linux
endif
set ttimeoutlen=50
set cursorline
set wildmenu
filetype plugin indent on

" Rails
autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2
autocmd FileType eruby setlocal expandtab shiftwidth=2 tabstop=2
set nocompatible
filetype indent on

" Use 2 characters space only indentation
set expandtab
set shiftwidth=2
set softtabstop=2

" Automatically close brackets
inoremap ( ()
inoremap [ []
inoremap { {}
inoremap " ""

set showcmd " Show (partial) command in status line.
set showmatch " Show matching brackets.
set incsearch " Incremental search
set mouse=a " Enable mouse usage (all modes)

" Add :DiffOrig command to show differences before saving
if !exists(":DiffOrig")
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
\ | wincmd p | diffthis
endif

"Plugin Install"
call plug#begin('~/.vim/autoload')

Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'ryanoasis/vim-devicons'
Plug 'leafOfTree/vim-vue-plugin'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

set termguicolors     " enable true colors support
colorscheme onehalflight

"Enable tagbar on startup
autocmd FileType rb call tagbar#autoopen(0)
nmap <F8> :TagbarToggle<CR>

" NERDTreeToggle
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.DS_Store', '\~$', '\.swp', '\.git', 'node_modules', 'venv']
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let mapleader = " " " map leader key to <space>
let g:mapleader = " "
" Fast saving
nmap <leader>w :w!<cr>
" Map ESC to jj
:imap jj <Esc>
" Hide highlight
map <silent> <leader><cr> :noh<cr>
" Move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-l> <C-W>l
map <C-h> <C-W>h

" reload vimrc
map <leader>s :source ~/.vimrc<CR>

nmap <F1> :NERDTreeToggle<Enter>
"map <leader>t :NERDTreeToggle<Enter>
" Relative or absolute number lines
function! NumberToggle()
    if(&nu+&rnu==2)
        set nonu
        set nornu
    else
        set rnu
        set nu
    endif
endfunction

nmap <F4> :call NumberToggle()<CR>
" ctrl+s to save

nnoremap <silent> <C-f> :Files<CR>
nnoremap <silent><c-s> :<c-u>update<cr>
noremap <Leader>f :FZF<Enter>
noremap qq :qa!<Enter>

" quick edit .vimrc
nmap <Leader>v :e ~/.vimrc<CR>
" Coc.vim
" TextEdit might fail if hidden is not set.
set hidden

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
let g:vim_vue_plugin_load_full_syntax = 1

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
"" fzf.vim
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path '**/node_modules/**' -prune -o -path 'node_modules/**'  -prune -o -path 'tmp/**' -prune -o -path 'vendor/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"
let g:lightline = {
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \ }
      \ }

" trigger configuration. do not use <tab> if you use https://github.com/valloric/youcompleteme.
let g:ultisnipsexpandtrigger="<tab>"
"let g:ultisnipsjumpforwardtrigger="<C-b>"
""let g:ultisnipsjumpbackwardtrigger="<C-z>"
if !exists("g:UltiSnipsJumpForwardTrigger")
  let g:UltiSnipsJumpForwardTrigger = "<tab>"
endif
" if you want :ultisnipsedit to split your window.
let g:ultisnipseditsplit="vertical"

function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

" IndentLine {{
let g:indentLine_setColors = 0
let g:indentLine_color_term = 239
let g:indentLine_bgcolor_term = 202
let g:indentLine_bgcolor_gui = '#FF5F00'
" }}
