VSCode Neovim Setup Guide

Personal reference for integrating Neovim into VSCode using the vscode-neovim extension.

What is it?

The vscode-neovim extension embeds a real Neovim instance inside VSCode. It's not a Vim emulator — it runs actual nvim as a backend process.

The split:

Neovim owns: Normal mode, visual mode, motions, text objects, macros, registers, dot-repeat, and custom keybindings from init.lua.
VSCode owns: Insert mode (autocomplete, Copilot, snippets, multi-cursor), LSP, file explorer, debugger, Git UI, extensions, and theming.
Installation

Install Neovim 0.10.0+
Install the vscode-neovim extension from the VS Code marketplace
(Optional) Set the Neovim binary path in extension settings: vscode-neovim.neovimExecutablePaths.darwin (or .linux / .win32)
Config Structure

No separate config directory. The extension reads the existing ~/.config/nvim/init.lua. Use vim.g.vscode to branch behavior.

~/.config/nvim/
├── init.lua                  ← entry point (shared + branching)
├── lua/
│   ├── config/
│   │   ├── lazy.lua          ← plugin manager bootstrap
│   │   └── keybinds/
│   │       ├── shared.lua    ← keybinds for both environments
│   │       ├── vscode.lua    ← VSCode-specific remaps
│   │       └── terminal.lua  ← terminal Neovim keybinds
│   └── plugins/
│       ├── editor/           ← loads in both (surround, commasemi, which-key)
│       ├── completion/       ← gated: terminal only
│       ├── lang/             ← gated: terminal only
│       ├── lsp/              ← gated: terminal only
│       ├── tools/            ← gated: terminal only
│       └── ui/               ← gated: terminal only

init.lua

if vim.g.vscode then
    -- VSCode handles these natively
else
    vim.cmd.colorscheme("unokai")
    vim.opt.number = true
    vim.opt.relativenumber = true
    vim.opt.cursorline = true
    vim.opt.termguicolors = true
end

-- Shared settings (both environments)
vim.opt.scrolloff = 8
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

require("config.lazy")

lazy.lua — Gating Plugin Groups

Use cond = not vim.g.vscode on the import level to gate entire folders:

require("lazy").setup({
    spec = {
        { import = "plugins.editor" },                              -- always
        { import = "plugins.completion", cond = not vim.g.vscode }, -- terminal only
        { import = "plugins.lang",       cond = not vim.g.vscode },
        { import = "plugins.lsp",        cond = not vim.g.vscode },
        { import = "plugins.tools",      cond = not vim.g.vscode },
        { import = "plugins.ui",         cond = not vim.g.vscode },
    },
    checker = { enabled = true, notify = false },
    change_detection = { notify = false },
    rocks = { hererocks = true },
})

For individual plugins in a "keep" folder that should still be gated:

-- e.g. plugins/editor/autopairs.lua
return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    cond = not vim.g.vscode,  -- VSCode handles bracket pairing
    opts = {},
}

Plugin Sorting

Gate off (cond = not vim.g.vscode) — VSCode handles these

Plugin	Reason
blink.cmp	VSCode completion
nvim-lspconfig	VSCode LSP
nvim-treesitter	VSCode syntax highlighting
nvim-autopairs	VSCode bracket pairing
nvim-ts-autotag	VSCode HTML tag closing
indent-blankline.nvim	VSCode indent guides
rainbow-delimiters.nvim	VSCode bracket colorization
rainbow-variables-nvim	VSCode highlighting
lualine.nvim	VSCode status bar
tiny-inline-diagnostic.nvim	VSCode diagnostics
smear-cursor.nvim	VSCode cursor rendering
gruvbox.nvim / unokai	VSCode theme
lazydev.nvim	LSP dependency
nui.nvim	Terminal UI dependency
nvim-web-devicons	Terminal UI dependency
vim-astro	Treesitter dependency
Keep (no cond) — Useful in both environments

Plugin	Reason
mini.surround	Text editing (surround motions)
commasemi.nvim	Text editing (toggle trailing chars)
which-key.nvim	Keybind discovery
friendly-snippets	Snippet definitions
mini.snippets	Snippet engine
Your call — depends on workflow

Plugin	Consideration
toggleterm.nvim	VSCode has integrated terminal
conform.nvim	VSCode has formatters
searchbox.nvim	VSCode has search
snacks.nvim	Depends which modules you use
rustaceanvim / crates.nvim	VSCode has rust-analyzer extension
Keybind Sorting

Shared — work in both environments

