" ### Basic settings ###
set nocompatible		" Disable compatible mode
set shortmess+=I		" Disable the welcome screen
set mouse=a			" Use mouse in all cases
set guioptions-=T
set autoindent			" Automatic indenting
set smartindent
set copyindent			" Copy previous indenting
set expandtab     " Make tabs into spaces
set tabstop=2			" Change tab size to two spaces
set shiftwidth=2  " Change increment size to two spaces
set showcmd			" Show command being typed
set wildmode=longest,list,full " Base like completion
set wildmenu			" Command completion list
set clipboard=unnamed		" Unnamed register is X PRIMARY clipboard
set linebreak			" Wrap lines without cutting words
set backup			" Keep a backup file
set backupdir=/tmp		" Backup directory
set noswapfile
set hidden			" Make buffers hide instead of closing
syntax on			" Syntax highlighting
set pastetoggle=<F2>		" Toggle autoindenting
set ofu=syntaxcomplete#Complete " Omni completion
set completeopt=menu " No annoying scratch window
set background=dark
"set viminfo=%,'100,<100,s100,:100 " Restore buffers and whatnot
"autocmd QuickFixCmdPost *grep* lwindow " Open quickfix window after grep

" ### Plugins ###
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'tpope/vim-fugitive'
Plugin 'milkypostman/vim-togglelist'
Plugin 'derekwyatt/vim-fswitch'
Plugin 'scrooloose/nerdtree'
Plugin 'Valloric/YouCompleteMe'
Plugin 'kien/ctrlp.vim'
Plugin 'vim-scripts/errormarker.vim'

call vundle#end()
filetype plugin indent on

" ### urxvt settings ###
silent !echo -ne "\033]12;\#6f99b4\007"
let &t_SI="\033]12;\#ae4747\007"
let &t_EI="\033]12;\#6f99b4\007"
au VimLeave * silent !echo -ne "\033]12;\#6f99b4\007"

" ### Status line ###
set laststatus=2
set statusline=%#CursorIM#\"%F\"\ %#ErrorMsg#%m%#CursorIM#\ %y%=%l,%c\ %P

" ### Mappings ###
map <down> <ESC>:bn<CR>
map <up> <ESC>:bp<CR>
cmap w!! w !sudo tee % >/dev/null
nnoremap <leader>/ :set invhlsearch<CR>
map <silent> <leader>ev :e $MYVIMRC<CR>
map <silent> <leader>sv :so $MYVIMRC<CR>
map <silent> <leader>bd :bp\|bd #<CR>
map <C-n> :NERDTreeToggle<CR>
map <leader>m :make!<CR><CR>

" ### Search settings ###
set incsearch			" Search as you type
set ignorecase			" Ignore case in searches
set smartcase                   " Upper-case sensitive search
" # Grep #
map <silent> <leader>g :Ggrep <cword> <CR><CR><C-O>

" ### Matching bracket settings ###
set showmatch			" Show matching brackets
set mat=5			" Show matching brackets for 0.5 seconds
set matchpairs+=<:>		" Also show matching < and >

" ### Python settings ###
autocmd FileType python set omnifunc=pythoncomplete"Complete
autocmd FileType python set tags+=/mnt/media/git/personal/python/tags

" ### Scala settings ###
autocmd FileType scala set errorformat=[error]\ %f:%l:\ %m " Error format for Scala error messages
autocmd FileType scala set makeprg=cat\ ~/Projects/errors " :make reads errors from ~/Projects/errors
autocmd FileType scala set wildignore+=*class,*/project/target/*,*/target/*
nmap <leader>t :Ggrep -E "(val\|var\|class\|trait\|object\|def\|package) <cword>" <CR><CR>

" ### CtrlP ###
let g:ctrlp_cmd = 'CtrlPBuffer'

" ### vimdiff ###
map <silent> <leader>2 :diffget //2<CR>:diffupdate<CR>
map <silent> <leader>3 :diffget //3<CR>:diffupdate<CR>

" ### Colors ###
colorscheme solarized
set visualbell

" ### Session management ###
map <silent> <leader>ss :execute 'mksession! ~/Projects/sessions/'.fnamemodify('.',':p:h:t')<CR>
if argc() == 0
  cd ~/Projects/sessions
endif

" ### YouCompleteMe ###
let g:ycm_enable_diagnostic_signs = 0 
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
