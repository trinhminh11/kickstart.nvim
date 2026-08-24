# Neovim Keymap Reference

Leader key: `<Space>`
Local leader key: `<Space>`

This file documents Lua mappings found in files that call `vim.keymap.set`, plus a quick reference for default Vim motions. Mappings from LSP, nvim-tree, gitsigns, undotree, and other plugins may only exist in the relevant buffer or after that plugin attaches.

## Modes

| Mode | Meaning |
| --- | --- |
| `n` | Normal |
| `i` | Insert |
| `v` | Visual and Select |
| `x` | Visual only |
| `o` | Operator-pending |
| `t` | Terminal |

## General

| Mode | Key | Action | Source |
| --- | --- | --- | --- |
| `n` | `<Esc>` | Clear search highlights | `init.lua` |
| `n` | `<leader>pv` | Open netrw file explorer with `:Ex` | `lua/fool/99-remap.lua` |
| `i` | `<C-c>` | Leave insert mode | `lua/fool/99-remap.lua` |
| `n` | `<C-f>` | Start substitute for word under cursor across the buffer | `lua/fool/99-remap.lua` |
| `n`, `v` | `<leader>f` | Format current buffer with Conform | `init.lua`, `lua/fool/01-setup.lua` |
| `n` | `<leader>q` | Open diagnostics in the location list | `init.lua` |

## Editing

| Mode | Key | Action | Source |
| --- | --- | --- | --- |
| `n` | `<S-j>` | Move current line down | `lua/fool/99-remap.lua` |
| `n` | `<S-k>` | Move current line up | `lua/fool/99-remap.lua` |
| `v` | `<S-j>` | Move selected lines down | `lua/fool/99-remap.lua` |
| `v` | `<S-k>` | Move selected lines up | `lua/fool/99-remap.lua` |
| `v` | `>` | Indent selection and keep it selected | `lua/fool/99-remap.lua` |
| `v` | `<` | Outdent selection and keep it selected | `lua/fool/99-remap.lua` |
| `n` | `dx` | Delete current line normally, preserving default yank behavior | `lua/fool/99-remap.lua` |
| `n` | `dd` | Delete current line into the black-hole register | `lua/fool/99-remap.lua` |
| `x` | `x` | Delete selection normally, preserving default yank behavior | `lua/fool/99-remap.lua` |
| `x` | `d` | Delete selection into the black-hole register | `lua/fool/99-remap.lua` |

## Search And Movement Tweaks

| Mode | Key | Action | Source |
| --- | --- | --- | --- |
| `n` | `n` | Next search result and center cursor | `lua/fool/99-remap.lua` |
| `n` | `N` | Previous search result and center cursor | `lua/fool/99-remap.lua` |
| `n` | `<C-d>` | Scroll half-page down and center cursor | `lua/fool/99-remap.lua` |
| `n` | `<C-u>` | Scroll half-page up and center cursor | `lua/fool/99-remap.lua` |

## Windows, Buffers, And Terminals

