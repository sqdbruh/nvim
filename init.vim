set nocompatible
noremap ; l
noremap l k
noremap k j
noremap j h
noremap k gj
noremap l gk
nnoremap <SPACE> <Nop>
let mapleader=" "
command! ClearQuickfixList cexpr []
nmap <leader>cq :ClearQuickfixList<cr>
autocmd VimEnter * :clearjumps
call plug#begin()
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'vim-utils/vim-man'

Plug 'L3MON4D3/LuaSnip'

Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }

Plug 'rhysd/vim-clang-format'

Plug 'preservim/nerdtree'
Plug 'jiangmiao/auto-pairs'
Plug 'valloric/MatchTagAlways'
Plug 'preservim/nerdcommenter'
Plug 'preservim/tagbar'
Plug 'itchyny/lightline.vim'

"Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
"Plug 'nvim-treesitter/nvim-treesitter-textobjects'
"Plug 'nvim-treesitter/nvim-treesitter-context'
"Plug 'RRethy/nvim-treesitter-textsubjects'
Plug 'sheerun/vim-polyglot'
Plug 'dhruvasagar/vim-markify'

Plug 'skywind3000/vim-preview'
Plug 'ludovicchabant/vim-gutentags'

Plug 'lukas-reineke/indent-blankline.nvim'

Plug 'easymotion/vim-easymotion'
Plug 'PeterRincker/vim-argumentative'
Plug 'svermeulen/vim-cutlass'
Plug 'svermeulen/vim-yoink'
Plug 'svermeulen/vim-subversive'
Plug 'bkad/CamelCaseMotion'
Plug 'dbakker/vim-paragraph-motion'
Plug 'michaeljsmith/vim-indent-object'

Plug 'ThePrimeagen/git-worktree.nvim'
Plug 'ThePrimeagen/harpoon'
Plug 'rafamadriz/friendly-snippets'

Plug 'glts/vim-magnum'
Plug 'glts/vim-radical'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'nvim-telescope/telescope-project.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }

Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

Plug 'mrjones2014/smart-splits.nvim'
Plug 'folke/todo-comments.nvim'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/echodoc.vim'
Plug 'deoplete-plugins/deoplete-tag'
Plug 'deoplete-plugins/deoplete-lsp'
Plug 'deoplete-plugins/deoplete-clang'
Plug 'Shougo/neoinclude.vim'
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'BurntSushi/ripgrep'
Plug 'OmniSharp/omnisharp-vim'

call plug#end()
function! SetCSSettings()
    "let g:OmniSharp_selector_ui = 'fzf'    " Use fzf
    "let g:OmniSharp_selector_findusages = 'fzf'
    nmap <silent> <buffer> <Leader>rn <Plug>(omnisharp_rename)
    nmap <silent> <buffer> <Leader>osfu <Plug>(omnisharp_fix_usings)
    nmap <silent> <buffer> cf <Plug>(omnisharp_code_format)
    nmap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)
    imap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)

    nmap <silent> <buffer> <Leader>ca <Plug>(omnisharp_code_actions)
    xmap <silent> <buffer> <Leader>ca <Plug>(omnisharp_code_actions)

    nmap <silent> <buffer> <Leader>. <Plug>(omnisharp_code_action_repeat)
    xmap <silent> <buffer> <Leader>. <Plug>(omnisharp_code_action_repeat)

    nmap <silent> <buffer> <Leader>tl <Plug>(omnisharp_type_lookup)

    nmap <silent> <buffer> [[ <Plug>(omnisharp_navigate_up)
    nmap <silent> <buffer> ]] <Plug>(omnisharp_navigate_down)
    nmap <silent> <buffer> gr <Plug>(omnisharp_find_usages)
    " Find all code errors/warnings for the current solution and populate the quickfix window
    nmap <silent> <buffer> <F1> <Plug>(omnisharp_global_code_check)
    let g:OmniSharp_open_quickfix = 0
    let g:omnicomplete_fetch_full_documentation = 0
    let g:OmniSharp_popup_mappings = {
                \ 'sigNext': '<C-k>',
                \ 'sigPrev': '<C-l>',
                \ 'sigParamPrev': '<C-j>',
                \ 'sigParamNext': '<C-;>',
                \}
    let g:OmniSharp_diagnostic_showid = 1
    let g:OmniSharp_highlight_groups = {
                \ 'ClassName': 'Type',
                \ 'StructName': 'Type',
                \ 'DelegateName': 'Type',
                \ 'EnumName': 'Type',
                \ 'InterfaceName': 'Type',
                \ 'Keyword': 'Keyword',
                \ 'Operator': 'Operator',
                \ 'Comment': 'Comment',
                \}
    let g:OmniSharp_diagnostic_exclude_paths = [
                \ 'obj\\',
                \ '[Tt]emp\\',
                \ '\.nuget\\',
                \ 'Library\\',
                \ '\<AssemblyInfo\.cs\>'
                \]
    let g:OmniSharp_diagnostic_overrides = {
                \ 'CS8019': {'type': 'None'},
                \ 'RemoveUnnecessaryImportsFixable': {'type': 'None'}
                \}
    "exe ":ALEEnable"
    " Use deoplete.
    call deoplete#enable()
    call echodoc#disable()

    " Use smartcase.
    call deoplete#custom#option('smart_case', v:true)

    call deoplete#custom#option('sources', {
                \ 'cs': ['omnisharp'],
                \ })
    " Use OmniSharp-vim omnifunc 
    call deoplete#custom#source('omni', 'functions', { 'cs':  'OmniSharp#Complete' })

    " Set how Deoplete filters omnifunc output.
    call deoplete#custom#var('omni', 'input_patterns', {
                \ 'cs': '[^. *\t]\.\w*',
                \})

    "nnoremap <C-k> :ALENext<cr>
    "nnoremap <C-l> :ALEPrevious<cr>
    " ... then goes your mappings for :OmniSharp* functions, see its doc
