set nocompatible " uses VIM defaults instead of 100% VI
set backspace=indent,eol,start " More powerful backspacing
set nobackup " Keep a backup
set ruler " Show cursor position always
set title " show title in console titlebar
set ttyfast " smoother changes on fast (non-serial) ttys
set showmode
set showcmd             " Show (partial) command in status line.
set showmatch           " Show matching brackets.
set ignorecase          " Do case insensitive matching
set incsearch           " Incremental search
set autowrite           " Automatically save before commands like :next and :make (but may be bad for editing code in deployed projects)
set number

" Keyboard shortcuts
" ========================
set pastetoggle=<F2>
"buffer resizing shortcuts
if bufwinnr(1)
	map + <C-W>+
	map - <C-W>-
endif

map <F5> :%s/<\([^>]\)*>/\r&\r/g<enter>:g/^$/d<enter>vat=
map <F6> vatJxvito<right><left>x
map <F7> /\v^\s*([a-zA-Z\-0-9\$])<enter>qm<F6>nq@q1000@@:1<enter>

filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle (required)
Bundle 'gmarik/vundle'

Bundle 'altercation/vim-colors-solarized'
Bundle 'ervandew/supertab'
Bundle 'tpope/vim-fugitive'
Bundle 'jnwhiteh/vim-golang'

" Vim Internal Settings
" ===================================
let mapleader = ","

"" Ctrl+kjhl Navigation
" TODO: This clashes if you try to move up or down too soon after
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k

" Commenting blocks of code.
autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
autocmd FileType sh,ruby,python   let b:comment_leader = '# '
autocmd FileType conf,fstab       let b:comment_leader = '# '
autocmd FileType tex              let b:comment_leader = '% '
autocmd FileType mail             let b:comment_leader = '> '
autocmd FileType vim              let b:comment_leader = '" '

" NERDCommenter does this, not sure if better or worse... TODO: Test
" ,cc comments
" ,cu uncomments
noremap <silent> <leader>cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> <leader>cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
set wildignore=*.o,*.obj,*.bak,*.exe,*.pyc,*.DS_Store,*.db

if has ("autocmd")
 " Enabled file type detection
 " Use the default filetype settings. If you also want to load indent files
 " to automatically do language-dependent indenting add 'indent' as well.
 filetype plugin on
 filetype indent on
endif " has ("autocmd")

" Some Debian-specific things
augroup filetype
  au BufRead reportbug.*                set ft=mail
  au BufRead reportbug-*                set ft=mail
augroup END

"display stuff
set background=dark  " hint that the terminal is dark-background
set t_Co=256
colorscheme solarized
syntax on " by default... could do it instead in filetype areas.

" Language Specific Settings
" =============================
"python
"au FileType python set omnifunc=pythoncomplete#Complete
au FileType python setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4 smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
au BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

"javascript
au Filetype javascript setlocal ts=4 sts=4 sw=4

"htmldjango
au Filetype htmldjango setlocal ts=2 sts=2 sw=2
au Filetype html setlocal ts=2 sts=2 sw=2

"xml
""" REQUIRES: libxml2-utils
au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null

" Plugin specific settings
" ==================================

"supertab stuffs
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabClosePreviewOnPopupClose=1
set completeopt=menuone,longest,preview
