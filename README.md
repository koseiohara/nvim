# Neovim-Environment

This environment depends on various plugins, including a plugin manager.  
Simply clone this repository into `$HOME/.config/` after neovim is built.  
All files in this repository cannot be used with vim.

## Key Bindings
Key bindings are written in `nvim/lua/config/leymap.lua`.  
Both `<leader>` and `<localleader>` are set as `<space>`.
They can be reset in `init.lua` by yourself.

### Normal Mode
| Key | Action | Description |
|-----|--------|-------------|
| gh | ^ | to first non-blank character in the line |
| gl | $ | to the end of line |
| gk | gg | to the first line |
| gj | G | to the last line |


## Plugins
In this toolkit, <a href="https://github.com/folke/lazy.nvim.git">lazy.nvim</a> is used as the package manager.
Plugin list can be displayed with command `:Lazy`.


