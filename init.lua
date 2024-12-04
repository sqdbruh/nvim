local api, if_nil = vim.api, vim.F.if_nil
require('plugins')
require('luasnip-settings')
require('telescope-settings')
require('todo-comments-settings')
local pid = vim.fn.getpid()
local vim_path = vim.fn.stdpath('config')
local legacy_vim_path = vim_path .. '/legacy.vim'
-- Use vim.cmd to source the legacy.vim file
vim.cmd('source ' .. legacy_vim_path)

-- Set up nvim-cmp.
local cmp = require'cmp'

cmp.setup({
        snippet = {
            -- REQUIRED - you must specify a snippet engine
            expand = function(args)
                -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            end,
        },
        window = {
            -- completion = cmp.config.window.bordered(),
            -- documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
            }),
        sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'calc' },
                -- { name = 'vsnip' }, -- For vsnip users.
                { name = 'luasnip' }, -- For luasnip users.
                -- { name = 'ultisnips' }, -- For ultisnips users.
                -- { name = 'snippy' }, -- For snippy users.
            }, {
                { name = 'buffer' },
            })
    })

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
                { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
            }, {
                { name = 'buffer' },
            })
    })

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer' }
        }
    })


-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
                { name = 'path' }
            }, {
                { name = 'cmdline' }
            })
    })

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require "lsp_signature".setup({
        hint_prefix = "",
        floating_window = false,
        bind = true,
    })

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
    )

require'nvim-web-devicons'.setup()


require("oil").setup()
vim.keymap.set("n", "<kMinus>", "<CMD>Oil<CR>", { desc = "Open parent directory" })
require("nvim-autopairs").setup {}

vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', {
        desc = "Toggle Spectre"
    })
vim.keymap.set('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
        desc = "Search current word"
    })
vim.keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
        desc = "Search current word"
    })
vim.keymap.set('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
        desc = "Search on current file"
    })

local diagnostics_visible = true

function ToggleDiagnostics()
    diagnostics_visible = not diagnostics_visible
    if diagnostics_visible then
        vim.diagnostic.show(nil, 0)
        vim.diagnostic.config({
                virtual_text = true,
                signs = true,
                underline = true,
                update_in_insert = false,
                severity_sort = false,
            })
    else
        vim.diagnostic.hide(nil, 0)
        vim.diagnostic.config({
                virtual_text = false,
                signs = false,
                underline = false,
                update_in_insert = false,
                severity_sort = false,
            })
    end
end

vim.api.nvim_create_user_command('ToggleDiagnostics', ToggleDiagnostics, {})
ToggleDiagnostics()

local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', 'gh', ':ClangdSwitchSourceHeader<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>d', ':ToggleDiagnostics<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>qd', '<cmd>lua vim.diagnostic.setqflist({open = false, severity = vim.diagnostic.severity.ERROR})<CR>', opts)

-- -- NOTE(sqd): Keep cursor in the same position while yank-pasting
-- vim.keymap.set("n", "p", function()
--     local row, col = unpack(vim.api.nvim_win_get_cursor(0))
--     vim.cmd('put')
--     vim.api.nvim_win_set_cursor(0, { row + 1, col })
--   end)

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, opts)

local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>cf', '<cmd>lua vim.lsp.buf.format()<CR>', opts)
end

require('lspconfig')['clangd'].setup {
    on_attach = on_attach,
    capabilities = capabilities
}

require'lspconfig'.lua_ls.setup {
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT'
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME
              -- "${3rd}/luv/library"
              -- "${3rd}/busted/library",
            }
            -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
            -- library = vim.api.nvim_get_runtime_file("", true)
          }
        }
      })

      client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    end
    return true
  end
}

local config = {
  handlers = {
    ["textDocument/definition"] = require('csharpls_extended').handler,
    ["textDocument/typeDefinition"] = require('csharpls_extended').handler,
},
on_attach = on_attach,
capabilities = capabilities,
}

require'lspconfig'.csharp_ls.setup(config)

vim.cmd("highlight DiagnosticError guifg=#e65c5c")
vim.cmd("highlight DiagnosticWarn guifg=#ffb833")

-- Autocommand that updates the quickfix list with LSP diagnostics
-- vim.api.nvim_create_autocmd({"DiagnosticChanged"}, {
--     pattern = "*",
--     callback = function()
--         -- Update the quickfix list with current diagnostics
--         vim.diagnostic.setqflist({open = false, severity = vim.diagnostic.severity.ERROR})
--     end,
-- })

function GoToQuickfixItem(opts, direction)
    -- Ensure opts is a table, defaulting to an empty table if not provided
    opts = opts or {}
    -- Default float to true if it's nil; no need for if_nil with this pattern
    local float = opts.float
    if float == nil then float = true end

    -- Determine the command based on the direction
    local command = direction == "next" and 'cn' or 'cp'

    -- Try to execute the command and capture if it fails due to no more items
    local status, err = pcall(vim.cmd, command)
    if not status then
        print("No more items.") -- Or handle the error however you prefer
        return
    end

    -- Only proceed with opening the float if desired
    if float then
        local float_opts = type(float) == 'table' and float or {}
        vim.schedule(function()
            vim.diagnostic.open_float(nil, vim.tbl_extend('keep', float_opts, {
                scope = 'cursor',
                focus = false,
            }))
        end)
    end
end

vim.api.nvim_set_keymap('n', '<A-k>', ':lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<A-l>', ':lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-k>', '<cmd>Cnext<CR>', opts)
vim.api.nvim_set_keymap('n', '<C-l>', '<cmd>Cprev<CR>', opts)
require("project_nvim").setup
{
    manual_mode = true,

}

vim.lsp.handlers["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
  if not err and result and result.uri then
    -- Extract the file path from the URI
    local uri = result.uri
    local bufnr = vim.uri_to_bufnr(uri)

    -- Check if the file name is generated.h
    if string.find(vim.api.nvim_buf_get_name(bufnr), "generated.h$") then
      -- Do not process diagnostics for generated.h
      return
    end
  end

  -- Process diagnostics normally for other files
  vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, config)
end

vim.api.nvim_set_keymap('n', '<leader>md', ':%s/\\r//g<CR>', { noremap = true, silent = true })

function ShowSemanticTokens()
  vim.lsp.buf.semantic_tokens()
end
