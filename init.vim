set guicursor=n-v:block-nCursor,i-ci-ve-c:ver25,r-cr:hor20,o:hor50
au VimLeave * set guicursor=a:ver25  "make the cursor a vertical line when exit vim

set number
set relativenumber
set showcmd
set cursorline
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
"set list
"set listchars=tab:\|\ ,trail:▫
set scrolloff=4
set ttimeoutlen=0 
"set notimeout
set viewoptions=cursor,folds,slash,unix
set wrap
set tw=0
set indentexpr=
set foldmethod=indent
set foldlevel=99
set formatoptions-=tc
set splitright
set splitbelow
set wildmenu
set ignorecase
set smartcase
set inccommand=split
set completeopt=longest,noinsert,menuone,noselect,preview
silent !mkdir -p ~/.config/nvim/tmp/backup
silent !mkdir -p ~/.config/nvim/tmp/undo
set backupdir=~/.config/nvim/tmp/backup,.
set directory=~/.config/nvim/tmp/backup,.
if has('persistent_undo')
	set undofile
	set undodir=~/.config/nvim/tmp/undo,.
endif

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


let mapleader=" "
noremap ; :

noremap Q :q<CR>
noremap S :w<CR>

nnoremap Y y$
vnoremap <LEADER>y "+y

noremap < <<
noremap > >>

noremap <silent> <LEADER>o za

noremap <LEADER><CR> :nohlsearch<CR>
noremap - Nzz
noremap = nzz


" I/K ley for 5times i/k (faster navigation)
noremap <silent> J 5j
noremap <silent> K 5k

noremap <silent> H 0
noremap <silent> L $


noremap W 5w
noremap B 5b

noremap <C-k> 5<C-y>
noremap <C-j> 5<C-e>

inoremap <C-a> <ESC>A

noremap <LEADER>w <C-w>w
noremap <LEADER>k <C-w>k
noremap <LEADER>j <C-w>j
noremap <LEADER>h <C-w>h
noremap <LEADER>l <C-w>l

noremap s <nop>
noremap X s

noremap sk :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
noremap sj :set splitbelow<CR>:split<CR>
noremap sh :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
noremap sl :set splitright<CR>:vsplit<CR>

noremap <UP> :res +5<CR>
noremap <down> :res -5<CR>
noremap <left> :vertical resize-5<CR>
noremap <right> :vertical resize+5<CR>

noremap sn <C-w>t<C-w>K
noremap sv <C-w>t<C-w>H

noremap tk :tabe<CR>
noremap th :-tabnext<CR>
noremap tl :+tabnext<CR>

" ===
" === Compile function
" ===
noremap r :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
        exec "!clang -g % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'html'
        silent ! exec "!".g:mkdp_browser." % & "
	elseif &filetype == 'markdown'
        exec "MarkdownPreview"
	endif
endfunc


" ===
" === Vim-plug
" ===
call plug#begin('~/.config/nvim/plugged')

Plug 'mg979/vim-xtabline'
Plug 'theniceboy/eleline.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'ryanoasis/vim-devicons'
Plug 'ajmwagar/vim-deus'
"Plug 'liuchengxu/space-vim-theme'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'tomtom/tcomment_vim'
"Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'RRethy/vim-illuminate'



"Plug 'othree/html5.vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'mattn/emmet-vim',{'for':['html', 'css']}
Plug 'alvan/vim-closetag'
Plug 'andymass/vim-matchup'

"markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

call plug#end()


" ===
" === Themes
" ===
set t_8f=[38;2;%lu;%lu;%lum
set t_8f=[48;2;%lu;%lu;%lum
set t_Co=256
set termguicolors
colorscheme deus 
"hi NonText ctermfg=gray guifg=grey10


" ===
" === Xtabline
" ===
let g:xtabline_settings = {}
let g:xtabline_settings.enable_mappings = 0
let g:xtabline_settings.enable_persistance = 0
let g:xtabline_settings.last_open_first = 1
let g:xtabline_settings.use_devicons = 1
let g:xtabline_settings.buffers_paths = 1
let g:xtabline_settings.current_tab_paths = 1
let g:xtabline_settings.other_tabs_paths = 1
let g:xtabline_settings.tab_icon  = "\uf115 "
let g:xtabline_settings.indicators = {
    \ 'modified':"\uf067",
    \}

" ===
" === lightline
" === 
set laststatus=2

" ===
" === Indent-guides
" ===
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let	g:indent_guides_guide_size = 1
let g:indent_guides_tab_guides = 0

" ===
" === Coc-nvim
" ===
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <silent><expr> <TAB>
	\ pumvisible() ? "\<C-n>" : "\<TAB>"
"	\ <SID>check_back_space() ? "\<TAB>" :
"	\ coc#refresh()
inoremap <expr><s-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
function! s:check_back_space() abort
	let col = col('.') -1
	return !col || getline('.')[col -1]  =~# '\s'
endfunction
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <NUL> coc#refresh()

xmap if <plug>(coc-funcobj-i)
xmap af <plug>(coc-funcobj-a)
omap if <plug>(coc-funcobj-i)
omap af <plug>(coc-funcobj-a)

let g:coc_sinppet_next = '<c-j>'
let g:coc_sinppet_prev = '<c-k>'

" ===
" === Coc-explorer
" ===
nmap tt :CocCommand explorer <CR>

" ===
" === Tcomment
" ===
let g:tcomment_mapleader2=','

" ===
" === 
" ===
let g:Illuminate_delay = 750
hi illuminatedWord cterm=undercurl gui=undercurl

" ===
" === Emmet
" ===
let g:user_emmet_leader_key=','
"imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")

" ===
" === matchup
" ===
let g:matchup_matchpref = { 'html': { 'nolists': 1 } }

" ===
" === MarkdownPreview
" ===
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0
let g:mkdp_open_ip = ''
let g:mkdp_echo_preview_url = 0
let g:mkdp_browserfunc = ''
let g:mkdp_preview_options = {
                        \ 'mkit': {},
                        \ 'katex': {},
                        \ 'uml': {},
                        \ 'maid': {},
                        \ 'disable_sync_scroll': 0,
                        \ 'sync_scroll_type': 'middle',
                        \ 'hide_yaml_meta': 1
                        \ }
let g:mkdp_markdown_css = ''
let g:mkdp_highlight_css = ''
let g:mkdp_port = ''
let g:mkdp_page_title = '「${name}」'

" ===
" === Fcitx                                          
" ===
let g:input_toggle = 0 
function! Fcitx2en()
    let b:input_status = system("fcitx-remote")
    if b:input_status == 2
        let b:input_toggle = 1
        let l:a = system("fcitx-remote -c")
    endif
endfunction

function! Fcitx2zh( )
    let b:input_status = system("fcitx-remote")
    if !exists("b:input_toggle")
        let b:input_toggle = g:input_toggle
    endif
    if b:input_status != 2 && b:input_toggle == 1
        let l:a = system("fcitx-remote -o")
        let b:input_toggle = 0
    endif
endfunction

set timeoutlen=500
autocmd InsertLeave * call Fcitx2en()
"autocmd InsertEnter * call Fcitx2zh()