endfunction

augroup csharp_commands
    autocmd!

    " Use smartcase.
    " call deoplete#custom#option('smart_case', v:true) 
    autocmd FileType cs call SetCSSettings()

augroup END
let g:OmniSharp_server_stdio = 1
let g:easytags_python_enabled = 1
let g:easytags_on_cursorhold = 0
let g:easytags_async = 1
let g:easytags_syntax_keyword = 'always'
let g:easytags_events = ['BufEnter', 'BufRead', 'BufWritePost']
let g:easytags_auto_update = 0
command! TselectCword execute 'tselect' expand('<cword>')

function! HeaderToggle()
    let filename = expand("%:t")
    if filename =~ ".cpp"
        execute "e %:r.h"
    else
        execute "e %:r.cpp"
    endif
endfunction
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#clang#sort_algo = 'priority'
let g:deoplete#sources#clang#flags = ['-x', 'c']
"let g:deoplete#disable_auto_complete = 1
let g:deoplete#sources#clang#filter_availability_kinds = ['NotAvailable', 'NotAccessible']
inoremap <expr> <C-n>  deoplete#manual_complete()
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'floating'
highlight link EchoDocFloat Pmenu

function! MarkAndDo()
   execute "normal! m" . nr2char(getchar())
endfunction

nnoremap <silent> <leader>a :call MarkAndDo()<CR>

nnoremap <leader>/ <cmd>nohlsearch<CR> 

nmap <silent> <A-j> :lua require('smart-splits').resize_left()<CR>
nmap <silent> <A-k> :lua require('smart-splits').resize_down()<CR>
nmap <silent> <A-l> :lua require('smart-splits').resize_up()<CR>
nmap <silent> <A-;> :lua require('smart-splits').resize_right()<CR>

let g:yoinkIncludeDeleteOperations=1 
nmap m <plug>(SubversiveSubstitute)
nmap mm <plug>(SubversiveSubstituteLine)
nmap M <plug>(SubversiveSubstituteToEndOfLine)
xmap m <plug>(SubversiveSubstitute)
nmap <leader>m <plug>(SubversiveSubstituteRange)
xmap <leader>m <plug>(SubversiveSubstituteRange)
nmap <leader>MM <plug>(SubversiveSubstituteWordRange)

