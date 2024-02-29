local vim = vim
local Plug = vim.fn['plug#']
vim.call('plug#begin')
Plug ('sheerun/vim-polyglot')
Plug ('stevearc/oil.nvim')
Plug ('bkad/CamelCaseMotion')
Plug ('L3MON4D3/LuaSnip')
Plug ('rrethy/vim-hexokinase', { ['do'] = 'make hexokinase' })
Plug ('windwp/nvim-autopairs')
Plug ('valloric/MatchTagAlways')
Plug ('sheerun/vim-polyglot')
Plug ('dhruvasagar/vim-markify')
Plug ('Yggdroot/indentLine')
Plug ('easymotion/vim-easymotion')
Plug ('PeterRincker/vim-argumentative')

Plug ('svermeulen/vim-cutlass')
Plug ('svermeulen/vim-yoink')
Plug ('svermeulen/vim-subversive')

Plug ('dbakker/vim-paragraph-motion')

Plug ('glts/vim-magnum')
Plug ('glts/vim-radical')
Plug ('nvim-lua/plenary.nvim')
Plug ('nvim-telescope/telescope.nvim', { ['tag'] = '0.1.4' })
Plug ('nvim-telescope/telescope-fzf-native.nvim', { ['do'] = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' })
Plug ('tpope/vim-abolish')
Plug ('tpope/vim-dispatch')
Plug ('tpope/vim-speeddating')
Plug ('tpope/vim-repeat')
Plug ('tpope/vim-obsession')
Plug ('tpope/vim-surround')
Plug ('tpope/vim-unimpaired')
Plug ('tpope/vim-sensible')
Plug ('tpope/vim-fugitive')
Plug ('tpope/vim-commentary')

Plug ('ahmedkhalf/project.nvim')

Plug ('BurntSushi/ripgrep')
Plug ('mrjones2014/smart-splits.nvim')
Plug ('folke/todo-comments.nvim')
Plug ('neovim/nvim-lspconfig')
Plug ('ray-x/lsp_signature.nvim')
Plug ('hrsh7th/cmp-nvim-lsp')
Plug ('hrsh7th/cmp-buffer')
Plug ('hrsh7th/cmp-path')
Plug ('hrsh7th/cmp-cmdline')
Plug ('hrsh7th/nvim-cmp')
Plug ('L3MON4D3/LuaSnip')
Plug ('saadparwaiz1/cmp_luasnip')
Plug ('hrsh7th/cmp-calc')
Plug ('razzmatazz/csharp-language-server')
Plug ('Decodetalkers/csharpls-extended-lsp.nvim')
Plug ('nvim-pack/nvim-spectre')
Plug ('nvim-tree/nvim-web-devicons')

vim.call('plug#end')
