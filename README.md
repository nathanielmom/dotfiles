# Dotfiles

Personal configuration for Neovim, tmux, and shell. Default shell is fish.

## Quick start

```bash
git clone https://github.com/nathanielmom/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

`install.sh` symlinks:
- `tmux/tmux.conf` → `~/.config/tmux/tmux.conf` + `~/.tmux.conf` (both, for tmux < 3.1)
- `nvim/` → `~/.config/nvim`

## Neovim

Requires **Neovim 0.12+**.

### Theme setup

Copy the env example and set your theme:

```bash
cp ~/.dotfiles/nvim/.env.example ~/.config/nvim/.env
```

Edit `.env`:

```sh
THEME=catppuccin          # matches a file in lua/user/plugins/<THEME>.lua
COLORSCHEME=catppuccin-mocha  # passed directly to :colorscheme
```

Available themes: `catppuccin`, `tokyonight`, `onedark`, `gruvbox`.

### Plugins

Most plugins are managed by [lazy.nvim](https://github.com/folke/lazy.nvim). Treesitter uses Neovim 0.12's built-in `vim.pack` due to a compatibility issue with lazy.nvim on 0.12.

LSP servers are installed by [mason.nvim](https://github.com/williamboman/mason.nvim). Auto-installed servers: `clangd`, `ts_ls`, `lua_ls`, `tailwindcss`, `jsonls`, `emmet_language_server`, `intelephense`. Dart LSP (`dartls`) requires the Dart SDK installed separately.

### Key mappings

Leader key is `<Space>`.

**Navigation**

| Key | Action |
|-----|--------|
| `<C-h/j/k/l>` | Move between splits |
| `<leader>sf` | Find files (Telescope) |
| `<leader>sg` | Live grep |
| `<leader>sw` | Grep word under cursor |
| `<leader>sb` | Search open buffers |
| `<leader>sr` | Recently opened files |
| `<leader>\`` | Toggle file tree (Neo-tree) |

**LSP**

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Go to references |
| `gI` | Go to implementation |
| `K` | Hover documentation |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |
| `[d` / `]d` | Previous / next diagnostic |
| `<leader>e` | Open diagnostic float |

**Git**

| Key | Action |
|-----|--------|
| `]h` / `[h` | Next / previous hunk |
| `gs` | Stage hunk |
| `gS` | Undo stage hunk |
| `gp` | Preview hunk |
| `gb` | Blame line |

**Testing** (via vim-test, runs in floaterm)

| Key | Action |
|-----|--------|
| `<leader>tn` | Run nearest test |
| `<leader>tf` | Run test file |
| `<leader>ts` | Run test suite |
| `<leader>tl` | Re-run last test |

**Treesitter text objects**

| Key | Action |
|-----|--------|
| `aa` / `ia` | Parameter outer / inner |
| `af` / `if` | Function outer / inner |
| `ac` / `ic` | Class outer / inner |
| `<leader>a` / `<leader>A` | Swap parameter with next / prev |

**Other**

| Key | Action |
|-----|--------|
| `<leader>w` | Save file |
| `<C-f>` (insert) | Accept Copilot suggestion |
| `<leader>2` | Copilot panel |
| `<leader>pm` | PHPActor context menu |
| `<leader>h` | Clear search highlights |
| `<F1>` | Toggle floating terminal |

## tmux

Prefix: `C-Space` (secondary: `C-b`).

**Panes**

| Key | Action |
|-----|--------|
| `prefix h` | Split horizontal |
| `prefix v` | Split vertical |
| `prefix x` | Kill pane |
| `C-M-Arrow` | Navigate panes |
| `C-M-S-Arrow` | Resize panes |

**Windows**

| Key | Action |
|-----|--------|
| `M-1` … `M-9` | Select window by number |
| `M-Left/Right` | Previous / next window |
| `M-S-Left/Right` | Move window left / right |
| `prefix r` | Rename window |
| `prefix k` | Kill window |

**Sessions**

| Key | Action |
|-----|--------|
| `M-Up/Down` | Previous / next session |
| `prefix R` | Rename session |
| `prefix K` | Kill session |

**Other**

| Key | Action |
|-----|--------|
| `prefix q` | Reload tmux config |
| `v` / `y` | Begin / copy selection (copy mode) |
