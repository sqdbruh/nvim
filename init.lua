-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.opt.swapfile = false

require("lazy").setup({
  spec = {
  { "kalvinpearce/ShaderHighlight" },    -- можно потом повесить на ft={'glsl','shader'} и др.

  { "ray-x/go.nvim",                     lazy = false, dependencies = {
      "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter", "neovim/nvim-lspconfig"
  }},

  {
      "mason-org/mason.nvim",
      opts = {}
  },

  { "stevearc/oil.nvim",                 lazy = false },
  { "bkad/CamelCaseMotion" },            -- хоткеи сами по себе, можно оставить лениво

  { "windwp/nvim-autopairs",             lazy = false },
  { "windwp/nvim-ts-autotag",            dependencies = { "nvim-treesitter/nvim-treesitter" } },

  { "nvim-treesitter/nvim-treesitter",   build = ":TSUpdate", lazy = false },

  { "dhruvasagar/vim-markify" },
  { "nvimdev/indentmini.nvim" },

  { "easymotion/vim-easymotion" },
  { "PeterRincker/vim-argumentative" },

  { "svermeulen/vim-cutlass" },
  { "svermeulen/vim-yoink" },
  { "svermeulen/vim-subversive" },

  { "dbakker/vim-paragraph-motion" },
  { "glts/vim-magnum" },
  { "glts/vim-radical" },

  { "nvim-lua/plenary.nvim",             lazy = false },
  {
      'nvim-telescope/telescope.nvim', tag = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim' },
  },
  { "nvim-telescope/telescope-fzf-native.nvim",
      -- твой Windows-friendly билд через CMake:
      build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
      dependencies = { "nvim-telescope/telescope.nvim" }
  },

  { "EtiamNullam/deferred-clipboard.nvim"},
  { "tpope/vim-abolish" },
  { "tpope/vim-dispatch" },
  { "tpope/vim-speeddating" },
  { "tpope/vim-repeat" },
  { "tpope/vim-obsession" },
  { "tpope/vim-surround" },
  { "tpope/vim-unimpaired" },
  { "tpope/vim-fugitive" },
  { "tpope/vim-commentary" },

  { "ellisonleao/gruvbox.nvim" },
  { "rafamadriz/friendly-snippets",      lazy = false },
  { "ahmedkhalf/project.nvim",           lazy = false },

  -- ВНИМАНИЕ: BurntSushi/ripgrep — это не neovim-плагин. Установи ripgrep системно (scoop/choco/pacman/apt).
  -- { "BurntSushi/ripgrep" },

  { "mrjones2014/smart-splits.nvim" },
  { "folke/todo-comments.nvim",          lazy = false, dependencies = { "nvim-lua/plenary.nvim" } },

  { "neovim/nvim-lspconfig",             lazy = false },  -- нужен util + серверные конфиги
  -- { "ray-x/lsp_signature.nvim",          lazy = false },

  { "hrsh7th/cmp-nvim-lsp",              lazy = false },
  { "hrsh7th/cmp-buffer",                lazy = false },
  { "hrsh7th/cmp-path",                  lazy = false },
  { "hrsh7th/cmp-cmdline",               lazy = false },
  { "hrsh7th/nvim-cmp",                  lazy = false },
  { "L3MON4D3/LuaSnip",                  lazy = false },
  { "saadparwaiz1/cmp_luasnip",          lazy = false },
  { "hrsh7th/cmp-calc",                  lazy = false },
  {
      "seblyng/roslyn.nvim",
      opts = {
          broad_search = false,   
          lock_target  = true,   
          filewatching = "off",
          settings = {
              ["csharp|inlay_hints"] = {
                  csharp_enable_inlay_hints_for_implicit_object_creation = false,
                  csharp_enable_inlay_hints_for_implicit_variable_types  = false,
                  csharp_enable_inlay_hints_for_lambda_parameter_types   = false,
                  csharp_enable_inlay_hints_for_types                    = false,
                  dotnet_enable_inlay_hints_for_parameters               = false,
              },
              ["csharp|background_analysis"] = {
                  ["background_analysis.dotnet_analyzer_diagnostics_scope"] = "none",
                  ["background_analysis.dotnet_compiler_diagnostics_scope"] = "none",
              },
              ["csharp|code_lens"] = {
                  dotnet_enable_references_code_lens = false,
                  dotnet_enable_tests_code_lens      = false,
              },
              ["csharp|symbol_search"] = { dotnet_search_reference_assemblies = false },
          },
      },
  },

  { "nvim-pack/nvim-spectre",            dependencies = { "nvim-lua/plenary.nvim" } },
  { "nvim-tree/nvim-web-devicons",       lazy = false },
  },
  install = { colorscheme = { "habamax" } },
  checker = { enabled = true },
})

