-- init.lua (верх файла)
pcall(function() vim.loader.enable() end)  -- быстрый загрузчик Lua-модулей

local api = vim.api

require('plugins')                   -- Оставляем ваш менеджер плагинов
require('luasnip-settings')
require('telescope-settings')        -- (ниже приложу фикс)
require('todo-comments-settings')

-- Перенесённый из Vimscript "legacy" в Lua:
require('legacy_port')               -- НОВОЕ: вместо :source legacy.vim

-- === nvim-cmp (оставил вашу настройку, добавил совместимость с LuaSnip на <C-f>) ===
local cmp = require('cmp')
local function small_current_buf(max_lines) return vim.api.nvim_buf_line_count(0) < max_lines end
cmp.setup({
  completion  = { keyword_length = 2 },
  performance = { debounce = 80, throttle = 30, fetching_timeout = 150, max_view_entries = 40 },
  formatting  = {
    fields = { 'abbr', 'kind', 'menu' },
    format = function(_, item)
      local MAX = 50
      if #item.abbr > MAX then item.abbr = item.abbr:sub(1, MAX - 1) .. '…' end
      if item.menu and #item.menu > MAX then item.menu = item.menu:sub(1, MAX - 1) .. '…' end
      return item
    end,
  },
  preselect = cmp.PreselectMode.None,
  snippet = { expand = function(args) require('luasnip').lsp_expand(args.body) end },
  window = { documentation = { max_width = 60, border = 'none' } },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>']     = cmp.mapping.scroll_docs(-4),
    -- ВАЖНО: <C-f> теперь сначала пробует LuaSnip, иначе скроллит доки как раньше
    ['<C-f>']     = function(fallback)
      local ls = require('luasnip')
      if ls.expand_or_jumpable() then ls.expand_or_jump() else cmp.mapping.scroll_docs(4)() end
    end,
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>']     = cmp.mapping.abort(),
  }),
  sources = cmp.config.sources({
      { name = 'nvim_lsp', max_item_count = 40 },
      { name = 'calc' },
      { name = 'luasnip' },
    }, {
      { name = 'buffer', option = {
          keyword_length = 3,
          get_bufnrs = function() return small_current_buf(20000) and {0} or {} end,
      }},
    }),
})
cmp.setup.filetype('gitcommit', { sources = cmp.config.sources({ { name = 'git' } }, { { name = 'buffer' } }) })
cmp.setup.cmdline({ '/', '?' }, { mapping = cmp.mapping.preset.cmdline(), sources = { { name = 'buffer' } } })
cmp.setup.cmdline(':', { mapping = cmp.mapping.preset.cmdline(), sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } }) })

-- autopairs + cmp confirm
require('nvim-autopairs').setup {}
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

require('nvim-web-devicons').setup()
require('oil').setup()
vim.keymap.set('n', '<kMinus>', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

-- ==== LSP: новый API 0.11+ ====
local capabilities = require('cmp_nvim_lsp').default_capabilities()
require('lsp_signature').setup({ hint_prefix = "", floating_window = false, bind = true })

-- Общий on_attach + хоткеи (оставил ваши)
local opts = { noremap = true, silent = true, nowait = true }
local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {buffer=bufnr})
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition,  {buffer=bufnr})
  vim.keymap.set('n', 'K',  vim.lsp.buf.hover,       {buffer=bufnr})
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {buffer=bufnr})
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, {buffer=bufnr})
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {buffer=bufnr})
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {buffer=bufnr})
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, {buffer=bufnr})
  vim.keymap.set('n', '<leader>cf', function() vim.lsp.buf.format({async=true}) end, {buffer=bufnr})
end

