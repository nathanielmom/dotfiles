# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Setup

Run `./install.sh` to symlink configs into place:
- `tmux/tmux.conf` → `~/.config/tmux/tmux.conf` and `~/.tmux.conf` (both, for pre-3.1 tmux compatibility)
- `nvim/` → `~/.config/nvim`

Shell config directories (`bash/`, `fish/`, `zsh/`, `vim/`) are currently empty placeholders. Default shell is fish.

## Neovim architecture

This config targets **Neovim 0.12+** and uses a hybrid plugin management approach: most plugins are managed by lazy.nvim, but treesitter is installed via `vim.pack` (Neovim's built-in package manager) due to a compatibility issue with lazy.nvim on 0.12. LSP uses the 0.12 API (`vim.lsp.config`/`vim.lsp.enable`) rather than the older `require('lspconfig').server.setup()` pattern.

`nvim/init.lua` loads five modules in order: `env` → `options` → `keymaps` → `misc` → `plugins`.

**`lua/user/`**
- `env.lua` — reads `~/.config/nvim/.env` (gitignored) and injects variables into `vim.env`. The `THEME` variable selects which colorscheme plugin to load.
- `options.lua` — editor options (4-space tabs, relative numbers, no wrap, spell check, scrolloff=8)
- `keymaps.lua` — global keymaps; leader is `<Space>`
- `misc.lua` — autocommands (yank highlight)
- `plugins.lua` — plugin manager bootstrap + treesitter setup

**Plugin managers (two coexist)**

- **lazy.nvim** manages most plugins. Individual plugin specs live in `lua/user/plugins/*.lua` and are imported via `{ import = 'user.plugins.<name>' }`.
- **`vim.pack`** (Neovim 0.12 native) manages nvim-treesitter and nvim-treesitter-textobjects. Treesitter config (parser installation, highlight, indent, folds, textobjects, keymaps) lives entirely in `plugins.lua`. The `lua/user/plugins/treesitter.lua` file exists but is commented out in `plugins.lua`.

**LSP setup** (`lua/user/plugins/lspconfig.lua`)

mason-lspconfig installs servers but has `automatic_enable = false`. Each LSP is enabled explicitly using the Neovim 0.12 API (`vim.lsp.config(name, opts)` + `vim.lsp.enable(name)`). To add a new LSP: add it to the `servers` table (for mason to install), then add a `vim.lsp.config` + `vim.lsp.enable` block.

## Key keymaps

| Key | Action |
|-----|--------|
| `<Leader>w` | Save file |
| `<C-h/j/k/l>` | Navigate splits (mirrors tmux pane navigation) |
| `<Leader>sf/sg/sw/sb` | Telescope: find files / live grep / grep word / buffers |
| `<Leader>rn` / `<Leader>ca` | LSP rename / code action |
| `gd` / `gr` / `gI` | LSP goto definition / references / implementation |
| `K` | LSP hover docs |
| `[d` / `]d` | Previous/next diagnostic |
| `<C-f>` (insert) | Accept Copilot suggestion |
| `<Leader>tn/tf/ts/tl` | vim-test: nearest / file / suite / last |
| `<Leader>a` / `<Leader>A` | Swap next/prev function parameter (treesitter) |
| `aa/ia/af/if/ac/ic` | Treesitter text objects: parameter outer/inner, function, class |

## Tmux

Prefix: `C-Space` (secondary: `C-b`). Reload config: `prefix q`.

| Action | Key |
|--------|-----|
| Split horizontal / vertical | `prefix h` / `prefix v` |
| Navigate panes | `C-M-Arrow` |
| Resize panes | `C-M-S-Arrow` |
| Select window 1–9 | `M-1` … `M-9` |
| Previous / next window | `M-Left` / `M-Right` |
| Move window left / right | `M-S-Left` / `M-S-Right` |
| Previous / next session | `M-Up` / `M-Down` |
| Kill pane / window / session | `prefix x` / `prefix k` / `prefix K` |

Vi keys in copy mode; `v` to select, `y` to copy.

## Adding a colorscheme

1. Create `nvim/lua/user/plugins/<theme-name>.lua` returning a lazy plugin spec.
2. Set `THEME=<theme-name>` in `~/.config/nvim/.env`.
