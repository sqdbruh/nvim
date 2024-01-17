set statusline=%f\ %y\ %h%m%r%=%-14.(%l,%c%V%)\ %P
nnoremap <SPACE> <Nop>
set termguicolors
let mapleader=" "
syntax on
set langmenu=en_US
let $LANG = 'en_US'
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
set splitbelow
set splitright
set guifont=JetBrains\ Mono:h10
autocmd VimEnter * :clearjumps
" Even out windows
autocmd VimEnter * wincmd =

call plug#begin()
Plug 'ycm-core/YouCompleteMe'
"Plug 'szw/vim-tags'
"Plug 'jiangmiao/auto-pairs'
"Plug 'itchyny/lightline.vim'
"Plug 'kshenoy/vim-signature'
Plug 'stevearc/oil.nvim'
Plug 'bkad/CamelCaseMotion'
"Plug 'sharkdp/bat'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/asyncomplete-buffer.vim'
"Plug 'prabirshrestha/vim-lsp'
"Plug 'mattn/vim-lsp-settings'
Plug 'ThePrimeagen/harpoon'
Plug 'OmniSharp/omnisharp-vim'
Plug 'L3MON4D3/LuaSnip'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'rhysd/vim-clang-format'
Plug 'preservim/nerdtree'
Plug 'windwp/nvim-autopairs'
Plug 'valloric/MatchTagAlways'
Plug 'preservim/nerdcommenter'
Plug 'sheerun/vim-polyglot'
Plug 'dhruvasagar/vim-markify'
Plug 'Yggdroot/indentLine'
Plug 'easymotion/vim-easymotion'
Plug 'PeterRincker/vim-argumentative'

Plug 'svermeulen/vim-cutlass'
Plug 'svermeulen/vim-yoink'
Plug 'svermeulen/vim-subversive'

Plug 'dbakker/vim-paragraph-motion'

Plug 'rafamadriz/friendly-snippets'

Plug 'glts/vim-magnum'
Plug 'glts/vim-radical'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.4' }
Plug 'nvim-telescope/telescope-project.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-fugitive'

Plug 'mrjones2014/smart-splits.nvim'
Plug 'folke/todo-comments.nvim'

"Plug 'prabirshrestha/asyncomplete-tags.vim'
"Plug 'prabirshrestha/asyncomplete-file.vim'
"Plug 'machakann/asyncomplete-ezfilter.vim'
call plug#end()
lua << EOF
require("oil").setup()
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
require("nvim-autopairs").setup {}
EOF

nnoremap gc :silent !ctags -R --fields=+ailmnS --c++-types=+l --extra=+fq --c++-kinds=+pl --links=no<CR>


augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

let g:lsp_document_code_action_signs_enabled=0
nnoremap <leader>/ <cmd>nohlsearch<CR> 

nmap <silent> <A-h> :lua require('smart-splits').resize_left()<CR>
nmap <silent> <A-j> :lua require('smart-splits').resize_down()<CR>
nmap <silent> <A-k> :lua require('smart-splits').resize_up()<CR>
nmap <silent> <A-l> :lua require('smart-splits').resize_right()<CR>

let g:yoinkIncludeDeleteOperations=1 
nmap s <plug>(SubversiveSubstitute)
nmap ss <plug>(SubversiveSubstituteLine)
nmap S <plug>(SubversiveSubstituteToEndOfLine)
xmap s <plug>(SubversiveSubstitute)
nmap <leader>s <plug>(SubversiveSubstituteRange)
xmap <leader>s <plug>(SubversiveSubstituteRange)
nmap <leader>SS <plug>(SubversiveSubstituteWordRange)

nmap <c-n> <plug>(YoinkPostPasteSwapBack)
nmap <c-p> <plug>(YoinkPostPasteSwapForward)
nmap p <plug>(YoinkPaste_p)
nmap P <plug>(YoinkPaste_P)
" Also replace the default gp with yoink paste so we can toggle paste in this case too"
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

map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
nmap xX ^xg_
nmap dD ^dg_
nmap cC ^cg_
nmap yY ^yg_