nmap <c-n> <plug>(YoinkPostPasteSwapBack)
nmap <c-p> <plug>(YoinkPostPasteSwapForward)
nmap p <plug>(YoinkPaste_p)
nmap P <plug>(YoinkPaste_P)
" Also replace the default gp with yoink paste so we can toggle paste in this case too
nmap gp <plug>(YoinkPaste_gp)
nmap gP <plug>(YoinkPaste_gP)
nmap [y <plug>(YoinkRotateBack)
nmap ]y <plug>(YoinkRotateForward)
au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=150}

nmap ( <plug>Argumentative_MoveLeft
nmap ) <plug>Argumentative_MoveRight
xmap ia <plug>Argumentative_InnerTextObject
xmap aa <plug>Argumentative_OuterTextObject
omap ia <plug>Argumentative_OpPendingInnerTextObject
omap aa <plug>Argumentative_OpPendingOuterTextObject

nnoremap x d
xnoremap x d
nnoremap xx dd
nnoremap X D

" JK motions: Line motions
map s <Plug>(easymotion-overwin-f2)
map <Leader>j <Plug>(easymotion-linebackward)
map <Leader>; <Plug>(easymotion-lineforward)
map <Leader>l <Plug>(easymotion-k)
map <Leader>k <Plug>(easymotion-j)
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
nmap xX ^xg_
nmap dD ^dg_
nmap cC ^cg_
nmap yY ^yg_
"map  n <Plug>(easymotion-next)
"map  N <Plug>(easymotion-prev)

nmap td :bdelete<cr>

let g:Hexokinase_highlighters = ['virtual']
let g:cursorhold_updatetime = 100
set termguicolors
colorscheme handmade
set clipboard=unnamed,unnamedplus

let g:terminator_split_location = 'vertical belowright'

let g:tagbar_map_togglesort = ''
set completeopt=menu,menuone
if has('win32')
    let g:deoplete#sources#clang#libclang_path = 'C:\\Program Files\\LLVM\\bin\\libclang.dll'
    let g:deoplete#sources#clang#clang_header = 'C:\\Program Files\\LLVM\\lib\\clang'
    let g:python3_host_prog = 'C:\Python310\python.exe'
    luafile ~\AppData\Local\nvim\luasnip.lua
    "luafile ~\AppData\Local\nvim\lsp.lua
    "luafile ~\AppData\Local\nvim\nvim-cmp.lua
    "luafile ~\AppData\Local\nvim\tree-sitter.lua
    luafile ~\AppData\Local\nvim\telescope.lua
    luafile ~\AppData\Local\nvim\todo-comments.lua
    luafile ~\AppData\Local\nvim\lua\lsp-ext.lua
elseif has('macunix')
    let g:deoplete#sources#clang#libclang_path = ~/Library/Developer/CommandLineTools/usr/lib/libclang.dylib
    let g:deoplete#sources#clang#clang_header = ~/Library/Developer/CommandLineTools/usr/lib/clang
    let g:python3_host_prog = ~/opt/homebrew/bin/python3
    luafile ~/.config/nvim/luasnip.lua
    "luafile ~/.config/nvim/lsp.lua
    "luafile ~/.config/nvim/nvim-cmp.lua
    "luafile ~/.config/nvim/tree-sitter.lua
    luafile ~/.config/nvim/telescope.lua
    luafile ~/.config/nvim/todo-comments.lua
    luafile ~/.config/nvim/lua/lsp-ext.lua
    
endif

set encoding=utf-8

set mouse=a
set hidden
set cursorline
set number
set relativenumber
set backspace=indent,eol,start

map <C-k> :cn<CR>
map <C-l> :cp<CR>

map <silent> W <Plug>CamelCaseMotion_w
map <silent> B <Plug>CamelCaseMotion_b
map <silent> E <Plug>CamelCaseMotion_e
map <silent> ge <Plug>CamelCaseMotion_ge
sunmap W
sunmap B
sunmap E
sunmap ge

filetype plugin indent on
filetype indent on
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set smartindent
set ignorecase
set smartcase
let g:compiler = 'msvc'
set pumheight=8

