" vim: set fmr={{{,}}} fdls=0 fdm=marker:
" peter50216's vimrc.

" TODO: Remove this after migration
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

"--------------------------------------------------------------------
" Plugins {{{
" Use vim-plug to manage.
call plug#begin('~/.vim/plugged')

" File navigation {{{
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Plug 'nvim-lua/popup.nvim'
" Plug 'nvim-lua/plenary.nvim'
" telescope.vim is somewhat slow QQ
" Plug 'nvim-telescope/telescope.nvim'
" }}}

" Completions and diagnosis {{{
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': { -> coc#util#install()}}
" TODO(Darkpi): Check builtin lsp support
" ref: https://blog.inkdrop.info/how-to-set-up-neovim-0-5-modern-plugins-lsp-treesitter-etc-542c3d9c9887
" Plug 'neovim/nvim-lspconfig'
" }}}

" Fast formatting & moving around {{{
Plug 'AndrewRadev/splitjoin.vim'
Plug 'Lokaltog/vim-easymotion'
Plug 'Raimondi/delimitMate'
Plug 'scrooloose/nerdcommenter'
Plug 'sickill/vim-pasta'
Plug 'mg979/vim-visual-multi'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-surround'
Plug 'wellle/targets.vim'
Plug 'Chiel92/vim-autoformat'
Plug 'unblevable/quick-scope'
" }}}

" Buffers {{{
Plug 'ton/vim-bufsurf'
" }}}

" Misc {{{
" TODO(Darkpi): Consider defx.nvim?
Plug 'Konfekt/FastFold'
Plug 'mhinz/vim-signify'
Plug 'jpalardy/vim-slime'
Plug 'mbbill/undotree'
Plug 'mhinz/vim-startify'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-repeat'
Plug 'vim-scripts/restore_view.vim'
Plug 'hackel/vis'  " For ruby shortcuts below
Plug 'tpope/vim-fugitive'
Plug 'chrisbra/vim-diff-enhanced'
Plug 'peter50216/vim-plugin'
if !has('nvim')
  Plug 'drmikehenry/vim-fixkey'
endif

" TODO: rewrite this in a faster language (rust? Or maybe just accept
" vimscript...) so the startup time can be faster.
Plug 'peter50216/vim-simple-statusline'
Plug '~/chromium/src/tools/vim/mojom'
" }}}

" {{{ Colorscheme
Plug 'w0ng/vim-hybrid'
" }}}

" To consider list {{{
" Plug 'mtth/scratch.vim'
" Plug 'nvim-telescope/telescope.nvim'
" }}}

" Language syntax/indent/compile/etc. {{{
Plug 'vim-scripts/ifdef-highlighting'
Plug 'gentoo/gentoo-syntax'
Plug 'mattn/emmet-vim'
" One pack for all!!!
" Plug 'sheerun/vim-polyglot'
Plug 'plasticboy/vim-markdown'
Plug 'sgeb/vim-diff-fold'
Plug 'jyelloz/vim-dts-indent'
Plug 'tmux-plugins/vim-tmux'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'https://github.com/kalcutter/vim-gn'
" }}}

call plug#end()
" }}}

"--------------------------------------------------------------------
" Vim settings {{{
set background=dark
set colorcolumn=80
set clipboard=
set completeopt=menuone
set confirm
set encoding=utf8
set expandtab
set fillchars=vert:\|
set fileencoding=utf8
set fileencodings=utf8,iso-8859-1,big5,cp950
set foldmethod=marker
set hidden
set hlsearch
set ignorecase
if has('nvim')
  set inccommand=nosplit
endif
set incsearch
set lazyredraw
set list
set mouse=a
set number
set ruler
set scrolloff=5
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
if has('nvim')
  set termguicolors
end
set title
set titleold=
set ttimeoutlen=50
set updatetime=200
set viewoptions=cursor,folds,slash,unix
set virtualedit=block
set visualbell t_vb=
set wildmenu
set wildignore=*.o,*.so,*.swp,*~,*.pyc
colorscheme hybrid
" }}}

"--------------------------------------------------------------------
" Colors {{{
" For transparent background
highlight Normal ctermbg=NONE guibg=NONE
" hybrid MatchParen doesn't work well with terminal reverted cursor color :(
highlight MatchParen ctermfg=60 ctermbg=234 guifg=#5F5F87 guibg=#1d1f21
" }}}

