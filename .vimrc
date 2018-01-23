"this must be first, because it changes other options as a side effect.
set nocompatible " This setting prevents vim from emulating the original vi's bugs and limitations.

" add utf-8 support
set fileencodings=utf-8,latin2
set number

"set background=light
"syntax enable
"colorscheme SolarizedDark
"let g:solarized_termcolors=256
"

"let &runtimepath.=',~/.vim/bundle/ale'

set bs=2    " allow backspacing over everything in insert mode
set ai      " always set autoindenting on
"set backup " keep a backup file
"set viminfo='20,\"50  " read/write a .viminfo file, don't store more than 50 lines of registers
set history=50    " keep 50 lines of command line history
set ruler    " show the cursor position all the time
set tabstop=2 " ts
set expandtab
set noet "automatically convert tab chars into spaces
set shiftwidth=2 " sw
set softtabstop=2 " sts
set expandtab " added 2012.03.20
set smarttab
set showmatch
set nowrapscan
set nowrap
set nohlsearch
set incsearch
set ignorecase
set nohlsearch
set noswapfile
set wmnu
set list
set iskeyword+=-
set lcs=tab:+-
set splitright
"set guifont=8x13bold
;
" Disable annoying beeping
:set noerrorbells
:set novisualbell
:set errorbells

 if has('nvim')
     nmap <BS> <C-W>h
 endif

nmap <silent> ,/ :nohlsearch<CR> " clear highlighted searches instead of /asdf
xnoremap p pgvy


" Nerd Tree specific
let NERDTreeShowFiles=1
let NERDTreeShowHidden=1
let g:ctrlp_dont_split = 'NERD_tree_2'

"" skip the c-w
nnoremap <C-j> <C-W><C-J>
nnoremap <C-k> <C-W><C-K>
nnoremap <C-l> <C-W><C-L>
nnoremap <C-h> <C-W><C-H>
nnoremap <c-j> <C-W><C-J>
nnoremap <c-k> <C-W><C-K>
nnoremap <c-l> <C-W><C-L>
nnoremap <c-h> <C-W><C-H>



"nnoremap :set paste! "avoid staircase affect when pasting mulitple lines
"nnoremap <F5> :set invpaste paste?<Enter>
map <F5> :set invpaste paste?<Enter>
imap <F5> <C-O><F5>
set pastetoggle=<F5> " hit F5 before and after pasting
nnoremap <F2> :NERDTreeToggle<CR>


" UPDATED 2010.08.05
set complete=.,w,b,u,t,i,k " keyword completion with CTRL-P or N
" :help options -> left off at line 2570

autocmd BufRead *.asp set smartindent cinwords=if,elsif,else,for,while,try,except,finally,sub,class,switch,case
autocmd BufRead *.htx set smartindent cinwords=if,elsif,else,for,while,try,except,finally,sub,class,switch,case
autocmd BufRead *.js set smartindent cinwords=if,else,for,while,try,except,finally,function,switch,case
autocmd BufRead *.pl set smartindent cinwords=if,elsif,else,for,while,try,except,finally,sub,class,switch,case
autocmd BufRead *.php set smartindent cinwords=if,elseif,else,for,while,try,except,finally,function,class,switch,case
autocmd BufRead *.phpx set smartindent cinwords=if,elseif,else,for,while,try,except,finally,function,class,switch,case
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
"Remove White space
autocmd BufWritePre *.py :%s/\s\+$//e

" / END UPDATED 2010.08.05


let g:ale_sign_error = '⚠'
let g:ale_sign_warning = '✗'
let g:ale_lint_on_text_changed = 'never'

" Eslint vs. Standard
" " " ----------------------------------------------------------------------------

