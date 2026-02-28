-- lua/legacy_port.lua
local api, cmd, fn = vim.api, vim.cmd, vim.fn
local map = vim.keymap.set

-- ====== БАЗОВЫЕ НАСТРОЙКИ/ОКРУЖЕНИЕ =======================================
pcall(cmd, "colorscheme handmade1")

-- filetype/syntax/lang
cmd([[
  filetype plugin on
  filetype plugin indent on
  filetype indent on
  syntax on
]])
vim.o.langmenu = 'en_US'
vim.env.LANG = 'en_US'

-- GUI font (если GUI; в терминале шрифт настраивается в эмуляторе)
vim.opt.guifont = "JetBrainsMono Nerd Font:h10"

-- Опции (идём по legacy, учитывая, что последнее слово за более поздней установкой)
local o = vim.opt
o.foldlevelstart = 99
o.hidden = true           -- в legacy сначала nohidden, потом hidden → оставляем hidden
o.autoread = true
o.tabstop = 4
o.shiftwidth = 4
o.smarttab = true
o.expandtab = true
o.smartindent = true
o.ignorecase = true
o.smartcase = true
o.pumheight = 8
o.grepprg = "rg --vimgrep --no-heading --smart-case"
o.grepformat = "%f:%l:%c:%m"
o.statusline = "%f %y %h%m%r%=%-14.(%l,%c%V%) %P"
o.termguicolors = true
o.splitbelow = true
o.splitright = true
o.signcolumn = "yes"
o.completeopt = { "menu", "menuone", "noselect" }
o.shortmess:append("c")
cmd("set belloff+=ctrlg")
vim.g.AutoPairsMapSpace = 0
vim.g.terminator_split_location = 'vertical belowright'
o.encoding = "utf-8"
o.fileencoding = "utf-8"
o.mouse = "a"
o.cursorline = true
o.number = true
o.relativenumber = true
o.backspace = { "indent", "eol", "start" }

map('n', '<SPACE>', '<Nop>', { noremap = true })

-- ====== АВТОКОМАНДЫ И РАЗНОЕ ==============================================
api.nvim_create_autocmd("FileType", {
  pattern = { "c","cpp","h","hpp","cs","frag","vert","glsl" },
  callback = function() vim.opt_local.commentstring = "// %s" end,
})
api.nvim_create_autocmd("FileType", {
  pattern = { "c","cpp","hpp","h" },
  callback = function() vim.opt_local.formatprg = "clang-format" end,
})
api.nvim_create_autocmd("FileType", {
  pattern = { "odin" },
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end,
})

api.nvim_create_autocmd("VimEnter", {
  callback = function()
    cmd("clearjumps")
    cmd("wincmd =")
  end
})

-- Закрывать preview-попапы, если меню автодопа не открыто
api.nvim_create_autocmd("CursorMovedI", {
  callback = function() if fn.pumvisible() == 0 then pcall(cmd, "silent! pclose") end end
})
api.nvim_create_autocmd("InsertLeave", {
  callback = function() if fn.pumvisible() == 0 then pcall(cmd, "silent! pclose") end end
})

-- сохранять shada на выход
api.nvim_create_autocmd("VimLeave", { command = "wshada!" })

-- форматопции (убрать c r o)
api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*",
  callback = function() vim.opt_local.formatoptions:remove({ "c","r","o" }) end
})

-- Цвета EasyMotion
cmd([[
  highlight! EasyMotionTarget guibg=NONE guifg=#b36a5d
  highlight! EasyMotionTarget2First guibg=NONE guifg=#cea046
  highlight! EasyMotionTarget2Second guibg=NONE guifg=#cea046
  hi link EasyMotionShade Comment
]])

-- Курсоры (финальные значения из legacy)
cmd([[
  highlight Cursor  guifg=black guibg=steelblue
  highlight iCursor guifg=black guibg=steelblue
]])
o.guicursor = table.concat({
  "n-v-c:block-Cursor",
  "i:ver100-iCursor",
  "n-v-c:blinkon0",
  "i:blinkwait10",
}, ",")

-- errorformat (clang без notes)
o.errorformat = [[%E%f:%l:%c:\ error:\ %m,%W%f:%l:%c:\ warning:\ %m]]

-- ====== ФУНКЦИИ И КОМАНДЫ ИЗ LEGACY =======================================
-- Grep текущего слова через Telescope
local function GrepWordUnderCursor()
  local ok, t = pcall(require, 'telescope.builtin')
  if ok then t.grep_string({ search = fn.expand("<cword>") }) end
end

-- Quickfix: safe next/prev, toggle, clear
local function SafeCnext()
  if #fn.getqflist() == 0 then print("Quickfix list is empty.") return end
  if not pcall(cmd, "cnext") then cmd("cfirst") end