"--------------------------------------------------------------------
" Abbreviations {{{
iabbrev @@ Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
" TODO(Darkpi): Abbreviations for frequent typos.
" }}}

"--------------------------------------------------------------------
" Custom keybinding {{{
let mapleader="\<Space>"
let maplocalleader="\<Space>"
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
inoremap jk <Esc>

" Close buffer without affecting window layout
nnoremap <Leader>q :bp\|bd #<CR>

" Quick exit
nnoremap Q :qa<CR>

" Quick load/save
nnoremap <Leader>w :w<CR>
nnoremap <Leader>e :e<CR>

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

" Fast edit & reload vimrc
nnoremap <Leader>ve :vsplit $MYVIMRC<CR>

" Easy doing some complex things
if executable('ruby')
  vnoremap <Leader>rr :B !ruby 2>&1<CR>
  vnoremap <Leader>re :B !ruby -e 'print eval($stdin.read)' 2>&1<CR>
endif

" Splits
" Maximize current split
" nnoremap <Leader>wm <C-w>_<C-w><Bar>
" Resize all split
" nnoremap <Leader>wr <C-w>=
" Fast split
nnoremap _ :split<CR><C-w>j
nnoremap <Bar> :vsplit<CR><C-w>l

" Reindent all code, while preserving cursor location
nnoremap <Leader>= mqHmwgg=G`wzt`q

" Toggle colorcolumn
function! g:ToggleColorColumn()
  if &colorcolumn !=# ''
    setlocal colorcolumn&
  else
    setlocal colorcolumn=80
  endif
endfunction

nnoremap <silent> <leader>tc :call g:ToggleColorColumn()<CR>

" Insert newline without entering insert mode
nnoremap <C-J> i<CR><Esc>k$

" Don't show me that stupid window :D
nnoremap q: :q

" }}}

"--------------------------------------------------------------------
" Autocmds {{{
augroup MyAutoCmd
  autocmd!
  autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
  " autocmd BufNewFile,BufRead *.tsx set filetype=typescript.jsx
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
" Otherwise it saves it to ~/.vim/swap, ~/tmp or .
if isdirectory($HOME . '/.vim/swap') == 0
  :silent !mkdir -p ~/.vim/swap >/dev/null 2>&1
endif
set directory=./.vim-swap//
set directory+=~/.vim/swap//
set directory+=~/tmp//
set directory+=.

if exists('+undofile')
  " undofile - This allows you to use undos after exiting and restarting
  " This, like swap and backups, uses .vim-undo first, then ~/.vim/undo,
  " then .
  " :help undo-persistence
  " This is only present in 7.3+
  if isdirectory($HOME . '/.vim/undo') == 0
    :silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
  endif
  set undodir=./.vim-undo//
  set undodir+=~/.vim/undo//
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

" Lazy-loading slow-startup plugins {{{
augroup LazyLoadGroup
  autocmd!
augroup END
autocmd LazyLoadGroup CursorHold * call LoadPluginTrigger()
autocmd LazyLoadGroup InsertEnter * call LoadPluginTrigger()

function! LoadPluginTrigger()
  " call plug#load('YouCompleteMe')
  augroup LazyLoadGroup
    autocmd!
  augroup END
endfunction
" }}}
" }}}

"--------------------------------------------------------------------
" Plugin settings {{{
" NERDTree {{{
" Settings {{{
let NERDTreeWinSize=24
let NERDTreeIgnore=['\.o$', '\.a$', '\.d$[[file]]', '\.pyc', '\.swo', '\.swp', '\.un\~', '\.un', '\.git$[[dir]]']
" }}}
" Mappings {{{
nnoremap <S-Tab> :NERDTreeToggle<CR>
nnoremap <Leader>n :NERDTreeFind<CR>:wincmd p<CR>
" }}}
" Autocmds {{{
" Close vim if the only window open is nerdtree
autocmd MyAutoCmd BufEnter *
      \ if (winnr('$') == 1 && exists('b:NERDTreeType') && b:NERDTreeType == 'primary') | q | endif
" }}}
" }}}

