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

filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle (required)
Bundle 'gmarik/vundle'

"My Bundles

" Work
Bundle 'tpope/vim-fugitive'
Bundle 'altercation/vim-colors-solarized'
Bundle 'jnwhiteh/vim-golang'
Bundle 'undx/vim-gocode'
Bundle 'ervandew/supertab'
""" Jedi works with regular library packages (not external yet)
"Bundle 'davidhalter/jedi-vim'
"Bundle 'jmcantrell/vim-virtualenv'

" non-work related
"Bundle 'mattn/zencoding-vim'
"Bundle 'lukaszb/vim-web-indent'
"Bundle 'pangloss/vim-javascript'
"Bundle 'tpope/vim-surround'
"Bundle 'Raimondi/delimitMate'
"Bundle 'msanders/snipmate.vim'
"Bundle 'vim-scripts/slimv.vim'
"Bundle 'jpalardy/vim-slime'
"Bundle 'klen/python-mode' 
"

" Vim Internal Settings
" ===================================

let mapleader = ","

nnoremap <leader><space> :noh<cr>
nnoremap <leader>v V` ] " ,v re-visual-selects just-pasted text

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
highlight Comment ctermfg=white  " Blue comments are impossible to read on many terminals

" Language Specific Settings
" =============================
"python
au FileType python set omnifunc=pythoncomplete#Complete
au FileType python setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4 smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
au BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

"javascript
au Filetype javascript setlocal ts=4 sts=4 sw=4

"htmldjango
au Filetype htmldjango setlocal ts=2 sts=2 sw=2
au Filetype html setlocal ts=2 sts=2 sw=2

" Plugin specific settings
" ==================================

"supertab stuffs
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabClosePreviewOnPopupClose=1
set completeopt=menuone,longest,preview

" currently unused stuff
" =====================================

" Rope AutoComplete
"let ropevim_vim_completion = 1
"let ropevim_extended_complete = 1
"let g:ropevim_autoimport_modules = ["os.*","traceback","django"]
"imap <c-space> <C-R>=RopeCodeAssistInsertMode()<CR>

"PyMode
"let g:pymode_doc=1
"let g:pymode_lint=0
" Enable autoimport
"let g:pymode_rope_enable_autoimport = 1

" vim-virtualenv
"let g:virtualenv_auto_activate = 1

"" jedi stuff
"let g:jedi#auto_initialization = 1

" slimv
" let g:lisp_rainbow=1

"vim-slime
" let g:slime_paste_file = "$HOME/.slime_paste"


