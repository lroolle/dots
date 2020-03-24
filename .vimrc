
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vimrc for Common People
" Plugins managed by [vim-plug](https://github.com/junegunn/vim-plug)
" Version  : 0.1.2
" Platform : macOS Catalina
" Author   : Eric Wang
" Email    : wrqatw@gmail.com
" Date     : 20200318
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 0). Leader & vim-plug {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let mapleader      = ","
let maplocalleader = ","

call plug#begin('~/.vim/plugged')

" TODO: CtrlN(one and only useful)
" Plug 'mg979/vim-visual-multi' " Too fucking much shortcuts for god

Plug 'Chiel92/vim-autoformat'
Plug 'plasticboy/vim-markdown'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'psf/black'
Plug 'tyru/open-browser.vim'
Plug 'ybian/smartim'
  " {{{
  let g:smartim_default = 'com.apple.keylayout.ABC'
" }}}

Plug 'thinca/vim-quickrun'
" {{{
  let g:quickrun_config          = {}
  let g:quickrun_config.markdown = {
	      \ 'type': 'markdown/pandoc',
	      \ 'cmdopt': '-s',
	      \ 'outputter': 'browser'
	      \ }
" }}}

Plug 'roman/golden-ratio'
  " {{{ Exclude NERDTree/TagBar
  let g:golden_ratio_exclude_nonmodifiable = 1
" END golden-ratio}}}

Plug 'preservim/nerdcommenter'
" preservim/nerdcommenter {{{
  let g:NERDDefaultAlign    = 'left'
  let g:NERDCompactSexyComs = 1
  let g:NERDSpaceDelims     = 1
  " ctrl-/ to toggle comment
  map <c-_> <plug>NERDCommenterToggle
" END preservim/nerdcommenter }}}

Plug 'junegunn/vim-easy-align'
" junegunn/vim-easy-align gai*| {{{
  xmap ga <plug>(EasyAlign)
  nmap ga <plug>(EasyAlign)
" END junegunn/vim-easy-align }}}

Plug 'ludovicchabant/vim-gutentags'
" vim-gutentags: ctags & gtags management {{{
  let g:gutentags_project_root           = ['.root', '.svn', '.git', '.hg', '.project']
  let g:gutentags_ctags_tagfile          = '.tags'
  " work with ctags & gtags both
  let g:gutentags_modules                = []
  if executable('ctags')
  	let g:gutentags_modules             += ['ctags']
  endif
  if executable('gtags-cscope') && executable('gtags')
  	let g:gutentags_modules             += ['gtags_cscope']
  endif
  let g:gutentags_cache_dir              = expand('~/.cache/tags')
  " Note Exuberant-ctags should not cotain --extra=+q
  " Universal-ctags is highly recommended
  let g:gutentags_ctags_extra_args       = ['--fields=+niazS', '--extra=+q']
  let g:gutentags_ctags_extra_args      += ['--c++-kinds=+px']
  let g:gutentags_ctags_extra_args      += ['--c-kinds=+px']
  " Add when using universal-ctags
  let g:gutentags_ctags_extra_args      += ['--output-format=e-ctags']
  let g:gutentags_auto_add_gtags_cscope  = 0
" END ludovicchabant/vim-gutentags }}}

Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
" LeaderF {{{
  let g:Lf_WindowPosition        = 'popup'
  let g:Lf_PreviewInPopup        = 1
  " search visually selected text literally
  let g:Lf_RgConfig              = [
        \ "--max-columns=150",
        \ "--glob=!git/*",
        \ "--hidden"
    \ ]
  noremap <leader>fg :Leaderf rg<CR>
  xnoremap gf :<C-U><C-R        >= printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>
  noremap go :<C-U>Leaderf! rg --recall<CR>
  " Should use `Leaderf gtags --update` first
  " TODO: NOT WORK WITH PYTHON TAGS
  let g:Lf_GtagsAutoGenerate     = 1
  let g:Lf_Gtagslabel            = 'native-pygments'
  noremap <leader>fr :<C-U><C-R >= printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
  noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
  noremap <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
  noremap <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
  noremap <leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>
" END LeaderF }}}

Plug 'scrooloose/nerdtree'
" NERDTree {{{
  let g:NERDTreeWinPos             = "right"
  let g:NERDTreeShowHidden         = 1
  let g:NERDTreeIgnore             = ['\.pyc$', '__pycache__']
  let g:NERDTreeWinSize            = 35
  let g:NERDTreeMapJumpNextSibling = ''
  let g:NERDTreeMapJumpPrevSibling = ''
  map <leader>nn :NERDTreeToggle<cr>
  map <leader>nf :NERDTreeFind<cr>
" END NERDTree }}}

Plug 'majutsushi/tagbar'
" TagBar {{{
  map <leader>tt :TagbarToggle<CR>
  let g:tagbar_sort        = 0
  let g:tagbar_foldlevel   = 0
  let g:tagbar_autoshowtag = 1
  let g:tagbar_autopreview = 0
" END TagBar }}}

Plug 'dense-analysis/ale'
" ALE {{{
  let g:ale_hover_to_preview = 1
  let g:ale_echo_msg_format  = '[%linter%]%code%:%s'
  let g:ale_linters          = {
  \   'javascript': ['jshint'],
  \   'python': ['pyflakes', 'pylint'],
  \   'go': ['go', 'golint', 'errcheck']
  \}
  nmap <silent> <leader>a <Plug>(ale_next_wrap)
" END ALE }}}

Plug 'vim-airline/vim-airline'
" Airline {{{
  let g:airline#extensions#ale#enabled     = 1
  let g:airline#extensions#tabline#enabled = 1
" END Airline }}}

Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --all' }
" YCM {{{
  let g:ycm_python_binary_path                            = 'python3'
  let g:ycm_collect_identifiers_from_tags_files           = 1
  let g:ycm_seed_identifiers_with_syntax                  = 1
  let g:ycm_complete_in_comments                          = 1
  let g:ycm_complete_in_strings                           = 1
  let g:ycm_collect_identifiers_from_comments_and_strings = 1
  let g:ycm_confirm_extra_conf                            = 1
  let g:ycm_key_list_select_completion                    = ['<C-j>', '<Down>', '<Tab>']
  let g:ycm_key_list_previous_completion                  = ['<C-k>', '<Up>', '<S-Tab>']
  let g:ycm_autoclose_preview_window_after_completion     = 1
  let g:ycm_goto_buffer_command                           = 'vertical-split'
  let g:ycm_python_binary_path                            = 'python'
  let g:ycm_filetype_blacklist                            = {'unite': 1, 'tagbar': 1, 'pandoc': 1, 'qf': 1, 'infolog': 1, }
  nnoremap <leader>] : YcmCompleter GoTo<CR>
  nnoremap <leader>i : YcmCompleter GoToDefinitionElseDeclaration<CR>
  nnoremap <leader>; : YcmCompleter GoToReferences<CR>