" NERDCommenter {{{
" Settings {{{
let g:NERDSpaceDelims=1
let g:NERDUsePlaceHolders=0
let g:NERDCustomDelimiters = { 'vue': { 'left': '//','right': '' } }
" }}}
" Mappings {{{
nmap \ <Leader>c<Space>
vmap \ <Leader>c<Space>
" }}}
" }}}

" coc.nvim {{{
" Settings {{{
highlight CocUnusedHighlight ctermfg=248 ctermbg=NONE guifg=#A1A1A1 guibg=NONE
" }}}
" Mappings {{{
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype ==# 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
command! -nargs=0 Format :call CocAction('format')
nmap <silent> <Leader>xf <Plug>(coc-diagnostic-info)
nmap <silent> <Leader>xa <Plug>(coc-codeaction)
nmap <silent> <Leader>xx <Plug>(coc-fix-current)
nmap <silent> <Leader>xd <Plug>(coc-definition)
nmap <silent> <Leader>xt <Plug>(coc-type-definition)
nmap <silent> <Leader>xr <Plug>(coc-rename)
nmap <silent> <Leader>xi <Plug>(coc-implementation)
nmap <silent> <Leader>xq <Plug>(coc-references)
nmap <silent> <Leader>xn <Plug>(coc-diagnostic-next)
nmap <silent> <Leader>xp <Plug>(coc-diagnostic-prev)
" }}}
" Autocmds {{{
" }}}
" }}}

" YouCompleteMe {{{
" Settings {{{
let g:ycm_confirm_extra_conf=0
let g:ycm_key_list_select_completion=['<TAB>']
let g:ycm_key_list_previous_completion=['<S-TAB>']
let g:ycm_path_to_python_interpreter = '/usr/bin/python'
let g:ycm_max_diagnostics_to_display=0
" }}}
" Mappings {{{
noremap <F5> :YcmForceCompileAndDiagnostics<CR>
inoremap <F5> <ESC>:YcmForceCompileAndDiagnostics<CR>
" }}}
" Autocmds {{{
autocmd MyAutoCmd BufWritePost * silent! YcmForceCompileAndDiagnostics
" }}}
" }}}

" ale {{{
" Settings {{{
let g:ale_python_pylint_options='--rcfile=~/pylint.rc'
let g:ale_linters = {
      \ 'javascript': ['eslint', 'prettier'],
      \ 'typescript': ['tslint'],
      \ 'cpp': [],
      \ 'c': [],
      \ }
highlight ALEWarning ctermbg=None
" }}}
" Autocmds {{{
augroup AleRedrawStatus
  autocmd!
  autocmd User ALELintPre  redrawstatus!
  autocmd User ALELintPost redrawstatus!
augroup END
" }}}
" }}}

" EasyMotion {{{
" Settings {{{
let g:EasyMotion_move_highlight=0
let g:EasyMotion_smartcase=1
" }}}
" Mappings {{{
map <Leader>m <Plug>(easymotion-prefix)
map s <Plug>(easymotion-s2)

" map / <Plug>(easymotion-sn)\v
" omap / <Plug>(easymotion-tn)\v
" map n <Plug>(easymotion-next)
" map N <Plug>(easymotion-prev)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
" }}}
" }}}

" FastFold {{{
" Settings {{{
let g:fastfold_force=1
" }}}
" }}}

" Indent guide {{{
" Settings {{{
let g:indent_guides_auto_colors=0
let g:indent_guides_guide_size=1
let g:indent_guides_enable_on_vim_startup=1
" }}}
" Autocmds {{{
autocmd MyAutoCmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=235
autocmd MyAutoCmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=235
" }}}
" }}}

" DelimitMate {{{
" Settings {{{
let g:delimitMate_expand_cr=1
" }}}
" Mappings {{{
imap <C-D> <Plug>delimitMateJumpMany

" Workaround YCM issue as in https://github.com/Valloric/YouCompleteMe/issues/2696
imap <silent> <BS> <C-R>=YcmOnDeleteChar()<CR><Plug>delimitMateBS

function! YcmOnDeleteChar()
  if pumvisible()
    return "\<C-y>"
  endif
  return ''
endfunction
" }}}
" Autocmds {{{
autocmd MyAutoCmd FileType vim let b:delimitMate_quotes = "'"
" }}}
" }}}

