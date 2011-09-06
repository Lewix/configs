" ================
" General settings
" ================
" ### Basic settings ###
set nocompatible		" Disable compatible mode
set shortmess+=I		" Disable the welcome screen
set mouse=a			" Use mouse in all cases
set autoindent			" Automatic indenting
set copyindent			" Copy previous indenting
set expandtab     " Make tabs into spaces
set tabstop=4			" Change tab size to two spaces
set shiftwidth=4  " Change increment size to two spaces
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
set background=dark
set viminfo=%,'100,<100,s100,:100 " Restore buffers and whatnot

" ### Colors ###
colorscheme zellnermod

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

" ### Search settings ###
set incsearch			" Search as you type
set ignorecase			" Ignore case in searches
set smartcase                   " Upper-case sensitive search

" ### Matching bracket settings ###
set showmatch			" Show matching brackets
set mat=5			" Show matching brackets for 0.5 seconds
set matchpairs+=<:>		" Also show matching < and >

" ### Compilers ###
map <silent> <leader>hs :!ghc --make % && %:p:r<CR>
map <silent> <leader>jc :!javac %<CR>

" =============
" Java settings
" =============


" ===============
" Python settings
" ===============
" Jump to python class libraries
"python << EOF
"import os
"import sys
"import vim
"for p in sys.path:
    "if os.path.isdir(p):
        "vim.command(r"set path+=%s" % (p.replace(" ", r"\ ")))
"EOF
autocmd FileType python set omnifunc=pythoncomplete"Complete    " Code completion

" ===============
" Plugin settings
" ===============
" ### Pathogen ###
" Use pathogen to include plugins in the ~/.vim/bundle directory
"call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

" ### Latex-Suite ###
filetype plugin on		" Activate Latex-Suite for Latex files
filetype indent on              " Enable indenting
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'        " Set filetype of empty .tex files to 'latex'
autocmd Filetype tex,latex set grepprg=grep\ -nH\ $*	" Set grep to always display file name
autocmd Filetype tex,latex set wrapmargin=2 " Break lines for easier editing

" ### Taglist ###
let Tlist_Ctags_Cmd = "/usr/bin/ctags"
let Tlist_WinWidth = 50
map <left> :TlistToggle<CR>
