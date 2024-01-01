" TODO(sqdrck): Clean this up and probably make init.lua out of this.
set nobackup nowritebackup
set noswapfile
set noundofile
nnoremap <SPACE> <Nop>
set lazyredraw
set synmaxcol=128
syntax sync minlines=256
set nocompatible
set backupdir=~/.vim/backup
set directory=~/.vim/tmp
set noswapfile
let mapleader=" "
"nnoremap ; <tab>| nnoremap <tab> ;
"vnoremap ; <tab>| vnoremap <tab> ;
set guifont=JetBrains\ Mono:h10
noremap ; l
noremap l k
noremap k j
noremap j h
noremap k gj
noremap l gk
command! ClearQuickfixList cexpr []
nmap <leader>tq :ClearQuickfixList<cr>
autocmd VimEnter * :clearjumps
autocmd VimEnter * wincmd =

call plug#begin()
Plug 'OmniSharp/omnisharp-vim'
Plug 'Shougo/vimproc.vim'
Plug 'jbyuki/quickmath.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'sharkdp/fd'
Plug 'sharkdp/bat'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'vim-utils/vim-man'
Plug 'normen/vim-pio'

Plug 'L3MON4D3/LuaSnip'

Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }

Plug 'rhysd/vim-clang-format'

Plug 'preservim/nerdtree'
Plug 'jiangmiao/auto-pairs'
Plug 'valloric/MatchTagAlways'
Plug 'preservim/nerdcommenter'
Plug 'itchyny/lightline.vim'
Plug 'kshenoy/vim-signature'

Plug 'sheerun/vim-polyglot'
Plug 'dhruvasagar/vim-markify'

Plug 'skywind3000/vim-preview'

Plug 'Yggdroot/indentLine'

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

Plug 'folke/which-key.nvim' " optional

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.4' }
Plug 'nvim-telescope/telescope-project.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
"Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-pathogen'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-fugitive'

Plug 'mrjones2014/smart-splits.nvim'
Plug 'folke/todo-comments.nvim'

Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'


Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/echodoc.vim'
Plug 'deoplete-plugins/deoplete-tag'
Plug 'deoplete-plugins/deoplete-lsp'
Plug 'deoplete-plugins/deoplete-clang'
Plug 'Shougo/neoinclude.vim'

"Plug 'nvim-telescope/telescope-file-browser.nvim'

Plug 'BurntSushi/ripgrep'
Plug 'ludovicchabant/vim-gutentags'
Plug 'mbbill/undotree'
Plug 'justinmk/vim-sneak'
call plug#end()


lua << EOF
require'treesitter-context'.setup{
enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
max_lines = 5, -- How many lines the window should span. Values <= 0 mean no limit.
min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
line_numbers = true,
trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
}
EOF

nnoremap <leader>u :UndotreeToggle<CR>

let g:context_max_height = 2
let g:context_max_per_indent = 1
let g:context_max_join_parts = 0
let g:context_highlight_normal = 'Normal'
let g:context_highlight_border = 'Comment'
let g:context_highlight_tag    = 'Special'

autocmd VimLeave * wshada!
function! SetCSettings()
    exe 'TSContextEnable'
    "nmap <silent> <buffer> gd <C-]>
    nmap <silent> <Leader>rng :call ReplaceWordInAllFiles() <cr>
    nmap <silent> <Leader>rnc :call ReplaceWordInAllFilesWithPrompt() <cr>
    let g:gutentags_enabled = 1
    let g:gutentags_add_default_project_roots = ['Makefile', '.git']
    "let g:gutentags_project_root = ['package.json', '.git']
    "let g:gutentags_cache_dir = expand('~/.cache/vim/ctags/')
    "command! -nargs=0 GutentagsClearCache call system('rm ' . g:gutentags_cache_dir . '/*')
    let g:gutentags_generate_on_new = 1
    "let g:gutentags_generate_on_missing = 1
    let g:gutentags_generate_on_write = 1
    "let g:gutentags_generate_on_empty_buffer = 0
    "let g:gutentags_ctags_extra_args = [
                "\ '--tag-relative=yes',
                "\ '-R --fields=+ailmnS --c++-types=+l --extra=+fq --c++-kinds=+pl --links=no',
                "\ ]
endfunction

set grepprg=rg\ --vimgrep

function! Grep(...)
	return system(join([&grepprg] + [expandcmd(join(a:000, ' '))], ' '))
endfunction

command! -nargs=+ -complete=file_in_path -bar Grep  cgetexpr Grep(<f-args>)
command! -nargs=+ -complete=file_in_path -bar LGrep lgetexpr Grep(<f-args>)

cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() ==# 'grep')  ? 'Grep'  : 'grep'
cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() ==# 'lgrep') ? 'LGrep' : 'lgrep'