nnoremap <Leader>v <cmd>vsplit<cr>
nnoremap <Leader>h <cmd>split<cr>
nnoremap ff <cmd>Telescope find_files<cr>
nnoremap fl <cmd>Telescope live_grep<cr>
nnoremap fb <cmd>Telescope buffers<cr>
nnoremap fh <cmd>Telescope tags<cr>
nnoremap fq <cmd>Telescope quickfix<cr>
nnoremap fh <cmd>Telescope harpoon marks<cr>
nnoremap fr <cmd>Telescope resume<cr>
nnoremap h; <cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>
nnoremap ha <cmd>lua require("harpoon.mark").add_file()<cr>
nnoremap hp <cmd>lua require("harpoon.ui").nav_prev()<cr> 
nnoremap hn <cmd>lua require("harpoon.ui").nav_next()<cr> 
nnoremap h1 <cmd>lua require("harpoon.ui").nav_file(1)<cr> 
nnoremap h2 <cmd>lua require("harpoon.ui").nav_file(2)<cr> 
nnoremap h3 <cmd>lua require("harpoon.ui").nav_file(3)<cr> 
nnoremap h4 <cmd>lua require("harpoon.ui").nav_file(4)<cr> 
nnoremap h5 <cmd>lua require("harpoon.ui").nav_file(5)<cr> 
nnoremap h6 <cmd>lua require("harpoon.ui").nav_file(6)<cr> 
nnoremap h7 <cmd>lua require("harpoon.ui").nav_file(7)<cr> 
nnoremap h8 <cmd>lua require("harpoon.ui").nav_file(8)<cr> 
nnoremap h9 <cmd>lua require("harpoon.ui").nav_file(9)<cr> 
nnoremap tt <cmd>TagbarOpenAutoClose<cr>
nnoremap TT <cmd>TagbarToggle<cr>
imap <silent><expr> <C-f> '<Plug>luasnip-expand-or-jump'
function! OpenHeaderInSideWindow()
    if winnr('$') == 1 
        execute 'keepjumps vsplit'
    else
        let currentBuf = bufname()
        execute 'keepjumps wincmd w'
        execute 'keepjumps e '.currentBuf
    endif
    execute 'keepjumps call HeaderToggle()'
    sleep 1m "Function above does not get called without it for some reason.
    execute 'keepjumps wincmd p'
endfunction 
" Insert text at the current cursor position.
function! InsertText(text)
    let cur_line_num = line('.')
    let cur_col_num = col('.')
    let orig_line = getline('.')
    let modified_line =
        \ strpart(orig_line, 0, cur_col_num - 1)
        \ . a:text
        \ . strpart(orig_line, cur_col_num - 1)
    " Replace the current line with the modified line.
    call setline(cur_line_num, modified_line)
    " Place cursor on the last character of the inserted text.
    call cursor(cur_line_num, cur_col_num + strlen(a:text))
endfunction
function! GrepWordUnderCursor()
    execute 'Telescope grep_string search='.expand("<cword>")
endfunction
nnoremap fg :call GrepWordUnderCursor()<CR>
nmap gt <cmd>TselectCword<cr>
nnoremap tp <cmd>tp<CR>
nnoremap tn <cmd>tn<CR>
nnoremap fp <cmd>lua require'telescope'.extensions.project.project{}<cr>
nnoremap <silent> hh <cmd>call HeaderToggle()<cr>
nnoremap <silent> HH :call OpenHeaderInSideWindow()<cr>
nnoremap gp <cmd>PreviewTag<cr>
nnoremap gP <cmd>PreviewClose<cr>
nnoremap to <cmd>tabnew<cr>
nnoremap tc <cmd>tabclose<cr>
nnoremap t; <C-W><C-L>
nnoremap tj <C-W><C-H>
nnoremap tk <C-W><C-J>
nnoremap tl <C-W><C-K>
nnoremap tp <cmd>tabnext<cr>
nnoremap tu <cmd>tabprevious<cr>
nnoremap tU <cmd>tabm -1<cr>
nnoremap tP <cmd>tabm +1<cr>
nnoremap ts <C-W>r 
nnoremap t1 1gt
nnoremap t2 2gt
nnoremap t3 3gt
nnoremap t4 4gt
nnoremap t5 5gt
nnoremap t6 6gt
nnoremap t7 7gt
nnoremap t8 8gt
nnoremap t9 9gt
nnoremap tm <cmd>bprev<cr>
nnoremap t/ <cmd>bnext<cr>
nnoremap <leader>ss :CheckHighlightUnderCursor<cr>

