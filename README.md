# Neovim-Environment

This environment depends on various plugins, including a plugin manager.  
Simply clone this repository into `$HOME/.config/` after neovim is built.  
All files in this repository cannot be used with vim.  
To fully use tools in this repository, install <a href="https://github.com/BurntSushi/ripgrep.git">ripgrep</a>, <a fref="https://github.com/tree-sitter/tree-sitter.git">tree-sitter-cli</a>, <a href="https://github.com/laishulu/macism.git">macism</a> (only on macOS), latexmk, and a suetable PDF viewer depending on your OS.

- [Key Bindings](#key-bindings)
    - [Normal Mode](#normal-mode)
    - [Insert Mode](#insert-mode)
    - [Commands](#commands)
    - [Abbreviations](#abb)
- [Plugins](#plugins)


## Key Bindings<a id="key-bindigs"></a>
Key bindings are written in `nvim/lua/config/keymap.lua`.  
Both `<leader>` and `<localleader>` are set as `<space>`.
They can be reset in `init.lua` by yourself.

### Normal Mode<a id="normal-mode"></a>
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
| `<C-h>` | `<C-w>h` | move to the left window |
| `<C-l>` | `<C-w>l` | move to the right window |
| `<C-k>` | `<C-w>k` | move to the upper window |
| `<C-j>` | `<C-w>j` | move to the lower window |
| `<leader>wt` | `:tabnew` | open a new tab |
| `<leader>wv` | `:vsplit` | open a file in a new vertical split |
| `<leader>wh` | `:split` | open a file in a new horizontal split |
| `<leader><BS>` | `:close<CR>` | close the current file |
| `<right>` | `<C-w><` | decrease window width |
| `<left>` | `<C-w>>` | increase window width |
| `<down>` | `<C-w>-` | decrease window height |
| `<up>` | `<C-w>+` | increase window height |

### Insert Mode<a id="insert-mode"></a>
| Key | Action | Description |
|-----|--------|-------------|
| `kj`/`Kj`/`KJ` | `<Esc>` | return to normal mode |

### Visual Mode<a id="visual-mode"></a>
| Key | Action | Description |
|-----|--------|-------------|
| `<` | `<gv` | decrease indent |
| `>` | `>gv` | increase indent |

### Commands<a id="commands"></a>
| Command | Description |
|---------|-------------|
| `:rpl` | replace all highlighted matches with a new word |

### Abbreviations<a id="abb"></a>
| Abbreviation | File Type | Inserted Text | 
|--------------|-----------|---------------|
| `;;r` | fortran | `real` |
| `;;i` | fortran | `integer` |
| `;;l` | fortran | `logical` |
| `;;c` | fortran | `character` |



## Plugins<a id="plugins"></a>
In this toolkit, <a href="https://github.com/folke/lazy.nvim.git">lazy.nvim</a> is used as the package manager.
It will automatically install all plugins listed below.
Plugin list can be displayed with command `:Lazy`.  
In this document, descriptions of key bindings that are the same as the plugin defaults are omitted.

### nvim-web-devicons (<a href="https://github.com/nvim-tree/nvim-web-devicons.git">nvim-tree/nvim-web-devicons</a>)  

### mini.icons (<a href="https://github.com/nvim-mini/mini.icons.git">nvim-mini/mini.icons</a>)  
Some icons may not render correctly in certain terminal emulators, including Terminal.app on macOS.

### gitsigns.nvim (<a href="https://github.com/lewis6991/gitsigns.nvim.git">lewis6991/gitsigns.nvim</a>)  

### barbar.nvim (<a href="https://github.com/romgrk/barbar.nvim.git">romgrk/barbar.nvim</a>)  

### vim-commentary (<a href="https://github.com/tpope/vim-commentary.git">tpope/vim-commentary</a>)  

### hlchunk.nvim (<a href="https://github.com/shellRaining/hlchunk.nvim.git">shellRaining/hlchunk.nvim</a>)  

### lualine.nvim (<a href="https://github.com/nvim-lualine/lualine.nvim.git">nvim-lualine/lualine.nvim</a>)  

### nvim-treesitter (<a href="https://github.com/nvim-treesitter/nvim-treesitter.git">nvim-treesitter/nvim-treesitter</a>)  

### nvim-treesitter-context (<a href="https://github.com/nvim-treesitter/nvim-treesitter-context.git">nvim-treesitter/nvim-treesitter-context</a>)  

### mason.nvim (<a href="https://github.com/mason-org/mason.nvim.git">mason-org/mason.nvim</a>)  
`ltex`, `texlab`, `fortls`, `pylsp`, and `lua_ls` will be installed.

### mason-lspconfig.nvim (<a href="https://github.com/mason-org/mason-lspconfig.nvim.git">mason-org/mason-lspconfig.nvim</a>)  

### nvim-lspconfig (<a href="https://github.com/neovim/nvim-lspconfig.git">neovim/nvim-lspconfig</a>)  
This repository comes with the following Language Server Protocol (LSP) servers installed: `ltex`, `texlab`, `fortls`, `pylsp`, and `lua_ls`.
They will provide highlighting, virtual text annotations, and signs in the statuscolumn for syntax errors.
Hovers, auto-completion, and code-action are intentionally disabled to avoid disrupting focus.
If certain English words are incorrectly flagged as spelling mistakes by ltex, add them to `$HOME/.config/ltex/dictionary.en-US.txt`.

### nvim-surroud (<a href="https://github.com/kylechui/nvim-surround.git">kylechui/nvim-surround</a>)  

### oil.nvim (<a href="https://github.com/stevearc/oil.nvim.git">stevearc/oil.nvim</a>)  
Newly defined key bindings
| Key | Action | Description |
|-----|--------|-------------|
| `<C-h>` | `<Nop>` | (this command was removed) |
| `<C-l>` | `<Nop>` | (this command was removed) |
| `<BS>` | `'actions.parent'` | move to parent directory |
| `<C-CR>` | `'actions.select_tab'` | open selected file/directory in a new tab |
| `<CR>` |  | open selected file in a new tab, or move to the directory if a directory is selected |
| `<leader>e` | | open/close oil window |

### plenary.nvim (<a href="https://github.com/nvim-lua/plenary.nvim.git">nvim-lua/plenary.nvim</a>)  

### telescope-fzf-native.nvim (<a href="https://github.com/nvim-telescope/telescope-fzf-native.nvim.git">nvim-telescope/telescope-fzf-native.nvim</a>)  

### telescope.nvim (<a href="https://github.com/nvim-telescope/telescope.nvim.git">nvim-telescope/telescope.nvim</a>)  
Descriptions follow these of <a href="https://github.com/nvim-telescope/telescope.nvim?tab=readme-ov-file#pickers">official GitHub repository</a>.  
Key bindings
| Key | Description |
|-----|-------------|
| `<leader>ff` | lists files in your current working directory |
| `<leader>fg` | search for a string in your current working directory and get results live as you type |
| `<leader>fG` | searches for the string under your cursor or selection in your current working directory |
| `<leader>fb` | lists open buffers in current neovim instance |
| `<leader>fh` | lists available help tags and opens a new window with the relevant help info on `<CR>` |
| `<leader>gc` | lists git commits with diff preview |
| `<leader>gs` | lists current changes per file with diff preview and add action |

`<leader>fg` command needs <a href="https://github.com/BurntSushi/ripgrep.git">ripgrep</a>.

### toggleterm.nvim (<a href="https://github.com/akinsho/toggleterm.nvim.git">akinsho/toggleterm.nvim</a>)  
Key bindings
| Key | Description |
|-----|-------------|
| `<leader>tt` | open terminal in a new window |
| `<leader>tv` | open terminal in a new vertical split |
| `<leader>th` | open terminal in a new horizontal split |

### vimtex (<a href="https://github.com/lervag/vimtex.git">lervag/vimtex</a>)  
To edit latex source code using vimtex, install Skim on macOS, SumatraPDF on Windows, and Zathura on Linux.
Also, `latexmk` is needed to compile source codes.  
Key bindings
| Key | Description |
|-----|-------------|
| `<localleader>ll` | compile souce. if `.latexmkrc` is not in the same directory as the main file, it will be generated automatically |
| `<localleader>le` | open/close error window |

The automatically generated `.latexmkrc` is a copy of `tools/.latexmkrc`.
To change the compile method, edit the original `tools/.latexmkrc`.

#### NOTE
- VimTex's settings have not been tested on Windows and Linux.






