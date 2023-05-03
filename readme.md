My neovim config, that im using with Wezterm terminal.
## Current bugs:
- [ ] Omnisharp signature help is conflicting with deoplete.
- [x] Starts slowing down after a couple of hours. FIXED (Switched from WiNdOwS TeRmInAl to Wezterm terminal)
- [ ] Omnisharp server needs to be restarted after adding .cs files from Unity.
- [ ] cnext and cprev doesn't work when there is only one item in quickfix list.

## Instalation ([Choco](https://chocolatey.org/) on Windows)
1. `choco install neovim`
1. Install [vim-plug](https://github.com/junegunn/vim-plug)
1. Download and install [Python](https://www.python.org) for all users
1. Provide python host (python.exe) in init.vim
1. Download and install [LLVM](https://github.com/llvm/llvm-project)
2. Provide path to LLVM in init.vim
3. `choco install ripgrep`
4. `choco install fd`
6. `pip install neovim`
7. `pip install pynvim`
1. Open nvim and type `:PlugInstall`
2. Reload nvim and type `:UpdateRemotePlugins`
3. If errors still persist `:checkhealth` and try to resolve it yourself
### Wezterm (Optional)
1. `choco install wezterm`
1. Create wezterm.lua settings in .exe location folder ([my settings](https://gist.github.com/sqdrck/d9d6b21e9e039d26b0fb0f4b56f0b5a5))
