set nocompatible
noremap ; l
noremap l k
noremap k j
noremap j h
noremap k gj
noremap l gk
nnoremap <SPACE> <Nop>
let mapleader=" "
call plug#begin()
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
"Plug 'hrsh7th/cmp-path'
Plug 'antoinemadec/FixCursorHold.nvim'

Plug 'L3MON4D3/LuaSnip'
Plug 'kyazdani42/nvim-web-devicons'

Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }

Plug 'tpope/vim-unimpaired'

"Themes
Plug 'loliee/vim-patatetoy'

Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }

Plug 'rhysd/vim-clang-format'

Plug 'preservim/nerdtree'
Plug 'jiangmiao/auto-pairs'
Plug 'valloric/MatchTagAlways'
Plug 'preservim/nerdcommenter'
Plug 'preservim/tagbar'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-surround'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'RRethy/nvim-treesitter-textsubjects'

Plug 'dhruvasagar/vim-markify'

Plug 'bkad/CamelCaseMotion'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'skywind3000/vim-preview'
Plug 'ludovicchabant/vim-gutentags'

Plug 'lukas-reineke/indent-blankline.nvim'

Plug 'easymotion/vim-easymotion'
Plug 'PeterRincker/vim-argumentative'
Plug 'svermeulen/vim-cutlass'
Plug 'https://github.com/svermeulen/vim-yoink'
Plug 'svermeulen/vim-subversive'
Plug 'dbakker/vim-paragraph-motion'
Plug 'michaeljsmith/vim-indent-object'

Plug 'ThePrimeagen/git-worktree.nvim'
Plug 'ThePrimeagen/harpoon'
Plug 'rafamadriz/friendly-snippets'
Plug 'glts/vim-radical'
Plug 'glts/vim-magnum'
Plug 'nvim-telescope/telescope-project.nvim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-obsession'
Plug 'mrjones2014/smart-splits.nvim'
Plug 'folke/todo-comments.nvim'
Plug 'erietz/vim-terminator'
Plug 'lifepillar/vim-colortemplate'
" post install (yarn install | npm install) then load plugin only for editing supported files
Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }
call plug#end()

function! MarkAndDo()
   execute "normal! m" . nr2char(getchar())
endfunction

nnoremap <silent> <leader>a :call MarkAndDo()<CR>

nnoremap <leader>/ <cmd>nohlsearch<CR> 

nmap <A-j> :lua require('smart-splits').resize_left()<CR>
nmap <A-k> :lua require('smart-splits').resize_down()<CR>
nmap <A-l> :lua require('smart-splits').resize_up()<CR>
nmap <A-;> :lua require('smart-splits').resize_right()<CR>

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
    luafile ~\AppData\Local\nvim\luasnip.lua
    luafile ~\AppData\Local\nvim\lsp.lua
    luafile ~\AppData\Local\nvim\nvim-cmp.lua
    luafile ~\AppData\Local\nvim\tree-sitter.lua
    luafile ~\AppData\Local\nvim\telescope.lua
    luafile ~\AppData\Local\nvim\todo-comments.lua
    luafile ~\AppData\Local\nvim\lua\lsp-ext.lua
elseif has('macunix')
    luafile ~/.config/nvim/luasnip.lua
    luafile ~/.config/nvim/lsp.lua
    luafile ~/.config/nvim/nvim-cmp.lua
    luafile ~/.config/nvim/tree-sitter.lua
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
set pumheight=10

nnoremap <Leader>v <cmd>vsplit<cr>
nnoremap <Leader>h <cmd>split<cr>
nnoremap ff <cmd>Telescope find_files<cr>
nnoremap fl <cmd>Telescope live_grep<cr>
nnoremap fb <cmd>Telescope buffers<cr>
nnoremap fh <cmd>Telescope help_tags<cr>
nnoremap fq <cmd>Telescope quickfix<cr>
nnoremap gr <cmd>Telescope lsp_references<cr>
nnoremap hl <cmd>Telescope harpoon marks<cr>
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
    execute 'keepjumps ClangdSwitchSourceHeader'
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
function! FindSymbolUnderCursor()
    let l:search_symbol = 'Telescope lsp_workspace_symbols query='.expand("<cword>")
    execute l:search_symbol
endfunction
function! SearchWorkspaceSymbol()
    let l:search_symbol = 'Telescope lsp_workspace_symbols query='.input("Search for symbol: ")
    execute l:search_symbol
endfunction
nnoremap fs :call SearchWorkspaceSymbol()<CR>
nnoremap gs :call FindSymbolUnderCursor()<CR>
nnoremap fg :call GrepWordUnderCursor()<CR>
nmap gt <cmd>tselect<cr>
nnoremap fp <cmd>lua require'telescope'.extensions.project.project{}<cr>
nnoremap hh <cmd>ClangdSwitchSourceHeader<cr>
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
let g:gutentags_add_default_project_roots = 0
let g:gutentags_project_root = ['package.json', '.git']
let g:gutentags_cache_dir = expand('~/.cache/vim/ctags/')
command! -nargs=0 GutentagsClearCache call system('rm ' . g:gutentags_cache_dir . '/*')
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0
let g:gutentags_ctags_extra_args = [
      \ '--tag-relative=yes',
      \ '-R --fields=+ailmnS --c-types=+l --extra=+f',
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
nnoremap <silent> <F1> :make<CR><cr>
nnoremap <silent> <F2> :!run.bat<CR><cr>


let g:prettier#config#single_quote = 'true'
let g:prettier#config#trailing_comma = 'all'
set formatoptions-=cro

hi! NormalNC guibg=#101010