let g:Hexokinase_highlighters = ['virtual']
set clipboard=unnamed,unnamedplus

let g:terminator_split_location = 'vertical belowright'

set completeopt=menu,menuone
if has('win32')
    luafile ~\AppData\Local\nvim\luasnip.lua
    luafile ~\AppData\Local\nvim\telescope.lua
    luafile ~\AppData\Local\nvim\todo-comments.lua
elseif has('macunix')
    luafile ~/.config/nvim/luasnip.lua
    luafile ~/.config/nvim/telescope.lua
    luafile ~/.config/nvim/todo-comments.lua
endif

set encoding=utf-8

set mouse=a
set hidden
set cursorline
set number
set relativenumber
set backspace=indent,eol,start

map <C-j> :cn<CR>
map <C-k> :cp<CR>

map <silent> W <Plug>CamelCaseMotion_w
map <silent> B <Plug>CamelCaseMotion_b
map <silent> E <Plug>CamelCaseMotion_e
map <silent> ge <Plug>CamelCaseMotion_ge
sunmap W
sunmap B
sunmap E
sunmap ge

filetype plugin on
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
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fl <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>ft <cmd>Telescope tags<cr>
nnoremap <leader>fq <cmd>Telescope quickfix<cr>
nnoremap <leader>fh <cmd>Telescope harpoon marks<cr>
nnoremap <leader>fr <cmd>Telescope resume<cr>
nnoremap <leader>fm <cmd>Telescope marks<cr>
nnoremap <leader>h; <cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>
nnoremap <leader>ha <cmd>lua require("harpoon.mark").add_file()<cr>
nnoremap <leader>hp <cmd>lua require("harpoon.ui").nav_prev()<cr> 
nnoremap <leader>hn <cmd>lua require("harpoon.ui").nav_next()<cr> 
nnoremap <leader>h1 <cmd>lua require("harpoon.ui").nav_file(1)<cr> 
nnoremap <leader>h2 <cmd>lua require("harpoon.ui").nav_file(2)<cr> 
nnoremap <leader>h3 <cmd>lua require("harpoon.ui").nav_file(3)<cr> 
nnoremap <leader>h4 <cmd>lua require("harpoon.ui").nav_file(4)<cr> 
nnoremap <leader>h5 <cmd>lua require("harpoon.ui").nav_file(5)<cr> 
nnoremap <leader>h6 <cmd>lua require("harpoon.ui").nav_file(6)<cr> 
nnoremap <leader>h7 <cmd>lua require("harpoon.ui").nav_file(7)<cr> 
nnoremap <leader>h8 <cmd>lua require("harpoon.ui").nav_file(8)<cr> 
nnoremap <leader>h9 <cmd>lua require("harpoon.ui").nav_file(9)<cr> 
imap <silent><expr> <C-f> '<Plug>luasnip-expand-or-jump'
function! GrepWordUnderCursor()
    execute 'Telescope grep_string search='.expand("<cword>")
endfunction
nnoremap <leader>fg :call GrepWordUnderCursor()<CR>
nnoremap <leader>fp <cmd>lua require'telescope'.extensions.project.project{}<cr>

"
let g:indentLine_color_gui = '#262626'
let g:indentLine_leadingSpaceEnabled = 0

 let g:lsp_settings = {
 \  'clangd': {
 \    'args': ['-header-insertion=never'],
 \  },
 \}

call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
    \ 'name': 'buffer',
    \ 'priority': -1,
    \ 'allowlist': ['*'],
    \ 'blocklist': ['go'],
    \ 'completor': function('asyncomplete#sources#buffer#completor'),
    \ 'config': {
    \    'max_buffer_size': 5000000,
    \  },
    \ }))
au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#tags#get_source_options({
    \ 'name': 'tags',
    \ 'priority': -2,
    \ 'allowlist': ['c', 'cpp'],
    \ 'completor': function('asyncomplete#sources#tags#completor'),
    \ 'config': {
    \    'max_file_size': 50000000,
    \  },
    \ }))
