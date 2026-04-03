# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

Personal Neovim configuration targeting a full VSCode-replacement workflow for web development (HTML, CSS, JS/TS, Astro), Rust, Python, C, and Lua. Uses lazy.nvim for plugin management.

## Formatting

Lua files are formatted with StyLua. Config: `stylua.toml` — 120 column width, tabs, 4-space indent width, always collapse simple statements. Format-on-save is enabled via conform.nvim.

To format manually: `stylua .`

**Formatter assignments** (conform.nvim):
| Language | Formatter | Notes |
|---|---|---|
| Lua | `stylua` | |
| JS/TS/CSS/HTML | `biome` | |
| Astro | `prettier` (astro parser) | Requires project-level prettier config |
| Rust | `rustfmt` | Uses nightly toolchain |
| C | `clang-format` | Custom config at `lua/config/formatters/.clang-format` |

**Format-on-save exception:** `xmake.lua` files are excluded (conform skips them by filename check).

## Architecture

**Entry point:** `init.lua` → `lua/config/lazy.lua` (bootstraps lazy.nvim, sets vim options, loads all plugin specs).

**Plugin specs** are organized by category under `lua/plugins/`:
- `completion/` — blink.cmp autocompletion, snippet loaders
- `editor/` — autopairs, autotag, surround, searchbox, comma/semicolon toggler
- `lang/` — treesitter, rustaceanvim, crates.nvim, lazydev, astro
- `lsp/` — nvim-lspconfig (all LSP server configs), conform.nvim (formatting)
- `tools/` — snacks.nvim (dashboard/explorer/picker), toggleterm, which-key
- `ui/` — theme (gruvbox + transparency), lualine, indent guides, rainbow delimiters, icons, inline diagnostics

**Keybindings** are split into domain files under `lua/config/keybinds/` and loaded by which-key:
- `general.lua` — save, quit, comment, explorer, window nav, LSP (gd/gr/ss/code actions)
- `find.lua` — `<leader>f` group: file finder, git files, in-file search/replace
- `search.lua` — `<leader>s` group: live grep, grep word, grep buffers
- `git.lua` — `<leader>g` group: git log/status/issues/PRs via snacks pickers
- `terminal.lua` — `<leader>t` group: toggleterm instances, cargo run, xmake, C compile
- `buffers.lua` — `<leader>b` group + `<leader>,`: buffer picker, delete buffers
- `npm.lua` — `<leader>n` group: npm run dev

Leader is `<Space>`, local leader is `;`.

**Terminal presets** (`lua/config/terms.lua`): Pre-configured toggleterm terminals for `claude` (vertical split), `cargo run`, `xmake run` (release/debug), `npm run dev`, and a C compile-and-run helper that builds the current file with gcc.

**LSP configuration** uses the Neovim 0.11+ `vim.lsp.config()` / `vim.lsp.enable()` API (not the older `lspconfig.server.setup()` pattern). All servers get blink.cmp capabilities injected.

Configured servers:
| Server | Language(s) | Notes |
|---|---|---|
| `ts_ls` | JavaScript / TypeScript | |
| `html` | HTML | |
| `cssls` | CSS / SCSS | |
| `emmet_language_server` | Emmet (HTML/CSS/JSX/Svelte/Vue) | |
| `astro` | Astro | Custom TypeScript SDK resolution (project → global fallback) |
| `lua_ls` | Lua | Recognizes xmake DSL globals |
| `ruff` | Python (linting/formatting) | Hover disabled (deferred to ty) |
| `ty` | Python (type checking/hover) | |
| `clangd` | C | |

Rust LSP is handled by `rustaceanvim` (not in lspconfig).

**Astro-specific completion logic** in `blinkcmp.lua`:
- Emmet abbreviation completions are filtered out in Astro files (they conflict with template expressions)
- A custom `TextChangedI` autocmd triggers LSP completions inside `{}` expression blocks where blink.cmp wouldn't normally auto-trigger
- Completion uses `prefix` range matching instead of `full` for better Astro template behavior
- `{` is removed from blocked trigger characters in Astro files

**Custom snippets** live in `snippets/` using LuaSnip format — `global.lua` for all filetypes, `javascript.lua` and `shared/js_ts.lua` for JS/TS.

## Key Conventions

- Each plugin spec is a single file returning a lazy.nvim plugin table
- Lua code uses tabs for indentation (per stylua.toml), not spaces — note that `expandtab` is on in the editor (types spaces), but stylua converts to tabs on save for `.lua` files
- The config uses modern Neovim APIs: `vim.lsp.config/enable`, `vim.treesitter.start()`, `vim.uv`
- Theme: gruvbox with forced transparent background (the `unokai` colorscheme in `lazy.lua` is overridden by gruvbox in `theme.lua`)
- blink.cmp builds from source (`cargo build --release`) — Rust toolchain required
- Editor settings: 2-space display tabs, relative line numbers, format-on-save, scroll offset 8