com! CheckHighlightUnderCursor echo {l,c,n ->
        \   'hi<'    . synIDattr(synID(l, c, 1), n)             . '> '
        \  .'trans<' . synIDattr(synID(l, c, 0), n)             . '> '
        \  .'lo<'    . synIDattr(synIDtrans(synID(l, c, 1)), n) . '> '
        \ }(line("."), col("."), "name")
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc


function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction

nnoremap <silent> tq :call ToggleQuickFix()<cr>

map <leader><cr> i<cr><ESC>

let g:tagbar_foldlevel = 0
let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_smartcase = 1


nnoremap <C-t> :NERDTreeToggle<CR>
let g:gutentags_project_root = ['package.json', '.git']
let g:gutentags_cache_dir = expand('~/.cache/vim/ctags/')
command! -nargs=0 GutentagsClearCache call system('rm ' . g:gutentags_cache_dir . '/*')
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0
let g:gutentags_ctags_extra_args = [
      \ '--tag-relative=yes',
      \ '-R --fields=+ailmnS --c++-types=+l --extra=+fq --c++-kinds=+pl',
      \ ]
      let g:gutentags_ctags_exclude = [
      \ '*.git', '*.svg', '*.hg',
      \ '*/tests/*',
      \ 'build',
      \ 'dist',
      \ '*sites/*/files/*',
      \ 'bin',
      \ 'node_modules',
      \ 'bower_components',
      \ 'cache',
      \ 'compiled',
      \ 'docs',
      \ 'example',
      \ 'bundle',
      \ 'vendor',
      \ '*.md',
      \ '*-lock.json',
      \ '*.lock',
      \ '*bundle*.js',
      \ '*build*.js',
      \ '.*rc*',
      \ '*.json',
      \ '*.min.*',
      \ '*.map',
      \ '*.bak',
      \ '*.zip',
      \ '*.pyc',
      \ '*.class',
      \ '*.sln',
      \ '*.Master',
      \ '*.csproj',
      \ '*.tmp',
      \ '*.csproj.user',
      \ '*.cache',
      \ '*.pdb',
      \ 'tags*',
      \ 'cscope.*',
      \ '*.css',
      \ '*.less',
      \ '*.scss',
      \ '*.exe', '*.dll',
      \ '*.mp3', '*.ogg', '*.flac',
      \ '*.swp', '*.swo',
      \ '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png',
      \ '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
      \ '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx',
      \ ]

set splitbelow
set splitright

lua require("indent_blankline").setup {  }

let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -4,
            \ "BasedOnStyle" : "Microsoft",
            \ "PointerAlignment" : "Left",
            \ "AllowShortIfStatementsOnASingleLine" : "false",
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "AlignConsecutiveAssignments  " : "Consecutive",
            \ "Standard" : "C++11"}

autocmd FileType c,cpp,objc nnoremap <buffer>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer>cf :ClangFormat<CR>

:highlight Normal ctermfg=grey ctermbg=black
"Autocomplete popup icons color
" gray
"highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
"" blue
"highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
"highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
"" light blue
"highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
"highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE
"highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE
"" pink
"highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
"highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0
"" front
"highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
"highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4
"highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4
highlight! EasyMotionTarget guibg=NONE guifg=#b36a5d
highlight! EasyMotionTarget2First guibg=NONE guifg=#cea046
highlight! EasyMotionTarget2Second guibg=NONE guifg=#cea046
hi link EasyMotionShade  Comment
tnoremap <Esc> <C-\><C-n>
nnoremap <silent> <F1> :make!<CR><cr>
nnoremap <silent> <F2> :!run.bat<CR><cr>


let g:prettier#config#single_quote = 'true'
let g:prettier#config#trailing_comma = 'all'
set formatoptions-=cro

hi! NormalNC guibg=#101010

au BufNewFile,BufRead,BufEnter *.cpp,*.hpp set omnifunc=omni#cpp#complete#Main
nmap <silent> <Leader>fl :lua require'telescope.builtin'.live_grep{ vimgrep_arguments = { 'rg', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case', '-u' } }<cr>
nmap <silent> <Leader>ff :lua require'telescope.builtin'.find_files{no_ignore=true}<cr>
