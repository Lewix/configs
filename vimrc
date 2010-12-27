" ================
" General settings
" ================
" ### Basic settings ###
set nocompatible		" Disable compatible mode
set shortmess+=I		" Disable the welcome screen
set mouse=a			" Use mouse in all cases
set autoindent			" Automatic indenting
set copyindent			" Copy previous indenting
set showcmd			" Show command being typed
set wildmenu			" Command completion list
set clipboard=unnamed		" Unnamed register is X PRIMARY clipboard
set linebreak			" Wrap lines without cutting words
set backup			" Keep a backup file
set backupdir=/tmp		" Backup directory
set noswapfile
set hidden			" Make buffers hide instead of closing
syntax on			" Syntax highlighting
set pastetoggle=<F2>		" Toggle autoindenting



" ### Status line ###
set laststatus=2
set statusline=%#CursorIM#\"%F\"\ %#ErrorMsg#%m%#CursorIM#\ %y%=%l,%c\ %P

" ### GUI dependant ###
if has("gui_running")
	set guioptions=aegrLT	" Customize GUI options
	colorscheme zellner	" Uses shine in gui mode
	" Saving
	nmap <c-s> :w<CR>
	imap <c-s> <ESC>:w<CR>a
	" Clipboard tweaks
	nmap <c-c> "+yy
	imap <c-c> <ESC>"+yya
	vmap <c-c> "+y
	nmap <c-v> "+p
	imap <c-v> <ESC>"+pa
else
	colorscheme zellner	" Uses desert in console mode
endif

" ### Mappings ###
map <down> <ESC>:bn<CR>
map <up> <ESC>:bp<CR>
map <right> gt
map <left> gT
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

" ### NERDTree ###
" Quick access to files with NERDTree
nmap <leader>n :NERDTreeToggle<CR>
let NERDTreeQuitOnOPen=1	" Quit on opening files
let NERDTreeShowBookmarks=1	" Show bookmarks on startup

" ### Latex-Suite ###
filetype plugin on		" Activate Latex-Suite when a tex file is opened
filetype indent on              " Enable indenting
let g:tex_flavor='latex'        " Set filetype of empty .tex files to 'latex'
autocmd Filetype tex,latex set grepprg=grep\ -nH\ $*	" Set grep to always display file name

" ### Gundo ###
nnoremap <leader>u :GundoToggle<CR>