" END YCM }}}

call plug#end()
" END Leader & vim-plug plugins }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 1). Basics {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
set history=1000
" No backups and swap file
set nobackup
set nowb
set noswapfile

syntax   on
filetype plugin on
filetype indent on

" Fast file saving, if PermissionError, `:W` sudo do saves.
map <leader>w :w!<cr>
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!
" Fast .vimrc Edit && Source
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
" Fast Esc, and :
inoremap jk <Esc>
map <space> :

" Search & Ignore case
set hlsearch
set incsearch
set smartcase
set ignorecase
" Unhighlight searched
map <silent> <leader><cr> :noh<cr>

" Press <Tab> to show more above the command line
set wildmenu

" Use spaces instead of tabs
set expandtab
set smarttab

" 1 tab == 4 spaces
set tabstop=4
set shiftwidth=4

" Linebreak on 500 characters
set lbr
set tw=500
set textwidth=79
set colorcolumn=79

set ai
set si
set lz    " redraw only when need to
set wrap
set ruler

set nu
set sc    " showcmd
set sm    " {[()]} show match
set cul   " cursor line
set so=7

set foldenable
set foldnestmax=10
set foldlevelstart=1

set noerrorbells
set novisualbell
set t_vb           =

" Ignore bin files
set wildignore=*.o,*~,*.pyc

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

" Copy & Paste from system clipboard(+clipboard feature required)
noremap <leader>y "+y
noremap <leader>v "+p

" END General }}}


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Windows & Tabs & Buffers {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
set hidden " You can have edited buffers that aren't visible in a window somewhere
" Undo when file reopen(+persistent_undo feature required)
set undofile
set undodir=$HOME/.vim/undo  " mkdir required! where the undo files to be stored
" Easy jump between split windows
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l

" Useful mappings for managing tabs
noremap <leader>tn :tabnew<cr>
noremap <leader>to :tabonly<cr>
noremap <leader>tc :tabclose<cr>
" Opens a new tab with the current buffer's path
noremap <leader>te :tabedit <C-r> = expand("%:p:h")<cr>/

" Fast choose tab
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt

" Work perfect with airline buffer list extension
map <leader>l  :bnext<cr>
map <leader>h  :bprevious<cr>
" Switch CWD of the opened buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>
" END Windows & Tabs & Buffers }}}

" Toggle(zoom) current window :only {{{
function! WindowZoomToggle()
  if exists("s:maximize_session")
    exec "source " . s:maximize_session
    call delete(s:maximize_session)
    unlet s:maximize_session
    let &hidden=s:maximize_hidden_save
    unlet s:maximize_hidden_save
  else
    let s:maximize_hidden_save = &hidden
    let s:maximize_session = tempname()
    set hidden
    exec "mksession! " . s:maximize_session
    only
  endif
endfunction
nnoremap <leader>z :call WindowZoomToggle()<CR>
" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text Edit {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" END Text Edit }}}