| Mode | Key | Action | Source |
| --- | --- | --- | --- |
| `n` | `<C-h>` | Move focus to left window | `init.lua`, `lua/fool/99-remap.lua` |
| `n` | `<C-j>` | Move focus to lower window | `init.lua`, `lua/fool/99-remap.lua` |
| `n` | `<C-k>` | Move focus to upper window | `init.lua`, `lua/fool/99-remap.lua` |
| `n` | `<C-l>` | Move focus to right window | `init.lua`, `lua/fool/99-remap.lua` |
| `n` | `<C-w>` | Close current buffer, or close terminal panel in terminal buffers | `lua/fool/99-remap.lua` |
| `n` | `<Tab>` | Next buffer, or next terminal when in a terminal buffer | `lua/fool/99-remap.lua` |
| `n` | `<S-Tab>` | Previous buffer, or previous terminal when in a terminal buffer | `lua/fool/99-remap.lua` |
| `n`, `v` | `<leader><Tab>` | Cycle to next window | `lua/fool/99-remap.lua` |
| `n`, `v` | `<leader>wc` | Close current window | `lua/fool/99-remap.lua` |
| `n`, `v` | `<leader>wv` | Create vertical split | `lua/fool/99-remap.lua` |
| `n`, `v` | `<leader>wh` | Create horizontal split | `lua/fool/99-remap.lua` |
| `n`, `v` | `<C-Up>` | Increase window height | `lua/fool/99-remap.lua` |
| `n`, `v` | `<C-Down>` | Decrease window height | `lua/fool/99-remap.lua` |
| `n`, `v` | `<C-Left>` | Decrease window width | `lua/fool/99-remap.lua` |
| `n`, `v` | `<C-Right>` | Increase window width | `lua/fool/99-remap.lua` |
| `n`, `v` | `` <leader>` `` | Toggle terminal panel | `lua/fool/99-remap.lua` |
| `n`, `v` | `<leader>tn` | Create new terminal | `lua/fool/99-remap.lua` |
| `t` | `<Esc><Esc>` | Exit terminal mode | `init.lua`, `lua/fool/99-remap.lua` |

## File Trees

| Mode | Key | Action | Source |
| --- | --- | --- | --- |
| `n` | `<leader>E` | Toggle nvim-tree file explorer | `lua/fool/99-remap.lua` |
| `n` | `<leader>e` | Focus nvim-tree, or return to previous window from nvim-tree | `lua/fool/99-remap.lua` |
| `n` | `<S-CR>` | In nvim-tree, change root to node under cursor | `lua/fool/01-setup.lua` |
| `n` | `\` | Reveal current file in Neo-tree | `lua/kickstart/plugins/neo-tree.lua` |
| `n` | `\` | In Neo-tree filesystem window, close Neo-tree | `lua/kickstart/plugins/neo-tree.lua` |

## Telescope

| Mode | Key | Action | Source |
| --- | --- | --- | --- |
| `n` | `<leader>sh` | Search help tags | `init.lua` |
| `n` | `<leader>sk` | Search keymaps | `init.lua` |
| `n` | `<leader>sf` | Search files | `init.lua` |
| `n` | `<leader>ss` | Search Telescope builtins | `init.lua` |
| `n`, `v` | `<leader>sw` | Search current word or selection | `init.lua` |
| `n` | `<leader>sg` | Search git files | `lua/fool/04-telescope.lua` |
| `n` | `<leader>sd` | Search diagnostics | `init.lua` |
| `n` | `<leader>sr` | Resume last Telescope picker | `init.lua` |
| `n` | `<leader>s.` | Search recent files | `init.lua` |
| `n` | `<leader>sc` | Search commands | `init.lua` |
| `n` | `<leader><leader>` | Search open buffers | `init.lua` |
| `n` | `<leader>/` | Fuzzy search in current buffer | `init.lua` |
| `n` | `<leader>s/` | Live grep in open files | `init.lua` |
| `n` | `<leader>sn` | Search Neovim config files | `init.lua` |
| `n` | `<leader>sp` | Prompt for grep text, then grep project | `lua/fool/04-telescope.lua` |

## Overlapping Mappings

| Mode | Key | Earlier action | Later action | Effective action |
| --- | --- | --- | --- | --- |
| `n` | `<leader>sg` | Live grep from `init.lua` | Git files from `lua/fool/04-telescope.lua` | Git files |
| `n`, `v` | `<leader>f` | Format buffer from `init.lua` | Format buffer from `lua/fool/01-setup.lua` | Format buffer |
| `t` | `<Esc><Esc>` | Exit terminal mode from `init.lua` | Exit terminal mode from `lua/fool/99-remap.lua` | Exit terminal mode |
| `n` | `<C-h/j/k/l>` | Window navigation from `init.lua` | Window navigation from `lua/fool/99-remap.lua` | Window navigation |

## LSP

These mappings are buffer-local and exist only after an LSP client attaches.

| Mode | Key | Action | Source |
| --- | --- | --- | --- |
| `n` | `grr` | Telescope LSP references | `init.lua` |
| `n` | `gri` | Telescope LSP implementations | `init.lua` |
| `n` | `grd` | Telescope LSP definitions | `init.lua` |
| `n` | `gO` | Telescope document symbols | `init.lua` |
| `n` | `gW` | Telescope workspace symbols | `init.lua` |
| `n` | `grt` | Telescope type definitions | `init.lua` |
| `n` | `grn` | Rename symbol | `init.lua` |
| `n`, `x` | `gra` | Code action | `init.lua` |
| `n` | `grD` | Go to declaration | `init.lua` |
| `n` | `<leader>th` | Toggle inlay hints, when supported | `init.lua` |

## GitSigns

These mappings are buffer-local and exist only after gitsigns attaches.

| Mode | Key | Action | Source |
| --- | --- | --- | --- |
| `n` | `]c` | Jump to next git change, or next diff change in diff mode | `lua/kickstart/plugins/gitsigns.lua` |
| `n` | `[c` | Jump to previous git change, or previous diff change in diff mode | `lua/kickstart/plugins/gitsigns.lua` |
| `v` | `<leader>hs` | Stage selected hunk lines | `lua/kickstart/plugins/gitsigns.lua` |
| `v` | `<leader>hr` | Reset selected hunk lines | `lua/kickstart/plugins/gitsigns.lua` |
| `n` | `<leader>hs` | Stage current hunk | `lua/kickstart/plugins/gitsigns.lua` |
| `n` | `<leader>hr` | Reset current hunk | `lua/kickstart/plugins/gitsigns.lua` |
| `n` | `<leader>hS` | Stage buffer | `lua/kickstart/plugins/gitsigns.lua` |
| `n` | `<leader>hR` | Reset buffer | `lua/kickstart/plugins/gitsigns.lua` |
| `n` | `<leader>hp` | Preview hunk | `lua/kickstart/plugins/gitsigns.lua` |
| `n` | `<leader>hi` | Preview hunk inline | `lua/kickstart/plugins/gitsigns.lua` |
| `n` | `<leader>hb` | Show full blame for current line | `lua/kickstart/plugins/gitsigns.lua` |
| `n` | `<leader>hd` | Diff current file against index | `lua/kickstart/plugins/gitsigns.lua` |
| `n` | `<leader>hD` | Diff current file against last commit | `lua/kickstart/plugins/gitsigns.lua` |
| `n` | `<leader>hQ` | Put all repo hunks in quickfix list | `lua/kickstart/plugins/gitsigns.lua` |
| `n` | `<leader>hq` | Put current file hunks in quickfix list | `lua/kickstart/plugins/gitsigns.lua` |
| `n` | `<leader>tb` | Toggle current-line blame | `lua/kickstart/plugins/gitsigns.lua` |
| `n` | `<leader>tw` | Toggle word diff | `lua/kickstart/plugins/gitsigns.lua` |
| `o`, `x` | `ih` | Select git hunk text object | `lua/kickstart/plugins/gitsigns.lua` |

## Debugging

| Mode | Key | Action | Source |
| --- | --- | --- | --- |
| `n` | `<F5>` | Debug start or continue | `lua/kickstart/plugins/debug.lua` |
| `n` | `<F1>` | Debug step into | `lua/kickstart/plugins/debug.lua` |
| `n` | `<F2>` | Debug step over | `lua/kickstart/plugins/debug.lua` |
| `n` | `<F3>` | Debug step out | `lua/kickstart/plugins/debug.lua` |
| `n` | `<leader>b` | Toggle breakpoint | `lua/kickstart/plugins/debug.lua` |
| `n` | `<leader>B` | Set conditional breakpoint | `lua/kickstart/plugins/debug.lua` |
| `n` | `<F7>` | Toggle DAP UI | `lua/kickstart/plugins/debug.lua` |

## UndoTree

| Mode | Key | Action | Source |
| --- | --- | --- | --- |
| `n` | `<leader>u` | Toggle UndoTree | `lua/fool/01-setup.lua` |
| `n` | `j` | In UndoTree, move to next entry | `lua/fool/01-setup.lua`, `pack/github/start/undotree/lua/undotree/runtime.lua` |
| `n` | `k` | In UndoTree, move to previous entry | `lua/fool/01-setup.lua`, `pack/github/start/undotree/lua/undotree/runtime.lua` |
| `n` | `gj` | In UndoTree, move to parent entry | `lua/fool/01-setup.lua`, `pack/github/start/undotree/lua/undotree/runtime.lua` |
| `n` | `J` | In UndoTree, move to next change | `lua/fool/01-setup.lua`, `pack/github/start/undotree/lua/undotree/runtime.lua` |
| `n` | `K` | In UndoTree, move to previous change | `lua/fool/01-setup.lua`, `pack/github/start/undotree/lua/undotree/runtime.lua` |
| `n` | `<CR>` | In UndoTree, enter selected state | `lua/fool/01-setup.lua`, `pack/github/start/undotree/lua/undotree/runtime.lua` |
| `n` | `p` | In UndoTree or preview, toggle diff buffer | `lua/fool/01-setup.lua`, `pack/github/start/undotree/lua/undotree/runtime.lua` |
| `n` | `q` | In UndoTree or preview, close UndoTree | `lua/fool/01-setup.lua`, `pack/github/start/undotree/lua/undotree/runtime.lua` |
| `n` | `S` | In UndoTree, update view | `lua/fool/01-setup.lua`, `pack/github/start/undotree/lua/undotree/runtime.lua` |

## Default Vim Motions

### Basic Cursor Movement

| Key | Motion |
| --- | --- |
| `h` | Left one character |
| `j` | Down one line |
| `k` | Up one line |
| `l` | Right one character |
| `0` | Start of line |
| `^` | First non-blank character of line |
| `$` | End of line |
| `g_` | Last non-blank character of line |
| `gg` | First line of file |
| `G` | Last line of file |
| `{count}G` | Go to line number |
| `{count}gg` | Go to line number |
| `H` | Top of screen |
| `M` | Middle of screen |
| `L` | Bottom of screen |

### Word Movement

| Key | Motion |
| --- | --- |
| `w` | Start of next word |
| `W` | Start of next WORD, space-separated |
| `e` | End of next word |
| `E` | End of next WORD, space-separated |
| `b` | Start of previous word |
| `B` | Start of previous WORD, space-separated |
| `ge` | End of previous word |
| `gE` | End of previous WORD, space-separated |

### Paragraphs, Sentences, And Blocks

| Key | Motion |
| --- | --- |
| `(` | Previous sentence |
| `)` | Next sentence |
| `{` | Previous paragraph |
| `}` | Next paragraph |
| `[[` | Previous section |
| `]]` | Next section |
| `[]` | Previous section end |
| `][` | Next section end |
| `%` | Matching bracket, parenthesis, brace, or language match |

### Screen Movement And Scrolling

| Key | Motion |
| --- | --- |
| `<C-f>` | Scroll one page forward |
| `<C-b>` | Scroll one page backward |
| `<C-d>` | Scroll half-page down |
| `<C-u>` | Scroll half-page up |
| `<C-e>` | Scroll down one line |
| `<C-y>` | Scroll up one line |
| `zt` | Put cursor line at top of screen |
| `zz` | Put cursor line at center of screen |
| `zb` | Put cursor line at bottom of screen |

### Search Movement

| Key | Motion |
| --- | --- |
| `/pattern` | Search forward |
| `?pattern` | Search backward |
| `n` | Repeat last search in same direction |
| `N` | Repeat last search in opposite direction |
| `*` | Search forward for word under cursor |
| `#` | Search backward for word under cursor |
| `g*` | Search forward for partial word under cursor |
| `g#` | Search backward for partial word under cursor |

### Character And Line Search

| Key | Motion |
| --- | --- |
| `f{char}` | Move forward to character on current line |
| `F{char}` | Move backward to character on current line |
| `t{char}` | Move forward before character on current line |
| `T{char}` | Move backward after character on current line |
| `;` | Repeat latest `f`, `F`, `t`, or `T` |
| `,` | Repeat latest `f`, `F`, `t`, or `T` in the opposite direction |

### Marks And Jumps

| Key | Motion |
| --- | --- |
| `m{a-zA-Z}` | Set mark |
| `` `{mark}`` | Jump to exact mark position |
| `'{mark}` | Jump to first non-blank character on marked line |
| `` `` `` | Jump back to previous exact position |
| `''` | Jump back to previous line |
| `<C-o>` | Older jump-list position |
| `<C-i>` | Newer jump-list position |
| `gd` | Go to local declaration |
| `gD` | Go to global declaration |

### Text Objects

Use text objects with operators like `d`, `c`, `y`, `v`, `gU`, and `gu`.

| Key | Object |
| --- | --- |
| `iw` | Inner word |
| `aw` | Around word |
| `iW` | Inner WORD |
| `aW` | Around WORD |
| `is` | Inner sentence |
| `as` | Around sentence |
| `ip` | Inner paragraph |
| `ap` | Around paragraph |
| `i"` / `a"` | Inside / around double quotes |
| `i'` / `a'` | Inside / around single quotes |
| `` i` `` / `` a` `` | Inside / around backticks |
| `i(` / `a(` | Inside / around parentheses |
| `i[` / `a[` | Inside / around brackets |
| `i{` / `a{` | Inside / around braces |
| `it` / `at` | Inside / around tag |

### Common Operators

| Key | Operator |
| --- | --- |
| `d{motion}` | Delete through motion |
| `c{motion}` | Change through motion |
| `y{motion}` | Yank through motion |
| `>{motion}` | Indent through motion |
| `<{motion}` | Outdent through motion |
| `gU{motion}` | Uppercase through motion |
| `gu{motion}` | Lowercase through motion |
| `=` | Auto-indent through motion |
| `.` | Repeat last change |

Examples: `dw` deletes to the start of the next word, `ci"` changes inside double quotes, `dap` deletes around a paragraph, and `gUiw` uppercases the current word.
