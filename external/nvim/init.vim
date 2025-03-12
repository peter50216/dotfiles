" vim: set fmr={{{,}}} fdls=0 fdm=marker:
" peter50216's vimrc.

language en_US.UTF8

lua require('init')

"--------------------------------------------------------------------
" Vim settings {{{
set background=dark
set colorcolumn=80
set clipboard=
set completeopt=menuone
set confirm
set encoding=utf8
set expandtab
set exrc
set fillchars=vert:\|
set fileencoding=utf8
set fileencodings=utf8,iso-8859-1,big5,cp950
set foldmethod=marker
set hidden
set hlsearch
set ignorecase
set inccommand=nosplit
set incsearch
set lazyredraw
set list
set mouse=a
set number
set ruler
set scrolloff=5
set secure
set sessionoptions-=curdir
set noshiftround
set shiftwidth=2
set shortmess+=c
set showcmd
set signcolumn=yes
set smartcase
set smartindent
set softtabstop=2
set synmaxcol=200
set t_Co=256
set tabstop=2
set termguicolors
set title
set titleold=
set ttimeoutlen=50
set updatetime=200
set viewoptions=cursor,folds,slash,unix
set virtualedit=block
set visualbell t_vb=
set wildmenu
set wildignore=*.o,*.so,*.swp,*~,*.pyc
" }}}

"--------------------------------------------------------------------
" Abbreviations {{{
iabbrev @@ Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
" TODO(Darkpi): Abbreviations for frequent typos.
" }}}

"--------------------------------------------------------------------
" Custom keybinding {{{
set pastetoggle=<F2>

" One less shift!
vnoremap ; :
nnoremap ; :

" Habit from normal text editor...
vnoremap <S-Up> <Up>
vnoremap <S-Down> <Down>

" Easier Replace
vnoremap <C-R> "hy:%s/<C-R>h//g<Left><Left>

vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" 0 is sooo much easier to type than ^, and ^ is more useful.
nnoremap 0 ^
nnoremap ^ 0
vnoremap 0 ^
vnoremap ^ 0

" Esc is sooo far away :D
if exists('g:vscode')
  " TODO(Darkpi): Consider https://github.com/vscode-neovim/vscode-neovim#composite-escape-keys
else
  inoremap jk <Esc>
end

" Quick exit
if exists('g:vscode')
  nnoremap Q <Cmd>call VSCodeCall('workbench.action.closeActiveEditor')<CR>
else
  nnoremap Q :qa<CR>
end

" Quick load/save
if exists('g:vscode')
  nnoremap <Leader>w <Cmd>call VSCodeCall('workbench.action.files.save')<CR>
  " TODO(Darkpi): reload current file?
else
  nnoremap <Leader>w :w<CR>
  nnoremap <Leader>e :e<CR>
end

" Copy/paste using system clipboard
noremap <Leader>y "+y
noremap <Leader>d "+d
noremap <Leader>p "+p
noremap <Leader>P "+P

nnoremap <silent> <Leader>/ :set hlsearch! hlsearch?<CR>

" Folds
" I don't use fold that much now, can reserve <CR> to something more useful.
nnoremap <CR> za

" To avoid C-a collision with tmux.
nnoremap + <C-a>
nnoremap - <C-x>

" Easy doing some complex things
if executable('ruby')
  vnoremap <Leader>rr :B !ruby 2>&1<CR>
  vnoremap <Leader>re :B !ruby -e 'print eval($stdin.read)' 2>&1<CR>
endif

" Toggle colorcolumn
function! g:ToggleColorColumn()
  if &colorcolumn !=# ''
    setlocal colorcolumn&
  else
    setlocal colorcolumn=80
  endif
endfunction

" nnoremap <silent> <leader>tc :call g:ToggleColorColumn()<CR>

" Insert newline without entering insert mode
nnoremap <C-J> i<CR><Esc>k$

" Don't show me that stupid window :D
nnoremap q: :q

" ESC in terminal mode should exit terminal
tnoremap <Esc> <C-\><C-n>

" }}}

"--------------------------------------------------------------------
" Autocmds {{{
augroup MyAutoCmd
  autocmd!
  autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
  autocmd BufNewFile,BufRead *.toml set filetype=toml
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
augroup END
" }}}

"--------------------------------------------------------------------
" Misc utilities {{{
" Move swap/undo files. {{{
" Save your swp files to a less annoying place than the current directory.
" If you have .vim-swap in the current directory, it'll use that.
" Otherwise it saves it to ~/.local/share/nvim/swap, ~/tmp or .
if isdirectory($HOME . '/.local/share/nvim/swap') == 0
  :silent !mkdir -p ~/.local/share/nvim/swap >/dev/null 2>&1
endif
set directory=./.vim-swap//
set directory+=~/.local/share/nvim/swap//
set directory+=~/tmp//
set directory+=.

if exists('+undofile')
  " undofile - This allows you to use undos after exiting and restarting
  " This, like swap and backups, uses .vim-undo first, then
  " ~/.local/share/nvim/undo, then .
  " :help undo-persistence
  " This is only present in 7.3+
  if isdirectory($HOME . '/.local/share/nvim/undo') == 0
    :silent !mkdir -p ~/.local/share/nvim/undo > /dev/null 2>&1
  endif
  set undodir=./.vim-undo//
  set undodir+=~/.local/share/nvim/undo//
  set undodir+=.
  set undofile
endif
" }}}

" Load default code {{{
" TODO(Darkpi): Pull these things into a custom plugin?
function! LoadDefaultCode()
  " Some code from embear/vim-localvimrc
  if (&buftype !=# '')
    return
  endif
  " TODO(Darkpi): Do we want to use %:e or &ft?
  let l:ext=expand('%:e')
  if empty(l:ext)
    return
  endif
  let l:directory=fnameescape(expand('%:p:h'))
  if empty(l:directory)
    let l:directory=fnameescape(getcwd())
  endif
  let l:paths=['.default', 'templates/default']
  for l:path in l:paths
    let l:ds=findfile(l:path.'.'.l:ext, l:directory.';', 1)
    if !empty(l:ds)
      exec 'silent! 0r '.l:ds
      break
    endif
  endfor
endfunction

function! LoadDefaultCodeIfEmpty()
  if line('$') == 1 && col('$') == 1
    call LoadDefaultCode()
  endif
endfunction

autocmd MyAutoCmd BufNewFile * call LoadDefaultCode()
" Deal with file newed by nerdtree.
autocmd MyAutoCmd BufRead * call LoadDefaultCodeIfEmpty()
" }}}

" Bracketed paste mode {{{
let &t_ti .= "\<Esc>[?2004h"
let &t_te .= "\<Esc>[?2004l"

function! XTermPasteBegin(ret)
  set pastetoggle=<f29>
  set paste
  return a:ret
endfunction

execute "set <f28>=\<Esc>[200~"
execute "set <f29>=\<Esc>[201~"
map <expr> <f28> XTermPasteBegin('i')
imap <expr> <f28> XTermPasteBegin('')
vmap <expr> <f28> XTermPasteBegin('c')
cmap <f28> <nop>
cmap <f29> <nop>
" }}}
" }}}