require('deferred-clipboard').setup {
  lazy = true,
}

pcall(function() vim.loader.enable() end)  
require("indentmini").setup()
require('nvim-treesitter.configs').setup({
  highlight = {
    enable = false,
    additional_vim_regex_highlighting = false,
  },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "json", "jsonc" },
  callback = function()
    vim.wo.conceallevel = 0
  end,
})

require('luasnip-settings')
require('telescope-settings')        
require('todo-comments-settings')
require('legacy_port')      

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    -- чтобы не навешивать повторно
    if vim.b[event.buf].my_lsp_keymaps then return end
    vim.b[event.buf].my_lsp_keymaps = true

    local buf = event.buf
    local map = function(mode, lhs, rhs)
      vim.keymap.set(mode, lhs, rhs, { buffer = buf, silent = true })
    end

    map('n', 'gD', vim.lsp.buf.declaration)
    map('n', 'gd', vim.lsp.buf.definition)
    map('n', 'K',  vim.lsp.buf.hover)
    map('n', 'gi', vim.lsp.buf.implementation)
    map('n', '<leader>D',  vim.lsp.buf.type_definition)
    map('n', '<leader>rn', vim.lsp.buf.rename)
    map('n', '<leader>ca', vim.lsp.buf.code_action)
    map('n', 'gr', vim.lsp.buf.references)
    map('n', '<leader>cf', function() vim.lsp.buf.format({ async = true }) end)
  end,
})

local api = vim.api

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

require('nvim-autopairs').setup {}
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

require('nvim-web-devicons').setup()
require('oil').setup()
vim.keymap.set('n', '<kMinus>', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

-- require('lsp_signature').setup({
--   bind = true,
--   floating_window = true,  
--   handler_opts = { border = "none" },
--   doc_lines = 0,            
--   hint_enable = false,      
-- })

local capabilities = require('cmp_nvim_lsp').default_capabilities()
require('go').setup()
vim.lsp.config('gopls', {
  capabilities = capabilities,
  filetypes = { "go", "gomod" },
  settings = { gopls = { analyses = { unusedparams = true, nilness = true }, staticcheck = true } },
})

vim.lsp.enable('clangd') 
vim.lsp.enable('gopls')

-- === Диагностики: новый toggle без deprecated ===
vim.g.lsp_diagnostics_enabled = false  -- по-умолчанию OFF (как у вас)
api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    if not vim.g.lsp_diagnostics_enabled then
      vim.diagnostic.enable(false, { bufnr = args.buf })  -- НОВЫЙ API
    end
  end,
})

local function ToggleDiagnostics()
  vim.g.lsp_diagnostics_enabled = not vim.g.lsp_diagnostics_enabled
  vim.diagnostic.enable(vim.g.lsp_diagnostics_enabled) -- глобально ВКЛ/ВЫКЛ (новый API)
end
api.nvim_create_user_command('ToggleDiagnostics', ToggleDiagnostics, {})
vim.keymap.set('n', '<leader>d', ToggleDiagnostics, { silent = true, desc = "Toggle LSP diagnostics" })

vim.keymap.set('n', 'gh', ':ClangdSwitchSourceHeader<CR>', { noremap=true, silent=true, nowait=true })
vim.keymap.set('n', '<leader>qd', function()
  vim.diagnostic.setqflist({open = false, severity = vim.diagnostic.severity.ERROR})
end, { noremap=true, silent=true, nowait=true })

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<A-k>', function() vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR}) end, {silent=true})
vim.keymap.set('n', '<A-l>', function() vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR}) end, {silent=true})
vim.keymap.set('n', '<C-k>', '<cmd>Cnext<CR>', { noremap=true, silent=true, nowait=true })
vim.keymap.set('n', '<C-l>', '<cmd>Cprev<CR>', { noremap=true, silent=true, nowait=true })

vim.cmd.highlight('IndentLine guifg=#212121')
vim.cmd.highlight('IndentLineCurrent guifg=#333333')
vim.cmd("highlight DiagnosticError guifg=#e65c5c")
vim.cmd("highlight DiagnosticWarn  guifg=#ffb833")