au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
    \ 'name': 'file',
    \ 'allowlist': ['*'],
    \ 'priority': 10,
    \ 'completor': function('asyncomplete#sources#file#completor')
    \ }))
autocmd VimLeave * wshada!
let g:lsp_diagnostics_enabled = 0 
set grepprg=rg\ --vimgrep
"let g:asyncomplete_min_chars = 1
let g:lsp_document_highlight_enabled = 0
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    "if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gh :LspDocumentSwitchSourceHeader<cr>
    nmap <buffer> gD <plug>(lsp-declaration)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)
endfunction

nnoremap <C-t> :NERDTreeToggle<CR>


function! s:my_asyncomplete_preprocessor(options, matches) abort 
    let l:dict = {} 
    for [l:source_name, l:matches] in items(a:matches) 
        let l:source_priority = get(asyncomplete#get_source_info(l:source_name),'priority',0)
        for l:item in l:matches['items'] 
            if stridx(l:item['word'], a:options['base']) == 0
            "if l:item['word'] =~ '^' . a:options['base'] 
                let l:item['priority'] = l:source_priority
                if has_key(l:dict,l:item['word'])
                    let l:old_item = get(l:dict, l:item['word'])
                    if l:old_item['priority'] <  l:source_priority
                        let l:dict[item['word']] = l:item
                    endif
                else
                    let l:dict[item['word']] = l:item
                endif
            endif 
        endfor 
    endfor 
    let l:items =  sort(values(l:dict),{a, b -> b['priority'] - a['priority']})
    call asyncomplete#preprocess_complete(a:options, l:items) 
endfunction 

let g:asyncomplete_preprocessor = [function('s:my_asyncomplete_preprocessor')]

autocmd FileType TelescopePrompt let b:asyncomplete_enable = 0
autocmd FileType lsp-quickpick-filter let b:asyncomplete_enable = 0
autocmd FileType lsp-quickpick let b:asyncomplete_enable = 0

let g:clang_format#style_options = {
            "\ "BasedOnStyle" : "Microsoft", FIX THIS!
            \ "AccessModifierOffset" : -4,
            \ "PointerAlignment" : "Left",
            \ "SortIncludes" : "Never",
            \ "BreakBeforeBraces" : "Allman",
            \ "AllowShortIfStatementsOnASingleLine" : "Never",
            \ "AllowShortLambdasOnASingleLine" : "None",
            \ "AllowShortLoopsOnASingleLine" : "false",
            \ "AllowShortBlocksOnASingleLine" : "Never",
            \ "AllowShortCaseLabelsOnASingleLine" : "false",
            \ "AllowShortEnumsOnASingleLine" : "false",
            \ "AllowShortFunctionsOnASingleLine" : "None",
            \ "CompactNamespaces" : "false",
            \ "BinPackArguments" : "false",
            \ "BinPackParameters" : "false",
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "SpaceBeforeParens" : "Never",
            \ "BreakBeforeTernaryOperators" : "true",
            \ "AlignAfterOpenBracket" : "AlwaysBreak",
            \ "ColumnLimit" : 130,
            \ "Standard" : "C++11"}

autocmd FileType c,cpp,objc nnoremap <silent><buffer><leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <silent><buffer><leader>cf :ClangFormat<CR>


highlight! EasyMotionTarget guibg=NONE guifg=#b36a5d
highlight! EasyMotionTarget2First guibg=NONE guifg=#cea046
highlight! EasyMotionTarget2Second guibg=NONE guifg=#cea046
hi link EasyMotionShade  Comment
hi Cursor guifg=white guibg=white
hi Cursor2 guifg=white guibg=white
nnoremap <Esc> <C-\><C-n>
nnoremap <silent> <F1> <cmd>w <bar> make f1<cr><cr>
nnoremap <silent> <F2> <cmd>w <bar> make f2<cr><cr>
nnoremap <silent> <F3> <cmd>w <bar> make f3<cr><cr>
nnoremap <silent> <F4> <cmd>w <bar> make f4<cr><cr>
nnoremap <silent> <F5> <cmd>w <bar> make f5<cr><cr>
nnoremap <silent> <F6> <cmd>w <bar> make f6<cr><cr>
nnoremap <silent> <F7> <cmd>w <bar> make f7<cr><cr>
nnoremap <silent> <F8> <cmd>w <bar> make f8<cr><cr>
nnoremap <silent> <F9> <cmd>w <bar> make f9<cr><cr>
nnoremap <silent> <F10> <cmd>w <bar> make f10<cr><cr>
nnoremap <silent> <F11> <cmd>w <bar> make f11<cr><cr>
nnoremap <silent> <F12> <cmd>w <bar> make f12<cr><cr>