" vim-slime {{{
" Settings {{{
let g:slime_target='tmux'
let g:slime_no_mapping=1
" }}}
" Mappings {{{
vmap <Leader>ss <Plug>SlimeRegionSend
nmap <Leader>ss <Plug>SlimeParagraphSend
nmap <Leader>sc <Plug>SlimeConfig
" }}}
" }}}

" vim-signify {{{
" Settings {{{
highlight SignifySignAdd ctermfg=65 ctermbg=NONE guifg=#5F875F guibg=NONE
highlight SignifySignChange ctermfg=60 ctermbg=NONE guifg=#5F5F87 guibg=NONE
highlight SignifySignDelete ctermfg=167 ctermbg=NONE guifg=#CC6666 guibg=NONE
" }}}
" }}}

" fzf {{{
" Settings {{{
let g:fzf_command_prefix = 'FZF'
let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'botright split',
      \ 'ctrl-v': 'botright vsplit' }
if &termguicolors
  let s:blue = '0x81,0xa2,0xbe'
  let s:green = '0x8a,0xe2,0x34'
else
  let s:blue = 'blue'
  let s:green = 'green'
endif
command! -bang -nargs=* FZFRg
  \ call fzf#vim#grep(
  \   'rg --no-heading --vimgrep --colors path:style:bold --colors path:fg:'.s:blue.
  \   ' --colors line:style:bold --colors line:fg:black --colors match:fg:'.s:green.
  \   ' --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)
" }}}
" Mappings {{{
nnoremap <Leader>b :FZFBuffers<CR>
" nnoremap <Leader>c :FZFCommands<CR>
nnoremap <Leader><Space> :FZFFiles<CR>
nnoremap <Leader>l :FZFBLines<CR>
nnoremap <Leader>g m':FZFRg <C-R><C-W><CR>
nnoremap <Leader>h :FZFBLines <C-R><C-W><CR>
nnoremap <Leader>; :FZFHistory:<CR>
" }}}
" }}}

" telescope.nvim {{{
" Settings {{{
" }}}
" Mappings {{{
" lua <<EOF
" local action_set = require('telescope.actions.set')
" local actions = require('telescope.actions')

" -- TODO(Darkpi): this has weird behavior on boundary...
" function move_selection_next_page(prompt_bufnr)
  " action_set.shift_selection(prompt_bufnr, 12)
" end
" function move_selection_previous_page(prompt_bufnr)
  " action_set.shift_selection(prompt_bufnr, -12)
" end

" require('telescope').setup{
  " defaults = {
    " mappings = {
      " i = {
        " ["<esc>"] = actions.close,
        " ["<pageup>"] = move_selection_previous_page,
        " ["<pagedown>"] = move_selection_next_page,
      " },
    " },
  " }
" }
" EOF
" nnoremap <Leader>b <cmd>Telescope buffers<CR>
" nnoremap <Leader><Space> <cmd>Telescope find_files<CR>
" nnoremap <Leader>l <cmd>Telescope current_buffer_fuzzy_find<CR>
" nnoremap <Leader>g <cmd>Telescope grep_string<CR>
" nnoremap <Leader>h :FZFBLines <C-R><C-W><CR>
" }}}
" }}}

" undotree {{{
" Mappings {{{
nnoremap <Leader>u :UndotreeToggle<CR>
" }}}
" }}}

" vim-eunuch {{{
" Mappings {{{
cnoremap w!! SudoWrite
" }}}
" }}}

" vim-polyglot {{{
" Settings {{{
" for vim-cpp
let c_no_curly_error=1
let g:jsx_ext_required=0
" }}}
" Autocmds {{{
autocmd MyAutoCmd FileType python set softtabstop=2 tabstop=2 shiftwidth=2
autocmd MyAutoCmd FileType go set noet softtabstop=4 tabstop=4 shiftwidth=4
" }}}
" }}}

" BufSurf {{{
" Mappings {{{
nnoremap Z :BufSurfBack<CR>
nnoremap X :BufSurfForward<CR>
" }}}
" }}}

" vim-startify {{{
" Settings {{{
let g:startify_change_to_dir=0
let g:startify_custom_header=[]
" }}}
" }}}

" vim-easy-align {{{
" Mappings {{{
" xmap <Leader>a <Plug>(EasyAlign)
" nmap <Leader>a <Plug>(EasyAlign)
" }}}
" }}}