function! ReplaceWordInAllFilesWithPrompt()
    let cword = expand("<cword>")
    if len(cword) < 1
        return
    endif
    execute 'Grep '.cword

    let command = 'cdo s/\<'.cword.'\>/'.input("Replace '".cword."' with: ").'/gec'
    echo command
    exe command
    cexpr []
    cclose
    update
    redraw
endfunction
function! ReplaceWordInAllFiles()
    let cword = expand("<cword>")
    if len(cword) < 1
        return
    endif
    execute 'Grep '.cword

    let command = 'cdo s/\<'.cword.'\>/'.input("Replace '".cword."' with: ").'/ge'
    echo command
    exe command
    cexpr []
    cclose
    update
    redraw
endfunction

function! SetCSSettings()
    exe 'TSContextDisable'
    exe 'TSDisable c_sharp'
    let g:gutentags_enabled = 0
    nmap <silent> <buffer> <Leader>rn <Plug>(omnisharp_rename)
    nmap <buffer> <Leader>rs :OmniSharpRestartServer<cr>
    nmap <silent> <buffer> <Leader>osfu <Plug>(omnisharp_fix_usings)
    nmap <silent> <buffer> cf <Plug>(omnisharp_code_format)
    nmap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)
    imap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)
    nmap <silent> <buffer> <C-]> <Plug>(omnisharp_go_to_definition)
    nmap <silent> <buffer> <leader>gi <Plug>(omnisharp_find_implementations)

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
    " Use deoplete.
    call deoplete#enable()
    call echodoc#disable()

    " Use smartcase.
    call deoplete#custom#source('_', 'smart_case', v:true)

    call deoplete#custom#option('sources', {
                \ 'cs': ['omnisharp'],
                \ })
     "Use OmniSharp-vim omnifunc 
    call deoplete#custom#source('omni', 'functions', { 'cs':  'OmniSharp#Complete' })

    " Set how Deoplete filters omnifunc output.
    call deoplete#custom#var('omni', 'input_patterns', {
                \ 'cs': '[^. *\t]\.\w*',
                \})

endfunction

augroup csharp_commands
    autocmd!
    autocmd FileType cs call SetCSSettings()
augroup END
augroup c_commands
    autocmd!
    autocmd FileType c,cpp,h call SetCSettings()
augroup END
let g:OmniSharp_server_stdio = 1
command! TselectCword execute 'tselect' expand('<cword>')

function! HeaderToggle()
    let filename = expand("%:t")
    if filename =~ ".cpp"
        execute "e %:r.h"
    else
        execute "e %:r.cpp"
    endif
endfunction
let g:deoplete#sources#jedi#show_docstring = 1
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#clang#sort_algo = 'priority'
let g:deoplete#sources#clang#flags = ['-x', 'c']
"let g:deoplete#disable_auto_complete = 1
let g:deoplete#sources#clang#filter_availability_kinds = ['NotAvailable', 'NotAccessible']
let g:deoplete#smart_case = v:true
inoremap <expr> <C-n>  deoplete#manual_complete()
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'floating'
highlight link EchoDocFloat Pmenu
inoremap <Home> <C-o>^
map <Home> ^
inoremap <End> <C-o>$
map <End> $

"function! MarkAndDo()
    "execute "normal! m" . nr2char(getchar())
"endfunction

"nnoremap <silent> <leader>a :call MarkAndDo()<CR>

nnoremap <leader>/ <cmd>nohlsearch<CR> 

nmap <silent> <A-j> :lua require('smart-splits').resize_left()<CR>
nmap <silent> <A-k> :lua require('smart-splits').resize_down()<CR>
nmap <silent> <A-l> :lua require('smart-splits').resize_up()<CR>
nmap <silent> <A-;> :lua require('smart-splits').resize_right()<CR>

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


map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
nmap xX ^xg_
nmap dD ^dg_
nmap cC ^cg_
nmap yY ^yg_

nmap <leader>td :bdelete<cr>

let g:Hexokinase_highlighters = ['virtual']
let g:cursorhold_updatetime = 100
set termguicolors
colorscheme handmade
set clipboard=unnamed,unnamedplus

let g:terminator_split_location = 'vertical belowright'

set completeopt=menu,menuone
if has('win32')
    let g:deoplete#sources#clang#libclang_path = 'C:\\Program Files\\LLVM\\bin\\libclang.dll'
    let g:deoplete#sources#clang#clang_header = 'C:\\Program Files\\LLVM\\lib\\clang'
    let g:python3_host_prog = 'C:\Program Files\Python311\python.exe'
    luafile ~\AppData\Local\nvim\luasnip.lua
    luafile ~\AppData\Local\nvim\telescope.lua
    luafile ~\AppData\Local\nvim\lsp.lua
    luafile ~\AppData\Local\nvim\todo-comments.lua
    luafile ~\AppData\Local\nvim\lua\lsp-ext.lua