set errorformat=%f(%l):\ %trror\ C%n:\ %m

" Inactive tab highlight
hi! NormalNC guibg=#000000
hi! SignatureMarkText guifg=#bf9d73

au BufNewFile,BufRead,BufEnter *.cpp,*.hpp set omnifunc=omni#cpp#complete#Main
"nmap <silent> fl :lua require'telescope.builtin'.live_grep{ vimgrep_arguments = { 'rg', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case', '-u' } }<cr>
"nmap <silent> ff :lua require'telescope.builtin'.find_files{no_ignore=true}<cr>
let g:OmniSharp_highlighting = 0

"Disable deoplete in Telescope
autocmd FileType TelescopePrompt call deoplete#custom#buffer_option('auto_complete', v:false)

autocmd BufNewFile,BufRead * setlocal formatoptions-=cro

nnoremap <silent> <leader>dam :delm! <bar> delm A-Z0-9 <bar> SignatureRefresh<cr>
nnoremap <silent> dam :delm! <bar> SignatureRefresh<cr>
map <silent> K `]
map <silent> L `[

nnoremap <C-d> <C-d>
nnoremap <C-u> <C-u>zz
nnoremap n nzv
nnoremap N Nzv

" Go to previous file
nnoremap <leader>fd :e#<CR>
nnoremap <leader>2fd :e#2<CR>
nnoremap <leader>3fd :e#3<CR>
nnoremap <leader>4fd :e#4<CR>
nnoremap <leader>5fd :e#5<CR>
nnoremap <leader>6fd :e#6<CR>
nnoremap <leader>7fd :e#7<CR>
nnoremap <leader>8fd :e#8<CR>
nnoremap <leader>9fd :e#9<CR>

function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction
nnoremap <silent> <leader>tq :call ToggleQuickFix()<cr>
command! ClearQuickfixList cexpr []
nmap <leader>qc :ClearQuickfixList<cr>
" NOTE(sqdrck): Cursor
highlight Cursor guifg=black guibg=steelblue
highlight iCursor guifg=black guibg=steelblue
set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver100-iCursor
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkwait10

autocmd FileType cs :call SetCSSettings()

" TODO(sqdrck): Think about this later.
function! SetCSSettings()
    nmap <silent> <buffer> <Leader>rn <Plug>(omnisharp_rename)
    nmap <buffer> <Leader>rs :OmniSharpRestartServer<cr>
    nmap <silent> <buffer> <Leader>osfu <Plug>(omnisharp_fix_usings)
    nmap <silent> <buffer> <leader>cf <Plug>(omnisharp_code_format)
    nmap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)
    imap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)
    nmap <silent> <buffer> gd <Plug>(omnisharp_go_to_definition)
    nmap <silent> <buffer> gi <Plug>(omnisharp_find_implementations)

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
endfunction

function! HeaderToggle()
    let filename = expand("%:t")
    if filename =~ ".cpp"
        execute "e %:r.h"
    else
        execute "e %:r.cpp"
    endif
endfunction

"NOTE(sqd): Map home/end
inoremap <Home> <C-o>^
map <Home> ^
inoremap <End> <C-o>$
map <End> $

"NOTE(sqd): Insert \n
map <leader><cr> i<cr><ESC>

"NOTE(sqd): Smart indent when entering insert mode with i on empty lines
function! IndentWithI()
    if len(getline('.')) == 0
        return "\"_cc"
    else
        return "i"
    endif
endfunction
nnoremap <expr> i IndentWithI()
colorscheme handmade