" vim-pasta {{{
" Settings {{{
let g:pasta_disabled_filetypes = ['python', 'coffee', 'markdown', 'yaml', 'slim', 'nerdtree', 'make', 'gitsendemail']
" }}}
" }}}

" vim-autoformat {{{
" Settings {{{
let g:formatdef_yapf = "'yapf --style=\"{based_on_style:chromium,indent_width:'.&shiftwidth.(&textwidth ? ',column_limit:'.&textwidth : '').',ALLOW_MULTILINE_LAMBDAS: true, I18N_FUNCTION_CALL: func_not__exist}\" -l '.a:firstline.'-'.a:lastline"
let g:formatdef_eslint_d = '"eslint_d --fix --stdin --stdin-filename ".expand("%")." --fix-to-stdout"'
" let g:formatdef_jsbeautify_json = '"js-beautify -b expand,preserve-inline -i -".(&expandtab ? "s ".shiftwidth() : "t")'
let g:formatdef_jsbeautify_json = '"(cd ~/factory_things/json; bundle exec format.rb)"'
let g:formatdef_npx_prettier = '"pnpx prettier --stdin-filepath ".expand("%:p").(&textwidth ? " --print-width ".&textwidth : "")." --tab-width=".shiftwidth()'
let g:formatters_javascript=['npx_prettier', 'prettier']
let g:formatters_typescript=['eslint_d', 'npx_prettier', 'prettier']
let g:formatters_typescriptreact=['npx_prettier', 'prettier']
let g:formatters_vue=['eslint_d', 'npx_prettier', 'prettier']
let g:formatters_javascript=['clangformat']
let g:formatters_html = ['prettier']
let g:formatters_ruby = ['rubocop']
let g:autoformat_autoindent=0
let g:autoformat_retab=0
let g:autoformat_remove_trailing_spaces=0
" }}}
" Mappings {{{
vnoremap <Leader>f :Autoformat<CR>
nnoremap <Leader>f V:Autoformat<CR>
" }}}
" Autocmds {{{
autocmd MyAutoCmd BufWritePre *.vue,*.ts :Autoformat
" }}}
" }}}

" vim-visual-multi {{{
" Settings {{{
let g:VM_leader=','
let g:VM_mouse_mappings=1
" }}}
" }}}

" vim-multiple-cursors {{{
" Settings {{{
let g:multi_cursor_exit_from_visual_mode=0
let g:multi_cursor_exit_from_insert_mode=0
" }}}
" }}}

" vim-hardtime {{{
" Settings {{{
let g:hardtime_default_on=1
let g:hardtime_maxcount=3
let g:hardtime_showmsg=1
let g:hardtime_allow_different_key=1
let g:list_of_normal_keys = ['h', 'j', 'k', 'l', '<UP>', '<DOWN>', '<LEFT>', '<RIGHT>']
let g:list_of_visual_keys = ['h', 'j', 'k', 'l', '<UP>', '<DOWN>', '<LEFT>', '<RIGHT>']
" }}}
" }}}

" clever-f.vim {{{
" Settings {{{
let g:clever_f_fix_key_direction=1
" }}}
" }}}

" vim-markdown {{{
" Settings {{{
let g:vim_markdown_folding_disabled=1
" }}}
" }}}

" quick-scope {{{
" Settings {{{
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
" }}}
" }}}

" UltiSnips {{{
" Settings {{{
let g:UltiSnipsSnippetDirectories=[$HOME.'/UltiSnips']
let g:UltiSnipsExpandTrigger='<c-j>'
" }}}
" }}}

" targets.vim {{{
" Autocmds {{{
autocmd MyAutoCmd User targets#mappings#user call targets#mappings#extend({
    \ 'a': {'argument': [{'o': '[({[]', 'c': '[]})]', 's': ','}]}
    \ })
" }}}
" }}}

" vim-plugin (my custom plugin) {{{
" Mappings {{{
nmap <silent> <Leader>ucc <Plug>CopyCrosURLWithHash
nmap <silent> <Leader>ucm <Plug>CopyCrosURL
" }}}
" }}}

" nvim-treesitter {{{
" Settings {{{
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = { "ruby", "json" },
  },
}
EOF
" }}}
" }}}

" }}}
