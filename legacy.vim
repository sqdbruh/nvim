colorscheme handmade
filetype plugin on
filetype plugin indent on
filetype indent on
set foldlevelstart=99
set nohidden
set autoread
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set smartindent
set ignorecase
set smartcase
set pumheight=8
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
set grepformat=%f:%l:%c:%m
set statusline=%f\ %y\ %h%m%r%=%-14.(%l,%c%V%)\ %P
nnoremap <SPACE> <Nop>
set termguicolors
let mapleader=" "
syntax on
set langmenu=en_US
let $LANG = 'en_US'
set splitbelow
set splitright
set guifont=JetBrainsMono\ Nerd\ Font:h10
set signcolumn=yes
autocmd FileType c,cpp,h,hpp,cs setlocal commentstring=//\ %s
autocmd FileType c,cpp,cs,hpp,h setlocal formatprg=clang-format
autocmd VimEnter * :clearjumps
" Even out windows
autocmd VimEnter * wincmd =
map <A-j> :cn<CR>
map <A-k> :cp<CR>

set completeopt=menu,menuone,noselect
set shortmess+=c   " Shut off completion messages
set belloff+=ctrlg " Add only if Vim beeps during completion
let g:AutoPairsMapSpace = 0

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
nnoremap <leader>/ <cmd>nohlsearch<CR> 

nmap <silent> <A-h> :lua require('smart-splits').resize_left()<CR>
" nmap <silent> <A-j> :lua require('smart-splits').resize_down()<CR>
" nmap <silent> <A-k> :lua require('smart-splits').resize_up()<CR>
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

set encoding=utf-8

set mouse=a
set hidden
set cursorline
set number
set relativenumber
set backspace=indent,eol,start

map <silent> W <Plug>CamelCaseMotion_w
map <silent> B <Plug>CamelCaseMotion_b
map <silent> E <Plug>CamelCaseMotion_e
map <silent> ge <Plug>CamelCaseMotion_ge
sunmap W
sunmap B
sunmap E
sunmap ge

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
imap <silent><expr> <C-f> '<Plug>luasnip-expand-or-jump'
function! GrepWordUnderCursor()
    execute 'Telescope grep_string search='.expand("<cword>")
endfunction
nnoremap <leader>fg :call GrepWordUnderCursor()<CR>
nnoremap <leader>fp <cmd>lua require'telescope'.extensions.project.project{}<cr>

let g:indentLine_color_gui = '#262626'
let g:indentLine_leadingSpaceEnabled = 0

autocmd VimLeave * wshada!

highlight! EasyMotionTarget guibg=NONE guifg=#b36a5d
highlight! EasyMotionTarget2First guibg=NONE guifg=#cea046
highlight! EasyMotionTarget2Second guibg=NONE guifg=#cea046
hi link EasyMotionShade  Comment
hi Cursor guifg=white guibg=white
hi Cursor2 guifg=white guibg=white
nnoremap <Esc> <C-\><C-n>
nnoremap <silent> <F1> <cmd>w <bar> Make f1<cr><cr>
nnoremap <silent> <F2> <cmd>w <bar> Make f2<cr><cr>
nnoremap <silent> <F3> <cmd>w <bar> Make f3<cr><cr>
nnoremap <silent> <F4> <cmd>w <bar> Make f4<cr><cr>
nnoremap <silent> <F5> <cmd>w <bar> Make f5<cr><cr>
nnoremap <silent> <F6> <cmd>w <bar> Make f6<cr><cr>
nnoremap <silent> <F7> <cmd>w <bar> Make f7<cr><cr>
nnoremap <silent> <F8> <cmd>w <bar> Make f8<cr><cr>
nnoremap <silent> <F9> <cmd>w <bar> Make f9<cr><cr>
nnoremap <silent> <F10> <cmd>w <bar> Make f10<cr><cr>
nnoremap <silent> <F11> <cmd>w <bar> Make f11<cr><cr>
nnoremap <silent> <F12> <cmd>w <bar> Make f12<cr><cr>

set errorformat=%f:%l:%c:\ %trror:\ %m
" Inactive tab highlight
hi! NormalNC guibg=#000000
hi! SignatureMarkText guifg=#bf9d73

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
nnoremap <silent> <leader>qt :call ToggleQuickFix()<cr>
command! ClearQuickfixList cexpr []
nmap <leader>qc :ClearQuickfixList<cr>
" NOTE(sqdrck): Cursor
highlight Cursor guifg=black guibg=steelblue
highlight iCursor guifg=black guibg=steelblue
set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver100-iCursor
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkwait10

autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

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
