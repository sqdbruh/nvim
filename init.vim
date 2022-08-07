set nocompatible

call plug#begin()

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

Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }

Plug 'tpope/vim-unimpaired'

"Themes
Plug 'bluz71/vim-moonfly-colors'
Plug 'jacoborus/tender.vim'
Plug 'sainnhe/gruvbox-material'
Plug 'loliee/vim-patatetoy'

Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }

Plug 'rhysd/vim-clang-format'
Plug 'Shougo/vimproc.vim'

Plug 'preservim/nerdtree'
Plug 'jiangmiao/auto-pairs'
Plug 'valloric/MatchTagAlways'
Plug 'tpope/vim-commentary'
Plug 'preservim/tagbar'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-surround'
Plug 'tommcdo/vim-lion'
Plug 'mhinz/vim-startify'
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


call plug#end()

let g:Hexokinase_highlighters = ['backgroundfull']
let g:cursorhold_updatetime = 100
set termguicolors
" Available values: 'hard', 'medium'(default), 'soft'
let g:gruvbox_material_background = 'hard'
" For better performance
let g:gruvbox_material_better_performance = 1

colorscheme patatetoy
let g:lightline = { 'colorscheme': 'tender' }

set completeopt=menu,menuone
luafile C:\Users\sqdrc\AppData\Local\nvim\luasnip.lua
luafile C:\Users\sqdrc\AppData\Local\nvim\lsp.lua
luafile C:\Users\sqdrc\AppData\Local\nvim\nvim-cmp.lua
luafile C:\Users\sqdrc\AppData\Local\nvim\tree-sitter.lua
luafile C:\Users\sqdrc\AppData\Local\nvim\telescope.lua
luafile C:\Users\sqdrc\AppData\Local\nvim\lua\lsp-ext.lua

nnoremap <SPACE> <Nop>
nnoremap ,<space> :nohlsearch<CR> 
let mapleader=" "

set encoding=utf-8

set mouse=a
set hidden
set cursorline
set relativenumber
set number
set number relativenumber

nnoremap <C-N> <C-W><C-L>
nnoremap <C-P> <C-W><C-H>

noremap ; l
noremap l k
noremap k j
noremap j h
inoremap jk <ESC>

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

nnoremap ff <cmd>Telescope find_files<cr>
nnoremap fg <cmd>Telescope live_grep<cr>
nnoremap fb <cmd>Telescope buffers<cr>
nnoremap fh <cmd>Telescope help_tags<cr>
nnoremap fq <cmd>Telescope quickfix<cr>
nnoremap tt <cmd>TagbarOpenAutoClose<cr>
nnoremap TT <cmd>TagbarToggle<cr>

nnoremap gr <cmd>Telescope lsp_references<cr>
nnoremap gs <cmd>Telescope lsp_document_symbols<cr>
"nnoremap <silent> gd :lua require "telescope.builtin".lsp_definitions<cr>
nnoremap ft <cmd>Telescope treesitter<cr>
nnoremap fp <cmd>Telescope projects<cr>
nnoremap hh <cmd>ClangdSwitchSourceHeader<cr>
nnoremap gt <cmd>PreviewTag<cr>
nnoremap gT <cmd>PreviewClose<cr>
nnoremap <silent> <leader>dd :lua vim.lsp.diagnostic.disable()<cr>
nnoremap <silent> <leader>ed :lua vim.lsp.diagnostic.enable()<cr>

nnoremap to <cmd>tabnew<cr>
nnoremap tn <cmd>tabnext<cr>
nnoremap tp <cmd>tabprevious<cr>


nnoremap <C-t> :NERDTreeToggle<CR>

let g:gutentags_ctags_extra_args = '--fields+nS'

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

" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>

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