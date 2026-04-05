# Neovim Keybinds Reference

Leader: `<Space>` — Local leader: `;`

---

## General

| Keybind | Mode | Description |
|---|---|---|
| `<C-s>` | Insert | Save |
| `<leader>w` | Normal | Save |
| `<leader>q` | Normal, Visual | Quit |
| `<leader>wq` | Normal, Visual | Write and Quit |
| `<leader>/` | Normal | Toggle comment (line) |
| `<leader>/` | Visual | Toggle comment (selection) |
| `<leader>e` | Normal | File Explorer |
| `<leader>j` | Normal | Insert blank line below |
| `<leader>k` | Normal | Insert blank line above |
| `<leader>nh` | Normal | Clear search highlights |
| `;n` | Normal | Insert literal `\n` at cursor |
| `;n` | Insert | Insert literal `\n` at cursor |
| `;{` | Normal, Insert | Insert detached braces (C files only) |

---

## Insert Mode

| Keybind | Mode | Description |
|---|---|---|
| `jj` | Insert | Exit insert mode |
| `<S-CR>` | Insert | New line below (stays in insert) |
| `<C-z>` | Insert | Undo |
| `<C-S-z>` | Insert | Redo |

---

## Window Navigation

| Keybind | Mode | Description |
|---|---|---|
| `<C-h>` | Normal, Terminal, Insert | Focus window left |
| `<C-j>` | Normal, Terminal, Insert | Focus window down |
| `<C-k>` | Normal, Terminal, Insert | Focus window up |
| `<C-l>` | Normal, Terminal, Insert | Focus window right |

---

## LSP

| Keybind | Mode | Description |
|---|---|---|
| `gd` | Normal | Go to definition |
| `gr` | Normal | LSP references |
| `ss` | Normal | LSP symbols |
| `<leader>ca` | Normal | Code actions |

---

## Find (`<leader>f`)

| Keybind | Mode | Description |
|---|---|---|
| `<leader>ff` | Normal | Find files (cwd) |
| `<leader>fg` | Normal | Git-tracked files picker |
| `<leader>fs` | Normal | Search in file (incremental) |
| `<leader>fr` | Normal | Search and replace in file |

---

## Search (`<leader>s`)

| Keybind | Mode | Description |
|---|---|---|
| `<leader>sg` | Normal | Live grep (project) |
| `<leader>sw` | Normal | Grep word under cursor |
| `<leader>sb` | Normal | Grep open buffers |

---

## Git (`<leader>g`)

| Keybind | Mode | Description |
|---|---|---|
| `<leader>gl` | Normal | Git log |
| `<leader>gs` | Normal | Git status |
| `<leader>gi` | Normal | GitHub issues (open) |
| `<leader>gI` | Normal | GitHub issues (all) |
| `<leader>gp` | Normal | GitHub PRs (open) |
| `<leader>gP` | Normal | GitHub PRs (all) |
| `<leader>gf` | Normal | Git tracked files |

---

## Buffers (`<leader>b`)

| Keybind | Mode | Description |
|---|---|---|
| `<leader>,` | Normal | Buffer picker |
| `<leader>bd` | Normal | Delete current buffer |
| `<leader>bD` | Normal | Delete all buffers |
| `<leader>bo` | Normal | Delete other buffers (keep current) |

---

## Terminal (`<leader>t`)

| Keybind | Mode | Description |
|---|---|---|
| `<leader>tb` | Normal, Terminal | New horizontal terminal |
| `<leader>t1` | Normal, Terminal | Terminal 1 |
| `<leader>t2` | Normal, Terminal | Terminal 2 |
| `<leader>t3` | Normal, Terminal | Terminal 3 |
| `<leader>tr` | Normal, Terminal | Toggle Claude terminal |
| `<leader>tcr` | Normal | Toggle Cargo Run terminal |
| `<leader>ts` | Normal, Terminal | Select terminal |
| `<leader>cc` | Normal | Compile and run current C file |
| `<leader>cci` | Normal | Compile and run current C file (interactive) |

---

## Xmake (`<leader>x`)

| Keybind | Mode | Description |
|---|---|---|
| `<leader>xrr` | Normal | xmake run (release) |
| `<leader>xrd` | Normal | xmake run (debug) |

---

## npm (`<leader>n`)

| Keybind | Mode | Description |
|---|---|---|
| `<leader>nrd` | Normal | npm run dev |

---

## UV / Python (`<leader>u`)

| Keybind | Mode | Description |
|---|---|---|
| `<leader>uv` | Normal | uv run cwd/main.py |