-- НОВОЕ: объявляем конфиги, затем включаем
vim.lsp.config('clangd',    { on_attach = on_attach, capabilities = capabilities })
vim.lsp.config('lua_ls',    {
  on_init = function(client)
    local path = client.workspace_folders and client.workspace_folders[1] and client.workspace_folders[1].name or ''
    if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings or {}, {
        Lua = { runtime = { version = 'LuaJIT' }, workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } } }
      })
      client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    end
    return true
  end,
  on_attach = on_attach, capabilities = capabilities,
})
-- vim.lsp.config('csharp_ls', {
--   handlers = {
--     ["textDocument/definition"]     = require('csharpls_extended').handler,
--     ["textDocument/typeDefinition"] = require('csharpls_extended').handler,
--   },
--   on_attach = on_attach, capabilities = capabilities,
-- })

-- === Roslyn (neutral, запускаем через dotnet) ===
local util = require('lspconfig.util')
local fs   = vim.fs or require('vim.fs')
local uv   = vim.uv or vim.loop

-- Путь к твоей neutral-сборке:
local roslyn_exe = "C:/dev/tools/Microsoft.CodeAnalysis.LanguageServer.win-x64.5.3.0-1.25515.6/content/LanguageServer/win-x64/Microsoft.CodeAnalysis.LanguageServer.exe"

-- Проверим, что dotnet доступен
if vim.fn.executable('dotnet') == 0 then
  vim.notify("Roslyn: 'dotnet' не найден в PATH. Установи .NET SDK и перезапусти.", vim.log.levels.ERROR)
end

local roslyn_cmd = {
  roslyn_exe,
  "--logLevel", "Information",
  "--extensionLogDirectory", fs.joinpath(uv.os_tmpdir(), "roslyn_ls", "logs"),
  "--stdio",
}

-- (опц.) приглушаем semantic tokens, как ты хотел
local on_attach_roslyn = function(client, bufnr)
  if client.server_capabilities and client.server_capabilities.semanticTokensProvider then
    client.server_capabilities.semanticTokensProvider = nil
  end
  if type(on_attach) == "function" then on_attach(client, bufnr) end
end

-- ВАЖНО: вместо 'root_markers' используем 'root_dir'
vim.lsp.config('roslyn', {
  cmd         = roslyn_cmd,
  root_dir    = function(fname)
    return util.root_pattern('*.sln', '*.csproj')(fname)
        or util.find_git_ancestor(fname)
        or vim.loop.cwd()
  end,
  on_attach   = on_attach_roslyn,
  capabilities= require('cmp_nvim_lsp').default_capabilities(),

  -- твои настройки производительности 1:1
  settings = {
    ["csharp|background_analysis"] = {
      ["background_analysis.dotnet_analyzer_diagnostics_scope"] = "openFiles",
      ["background_analysis.dotnet_compiler_diagnostics_scope"] = "openFiles",
    },
    ["csharp|code_lens"] = {
      dotnet_enable_references_code_lens = false,
      dotnet_enable_tests_code_lens      = false,
    },
    ["csharp|symbol_search"] = {
      dotnet_search_reference_assemblies = false,
    },
    ["csharp|formatting"] = {
      dotnet_organize_imports_on_format = false,
    },
    ["csharp|inlay_hints"] = {
      csharp_enable_inlay_hints_for_implicit_object_creation = false,
      csharp_enable_inlay_hints_for_implicit_variable_types  = false,
      csharp_enable_inlay_hints_for_lambda_parameter_types   = false,
      csharp_enable_inlay_hints_for_types                    = false,
      dotnet_enable_inlay_hints_for_parameters               = false,
    },
  },
})

vim.lsp.enable('roslyn')

-- включаем сервер
-- vim.lsp.enable('roslyn')

require('go').setup()
vim.lsp.config('gopls', {
  on_attach = on_attach, capabilities = capabilities,
  filetypes = { "go", "gomod" },
  settings = { gopls = { analyses = { unusedparams = true, nilness = true }, staticcheck = true } },
})

-- Включаем конфиги (каждый отдельно, как советует README)
vim.lsp.enable('clangd')      -- см. «Migration instructions» в README lspconfig :contentReference[oaicite:2]{index=2}
vim.lsp.enable('lua_ls')
-- vim.lsp.enable('csharp_ls')
vim.lsp.enable('gopls')