end
local function SafeCprev()
  if #fn.getqflist() == 0 then print("Quickfix list is empty.") return end
  if not pcall(cmd, "cprev") then cmd("clast") end
end
api.nvim_create_user_command("Cnext", SafeCnext, {})
api.nvim_create_user_command("Cprev", SafeCprev, {})
local function ToggleQuickFix()
  local open = false
  for _, w in ipairs(fn.getwininfo()) do if w.quickfix == 1 then open = true break end end
  if open then cmd("cclose") else cmd("copen") end
end
api.nvim_create_user_command("ClearQuickfixList", function() cmd("cexpr []") end, {})

-- «умный» i/a/I/A на пустых строках
local function IndentWith(key)
  return function()
    if #api.nvim_get_current_line() == 0 then
      return vim.api.nvim_replace_termcodes([["_cc]], true, false, true)
    else
      return key
    end
  end
end


-- Smart i/a/I/A на пустых строках (из legacy)
map('n', 'i', IndentWith('i'), { expr = true })
map('n', 'a', IndentWith('a'), { expr = true })
map('n', 'I', IndentWith('I'), { expr = true })
map('n', 'A', IndentWith('A'), { expr = true })

-- ====== МАППИНГИ (1:1) =====================================================
-- j k l ; движение вместо hjkl (во всех обычных режимах: n/x/s/o)
for _, m in ipairs({ 'n','x','s','o' }) do
  map(m, 'h', ';', { noremap = true, silent = true })
  map(m, 'j', 'h', { noremap = true, silent = true })
  map(m, 'k', 'j', { noremap = true, silent = true })
  map(m, 'l', 'k', { noremap = true, silent = true })
  map(m, ';', 'l', { noremap = true, silent = true })
end

-- Alt-навигация/quickfix
map('', '<A-j>', ':cn<CR>')  -- legacy: "map", значит n/x/s/o
map('', '<A-k>', ':cp<CR>')
map('n', '<silent> <A-h>', function() require('smart-splits').resize_left() end)
map('n', '<silent> <A-l>', function() require('smart-splits').resize_right() end)

-- Поиск/очистка
map('n', '<leader>/', '<cmd>nohlsearch<CR>', { silent = true })

vim.g.yoinkIncludeDeleteOperations = 1

map('n', 's',  '<plug>(SubversiveSubstitute)', { remap = true })
map('n', 'ss', '<plug>(SubversiveSubstituteLine)', { remap = true })
map('n', 'S',  '<plug>(SubversiveSubstituteToEndOfLine)', { remap = true })
map('x', 's',  '<plug>(SubversiveSubstitute)', { remap = true })
map('n', '<leader>s',  '<plug>(SubversiveSubstituteRange)', { remap = true })
map('x', '<leader>s',  '<plug>(SubversiveSubstituteRange)', { remap = true })
map('n', '<leader>SS', '<plug>(SubversiveSubstituteWordRange)', { remap = true })

map('n', '<c-n>', '<plug>(YoinkPostPasteSwapBack)', { remap = true })
map('n', '<c-p>', '<plug>(YoinkPostPasteSwapForward)', { remap = true })
-- NB: чтобы не ловить E21 в немодифицируемых буферах, можно поставить expr-обёртку,
-- но здесь повторяем 1:1:
map('n', 'p',  '<plug>(YoinkPaste_p)', { remap = true })
map('n', 'P',  '<plug>(YoinkPaste_P)', { remap = true })
map('n', 'gp', '<plug>(YoinkPaste_gp)', { remap = true })
map('n', 'gP', '<plug>(YoinkPaste_gP)', { remap = true })
map('n', '[y', '<plug>(YoinkRotateBack)', { remap = true })
map('n', ']y', '<plug>(YoinkRotateForward)', { remap = true })

-- Argumentative
map('n', '(', '<plug>Argumentative_MoveLeft', { remap = true })
map('n', ')', '<plug>Argumentative_MoveRight', { remap = true })
map('x', 'ia', '<plug>Argumentative_InnerTextObject', { remap = true })
map('x', 'aa', '<plug>Argumentative_OuterTextObject', { remap = true })
map('o', 'ia', '<plug>Argumentative_OpPendingInnerTextObject', { remap = true })

-- vim.g.yoinkPersistSystemClipboard = 0
-- vim.g.yoinkSyncSystemClipboardOnFocus = 0

-- vim.api.nvim_create_autocmd({ "VimEnter", "FocusGained" }, {
--   callback = function()
--     -- pcall, чтобы не падать, если провайдера нет/пусто
--     pcall(vim.fn.getreg, '+')
--     pcall(vim.fn.getreg, '*')
--   end,
-- })

-- vim.keymap.set('n', 'p', 'p', { noremap = true })
-- vim.keymap.set('n', 'P', 'P', { noremap = true })
-- vim.keymap.set('n', 'gp', '<plug>(YoinkPaste_gp)', { remap = true })
-- vim.keymap.set('n', 'gP', '<plug>(YoinkPaste_gP)', { remap = true })
-- vim.keymap.set('n', '[y', '<plug>(YoinkRotateBack)',    { remap = true })
-- vim.keymap.set('n', ']y', '<plug>(YoinkRotateForward)', { remap = true })
-- vim.keymap.set('n', '<c-n>', '<plug>(YoinkPostPasteSwapBack)',    { remap = true })
-- vim.keymap.set('n', '<c-p>', '<plug>(YoinkPostPasteSwapForward)', { remap = true })

-- vim.keymap.set({'n','v'}, '<leader>y', '"+y', { desc = 'Yank to system clipboard' })
-- vim.keymap.set('n',        '<leader>Y', '"+Y', { desc = 'Yank line to system clipboard' })
-- vim.keymap.set({'n','v'}, '<leader>p', '"+p', { desc = 'Paste from system clipboard' })
-- vim.keymap.set('n',        '<leader>P', '"+P', { desc = 'Paste before from system clipboard' })

-- -- Subversive (s)
-- vim.keymap.set('n', 's',  '<plug>(SubversiveSubstitute)',                 { remap = true, desc = 'Subversive: substitute' })
-- vim.keymap.set('n', 'ss', '<plug>(SubversiveSubstituteLine)',             { remap = true, desc = 'Subversive: substitute line' })
-- vim.keymap.set('n', 'S',  '<plug>(SubversiveSubstituteToEndOfLine)',      { remap = true, desc = 'Subversive: substitute to EOL' })
-- vim.keymap.set('x', 's',  '<plug>(SubversiveSubstitute)',                 { remap = true, desc = 'Subversive: substitute (visual)' })
-- vim.keymap.set('n', '<leader>s',  '"+<plug>(SubversiveSubstituteRange)',      { remap = true, desc = 'Subversive: substitute range from system clipboard' })
-- vim.keymap.set('x', '<leader>s',  '"+<plug>(SubversiveSubstituteRange)',      { remap = true, desc = 'Subversive: substitute range (visual) from system clipboard' })
-- vim.keymap.set('n', '<leader>SS', '"+<plug>(SubversiveSubstituteWordRange)',  { remap = true, desc = 'Subversive: substitute word range from system clipboard' })
-- vim.keymap.set('n', '<leader>ss', '"+<plug>(SubversiveSubstituteLine)',  { remap = true, desc = 'Subversive: substitute word range from system clipboard' })

map('o', 'aa', '<plug>Argumentative_OpPendingOuterTextObject', { remap = true })

-- Переопределения x/X/xx
map('n', 'x',  'd',  { noremap = true })
map('x', 'x',  'd',  { noremap = true })
map('n', 'xx', 'dd', { noremap = true })
map('n', 'X',  'D',  { noremap = true })

-- EasyMotion "/" (в тех же режимах, что делал :map) + отдельный omap
for _, m in ipairs({'n','x','s'}) do
  map(m, '/', '<Plug>(easymotion-sn)', { remap = true })
end
map('o', '/', '<Plug>(easymotion-tn)', { remap = true })

-- nmap xX/dD/cC/yY
map('n', 'xX', '^xg_', { noremap = true })
map('n', 'dD', '^dg_', { noremap = true })
map('n', 'cC', '^cg_', { noremap = true })
map('n', 'yY', '^yg_', { noremap = true })

-- CamelCaseMotion (и снятие в select-режиме)
map('', 'W',  '<Plug>CamelCaseMotion_w',  { remap = true, silent = true })
map('', 'B',  '<Plug>CamelCaseMotion_b',  { remap = true, silent = true })
map('', 'E',  '<Plug>CamelCaseMotion_e',  { remap = true, silent = true })
map('', 'ge', '<Plug>CamelCaseMotion_ge', { remap = true, silent = true })
pcall(vim.keymap.del, 's', 'W')
pcall(vim.keymap.del, 's', 'B')
pcall(vim.keymap.del, 's', 'E')
pcall(vim.keymap.del, 's', 'ge')

-- Сплиты/тм
map('n', '<Leader>v', '<cmd>vsplit<cr>', { noremap = true })
map('n', '<Leader>h', '<cmd>split<cr>',  { noremap = true })

-- Telescope
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>',   { noremap = true })
map('n', '<leader>fl', '<cmd>Telescope live_grep<cr>',    { noremap = true })
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>',      { noremap = true })
map('n', '<leader>ft', '<cmd>Telescope tags<cr>',         { noremap = true })
map('n', '<leader>fq', '<cmd>Telescope quickfix<cr>',     { noremap = true })
map('n', '<leader>fh', '<cmd>Telescope harpoon marks<cr>',{ noremap = true }) -- если harpoon подключён
map('n', '<leader>fr', '<cmd>Telescope resume<cr>',       { noremap = true })
map('n', '<leader>fm', '<cmd>Telescope marks<cr>',        { noremap = true })
map('n', '<leader>fg', GrepWordUnderCursor,               { noremap = true })
map('n', '<leader>fp', '<cmd>Telescope projects<cr>',     { noremap = true })

-- LuaSnip хоткеи из legacy
map('i', '<C-f>', function()
  local ls = require('luasnip')
  if ls.expand_or_jumpable() then ls.expand_or_jump()
  else vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-f>', true,false,true), 'n', true) end
end, { silent = true })

map('s', '<C-f>', function() require('luasnip').jump(1) end, { silent = true })
map({'i','s'}, '<C-E>', function()
  local ls = require('luasnip')
  if ls.choice_active() then return '<Plug>luasnip-next-choice' end
  return '<C-E>'
end, { expr = true, silent = true, remap = true })

-- Прочие хоткеи
map('n', '<leader>fg', GrepWordUnderCursor, { noremap = true })
map('n', '<leader>qt', ToggleQuickFix, { noremap = true, silent = true })
map('n', '<leader>qc', '<cmd>ClearQuickfixList<cr>', { noremap = true })
map('n', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })

-- F1..F12 → :w | Make fX
for i = 1, 12 do
  map('n', ('<F%d>'):format(i), (':w | Make f%d<CR><CR>'):format(i), { noremap = true, silent = true })
end

-- Marks/подсказки/курсор и т.п.
map('n', '<leader>dam', ':delm! | delm A-Z0-9 | SignatureRefresh<CR>', { noremap = true, silent = true })
map('n', 'dam',         ':delm! | SignatureRefresh<CR>',               { noremap = true, silent = true })
map('',  'K', '`]', { silent = true })  -- как в legacy: map <silent> K `]
map('',  'L', '`[', { silent = true })

-- Прокрутка/поиск с раскрытием фолдов
map('n', '<C-d>', '<C-d>', { noremap = true })
map('n', '<C-u>', '<C-u>zz', { noremap = true })
map('n', 'n', 'nzv', { noremap = true })
map('n', 'N', 'Nzv', { noremap = true })

-- Переключение на предыдущие буферы
map('n', '<leader>fd',  ':e#<CR>',  { noremap = true })
map('n', '<leader>2fd', ':e#2<CR>', { noremap = true })
map('n', '<leader>3fd', ':e#3<CR>', { noremap = true })
map('n', '<leader>4fd', ':e#4<CR>', { noremap = true })
map('n', '<leader>5fd', ':e#5<CR>', { noremap = true })
map('n', '<leader>6fd', ':e#6<CR>', { noremap = true })
map('n', '<leader>7fd', ':e#7<CR>', { noremap = true })
map('n', '<leader>8fd', ':e#8<CR>', { noremap = true })
map('n', '<leader>9fd', ':e#9<CR>', { noremap = true })

-- Insert: Home/End
map('i', '<Home>', '<C-o>^', { silent = true })
map('',  '<Home>', '^',      { silent = true })
map('i', '<End>',  '<C-o>$', { silent = true })
map('',  '<End>',  '$',      { silent = true })

-- Вставить пустую строку по <leader><CR>
map('', '<leader><CR>', 'i<CR><ESC>', { silent = true })

-- Окна по лидеру (j k l ;)
map('n', '<Leader>j', '<C-w>h', { noremap = true })
map('n', '<Leader>k', '<C-w>j', { noremap = true })
map('n', '<Leader>l', '<C-w>k', { noremap = true })
map('n', '<Leader>;', '<C-w>l', { noremap = true })

-- Показать группу подсветки под курсором (F10)
map('n', '<F10>', [[<cmd>echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' .
  \ synIDattr(synID(line("."),col("."),0),"name") . "> lo<" .
  \ synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>]],
  { noremap = true })

local yank_grp = api.nvim_create_augroup("YankHighlight", { clear = true })
api.nvim_create_autocmd("TextYankPost", {
  group = yank_grp,
  callback = function()
    vim.highlight.on_yank({
      higroup = "YankFlash", -- своё имя группы (см. ниже)
      timeout = 100,         -- длительность в мс
      on_visual = true,      -- подсвечивать и визуальные yank'и
    })
  end,
})
-- Настрой цвет подсветки (пример: мягкая заливка, без смешивания)
cmd([[highlight YankFlash gui=nocombine guibg=#3c4150]])