elseif has('macunix')
    " TODO(sqdrck): Fix this.
    "let g:deoplete#sources#clang#libclang_path = ~/Library/Developer/CommandLineTools/usr/lib/libclang.dylib
    "let g:deoplete#sources#clang#clang_header = ~/Library/Developer/CommandLineTools/usr/lib/clang
    "let g:python3_host_prog = ~/opt/homebrew/bin/python3
    luafile ~/.config/nvim/luasnip.lua
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

map <C-k> :cn<CR>zz
map <C-l> :cp<CR>zz

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
"nnoremap ft <cmd>Telescope tags<cr>
nnoremap ft <cmd>Telescope tags<cr>

nnoremap fq <cmd>Telescope quickfix<cr>
nnoremap fh <cmd>Telescope harpoon marks<cr>
nnoremap fr <cmd>Telescope resume<cr>
nnoremap fm <cmd>Telescope marks<cr>
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

function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction

map <leader><cr> i<cr><ESC>

"let g:tagbar_foldlevel = 0
let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_smartcase = 1

"let g:indentLine_char = '|'
let g:indentLine_color_gui = '#262626'
let g:indentLine_leadingSpaceEnabled = 0
"let g:indentLine_leadingSpaceChar = "•"


nnoremap <C-t> :NERDTreeToggle<CR>

set splitbelow
set splitright

"lua require("indent_blankline").setup {  }

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

autocmd FileType c,cpp,objc nnoremap <silent><buffer>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <silent><buffer>cf :ClangFormat<CR>


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
" filename(line) : error|warning|fatal error C0000: message

set errorformat=%f(%l):\ %trror\ C%n:\ %m
" For local replace
nnoremap gr gd[{V%::s/<C-R>///gc<left><left><left>

let $BAT_THEME='gruvbox'
" Inactive tab highlight
hi! NormalNC guibg=#000000
hi! SignatureMarkText guifg=#bf9d73
hi! TreesitterContext  guibg=#000000

au BufNewFile,BufRead,BufEnter *.cpp,*.hpp set omnifunc=omni#cpp#complete#Main
nmap <silent> fl :lua require'telescope.builtin'.live_grep{ vimgrep_arguments = { 'rg', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case', '-u' } }<cr>
nmap <silent> ff :lua require'telescope.builtin'.find_files{no_ignore=true}<cr>
let g:OmniSharp_highlighting = 0

"Disable deoplete in Telescope
autocmd FileType TelescopePrompt call deoplete#custom#buffer_option('auto_complete', v:false)

"smart indent when entering insert mode with i on empty lines
function! IndentWithI()
    if len(getline('.')) == 0
        return "\"_cc"
    else
        return "i"
    endif
endfunction
nnoremap <expr> i IndentWithI()

autocmd BufNewFile,BufRead * setlocal formatoptions-=cro

nnoremap <silent> <leader>dam :delm! <bar> delm A-Z0-9 <bar> SignatureRefresh<cr>
nnoremap <silent> dam :delm! <bar> SignatureRefresh<cr>
map <silent> K `]zz
map <silent> L `[zz

nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap n nzzzv
nnoremap N Nzzzv

" Go to previous file
nnoremap fd :e#<CR>
nnoremap 2fd :e#2<CR>
nnoremap 3fd :e#3<CR>
nnoremap 4fd :e#4<CR>
nnoremap 5fd :e#5<CR>
nnoremap 6fd :e#6<CR>
nnoremap 7fd :e#7<CR>
nnoremap 8fd :e#8<CR>
nnoremap 9fd :e#9<CR>

map <leader>; <Plug>Sneak_f
map <leader>j <Plug>Sneak_F
map <leader>: <Plug>Sneak_t
map <leader>J <Plug>Sneak_T
nnoremap <right> <Plug>Sneak_;
vnoremap <right> <Plug>Sneak_;
nnoremap <left> <Plug>Sneak_,
vnoremap <left> <Plug>Sneak_,

let g:sneak#use_ic_scs = 1
highlight link Sneak None
" Needed if a plugin sets the colorscheme dynamically:
autocmd User SneakLeave highlight clear Sneak
" 2-character Sneak (default)

nnoremap <silent> tq :call ToggleQuickFix()<cr>

"highlight Cursor guifg=black guibg=#52ad70
"highlight iCursor guifg=black guibg=#52ad70
highlight Cursor guifg=black guibg=steelblue
highlight iCursor guifg=black guibg=steelblue
set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver100-iCursor
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkwait10