Keybind	Description
<C-s>	Save (insert mode)
<leader>w	Save
<leader>q	Quit
<leader>/	Toggle comment
<leader>j / <leader>k	Insert blank lines
<leader>nh	Clear search highlights
;n / ;{	Literal inserts
<C-h/j/k/l>	Window/split navigation
gd	Go to definition (extension maps this automatically)
<leader>ca	Code actions (extension maps this automatically)
Remap for VSCode (~/.config/nvim/lua/config/keybinds/vscode.lua)

local vscode = require("vscode")

-- Find / Search
vim.keymap.set("n", "<leader>ff", function() vscode.action("workbench.action.quickOpen") end)
vim.keymap.set("n", "<leader>fg", function() vscode.action("workbench.action.quickOpen") end)
vim.keymap.set("n", "<leader>fs", function() vscode.action("actions.find") end)
vim.keymap.set("n", "<leader>fr", function() vscode.action("editor.action.startFindReplaceAction") end)
vim.keymap.set("n", "<leader>sg", function() vscode.action("workbench.action.findInFiles") end)
vim.keymap.set("n", "<leader>sw", function()
    vscode.action("workbench.action.findInFiles", {
        args = { query = vim.fn.expand("<cword>") }
    })
end)

-- Explorer
vim.keymap.set("n", "<leader>e", function() vscode.action("workbench.view.explorer") end)

-- LSP
vim.keymap.set("n", "gr", function() vscode.action("editor.action.goToReferences") end)
vim.keymap.set("n", "ss", function() vscode.action("workbench.action.gotoSymbol") end)

-- Buffers → Editors
vim.keymap.set("n", "<leader>,", function() vscode.action("workbench.action.showAllEditors") end)
vim.keymap.set("n", "<leader>bd", function() vscode.action("workbench.action.closeActiveEditor") end)
vim.keymap.set("n", "<leader>bD", function() vscode.action("workbench.action.closeAllEditors") end)
vim.keymap.set("n", "<leader>bo", function() vscode.action("workbench.action.closeOtherEditors") end)

-- Git
vim.keymap.set("n", "<leader>gs", function() vscode.action("workbench.view.scm") end)
vim.keymap.set("n", "<leader>gl", function() vscode.action("git.viewHistory") end)

Terminal only — drop for VSCode

Keybind	Description
<leader>tb/t1/t2/t3/ts	toggleterm bindings
<leader>tr	Claude terminal
<leader>cc / <leader>cci	Compile C file
<leader>xrr / <leader>xrd	xmake run
<leader>nrd	npm run dev
<leader>uv	uv run
<leader>gl/gs/gi/gI/gp/gP/gf	Git pickers (Snacks/Telescope)
Insert mode — configured on VSCode side

Add to VSCode's settings.json:

{
    "vscode-neovim.compositeKeys": {
        "jj": {
            "command": "vscode-neovim.escape"
        }
    }
}

<C-z>, <C-S-z>, and <S-CR> are handled natively by VSCode in insert mode.

Keybind Loader

Wire everything together in init.lua or a keybinds init file:

if vim.g.vscode then
    require("config.keybinds.vscode")
else
    require("config.keybinds.terminal")
end
require("config.keybinds.shared")

Key Gotchas

:e, :q, :vsplit, etc. are remapped to VSCode equivalents — behavior differs slightly. :w and :wa work normally.
Insert mode is fully owned by VSCode — jj escape and similar must be configured in VSCode's settings.json, not init.lua.
Jumplist uses VSCode's navigation stack, so mouse clicks and "Go to Definition" are navigable with <C-o> / <C-i>.
Multi-cursor: Select lines in visual line/block mode, then ma/mi to spawn VSCode multi-cursors.
<leader>cd (vim.cmd.Ex) won't work — netrw doesn't apply. Remap to workbench.view.explorer.
Performance: Disable Neovim plugins that render decorators (line numbers, indent guides, bracket highlighters) — VSCode handles all of these.
Mac key repeat: Run defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false if h/j/k/l don't repeat when held.
VSCode Neovim API Quick Reference

local vscode = require("vscode")

vscode.action("command.name")              -- async execute VSCode command
vscode.call("command.name")                -- sync execute VSCode command
vscode.get_config("editor.tabSize")        -- read VSCode setting
vscode.update_config("key", value)         -- write VSCode setting
vscode.notify("message")                   -- show VSCode notification
vscode.eval("return vscode.window...")     -- evaluate JS in VSCode context