function! CheckForEslintPkgJson() abort
  let packagejsonpath = findfile('package.json', '.;')

  if packagejsonpath !=# ''
    let packagejson = join(readfile(packagejsonpath), '')

    return has_key(JSON#parse(packagejson), 'eslintConfig')
  else
    return 0
  endif
endfunction


function! CheckForEslint()

  " @see: https://vimhelp.appspot.com/editing.txt.html#file-searching
  let eslintconfig =
  \ findfile('.eslintrc', '.;', -1) +
  \ findfile('.eslintrc.js', '.;', -1) +
  \ findfile('.eslintrc.json', '.;', -1) +
  \ findfile('.eslintrc.yaml', '.;', -1) +
  \ findfile('.eslintrc.yml', '.;', -1)

  if len(eslintconfig) > 0
    return 1
  else
    return CheckForEslintPkgJson()
  endif
endfunction

if CheckForEslint()
  let g:ale_linters = {
        \   'javascript': ['eslint'],
        \ }
else
  let g:ale_linters = {
        \   'javascript': ['standard'],
        \ }
endif


" Don't use Ex mode, use Q for formatting
map Q gq

" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

"" Switch syntax highlighting on, when the terminal has colors
"" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif


" Only do this part when compiled with support for autocommands.
if has("autocmd")

 " In text files, always limit the width of text to 78 characters
 "autocmd BufRead *.txt set tw=78

 augroup cprog
  " Remove all cprog autocommands
  au!

  " When starting to edit a file:
  "   For C and C++ files set formatting of comments and set C-indenting on.
  "   For other files switch it off.
  "   Don't change the order, it's important that the line with * comes first.
  autocmd FileType *      set formatoptions=tcql nocindent comments&
  autocmd FileType c,cpp  set formatoptions=croql cindent comments=sr:/*,mb:*,el:*/,://
 augroup END

 augroup gzip
  " Remove all gzip autocommands
  au!

  " Enable editing of gzipped files
  " set binary mode before reading the file
  autocmd BufReadPre,FileReadPre  *.gz,*.bz2 set bin
  autocmd BufReadPost,FileReadPost  *.gz call GZIP_read("gunzip")
  autocmd BufReadPost,FileReadPost  *.bz2 call GZIP_read("bunzip2")
  autocmd BufWritePost,FileWritePost  *.gz call GZIP_write("gzip")
  autocmd BufWritePost,FileWritePost  *.bz2 call GZIP_write("bzip2")
  autocmd FileAppendPre      *.gz call GZIP_appre("gunzip")
  autocmd FileAppendPre      *.bz2 call GZIP_appre("bunzip2")
  autocmd FileAppendPost    *.gz call GZIP_write("gzip")
  autocmd FileAppendPost    *.bz2 call GZIP_write("bzip2")

  " After reading compressed file: Uncompress text in buffer with "cmd"
  fun! GZIP_read(cmd)
    " set 'cmdheight' to two, to avoid the hit-return prompt
    let ch_save = &ch
    set ch=3
    " when filtering the whole buffer, it will become empty
    let empty = line("'[") == 1 && line("']") == line("$")
    let tmp = tempname()
    let tmpe = tmp . "." . expand("<afile>:e")
    " write the just read lines to a temp file "'[,']w tmp.gz"
    execute "'[,']w " . tmpe
    " uncompress the temp file "!gunzip tmp.gz"
    execute "!" . a:cmd . " " . tmpe
    " delete the compressed lines
    '[,']d
    " read in the uncompressed lines "'[-1r tmp"
    set nobin
    execute "'[-1r " . tmp
    " if buffer became empty, delete trailing blank line
    if empty
      normal Gdd''
    endif
    " delete the temp file
    call delete(tmp)
    let &ch = ch_save
    " When uncompressed the whole buffer, do autocommands
    if empty
      execute ":doautocmd BufReadPost " . expand("%:r")
  endfun

  " After writing compressed file: Compress written file with "cmd"
  fun! GZIP_write(cmd)
    if rename(expand("<afile>"), expand("<afile>:r")) == 0
      execute "!" . a:cmd . " <afile>:r"
    endif
  endfun

  " Before appending to compressed file: Uncompress file with "cmd"
  fun! GZIP_appre(cmd)
    execute "!" . a:cmd . " <afile>"
    call rename(expand("<afile>:r"), expand("<afile>"))
  endfun

 augroup END

 " This is disabled, because it changes the jumplist.  Can't use CTRL-O to go
 " back to positions in previous files more than once.
 if 0
  " When editing a file, always jump to the last cursor position.
  " This must be after the uncompress commands.
   autocmd BufReadPost * if line("'\"") && line("'\"") <= line("$") | exe "normal `\"" | endif
 endif

endif " has("autocmd")



au BufNewFile,BufRead *.php,*.php3,*.inc,*.module,*.info,*.install set ft=php
au BufNewFile,BufRead *.nqc,*.cpp,*.c,*.as                         set ft=cpp
au BufNewFile,BufRead *.cgi,*.plx,*.pl                             set ft=perl
au BufNewFile,BufRead *.scss                                       set ft=scss



" MY ADDITIONS : 2008.12.11

" Shortcuts for moving between tabs.
" Alt-j to move to the tab to the left
noremap <A-j> gT
" Alt-k to move to the tab to the right
noremap <A-k> gt

" tComment
"map <leader>c <c-_><c-_>


" http://www.vim.org/scripts/script.php?script_id=2540
filetype off
filetype indent plugin on






" ---------------- Plugins
" ----------------
" ----------------
" ----------------
" ----------------
" ----------------
" ----------------


" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'w0rp/ale'

Bundle 'gmarik/vundle'

Bundle 'Lokaltog/vim-easymotion'
Bundle 'tpope/vim-surround'

Bundle 'tpope/vim-fugitive'
Bundle 'mattn/webapi-vim'
Bundle 'mattn/gist-vim'
  let g:gist_clip_command = 'pbcopy'
  let g:gist_show_privates = 1

Bundle 'pangloss/vim-javascript'
Bundle 'leshill/vim-json'
Bundle 'nono/vim-handlebars'
" Bundle 'othree/html5.vim'

" Includes scss/sass
Bundle 'tpope/vim-haml'

Bundle 'airblade/vim-gitgutter'
" Snipmate with dependancies
" Snippets are here : https://github.com/honza/vim-snippets
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "honza/vim-snippets"
Bundle "garbas/vim-snipmate"

Bundle "justinmk/vim-sneak"
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-vinegar'
  autocmd vimenter * if !argc() | NERDTree | endif

Bundle 'maksimr/vim-jsbeautify' 
  Bundle 'einars/js-beautify' 

    " set path to js-beautify file 
    "   let g:jsbeautify_file = fnameescape(fnamemodify(expand("<sfile>"),
    "   ":h")."/bundle/js-beautify/beautify.js")

" CtrlP File Finder
Bundle 'kien/ctrlp.vim'
  set wildignore+=*/tmp/*,*.so,*.swp,*.zip    " Linux/MacOSX
  let g:ctrlp_map = '<c-p>'
  let g:ctrlp_cmd = 'CtrlP'
  let g:ctrlp_custom_ignore = {
    \ 'dir':  '\.git$\|\.hg$\|\.svn$\|\.yardoc\|node_modules\|\node_modules\|public\/images\|public\/system\|data\|log\|tmp$',
    \ 'file': '\.exe$\|\.so$\|\.dat$'
    \ }


Bundle 'dracula/vim'
" All of your Plugins must be added before the following line
call vundle#end()            " required