-- === Диагностики: новый toggle без deprecated ===
vim.g.lsp_diagnostics_enabled = false  -- по-умолчанию OFF (как у вас)
api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    -- на каждом подключении LSP глушим диагностики для этого буфера, если глобально выключены
    if not vim.g.lsp_diagnostics_enabled then
      vim.diagnostic.enable(false, { bufnr = args.buf })  -- НОВЫЙ API
    end
  end,
})

local function ToggleDiagnostics()
  vim.g.lsp_diagnostics_enabled = not vim.g.lsp_diagnostics_enabled
  vim.diagnostic.enable(vim.g.lsp_diagnostics_enabled) -- глобально ВКЛ/ВЫКЛ (новый API)
  vim.notify("Diagnostics " .. (vim.g.lsp_diagnostics_enabled and "ON" or "OFF"), vim.log.levels.INFO)
end
api.nvim_create_user_command('ToggleDiagnostics', ToggleDiagnostics, {})
vim.keymap.set('n', '<leader>d', ToggleDiagnostics, { silent = true, desc = "Toggle LSP diagnostics" })

-- Быстрые хоткеи/прочее (оставляю ваши)
vim.keymap.set('n', 'gh', ':ClangdSwitchSourceHeader<CR>', { noremap=true, silent=true, nowait=true })
vim.keymap.set('n', '<leader>qd', function()
  vim.diagnostic.setqflist({open = false, severity = vim.diagnostic.severity.ERROR})
end, { noremap=true, silent=true, nowait=true })

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<A-k>', function() vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR}) end, {silent=true})
vim.keymap.set('n', '<A-l>', function() vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR}) end, {silent=true})
vim.keymap.set('n', '<C-k>', '<cmd>Cnext<CR>', { noremap=true, silent=true, nowait=true })
vim.keymap.set('n', '<C-l>', '<cmd>Cprev<CR>', { noremap=true, silent=true, nowait=true })

-- project.nvim
require("project_nvim").setup{ manual_mode = true }

-- Фильтр «не трогать diagnostics в generated.h» через обёртку над vim.diagnostic.set
do
  local orig_set = vim.diagnostic.set
  vim.diagnostic.set = function(ns, bufnr, diags, opts)
    local name = vim.api.nvim_buf_get_name(bufnr)
    if name:match("generated%.h$") then return end
    return orig_set(ns, bufnr, diags, opts)
  end
end

-- Косметика и анти-спам (оставил ваши)
vim.cmd("highlight DiagnosticError guifg=#e65c5c")
vim.cmd("highlight DiagnosticWarn  guifg=#ffb833")

-- Inlay hints OFF per LSP-буфер
api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local ih = vim.lsp.inlay_hint
    if ih and ih.enable then ih.enable(false, { bufnr = args.buf }) end
  end,
})

-- Тише уведомления/ENETER-prompt
vim.opt.shortmess:append("FIWc")
do
  local ok, notify = pcall(require, "notify")
  if ok then
    notify.setup({ stages = "static", timeout = 1000 })
    vim.notify = notify
  end
end
-- vim.lsp.set_log_level("OFF")
vim.lsp.handlers["window/logMessage"] = function() end
local mt = vim.lsp.protocol.MessageType
local level_map = { [mt.Error] = vim.log.levels.ERROR, [mt.Warning] = vim.log.levels.WARN }
vim.lsp.handlers["window/showMessage"] = function(_, result, ctx)
  if result.type == mt.Info or result.type == mt.Log then return end
  local client = vim.lsp.get_client_by_id(ctx.client_id)
  local title  = client and (client.name .. " (LSP)") or "LSP"
  local ok, n = pcall(require, "notify")
  if ok then
    n(result.message, level_map[result.type] or vim.log.levels.INFO, { title = title, timeout = 3000 })
  else
    vim.schedule(function() vim.api.nvim_echo({{result.message}}, false, {}) end)
  end
end
