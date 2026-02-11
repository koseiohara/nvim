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
| `gh` | `^` | move to first non-blank character in the line |
| `gl` | `$` | move to the end of line |
| `gk` | `gg` | move to the first line |
| `gj` | `G` | move to the last line |
| `<S-h>` | `10h` | move left 10 columns |
| `<S-l>` | `10l` | move right 10 columns |
| `<S-k>` | `10k` | move up 10 lines |
| `<S-h>` | `10h` | move down 10 lines |
| `<leader>b` | `%` | move to bracket |
| `x` | `"_x` | delete a character without yanking |
| `s` | `"_s` | delete a character and enter insert mode without yanking |
| `;` | `:` | enter command mode |
| `<leader>q` | `q:` | command-line window |
| `q:` | `<Nop>` | (this command was removed) |
| `<leader>n` | `:set relativenumber!<CR>` | switch linenumber <-> relativenumber |
| `<Tab>` | `:tabnext<CR>` | move to the next tab |
| `<S-Tab>` | `:tabprevious<CR>` | move to the previous tab |
| `<leader>wt` | `:tabnew` | open a new tab |
| `<C-h>` | `<C-w>h` | move to the left window |
| `<C-l>` | `<C-w>l` | move to the right window |
| `<C-k>` | `<C-w>k` | move to the upper window |
| `<C-j>` | `<C-w>j` | move to the lower window |
| `<leader>sv` | `:vsplit<CR>` | split the window vertically |
| `<leader>sh` | `:split<CR>` | split the window horizontally |
| `<leader>wv` | `:vsplit` | open a file in a new vertical split |
| `<leader>wh` | `:split` | open a file in a new horizontal split |
| `<leader><BS>` | `:close<CR>` | close the current file |
| `<right>` | `<C-w><` | decrease window width |
| `<left>` | `<C-w>>` | increase window width |
| `<down>` | `<C-w>-` | decrease window height |
| `<up>` | `<C-w>+` | increase window height |

### Insert Mode
| Key | Action | Description |
|-----|--------|-------------|
| `kj`/`Kj`/`KJ` | `<Esc>` | return to normal mode |

### Visual Mode
| Key | Action | Description |
|-----|--------|-------------|
| `<` | `<gv` | decrease indent |
| `>` | `>gv` | increase indent |





## Plugins
In this toolkit, <a href="https://github.com/folke/lazy.nvim.git">lazy.nvim</a> is used as the package manager.
Plugin list can be displayed with command `:Lazy`.


