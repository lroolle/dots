
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vimrc, managed plugins by vim-plug 
" Version  : 0.1.1 
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

" => https://github.com/junegunn/vim-plug 
call plug#begin('~/.vim/plugged')

Plug 'Chiel92/vim-autoformat'
Plug 'thinca/vim-quickrun'
Plug 'plasticboy/vim-markdown'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'psf/black', { 'tag': '19.10b0' }
Plug 'ybian/smartim'
  let g:smartim_default = 'com.apple.keylayout.ABC'
Plug 'roman/golden-ratio'
  " Exclude NERDTree/TagBar
  let g:golden_ratio_exclude_nonmodifiable = 1

" TODO: CtrlN(one and only useful)
" Plug 'mg979/vim-visual-multi'

" preservim/nerdcommenter {{{ 
Plug 'preservim/nerdcommenter'
  let g:NERDDefaultAlign    = 'left'
  let g:NERDCompactSexyComs = 1
  let g:NERDSpaceDelims     = 1
  " ctrl-/ to toggle comment
  map <c-_> <plug>NERDCommenterToggle
" END preservim/nerdcommenter }}}

" junegunn/vim-easy-align {{{
Plug 'junegunn/vim-easy-align'
  xmap ga <plug>(EasyAlign)
  nmap ga <plug>(EasyAlign)
" END junegunn/vim-easy-align }}}

" Tag Management with vim-gutentags {{{  
Plug 'ludovicchabant/vim-gutentags'
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

" LeaderF {{{
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
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

" NERDTree {{{
Plug 'scrooloose/nerdtree'
  let g:NERDTreeWinPos             = "right"
  let g:NERDTreeShowHidden         = 1
  let g:NERDTreeIgnore             = ['\.pyc$', '__pycache__']
  let g:NERDTreeWinSize            = 35
  let g:NERDTreeMapJumpNextSibling = ''
  let g:NERDTreeMapJumpPrevSibling = ''
  map <leader>nn :NERDTreeToggle<cr>
  map <leader>nf :NERDTreeFind<cr>
" END NERDTree }}}
  
" TagBar {{{
Plug 'majutsushi/tagbar'
  map <leader>tt :TagbarToggle<CR>
  let g:tagbar_sort        = 0
  let g:tagbar_foldlevel   = 0
  let g:tagbar_autoshowtag = 1
  let g:tagbar_autopreview = 0
" END TagBar }}} 

" Airline {{{
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
  let g:airline#extensions#ale#enabled     = 1
  let g:airline#extensions#tabline#enabled = 1
  let g:ale_list_window_size               = 4
  let g:ale_echo_msg_format                = '[%linter%]%code%:%s'
" END Airline }}} 

" ALE {{{
Plug 'dense-analysis/ale'
  let g:ale_hover_to_preview = 1
  let g:ale_linters          = {
  \   'javascript': ['jshint'],
  \   'python': ['pyflakes', 'pylint'],
  \   'go': ['go', 'golint', 'errcheck']
  \}
  nmap <silent> <leader>a <Plug>(ale_next_wrap)
" END ALE }}}

" YCM {{{
Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --all' }
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
" END Leader & vim-plug }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 1). Basics {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
set history=1000

syntax   on
filetype plugin on
filetype indent on

" Fast file saving, if PermissionError, `:W` sudo do saves.
map <leader>w :w!<cr>
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

set nobackup
set nowb
set noswapfile

inoremap jj <Esc>
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
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
" Opens a new tab with the current buffer's path
map <leader>te :tabedit <C-r> = expand("%:p:h")<cr>/

" Fast choose tab 
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
"nnoremap <leader>9 9gt

" Work perfect with airline buffer list extension
map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>
" Switch CWD of the opened buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>
" END Windows & Tabs & Buffers }}}


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
au FileType python  noremap <buffer> ;c /class<CR>
au FileType python  noremap <buffer> ;d /def<CR>
au FileType python  noremap <buffer> ;C ?class<CR>
au FileType python  noremap <buffer> ;D ?def<CR>
au FileType python inoremap <buffer> ;i import 
au FileType python inoremap <buffer> ;p print()<Esc>i
au FileType python inoremap <buffer> ;c class :<Esc>i
au FileType python inoremap <buffer> ;d def (): <Esc>2hi
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

" Reverse selected text
vnoremap ;rv c<C-O>:set revins<CR><C-R>"<Esc>:set norevins<CR>

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
