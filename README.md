# nvim-config

Personal Neovim config built on [lazy.nvim](https://github.com/folke/lazy.nvim), with LSP (Mason), Treesitter, Telescope, and gruvbox as the default colorscheme.

## Prerequisites

- Neovim >= 0.10
- [git](https://git-scm.com/)
- [ripgrep](https://github.com/BurntSushi/ripgrep) (needed for Telescope's live grep)
- A [Nerd Font](https://www.nerdfonts.com/) set in your terminal (for icons)
- `node` and `npm` (for JS/TS/HTML language servers)
- `python3` and `pip` (for Python language servers)

## Install

```bash
# back up any existing config first
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null

git clone git@github.com:UjjavalParmar/nvim-config.git ~/.config/nvim

nvim
```

On first launch, `lazy.nvim` bootstraps itself and installs all plugins automatically. Once that finishes:

1. Restart Neovim.
2. Run `:Mason` and confirm the language servers install (they're set to auto-install via `ensure_installed`: `lua_ls`, `pyright`, `ruff`, `ts_ls`, `html`, `terraformls`).
3. Run `:TSUpdate` if any Treesitter parsers didn't install automatically.

## Structure

```
init.lua                    -- entry point
lua/ultron/
  init.lua                  -- autocmds, filetypes, global options
  set.lua                   -- vim.opt settings
  remap.lua                 -- keymaps
  lazy_init.lua             -- bootstraps lazy.nvim
  lazy/                     -- one file per plugin (or plugin group)
    colors.lua               -- colorschemes (gruvbox is active)
    lsp.lua                   -- mason, lspconfig, nvim-cmp
    treesitter.lua            -- parsers + textobjects
    telescope.lua             -- fuzzy finder + keymaps
    ...
```

## Changing the colorscheme

Edit the default in `lua/ultron/lazy/colors.lua`:

```lua
function ColorMyPencils(color)
    color = color or "gruvbox"   -- change this
    ...
```

## Keymaps worth knowing

- Leader key: `<space>`
- `<leader>pf` — find files
- `<C-p>` — find git files
- `<leader>pws` — grep word under cursor
- `gd` / `K` — go to definition / hover (once LSP attaches)

