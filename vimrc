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

filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle (required)
Bundle 'gmarik/vundle'

"My Bundles
" original repos on github
Bundle 'tpope/vim-fugitive'
Bundle 'altercation/vim-colors-solarized'
Bundle 'jnwhiteh/vim-golang'
Bundle 'ervandew/supertab'
Bundle 'mattn/zencoding-vim'
"Bundle 'lukaszb/vim-web-indent'
Bundle 'pangloss/vim-javascript'
"Bundle 'tpope/vim-surround'
"Bundle 'Raimondi/delimitMate'
Bundle 'msanders/snipmate.vim'
Bundle 'vim-scripts/slimv.vim'
Bundle 'jpalardy/vim-slime'

" The leader character is the proper way to create your own key commands:
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
 "autocmd FileType python source ~/.vim/filetype-py.vim

endif " has ("autocmd")

" Some Debian-specific things
augroup filetype
  au BufRead reportbug.*                set ft=mail
  au BufRead reportbug-*                set ft=mail
augroup END

augroup encrypted
    au!

    " First make sure nothing is written to ~/.viminfo while editing
    " an encrypted file.
    autocmd BufReadPre,FileReadPre      *.gpg set viminfo=
    " We don't want a swap file, as it writes unencrypted data to disk
    autocmd BufReadPre,FileReadPre      *.gpg set noswapfile
    " Switch to binary mode to read the encrypted file
    autocmd BufReadPre,FileReadPre      *.gpg set bin
    autocmd BufReadPre,FileReadPre      *.gpg let ch_save = &ch|set ch=2
    autocmd BufReadPost,FileReadPost    *.gpg '[,']!gpg --decrypt 2> /dev/null
    " Switch to normal mode for editing
    autocmd BufReadPost,FileReadPost    *.gpg set nobin
    autocmd BufReadPost,FileReadPost    *.gpg let &ch = ch_save|unlet ch_save
    autocmd BufReadPost,FileReadPost    *.gpg execute ":doautocmd BufReadPost " . expand("%:r")

    " Convert all text to encrypted-to-self text before writing
    autocmd BufWritePre,FileWritePre    *.gpg   '[,']!gpg --default-recipient-self -ae 2>/dev/null
    " Undo the encryption so we are back in the normal text, directly
    " after the file has been written.
    autocmd BufWritePost,FileWritePost    *.gpg   u
augroup END

" full support for golang stuff
set rtp+=$GOROOT/misc/vim

"display stuff
set background=dark  " hint that the terminal is dark-background
set t_Co=256
colorscheme solarized
syntax on " by default... could do it instead in filetype areas.
highlight Comment ctermfg=white  " Blue comments are impossible to read on many terminals

"python
au FileType python set omnifunc=pythoncomplete#Complete
au FileType python setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4 smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
au BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

"javascript
au Filetype javascript setlocal ts=4 sts=4 sw=4

"htmldjango
au Filetype htmldjango setlocal ts=2 sts=2 sw=2
au Filetype html setlocal ts=2 sts=2 sw=2

"supertab stuffs
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabClosePreviewOnPopupClose=1
set completeopt=menuone,longest,preview

set pastetoggle=<F2>

" slimv
let g:lisp_rainbow=1

"vim-slime
let g:slime_paste_file = "$HOME/.slime_paste"

"buffer resizing shortcuts
if bufwinnr(1)
	map + <C-W>+
	map - <C-W>-
endif
