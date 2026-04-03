# Neovim Config

Personal Neovim configuration targeting a full VSCode-replacement workflow for vanilla web development (HTML, CSS, JS/TS) and Rust. Uses [lazy.nvim](https://github.com/folke/lazy.nvim) for plugin management.

## Structure

```
~/.config/nvim/
├── init.lua                  # Entry point — loads config/lazy
├── lazy-lock.json            # Plugin version lockfile
├── snippets/                 # Custom snippet definitions
└── lua/
    ├── config/
    │   ├── lazy.lua          # Core settings, keymaps, lazy.nvim bootstrap
    │   ├── my-theme.lua      # Custom theme configuration
    │   └── terms.lua         # Terminal configuration
    └── plugins/
        ├── completion/       # Completion & snippet engines
        ├── editor/           # Text editing enhancements
        ├── lang/             # Language-specific support
        ├── lsp/              # Language server & formatting
        ├── tools/            # Utilities, navigation, terminal
        └── ui/               # Visual appearance & display
```

## Core Settings (`lua/config/lazy.lua`)

- **Leader key:** `<Space>` (local leader: `\`)
- **`<leader>cd`** — open netrw file explorer
- **`<C-s>`** — save (normal, visual + insert mode)
- **Colorscheme:** `unokai` (custom)
- **Editor:** relative line numbers, cursor line highlight, smart indent, 2-space tabs, scroll offset of 8, true color enabled

---

## Plugins

### Completion (`plugins/completion/`)

#### blink.cmp (`saghen/blink.cmp`)

Fast autocompletion engine written in Rust. The Neovim equivalent of VSCode's IntelliSense popup. Sources completions from LSP, file paths, snippets (via `friendly-snippets`), and current buffer text. Uses mono-style nerd font icons. Fuzzy matching uses the native Rust implementation for speed.

#### Snippets (`blink.compat` + custom loaders)

Snippet management with global and language-specific loaders. Works with the custom snippets defined in `snippets/`.

---

### Editor (`plugins/editor/`)

#### nvim-autopairs

Auto-closes brackets, quotes, and other paired characters as you type.

#### nvim-ts-autotag

Automatically closes and renames HTML/JSX tags as you type using treesitter. All three features enabled: auto-close, auto-rename, and close-on-slash (`<div>/` → `<div></div>`).

#### nvim-surround

Manipulate surrounding characters — add, change, or delete quotes, brackets, tags, and more.

#### searchbox.nvim

Enhanced find/replace with a floating UI popup.

---

### Language Support (`plugins/lang/`)

#### Treesitter (`nvim-treesitter`)

Provides accurate, AST-based syntax highlighting. Installs parsers for `html`, `css`, `javascript`, `typescript`, `tsx`, and `lua`. Uses a `FileType` autocmd to activate `vim.treesitter.start()` — the modern Nvim 0.10+ approach.

#### rustaceanvim

Enhanced Rust development with extended rust-analyzer integration — code actions, hover info, and test running.

#### crates.nvim

Rust crate management helper for `Cargo.toml` files — version info, available updates, and feature flags.

---

### LSP (`plugins/lsp/`)

#### nvim-lspconfig

Configures Neovim's built-in LSP client. This is the backbone — diagnostics, go-to-definition, hover docs, and completions all flow through here.

| Server                  | Language(s)                   |
| ----------------------- | ----------------------------- |
| `html`                  | HTML                          |
| `cssls`                 | CSS / SCSS                    |
| `ts_ls`                 | JavaScript / TypeScript       |
| `emmet_language_server` | Emmet abbreviation expansion  |
| `lua_ls`                | Lua (for editing this config) |

All web servers share a `root_dir` function that walks up from the current file looking for `.git` or `package.json`. Every server gets blink.cmp capabilities injected so completions flow through properly. The Lua server is configured to recognize the `vim` global and load Neovim's API docs.

#### conform.nvim

Code formatter with format-on-save support. Configured formatters: `rustfmt` (Rust), `stylua` (Lua), `biome` (JS/TS/CSS).

---

### Tools (`plugins/tools/`)

#### snacks.nvim

Swiss-army-knife plugin providing a dashboard, file explorer, and picker (file/git/grep/LSP search). Replaces the need for separate telescope/neo-tree plugins.

#### toggleterm.nvim

Integrated terminal with Nu shell support — VSCode's bottom panel terminal equivalent.

#### which-key.nvim

Keybinding help menu that pops up after pressing leader. Also serves as the central keybinding configuration with mappings for terminal, file finding, git, buffer management, and more.

---

### UI (`plugins/ui/`)

#### Theme (gruvbox + lualine)

Gruvbox colorscheme with lualine status bar showing mode, branch, diagnostics, and file type.

#### indent-blankline.nvim

Rainbow-colored vertical indent guides.

#### rainbow-delimiters.nvim

Color-codes nested brackets and parentheses for easier visual matching.

#### nvim-web-devicons

File type icons used by other plugins (lualine, snacks, etc.).

#### tiny-inline-diagnostic.nvim

Displays inline error/warning messages with minimal UI, replacing the default virtual text diagnostics.

---

## End Game: VSCode Replacement for Vanilla Web Dev

### The Goal

A Neovim setup that fully replaces VSCode for vanilla web development — HTML, CSS, JavaScript, TypeScript, and Rust.

### What's In Place

| VSCode Feature                       | Neovim Equivalent                   | Status |
| ------------------------------------ | ----------------------------------- | ------ |
| Syntax highlighting                  | Treesitter                          | Done   |
| IntelliSense / completions           | blink.cmp + LSP servers             | Done   |
| Go-to-definition, hover, diagnostics | nvim-lspconfig (ts_ls, html, cssls) | Done   |
| Emmet expansion                      | emmet_language_server               | Done   |
| Auto-close/rename HTML tags          | nvim-ts-autotag                     | Done   |
| File finder (`Cmd+P`)               | snacks.nvim picker                  | Done   |
| Project-wide search (`Cmd+Shift+F`) | snacks.nvim grep picker             | Done   |
| Quick save (`Cmd+S`)                | `<C-s>`                             | Done   |
| File explorer sidebar                | snacks.nvim explorer                | Done   |
| Format on save                       | conform.nvim                        | Done   |
| Auto pairs                           | nvim-autopairs                      | Done   |
| Statusline                           | lualine.nvim                        | Done   |
| Indent guides                        | indent-blankline.nvim               | Done   |
| Bracket colorization                 | rainbow-delimiters.nvim             | Done   |
| Integrated terminal                  | toggleterm.nvim                     | Done   |
| Snippet management                   | blink.cmp + custom snippets         | Done   |
| Inline diagnostics                   | tiny-inline-diagnostic.nvim         | Done   |
| Keybinding discoverability           | which-key.nvim                      | Done   |
| Rust tooling                         | rustaceanvim + crates.nvim          | Done   |

### What's Still Missing

| VSCode Feature           | What to Add                                                            | Notes                                                                    |
| ------------------------ | ---------------------------------------------------------------------- | ------------------------------------------------------------------------ |
| **Git integration**      | `gitsigns.nvim` (gutter signs) + `fugitive` or `neogit`               | VSCode shows git changes in the gutter and has a source control panel.   |
| **Color preview**        | `nvim-colorizer.lua`                                                   | Inline color swatches for hex/rgb values in CSS.                         |
| **Multi-cursor editing** | `vim-visual-multi` or learn Neovim-native alternatives (macros, `cgn`) | Different paradigm in Vim — macros and `cgn` often replace multi-cursor. |
| **Error/warning list**   | `trouble.nvim` or use built-in `:lopen`                                | VSCode's Problems panel equivalent.                                      |

### Priority Order for Next Steps

1. **Git gutter signs** — see what's changed without leaving the file
2. **Color preview** — helpful for CSS work
3. **Error/warning list** — dedicated diagnostics panel

Everything after that is polish. The core editing loop (write code → get completions → navigate → find files → format → save) is fully functional.
