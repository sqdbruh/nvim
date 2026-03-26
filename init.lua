-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
--
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set({ "n", "v", "o" }, "<Space>", "<Nop>", { silent = true })

vim.o.swapfile = false

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true
vim.o.guifont = "JetBrainsMono Nerd Font:h10"

-- [[ Setting options ]]
-- Make line numbers default
vim.o.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = "a"

vim.opt.tabstop = 4 -- how many spaces a tab counts for
vim.opt.shiftwidth = 4 -- indent size when using >> << or autoindent

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false
vim.o.cmdheight = 1
vim.o.smartindent = true
vim.o.autoindent = true

-- Enable break indent
vim.o.breakindent = true

-- Enable undo/redo changes even after closing and reopening a file
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 250

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-guide-options`
vim.o.list = false
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.o.inccommand = "split"

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
-- Remap movement from hjkl -> jkl;
vim.keymap.set({ "n", "v", "o" }, "j", "h", { noremap = true, silent = true, desc = "Left" })
vim.keymap.set({ "n", "v", "o" }, "k", "j", { noremap = true, silent = true, desc = "Down" })
vim.keymap.set({ "n", "v", "o" }, "l", "k", { noremap = true, silent = true, desc = "Up" })
vim.keymap.set({ "n", "v", "o" }, ";", "l", { noremap = true, silent = true, desc = "Right" })

-- Quickfix navigation
local function quickfix_jump(delta)
	return function()
		local qf = vim.fn.getqflist({ idx = 0, items = 1, size = 0 })
		if qf.size == 0 or not qf.items then
			return
		end

		local valid_indexes = {}
		for idx, item in ipairs(qf.items) do
			if item.valid == 1 then
				valid_indexes[#valid_indexes + 1] = idx
			end
		end

		if #valid_indexes == 0 then
			return
		end

		local current = qf.idx
		local target_pos

		if delta > 0 then
			local pos = 0
			for i, idx in ipairs(valid_indexes) do
				if idx <= current then
					pos = i
				else
					break
				end
			end

			target_pos = ((pos + vim.v.count1 - 1) % #valid_indexes) + 1
		else
			local pos = #valid_indexes + 1
			for i, idx in ipairs(valid_indexes) do
				if idx >= current then
					pos = i
					break
				end
			end

			target_pos = ((pos - vim.v.count1 - 1) % #valid_indexes) + 1
		end

		vim.cmd("cc " .. valid_indexes[target_pos])
	end
end

vim.keymap.set("n", "<C-k>", quickfix_jump(1), { desc = "Next quickfix item" })
vim.keymap.set("n", "<C-l>", quickfix_jump(-1), { desc = "Previous quickfix item" })
vim.keymap.set("n", "]q", quickfix_jump(1), { desc = "Next quickfix item" })
vim.keymap.set("n", "[q", quickfix_jump(-1), { desc = "Previous quickfix item" })

-- Diagnostics navigation
vim.keymap.set("n", "<A-k>", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next diagnostic" })

vim.keymap.set("n", "<A-l>", function()
	vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Previous diagnostic" })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Split windows
vim.keymap.set("n", "<leader>v", "<cmd>vsplit<CR>", { desc = "Vertical split" })
vim.keymap.set("n", "<leader>h", "<cmd>split<CR>", { desc = "Horizontal split" })

-- Navigate splits (based on your jkl; movement)
vim.keymap.set("n", "<leader>j", "<C-w>h", { desc = "Go to left split" })
vim.keymap.set("n", "<leader>;", "<C-w>l", { desc = "Go to right split" })
vim.keymap.set("n", "<leader>k", "<C-w>j", { desc = "Go to bottom split" })
vim.keymap.set("n", "<leader>l", "<C-w>k", { desc = "Go to top split" })

vim.api.nvim_create_user_command("Reveal", function()
	vim.fn.system('explorer /select,"' .. vim.fn.expand("%:p") .. '"')
end, {})
vim.keymap.set("n", "<leader>e", "<cmd>Reveal<CR>", { desc = "Reveal current file in Explorer" })

-- Diagnostic Config & Keymaps
-- See :help vim.diagnostic.Opts
vim.diagnostic.config({
	update_in_insert = false,
	severity_sort = true,
	float = { border = "single", source = "if_many" },
	underline = false,
	signs = false,

	-- Can switch between these as you prefer
	virtual_text = false, -- Text shows up at the end of the line
	virtual_lines = false, -- Text shows up underneath the line, with virtual lines

	-- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
	jump = { float = true },
})

-- vim.keymap.set("n", "<leader>q", function()
-- 	local is_open = false
--
-- 	for _, win in ipairs(vim.fn.getwininfo()) do
-- 		if win.quickfix == 1 then
-- 			is_open = true
-- 			break
-- 		end
-- 	end
--
-- 	if is_open then
-- 		vim.cmd("cclose")
-- 	else
-- 		vim.cmd("copen")
-- 	end
-- end, { desc = "Toggle quickfix" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")

vim.keymap.set("n", "<c-p>", "<Plug>(YankyPreviousEntry)")
vim.keymap.set("n", "<c-n>", "<Plug>(YankyNextEntry)")

vim.keymap.set("n", "]p", "<Plug>(YankyPutIndentAfterLinewise)")
vim.keymap.set("n", "[p", "<Plug>(YankyPutIndentBeforeLinewise)")
vim.keymap.set("n", "]P", "<Plug>(YankyPutIndentAfterLinewise)")
vim.keymap.set("n", "[P", "<Plug>(YankyPutIndentBeforeLinewise)")

vim.keymap.set("n", ">p", "<Plug>(YankyPutIndentAfterShiftRight)")
vim.keymap.set("n", "<p", "<Plug>(YankyPutIndentAfterShiftLeft)")
vim.keymap.set("n", ">P", "<Plug>(YankyPutIndentBeforeShiftRight)")
vim.keymap.set("n", "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)")

vim.keymap.set("n", "=p", "<Plug>(YankyPutAfterFilter)")
vim.keymap.set("n", "=P", "<Plug>(YankyPutBeforeFilter)")

local todo_snippet_keywords = {
	"TODO",
	"NOTE",
	"WARNING",
	"PERFORMANCE",
	"CRITICAL",
	"HACK",
	"FIX",
}

local todo_comment_keywords = {
	FIX = { alt = { "FIXME", "BUG", "FIXIT", "ISSUE", "CRITICAL", "CRIT" } },
}

local todo_highlight_pattern = [[.*<((KEYWORDS)\s*(\([^)]*\))?\s*:)]]
local todo_search_pattern = [[\b(KEYWORDS)\s*(\([^)]*\))?\s*:]]

-- NOTE: Here is where you install your plugins.
require("lazy").setup({
	{ "EtiamNullam/deferred-clipboard.nvim" },
	{
		"gbprod/yanky.nvim",
		opts = function()
			local mapping = require("yanky.telescope.mapping")
			local utils = require("yanky.utils")

			return {
				highlight = {
					on_put = true,
					on_yank = true,

					timer = 100,
				},
				picker = {
					telescope = {
						-- keep Yanky's extra mappings, but change Enter/default action
						use_default_mappings = true,
						mappings = {
							default = mapping.set_register(utils.get_default_register()),
						},
					},
				},
			}
		end,
	},
	{
		"gbprod/substitute.nvim",
		dependencies = { "gbprod/yanky.nvim" },
		opts = function()
			return {
				on_substitute = require("yanky.integration").substitute(),
				highlight_substituted_text = {
					enabled = true,
					timer = 100,
				},
			}
		end,
	},
	{
		"gbprod/cutlass.nvim",
		opts = {
			cut_key = "x",
			-- your configuration comes here
			-- or don't set opts to use the default settings
			-- refer to the configuration section below
		},
	},
	{ "bkad/CamelCaseMotion" },
	{
		"tpope/vim-dispatch",
	},
	{
		"folke/snacks.nvim",
		lazy = true,
		opts = {
			scratch = { enabled = true },
		},
		keys = {
			{
				"<leader>.",
				function()
					Snacks.scratch()
				end,
				desc = "Toggle scratch buffer",
			},
		},
	},
	{
		"chrisgrieser/nvim-recorder",
		opts = {
			useNerdfontIcons = vim.g.have_nerd_font,
		},
	},
	{
		"ptdewey/pendulum-nvim",
		config = function()
			require("pendulum").setup()
		end,
	},
	{
		"rmagatti/auto-session",
		lazy = false,
		opts = {
			root_dir = vim.fn.stdpath("data") .. "/sessions/",
			suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
			session_lens = {
				picker = "telescope",
				load_on_setup = true,
			},
		},
		config = function(_, opts)
			require("auto-session").setup(opts)

			vim.keymap.set("n", "fs", "<cmd>AutoSession search<CR>", {
				desc = "Find sessions",
			})
		end,
	},
	{
		"stevearc/quicker.nvim",
		ft = "qf",
		---@module "quicker"
		---@type quicker.SetupOptions
		opts = {},
	},
	{
		"stevearc/oil.nvim",
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {},
		-- Optional dependencies
		-- dependencies = { { "nvim-mini/mini.icons", opts = {} } },
		dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
		-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
		lazy = false,
		config = function()
			require("oil").setup()
		end,
	},
	{
		"slugbyte/lackluster.nvim",
		lazy = false,
		init = function()
			local lackluster = require("lackluster")
			local color = lackluster.color

			-- !must called setup() before setting the colorscheme!
			lackluster.setup({
				-- tweak_syntax = {
				-- 	type = color.blue,
				-- 	string = color.green,
				-- },
				-- tweak_color allows you to overwrite the default colors in the lackluster theme
				tweak_highlight = {
					Visual = {
						bg = lackluster.color.green,
					},
					VisualNOS = {
						overwrite = true,
						link = "Visual",
					},
				},
				tweak_background = {
					-- normal = 'default',    -- main background
					-- normal = 'none',    -- transparent
					-- normal = "#000000", -- hexcode
					-- normal = color.green,    -- lackluster color
					telescope = "default", -- telescope
					menu = "default", -- nvim_cmp, wildmenu ... (bad idea to transparent)
					popup = "default", -- lazy, mason, whichkey ... (bad idea to transparent)
				},
				-- tweak_highlight = vim.tbl_extend("force", tweak_highlight, {
				-- 	Function = {
				-- 		overwrite = true,
				-- 		fg = color.blue,
				-- 	},
				-- 	["@function.call"] = {
				-- 		overwrite = true,
				-- 		fg = color.blue,
				-- 	},
				-- 	["@function.method.call"] = {
				-- 		overwrite = true,
				-- 		fg = color.blue,
				-- 	},
				-- 	["@type.definition"] = {
				-- 		overwrite = true,
				-- 		fg = color.yellow,
				-- 	},
				-- }),
			})

			vim.cmd.colorscheme("lackluster-mint") -- my favorite
			vim.api.nvim_set_hl(0, "Cursor", { fg = color.black, bg = color.green })
			vim.api.nvim_set_hl(0, "lCursor", { fg = color.black, bg = color.green })
			vim.api.nvim_set_hl(0, "TermCursor", { fg = color.black, bg = color.green })
			vim.opt.guicursor =
				"n-v-c-sm:block-Cursor/lCursor,i-ci-ve:ver25-Cursor/lCursor,r-cr-o:hor20-Cursor/lCursor,t:block-TermCursor"
		end,
	},

	{
		"seblyng/roslyn.nvim",
		opts = {
			broad_search = false,
			lock_target = true,
			filewatching = "roslyn",
			settings = {
				["csharp|inlay_hints"] = {
					csharp_enable_inlay_hints_for_implicit_object_creation = false,
					csharp_enable_inlay_hints_for_implicit_variable_types = false,
					csharp_enable_inlay_hints_for_lambda_parameter_types = false,
					csharp_enable_inlay_hints_for_types = false,
					dotnet_enable_inlay_hints_for_parameters = false,
				},
				["csharp|background_analysis"] = {
					["background_analysis.dotnet_analyzer_diagnostics_scope"] = "none",
					["background_analysis.dotnet_compiler_diagnostics_scope"] = "none",
				},
				["csharp|code_lens"] = {
					dotnet_enable_references_code_lens = false,
					dotnet_enable_tests_code_lens = false,
				},
				["csharp|symbol_search"] = { dotnet_search_reference_assemblies = false },
			},
		},
	},
	{ "NMAC427/guess-indent.nvim", opts = {} },

	-- Alternatively, use `config = function() ... end` for full control over the configuration.
	-- If you prefer to call `setup` explicitly, use:
	--    {
	--        'lewis6991/gitsigns.nvim',
	--        config = function()
	--            require('gitsigns').setup({
	--                -- Your gitsigns configuration here
	--            })
	--        end,
	--    }
	--
	-- Here is a more advanced example where we pass configuration
	-- options to `gitsigns.nvim`.
	--
	-- See `:help gitsigns` to understand what the configuration keys do
	{ -- Adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		---@module 'gitsigns'
		---@type Gitsigns.Config
		---@diagnostic disable-next-line: missing-fields
		opts = {
			signcolumn = false,
			signs = {
				add = { text = "+" }, ---@diagnostic disable-line: missing-fields
				change = { text = "~" }, ---@diagnostic disable-line: missing-fields
				delete = { text = "_" }, ---@diagnostic disable-line: missing-fields
				topdelete = { text = "‾" }, ---@diagnostic disable-line: missing-fields
				changedelete = { text = "~" }, ---@diagnostic disable-line: missing-fields
			},
		},
	},

	-- NOTE: Plugins can also be configured to run Lua code when they are loaded.
	--
	-- This is often very useful to both group configuration, as well as handle
	-- lazy loading plugins that don't need to be loaded immediately at startup.
	--
	-- For example, in the following configuration, we use:
	--  event = 'VimEnter'
	--
	-- which loads which-key before all the UI elements are loaded. Events can be
	-- normal autocommands events (`:help autocmd-events`).
	--
	-- Then, because we use the `opts` key (recommended), the configuration runs
	-- after the plugin has been loaded as `require(MODULE).setup(opts)`.

	{ -- Useful plugin to show you pending keybinds.
		"folke/which-key.nvim",
		enabled = false,
		event = "VimEnter",
		---@module 'which-key'
		---@type wk.Opts
		---@diagnostic disable-next-line: missing-fields
		opts = {
			-- delay between pressing a key and opening which-key (milliseconds)
			delay = 0,
			icons = { mappings = vim.g.have_nerd_font },

			-- Document existing key chains
			spec = {
				{ "<leader>f", group = "[F]ind", mode = { "n", "v" } },
				{ "<leader>t", group = "[T]oggle" },
				{ "<leader>h", group = "Git [H]unk", mode = { "n", "v" } }, -- Enable gitsigns recommended keymaps first
			},
		},
	},

	-- NOTE: Plugins can specify dependencies.
	--
	-- The dependencies are proper plugin specifications as well - anything
	-- you do for a plugin at the top level, you can do for a dependency.
	--
	-- Use the `dependencies` key to specify the dependencies of a particular plugin

	{ -- Fuzzy Finder (files, lsp, etc)
		"nvim-telescope/telescope.nvim",
		-- By default, Telescope is included and acts as your picker for everything.

		-- If you would like to switch to a different picker (like snacks, or fzf-lua)
		-- you can disable the Telescope plugin by setting enabled to false and enable
		-- your replacement picker by requiring it explicitly (e.g. 'custom.plugins.snacks')

		-- Note: If you customize your config for yourself,
		-- it’s best to remove the Telescope plugin config entirely
		-- instead of just disabling it here, to keep your config clean.
		enabled = true,
		event = "VimEnter",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ -- If encountering errors, see telescope-fzf-native README for installation instructions
				"nvim-telescope/telescope-fzf-native.nvim",

				-- `build` is used to run some command when the plugin is installed/updated.
				-- This is only run then, not every time Neovim starts up.
				build = "make",

				-- `cond` is a condition used to determine whether this plugin should be
				-- installed and loaded.
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },

			-- Useful for getting pretty icons, but requires a Nerd Font.
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		},
		config = function()
			-- Telescope is a fuzzy finder that comes with a lot of different things that
			-- it can fuzzy find! It's more than just a "file finder", it can search
			-- many different aspects of Neovim, your workspace, LSP, and more!
			--
			-- The easiest way to use Telescope, is to start by doing something like:
			--  :Telescope help_tags
			--
			-- After running this command, a window will open up and you're able to
			-- type in the prompt window. You'll see a list of `help_tags` options and
			-- a corresponding preview of the help.
			--
			-- Two important keymaps to use while in Telescope are:
			--  - Insert mode: <c-/>
			--  - Normal mode: ?
			--
			-- This opens a window that shows you all of the keymaps for the current
			-- Telescope picker. This is really useful to discover what Telescope can
			-- do as well as how to actually do it!

			-- [[ Configure Telescope ]]
			-- See `:help telescope` and `:help telescope.setup()`
			require("telescope").setup({
				defaults = {
					border = true,
					borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
				},
				-- You can put your default mappings / updates / etc. in here
				--  All the info you're looking for is in `:help telescope.setup()`
				--
				-- defaults = {
				--   mappings = {
				--     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
				--   },
				-- },
				-- pickers = {}
				extensions = {
					["ui-select"] = { require("telescope.themes").get_dropdown() },
				},
			})

			-- Enable Telescope extensions if they are installed
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")

			-- See `:help telescope.builtin`
			local builtin = require("telescope.builtin")
			local function jump_to_qf_item(item)
				local win = vim.api.nvim_get_current_win()
				local from = vim.fn.getpos(".")
				from[1] = vim.api.nvim_get_current_buf()
				local tagname = vim.fn.expand("<cword>")

				-- Mirror Neovim's built-in LSP location handler so single-result jumps
				-- are recorded for <C-o> and <C-t>.
				vim.cmd("normal! m'")
				vim.fn.settagstack(vim.fn.win_getid(win), {
					items = {
						{ tagname = tagname, from = from },
					},
				}, "t")

				local bufnr = item.bufnr
				if not bufnr or bufnr == 0 then
					bufnr = vim.fn.bufadd(item.filename)
				end

				vim.fn.bufload(bufnr)
				vim.api.nvim_win_set_buf(0, bufnr)
				vim.api.nvim_win_set_cursor(0, { item.lnum, math.max(item.col - 1, 0) })
				vim.cmd.normal({ args = { "zv" }, bang = true })
			end

			local function lsp_jump_or_qf(request)
				return function()
					request(function(options)
						if #options.items == 1 then
							jump_to_qf_item(options.items[1])
							return
						end

						vim.fn.setqflist({}, " ", options)
						vim.cmd.copen()
					end)
				end
			end

			local function find_code_files()
				local code_globs = {
					"*.cs",
					"*.lua",
					"*.py",
					"*.js",
					"*.jsx",
					"*.ts",
					"*.tsx",
					"*.mjs",
					"*.cjs",
					"*.java",
					"*.kt",
					"*.kts",
					"*.go",
					"*.rs",
					"*.c",
					"*.h",
					"*.cpp",
					"*.cc",
					"*.cxx",
					"*.hpp",
					"*.hh",
					"*.hxx",
					"*.swift",
					"*.rb",
					"*.php",
					"*.sh",
					"*.bash",
					"*.zsh",
					"*.fish",
					"*.ps1",
					"*.psm1",
					"*.vim",
					"*.json",
					"*.jsonc",
					"*.json5",
					"*.yaml",
					"*.yml",
					"*.toml",
					"*.xml",
					"*.props",
					"*.targets",
					"*.csproj",
					"*.fsproj",
					"*.vbproj",
					"*.sln",
					"*.editorconfig",
					"*.gitignore",
					"*.gitattributes",
					"*.env",
					"*.md",
					"*.txt",
					"*.sql",
					"*.proto",
					"*.graphql",
					"*.html",
					"*.htm",
					"*.css",
					"*.scss",
					"*.sass",
					"*.less",
				}
				local named_files = {
					"Dockerfile",
					"docker-compose.yml",
					"docker-compose.yaml",
					"Makefile",
					"justfile",
					"CMakeLists.txt",
				}
				local find_command = { "rg", "--files" }

				for _, glob in ipairs(code_globs) do
					table.insert(find_command, "-g")
					table.insert(find_command, glob)
				end

				for _, name in ipairs(named_files) do
					table.insert(find_command, "-g")
					table.insert(find_command, name)
				end

				builtin.find_files({
					find_command = find_command,
				})
			end

			vim.keymap.set("n", "fh", builtin.help_tags, { desc = "[F]ind [H]elp" })
			vim.keymap.set("n", "fk", builtin.keymaps, { desc = "[F]ind [K]eymaps" })
			vim.keymap.set("n", "ff", find_code_files, { desc = "[F]ind [F]iles" })
			vim.keymap.set("n", "fa", builtin.find_files, { desc = "[F]ind [A]ll files" })
			vim.keymap.set({ "n", "v" }, "fw", builtin.grep_string, { desc = "[F]ind current [W]ord" })
			vim.keymap.set("n", "fl", builtin.live_grep, { desc = "[F]ind by [G]rep" })
			vim.keymap.set("n", "fd", builtin.diagnostics, { desc = "[F]ind [D]iagnostics" })
			vim.keymap.set("n", "fr", builtin.resume, { desc = "[F]ind [R]esume" })
			vim.keymap.set("n", "f.", builtin.oldfiles, { desc = '[F]ind Recent Files ("." for repeat)' })
			vim.keymap.set("n", "fc", builtin.commands, { desc = "[F]ind [C]ommands" })
			vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

			-- This runs on LSP attach per buffer (see main LSP attach function in 'neovim/nvim-lspconfig' config for more info,
			-- it is better explained there). This allows easily switching between pickers if you prefer using something else!
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("telescope-lsp-attach", { clear = true }),
				callback = function(event)
					local buf = event.buf

					-- Find references for the word under your cursor.
					vim.keymap.set(
						"n",
						"gr",
						lsp_jump_or_qf(function(on_list)
							vim.lsp.buf.references(nil, { on_list = on_list })
						end),
						{ buffer = buf, desc = "[G]oto [R]eferences" }
					)

					-- Jump to the implementation of the word under your cursor.
					-- Useful when your language has ways of declaring types without an actual implementation.
					vim.keymap.set(
						"n",
						"gi",
						lsp_jump_or_qf(function(on_list)
							vim.lsp.buf.implementation({ on_list = on_list, reuse_win = true })
						end),
						{ buffer = buf, desc = "[G]oto [I]mplementation" }
					)

					-- Jump to the definition of the word under your cursor.
					-- This is where a variable was first declared, or where a function is defined, etc.
					-- To jump back, press <C-t>.
					vim.keymap.set(
						"n",
						"gd",
						lsp_jump_or_qf(function(on_list)
							vim.lsp.buf.definition({ on_list = on_list, reuse_win = true })
						end),
						{ buffer = buf, desc = "[G]oto [D]efinition" }
					)

					-- Fuzzy find all the symbols in your current document.
					-- Symbols are things like variables, functions, types, etc.
					vim.keymap.set(
						"n",
						"go",
						builtin.lsp_document_symbols,
						{ buffer = buf, desc = "Open Document Symbols" }
					)

					-- Fuzzy find all the symbols in your current workspace.
					-- Similar to document symbols, except searches over your entire project.
					vim.keymap.set(
						"n",
						"gw",
						builtin.lsp_dynamic_workspace_symbols,
						{ buffer = buf, desc = "Open Workspace Symbols" }
					)

					-- Jump to the type of the word under your cursor.
					-- Useful when you're not sure what type a variable is and you want to see
					-- the definition of its *type*, not where it was *defined*.
					vim.keymap.set(
						"n",
						"gt",
						lsp_jump_or_qf(function(on_list)
							vim.lsp.buf.type_definition({ on_list = on_list, reuse_win = true })
						end),
						{ buffer = buf, desc = "[G]oto [T]ype Definition" }
					)
				end,
			})

			vim.keymap.set({ "n", "x" }, "<leader>/", "<cmd>nohlsearch<CR>", { desc = "[/] Clear search highlight" })

			-- It's also possible to pass additional configuration options.
			--  See `:help telescope.builtin.live_grep()` for information about particular keys
			vim.keymap.set("n", "f/", function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end, { desc = "[F]ind [/] in Open Files" })

			-- Shortcut for searching your Neovim configuration files
			vim.keymap.set("n", "fn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[F]ind [N]eovim files" })
		end,
	},

	-- LSP Plugins
	{
		-- Main LSP Configuration
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs and related tools to stdpath for Neovim
			-- Mason must be loaded before its dependents so we need to set it up here.
			-- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
			{
				"mason-org/mason.nvim",
				---@module 'mason.settings'
				---@type MasonSettings
				---@diagnostic disable-next-line: missing-fields
				opts = {
					registries = {
						"github:mason-org/mason-registry",
						"github:Crashdummyy/mason-registry",
					},
				},
			},
			-- Maps LSP server names between nvim-lspconfig and Mason package names.
			"mason-org/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			-- Brief aside: **What is LSP?**
			--
			-- LSP is an initialism you've probably heard, but might not understand what it is.
			--
			-- LSP stands for Language Server Protocol. It's a protocol that helps editors
			-- and language tooling communicate in a standardized fashion.
			--
			-- In general, you have a "server" which is some tool built to understand a particular
			-- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
			-- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
			-- processes that communicate with some "client" - in this case, Neovim!
			--
			-- LSP provides Neovim with features like:
			--  - Go to definition
			--  - Find references
			--  - Autocompletion
			--  - Symbol Search
			--  - and more!
			--
			-- Thus, Language Servers are external tools that must be installed separately from
			-- Neovim. This is where `mason` and related plugins come into play.
			--
			-- If you're wondering about lsp vs treesitter, you can check out the wonderfully
			-- and elegantly composed help section, `:help lsp-vs-treesitter`

			--  This function gets run when an LSP attaches to a particular buffer.
			--    That is to say, every time a new file is opened that is associated with
			--    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
			--    function will be executed to configure the current buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					-- NOTE: Remember that Lua is a real programming language, and as such it is possible
					-- to define small helper and utility functions so you don't have to repeat yourself.
					--
					-- In this case, we create a function that lets us more easily define mappings specific
					-- for LSP related items. It sets the mode, buffer and description for us each time.
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					-- Rename the variable under your cursor.
					--  Most Language Servers support renaming across files, etc.
					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

					-- Execute a code action, usually your cursor needs to be on top of an error
					-- or a suggestion from your LSP for this to activate.
					map("<leader>ca", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })

					-- WARN: This is not Goto Definition, this is Goto Declaration.
					--  For example, in C this would take you to the header.
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

					-- The following two autocommands are used to highlight references of the
					-- word under your cursor when your cursor rests there for a little while.
					--    See `:help CursorHold` for information about when this is executed
					--
					-- When you move your cursor, the highlights will be cleared (the second autocommand).
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.server_capabilities.semanticTokensProvider then
						client.server_capabilities.semanticTokensProvider = nil
					end

					-- The following code creates a keymap to toggle inlay hints in your
					-- code, if the language server you are using supports them
					--
					-- This may be unwanted, since they displace some of your code
					if client and client:supports_method("textDocument/inlayHint", event.buf) then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, "[T]oggle Inlay [H]ints")
					end
				end,
			})

			-- Enable the following language servers
			--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
			--  See `:help lsp-config` for information about keys and how to configure
			---@type table<string, vim.lsp.Config>
			local servers = {
				clangd = {},
				gopls = {},
				ols = {},
				roslyn = {},
				-- pyright = {},
				-- rust_analyzer = {},
				--
				-- Some languages (like typescript) have entire language plugins that can be useful:
				--    https://github.com/pmizio/typescript-tools.nvim
				--
				-- But for many setups, the LSP (`ts_ls`) will work just fine
				-- ts_ls = {},

				stylua = {}, -- Used to format Lua code

				-- Special Lua Config, as recommended by neovim help docs
				lua_ls = {
					on_init = function(client)
						if client.workspace_folders then
							local path = client.workspace_folders[1].name
							if
								path ~= vim.fn.stdpath("config")
								and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
							then
								return
							end
						end

						client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
							runtime = {
								version = "LuaJIT",
								path = { "lua/?.lua", "lua/?/init.lua" },
							},
							workspace = {
								checkThirdParty = false,
								-- NOTE: this is a lot slower and will cause issues when working on your own configuration.
								--  See https://github.com/neovim/nvim-lspconfig/issues/3189
								library = vim.tbl_extend("force", vim.api.nvim_get_runtime_file("", true), {
									"${3rd}/luv/library",
									"${3rd}/busted/library",
								}),
							},
						})
					end,
					settings = {
						Lua = {},
					},
				},
			}

			-- Ensure the servers and tools above are installed
			--
			-- To check the current status of installed tools and/or manually install
			-- other tools, you can run
			--    :Mason
			--
			-- You can press `g?` for help in this menu.
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				-- You can add other tools here that you want Mason to install
			})

			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			local blink = require("blink.cmp")

			for name, server in pairs(servers) do
				server.capabilities = blink.get_lsp_capabilities(server.capabilities)
				vim.lsp.config(name, server)
				vim.lsp.enable(name)
			end
		end,
	},

	{ -- Autoformat
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>cf",
				function()
					vim.bo.fileformat = "unix"
					vim.cmd([[silent keepjumps keeppatterns %s/\r$//e]])
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "[C]ode [F]ormat buffer",
			},
		},
		---@module 'conform'
		---@type conform.setupOpts
		opts = {
			notify_on_error = false,
			format_on_save = nil,
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform can also run multiple formatters sequentially
				-- python = { "isort", "black" },
				--
				-- You can use 'stop_after_first' to run the first available formatter from the list
				-- javascript = { "prettierd", "prettier", stop_after_first = true },
			},
		},
	},

	{ -- Autocompletion
		"saghen/blink.cmp",
		event = "VimEnter",
		version = "1.*",
		dependencies = {
			{
				"saghen/blink.compat",
				version = "2.*",
				lazy = true,
				opts = {},
			},
			{ "hrsh7th/cmp-calc" },
			-- Snippet Engine
			{
				"L3MON4D3/LuaSnip",
				version = "2.*",
				build = (function()
					-- Build Step is needed for regex support in snippets.
					-- This step is not supported in many windows environments.
					-- Remove the below condition to re-enable on windows.
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
				dependencies = {
					-- `friendly-snippets` contains a variety of premade snippets.
					--    See the README about individual language/framework/plugin snippets:
					--    https://github.com/rafamadriz/friendly-snippets
					{
						"rafamadriz/friendly-snippets",
						config = function()
							require("luasnip.loaders.from_vscode").lazy_load()
						end,
					},
				},
				opts = function()
					local ls = require("luasnip")
					local s = ls.snippet
					local i = ls.insert_node
					local f = ls.function_node

					local function make_comment_snippet(keyword)
						return s(keyword:lower(), {
							f(function()
								local cs = vim.bo.commentstring

								-- fallback if commentstring is missing
								if not cs or cs == "" or not cs:find("%%s") then
									cs = "# %s"
								end

								return cs:gsub("%%s", keyword .. "(sqd): ")
							end, {}),
							i(0),
						})
					end

					local snippets = {}
					for _, keyword in ipairs(todo_snippet_keywords) do
						snippets[#snippets + 1] = make_comment_snippet(keyword)
					end
					ls.add_snippets("all", snippets)
				end,
			},
		},
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = {
				-- 'default' (recommended) for mappings similar to built-in completions
				--   <c-y> to accept ([y]es) the completion.
				--    This will auto-import if your LSP supports it.
				--    This will expand snippets if the LSP sent a snippet.
				-- 'super-tab' for tab to accept
				-- 'enter' for enter to accept
				-- 'none' for no mappings
				--
				-- For an understanding of why the 'default' preset is recommended,
				-- you will need to read `:help ins-completion`
				--
				-- No, but seriously. Please read `:help ins-completion`, it is really good!
				--
				-- All presets have the following mappings:
				-- <tab>/<s-tab>: move to right/left of your snippet expansion
				-- <c-space>: Open menu or open docs if already open
				-- <c-n>/<c-p> or <up>/<down>: Select next/previous item
				-- <c-e>: Hide menu
				-- to
				-- <c-k>: Toggle signature help
				--
				-- See :h blink-cmp-config-keymap for defining your own keymap
				preset = "default",
				["<C-f>"] = {
					function(cmp)
						return cmp.select_and_accept({ force = true })
					end,
					"fallback",
				},

				-- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
				--    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
			},

			appearance = {
				-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = "mono",
			},
			completion = {
				accept = {
					auto_brackets = {
						enabled = false,
					},
				},
				list = {
					max_items = 5,
					selection = {
						preselect = false,
					},
				},
				-- By default, you may press `<c-space>` to show the documentation.
				-- Optionally, set `auto_show = true` to show the documentation after a delay.
				documentation = { auto_show = false, auto_show_delay_ms = 300 },
			},

			sources = {
				default = { "lsp", "path", "snippets", "calc" },
				providers = {
					calc = {
						name = "calc",
						module = "blink.compat.source",
						score_offset = 100,
					},
					lsp = {
						transform_items = function(_, items)
							local kinds = require("blink.cmp.types").CompletionItemKind
							return vim.tbl_filter(function(item)
								return item.kind ~= kinds.Keyword
							end, items)
						end,
					},
				},
			},

			snippets = { preset = "luasnip" },

			-- Blink.cmp includes an optional, recommended rust fuzzy matcher,
			-- which automatically downloads a prebuilt binary when enabled.
			--
			-- By default, we use the Lua implementation instead, but you may enable
			-- the rust implementation via `'prefer_rust_with_warning'`
			--
			-- See :h blink-cmp-config-fuzzy for more information
			fuzzy = { implementation = "lua" },

			-- Shows a signature help window while you type arguments for a function
			signature = { enabled = true },
		},
	},

	-- Highlight todo, notes, etc in comments
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		---@module 'todo-comments'
		---@type TodoOptions
		opts = {
			signs = false,
			keywords = todo_comment_keywords,
			highlight = {
				pattern = todo_highlight_pattern,
			},
			search = {
				pattern = todo_search_pattern,
			},
		},
	},

	{ -- Collection of various small independent plugins/modules
		"nvim-mini/mini.nvim",
		config = function()
			-- Better Around/Inside textobjects
			--
			-- Examples:
			--  - va)  - [V]isually select [A]round [)]paren
			--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
			--  - ci'  - [C]hange [I]nside [']quote
			require("mini.ai").setup({ n_lines = 500 })

			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			--
			-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			-- - sd'   - [S]urround [D]elete [']quotes
			-- - sr)'  - [S]urround [R]eplace [)] [']
			require("mini.surround").setup({
				mappings = {
					add = "Sa", -- add surrounding
					delete = "Sd", -- delete surrounding
					find = "Sf", -- find surrounding (right)
					find_left = "SF", -- find surrounding (left)
					highlight = "Sh", -- highlight surrounding
					replace = "Sr", -- replace surrounding
					update_n_lines = "Sn", -- update search length
				},
			})
			require("mini.pairs").setup()

			-- Simple and easy statusline.
			--  You could remove this setup call if you don't like it,
			--  and try some other statusline plugin
			local statusline = require("mini.statusline")
			-- set use_icons to true if you have a Nerd Font
			statusline.setup({
				use_icons = vim.g.have_nerd_font,
				content = {
					active = function()
						local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
						local git = statusline.section_git({ trunc_width = 40 })
						local diff = statusline.section_diff({ trunc_width = 75 })
						local diagnostics = statusline.section_diagnostics({ trunc_width = 75 })
						local lsp = statusline.section_lsp({ trunc_width = 75 })
						local filename = statusline.section_filename({ trunc_width = 140 })
						local fileinfo = statusline.section_fileinfo({ trunc_width = 120 })
						local location = statusline.section_location({ trunc_width = 75 })
						local search = statusline.section_searchcount({ trunc_width = 75 })
						local recorder_slots, recorder_status = "", ""
						local has_recorder, recorder = pcall(require, "recorder")

						if has_recorder then
							recorder_slots = recorder.displaySlots()
							recorder_status = recorder.recordingStatus()
						end

						return statusline.combine_groups({
							{ hl = mode_hl, strings = { mode } },
							{ hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics, lsp } },
							"%<",
							{ hl = "MiniStatuslineFilename", strings = { filename } },
							"%=",
							{ hl = "MiniStatuslineFileinfo", strings = { recorder_slots, fileinfo } },
							{ hl = mode_hl, strings = { recorder_status, search, location } },
						})
					end,
				},
			})

			-- You can configure sections in the statusline by overriding their
			-- default behavior. For example, here we set the section for
			-- cursor location to LINE:COLUMN
			---@diagnostic disable-next-line: duplicate-set-field
			statusline.section_location = function()
				return "%2l:%-2v"
			end

			-- ... and there is more!
			--  Check out: https://github.com/nvim-mini/mini.nvim
		end,
	},

	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		branch = "main",
		-- [[ Configure Treesitter ]] See `:help nvim-treesitter-intro`
		config = function()
			local parsers = {
				"bash",
				"c",
				"diff",
				"html",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"query",
				"vim",
				"vimdoc",
				"odin",
				"c_sharp",
			}
			require("nvim-treesitter").install(parsers)
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					local buf, filetype = args.buf, args.match

					local language = vim.treesitter.language.get_lang(filetype)
					if not language then
						return
					end

					-- check if parser exists and load it
					if not vim.treesitter.language.add(language) then
						return
					end
					-- enables syntax highlighting and other treesitter features
					vim.treesitter.start(buf, language)

					-- enables treesitter based folds
					-- for more info on folds see `:help folds`
					-- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
					-- vim.wo.foldmethod = 'expr'

					-- C# uses Neovim's built-in indent script, which delegates to
					-- GetCSIndent(). Tree-sitter has no c_sharp indent queries.
					if filetype == "cs" and vim.fn.exists("*GetCSIndent") == 1 then
						vim.bo[buf].cindent = true
						vim.bo[buf].indentexpr = "GetCSIndent(v:lnum)"
					-- Only enable Tree-sitter indentation when the language provides
					-- indent queries. Languages like C# ship a parser without them.
					elseif vim.treesitter.query.get(language, "indents") then
						vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})
		end,
	},

	-- The following comments only work if you have downloaded the kickstart repo, not just copy pasted the
	-- init.lua. If you want these files, they are in the repository, so you can just download them and
	-- place them in the correct locations.

	-- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
	--
	--  Here are some example plugins that I've included in the Kickstart repository.
	--  Uncomment any of the lines below to enable them (you will need to restart nvim).
	--
	-- require 'kickstart.plugins.debug',
	-- require 'kickstart.plugins.indent_line',
	-- require 'kickstart.plugins.lint',
	-- require 'kickstart.plugins.autopairs',
	-- require 'kickstart.plugins.neo-tree',
	-- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommended keymaps

	-- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
	--    This is the easiest way to modularize your config.
	--
	--  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
	-- { import = 'custom.plugins' },
	--
	-- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
	-- Or use telescope!
	-- In normal mode type `<space>fh` then write `lazy.nvim-plugin`
	-- you can continue same window with `<space>fr` which resumes last telescope search
}, { ---@diagnostic disable-line: missing-fields
	ui = {
		-- If you are using a Nerd Font: set icons to an empty table which will use the
		-- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})

vim.opt.makeprg = "make"
vim.opt.errorformat = {
	"%E%f(%l:%c) %m",
	"%W%f(%l:%c) %m",
	"%-G%.%#",
}

local function make_target(target)
	return function()
		vim.cmd.write()
		vim.cmd("Make " .. target)

		local qf = vim.fn.getqflist({ size = 0 })
		if qf.size > 0 then
			vim.cmd("cfirst")
		end
	end
end

for i = 1, 12 do
	vim.keymap.set("n", "<F" .. i .. ">", make_target("f" .. i), {
		silent = true,
		desc = "Build f" .. i,
	})
end
vim.keymap.set("n", "s", require("substitute").eol, { noremap = true })
vim.keymap.set("n", "s", require("substitute").operator, { noremap = true })
vim.keymap.set("n", "ss", require("substitute").line, { noremap = true })
vim.keymap.set("x", "s", require("substitute").visual, { noremap = true })

require("deferred-clipboard").setup({
	lazy = true,
})
vim.keymap.set("n", "fy", "<cmd>Telescope yank_history<CR>", {
	desc = "Yank history",
})

vim.keymap.set({ "n", "v", "o" }, "<Home>", "^", { noremap = true, silent = true })
vim.keymap.set("i", "<Home>", "<C-o>^", { noremap = true, silent = true })

-- require("handmade").load()

for _, lhs in ipairs({ "-", "<kMinus>" }) do
	vim.keymap.set({ "n", "x", "o" }, lhs, function()
		require("oil").open()
	end, {
		desc = "Open parent directory",
		silent = true,
	})
end

vim.keymap.set({ "n", "x", "o" }, "W", "<Plug>CamelCaseMotion_w")
vim.keymap.set({ "n", "x", "o" }, "B", "<Plug>CamelCaseMotion_b")
vim.keymap.set({ "n", "x", "o" }, "E", "<Plug>CamelCaseMotion_e")
if vim.g.neovide then
	vim.o.guifont = "JetBrainsMono Nerd Font:h10"

	vim.g.neovide_font_features = {
		["JetBrainsMono Nerd Font"] = {
			"-calt",
			"-liga",
		},
	}

	vim.g.neovide_scroll_animation_far_lines = 0
	vim.g.neovide_cursor_animation_length = 0
	vim.g.neovide_cursor_trail_size = 0
end

vim.keymap.set("n", "<leader>q", function()
  require("quicker").toggle()
end, {
  desc = "Toggle quickfix",
})
require("quicker").setup({
  keys = {
    {
      ">",
      function()
        require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
      end,
      desc = "Expand quickfix context",
    },
    {
      "<",
      function()
        require("quicker").collapse()
      end,
      desc = "Collapse quickfix context",
    },
  },
})