" END Basics }}}


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 2). Color Highlights {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_Co=256
hi ColorColumn ctermbg=234 guibg=lightgrey

" END Color Highlights }}}


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 3). Filetypes {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Python section {{{
let python_highlight_all = 1
autocmd BufWritePre *.py execute ':Black'
au BufNewFile,BufRead *.py set foldmethod=indent
au BufNewFile,BufRead *.py set foldlevel=4
" Fast seacrh calss, def, print...
au FileType python  noremap <buffer> ;c /class<CR>
au FileType python  noremap <buffer> ;d /def<CR>
au FileType python  noremap <buffer> ;C ?class<CR>
au FileType python  noremap <buffer> ;D ?def<CR>
au FileType python  noremap <buffer> ;p /print(<CR>
au FileType python  noremap <buffer> ;P ?print(<CR>
" Fast input import, class, def, print, return, docstring...
au FileType python inoremap <buffer> ;i import
au FileType python inoremap <buffer> ;c class :<Esc>i
au FileType python inoremap <buffer> ;d def (): <Esc>2hi
au FileType python inoremap <buffer> ;p print()<Esc>i
au FileType python inoremap <buffer> ;r return
au FileType python inoremap <buffer> ;' """  <CR>"""<Esc>ka
" END Python section }}}

" Markdown
let vim_markdown_folding_disabled = 1

" END 3). Filetypes }}}


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 4). Extend {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" TMUX: allows cursor change in tmux mode {{{
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
" END Tmux cursor change }}}

" END 4). Extended }}}


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 5). Plays & Tricks {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Fast reverse selected text
vnoremap ;rv c<C-O>:set revins<CR><C-R>"<Esc>:set norevins<CR>
" Fast select all
noremap  ;a ggVG
" Fast trim white spaces
nnoremap <silent> ;<Space> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

" NERDTreeToggle with TagbarToggle {{{
function! s:ToggleNERDTreeAndTagbar()
    if exists('g:tagbar_left')
        let s:tagbar_left_user = g:tagbar_left
    else
        let s:tagbar_left_user = 0
    endif

    if exists('g:tagbar_vertical')
        let s:tagbar_vertical_user = g:tagbar_vertical
    else
        let s:tagbar_vertical_user = 0
    endif

    " settings required for split window nerdtree / tagbar
    let g:NERDTreeWinSize = max([g:tagbar_width, g:NERDTreeWinSize])
    let g:tagbar_left = 0
    let g:tagbar_vertical = winheight(0)/2

    " Detect which plugins are open
    if exists('t:NERDTreeBufName')
        let s:nerdtree_open = bufwinnr(t:NERDTreeBufName) != -1
    else
        let s:nerdtree_open = 0
    endif
    let s:tagbar_open = bufwinnr('__Tagbar__') != -1

    " toggle tagbar & NERDTree
    if s:nerdtree_open && s:tagbar_open
        NERDTreeClose
        TagbarClose
    else
        if s:nerdtree_open
            NERDTreeClose
        elseif s:tagbar_open
            TagbarClose
        endif

        " remember buffer (actually, this is a hack, not sure if there is a
        " good way to do this)
        let b:NERDTreeAndTagbar_come_back_to_me = 1

        " open tagbar as split of nerdtree window
        " TagbarOpen |
        NERDTree | TagbarOpen

        " go back to initial buffer
        while !exists('b:NERDTreeAndTagbar_come_back_to_me')
            wincmd w
        endwhile
        unlet b:NERDTreeAndTagbar_come_back_to_me
    endif

    " reset default / user configuration of tagbar
    let g:tagbar_left = s:tagbar_left_user
    let g:tagbar_vertical = s:tagbar_vertical_user
endfunction

command! -nargs=0 ToggleNERDTreeAndTagbar :call s:ToggleNERDTreeAndTagbar()
map <leader>nt :ToggleNERDTreeAndTagbar<CR>
" END NERDTreeToggle with TagbarToggle }}}

" END 5). Plays & Tricks }}}


" vim: set foldmethod=marker foldlevel=1 nomodeline:
