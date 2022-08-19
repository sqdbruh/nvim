set nocompatible

call plug#begin()
Plug 'folke/todo-comments.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'antoinemadec/FixCursorHold.nvim'

Plug 'kyazdani42/nvim-web-devicons'

Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }

Plug 'tpope/vim-unimpaired'

"Themes
Plug 'loliee/vim-patatetoy'

Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }

Plug 'rhysd/vim-clang-format'
Plug 'Shougo/vimproc.vim'

Plug 'preservim/nerdtree'
Plug 'jiangmiao/auto-pairs'
Plug 'valloric/MatchTagAlways'
Plug 'preservim/nerdcommenter'
Plug 'preservim/tagbar'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-surround'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-refactor' " this provides "go to def" etc

Plug 'dhruvasagar/vim-markify'

Plug 'bkad/CamelCaseMotion'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'skywind3000/vim-preview'
Plug 'ludovicchabant/vim-gutentags'
Plug 'ahmedkhalf/project.nvim'

Plug 'lukas-reineke/indent-blankline.nvim'

Plug 'easymotion/vim-easymotion'


call plug#end()

let g:Hexokinase_highlighters = ['backgroundfull']
let g:cursorhold_updatetime = 100
set termguicolors


colorscheme patatetoy
"let g:lightline = { 'colorscheme': 'tender' }
let g:tagbar_map_togglesort = ''
set completeopt=menu,menuone
luafile C:\Users\sqdrc\AppData\Local\nvim\luasnip.lua
luafile C:\Users\sqdrc\AppData\Local\nvim\lsp.lua
luafile C:\Users\sqdrc\AppData\Local\nvim\nvim-cmp.lua
luafile C:\Users\sqdrc\AppData\Local\nvim\tree-sitter.lua
luafile C:\Users\sqdrc\AppData\Local\nvim\telescope.lua
luafile C:\Users\sqdrc\AppData\Local\nvim\todo-comments.lua
luafile C:\Users\sqdrc\AppData\Local\nvim\lua\lsp-ext.lua

nnoremap <SPACE> <Nop>
nnoremap ,<space> :nohlsearch<CR> 
let mapleader=" "

set encoding=utf-8

set mouse=a
set hidden
set cursorline
set number
set relativenumber
set backspace=indent,eol,start

nnoremap <A-;> <C-W><C-L>
nnoremap <A-k> <C-W><C-J>
nnoremap <A-l> <C-W><C-K>
nnoremap <A-j> <C-W><C-H>

noremap ; l
noremap l k
noremap k j
noremap j h

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

nnoremap <Leader>v <cmd>vsplit<cr>
nnoremap <Leader>h <cmd>split<cr>
nnoremap ff <cmd>Telescope find_files<cr>
nnoremap fg <cmd>Telescope live_grep<cr>
nnoremap fb <cmd>Telescope buffers<cr>
nnoremap fh <cmd>Telescope help_tags<cr>
nnoremap fq <cmd>Telescope quickfix<cr>
nnoremap tt <cmd>TagbarOpenAutoClose<cr>
nnoremap TT <cmd>TagbarToggle<cr>

nnoremap gr <cmd>Telescope lsp_references<cr>
function! FindWorkspaceSymbols()
    let l:search_symbol = 'Telescope lsp_workspace_symbols query='.input("Search for symbol: ")
    execute l:search_symbol
endfunction
nnoremap ft :call FindWorkspaceSymbols()<CR>
"nnoremap ft <cmd>Telescope lsp_workspace_symbols query=input()<cr>
nmap gD <C-]> 
nnoremap fp <cmd>Telescope projects<cr>
nnoremap hh <cmd>ClangdSwitchSourceHeader<cr>
nnoremap gp <cmd>PreviewTag<cr>
nnoremap gP <cmd>PreviewClose<cr>
nnoremap <silent> <leader>dd :lua vim.lsp.diagnostic.disable()<cr>
nnoremap <silent> <leader>ed :lua vim.lsp.diagnostic.enable()<cr>

nnoremap to <cmd>tabnew<cr>
nnoremap tc <cmd>tabclose<cr>
nnoremap t; <cmd>tabnext<cr>
nnoremap tj <cmd>tabprevious<cr>
nnoremap ts <C-W>r 

let g:tagbar_foldlevel = 0

let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
"nmap s <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-overwin-f2)

" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-linebackward)
map <Leader>; <Plug>(easymotion-lineforward)
map <Leader>l <Plug>(easymotion-k)
map <Leader>k <Plug>(easymotion-j)
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

" These `n` & `N` mappings are options. You do not have to map `n` & `N` to EasyMotion.
" Without these mappings, `n` & `N` works fine. (These mappings just provide
" different highlight method and have some other features )
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

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
      \ '--fields=+ailmnS',
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

lua << EOF
  require("project_nvim").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
EOF

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
highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
" blue
highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
" light blue
highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE
highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE
" pink
highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0
" front
highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4
highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4

nnoremap <silent> <F1> :make<CR>
nnoremap <silent> <F2> :!build\win32_handmade.exe<CR>
