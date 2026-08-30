vim.keymap.set({ 'n', 'v' }, '<leader>pv', vim.cmd.Ex)
vim.keymap.set('n', 'C-c', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlight' })

vim.keymap.set('n', '<leader>cd', function()
  local dir = vim.fn.expand '%:p:h'

  vim.cmd.cd(dir)
  require('nvim-tree.api').tree.change_root(dir)

  vim.cmd.pwd()
end, { desc = '[C]hange working [D]irectory to current file' })

-- ============================================================================
-- Better default
-- ============================================================================
do
  vim.keymap.set('n', 'Q', '<nop>') -- disable ex mode

  -- better j
  -- Press j on the last line to move onto a new editable line
  vim.keymap.set('n', 'j', function()
    local count = vim.v.count1
    local line = vim.fn.line '.'
    local last = vim.fn.line '$'

    local editable = vim.bo.modifiable and not vim.bo.readonly and vim.bo.buftype == ''

    if line == last and count == 1 and editable then
      vim.cmd 'normal! o'
      vim.cmd 'stopinsert'
    else
      vim.cmd('normal! ' .. count .. 'j')
    end
  end, { silent = true })
  -- better p
  -- p and P only paste from system clipboard register, not from default register
  vim.keymap.set('n', 'p', '"+p', { remap = false })
  vim.keymap.set('n', 'P', '"+P', { remap = false })

  -- Normal mode
  vim.keymap.set('n', 'dx', '"+dd', { remap = false }) -- delete line + copy it

  -- Visual mode
  vim.keymap.set('x', 'x', '"+d', { remap = false }) -- delete selection + copy it
end
-- ============================================================================
-- Better movement
-- ============================================================================
do
  -- Shift line or selection (in visual mode)
  vim.keymap.set('v', '<S-j>', ":m '>+1<CR>gv=gv", {})
  vim.keymap.set('v', '<S-k>', ":m '<-2<CR>gv=gv", {})

  vim.keymap.set('n', 'n', 'nzzzv')
  vim.keymap.set('n', 'N', 'Nzzzv')
  vim.keymap.set('n', '<C-d>', '<C-d>zz')
  vim.keymap.set('n', '<C-u>', '<C-u>zz')

  -- when ident, re selection
  vim.keymap.set('v', '>', '>gv')
  vim.keymap.set('v', '<', '<gv')

  vim.keymap.set('i', '<C-c>', '<Esc>')
end

-- Treesitter textobjects
do
  vim.keymap.set(
    { 'x', 'o' },
    'am',
    function() require('nvim-treesitter-textobjects.select').select_textobject('@function.outer', 'textobjects') end,
    { desc = 'Select around [m]ethod' }
  )
  vim.keymap.set(
    { 'x', 'o' },
    'im',
    function() require('nvim-treesitter-textobjects.select').select_textobject('@function.inner', 'textobjects') end,
    { desc = 'Select inner [m]ethod' }
  )
  vim.keymap.set(
    { 'x', 'o' },
    'ac',
    function() require('nvim-treesitter-textobjects.select').select_textobject('@class.outer', 'textobjects') end,
    { desc = 'Select around [c]lass' }
  )
  vim.keymap.set(
    { 'x', 'o' },
    'ic',
    function() require('nvim-treesitter-textobjects.select').select_textobject('@class.inner', 'textobjects') end,
    { desc = 'Select inner [c]lass' }
  )
  vim.keymap.set(
    { 'x', 'o' },
    'as',
    function() require('nvim-treesitter-textobjects.select').select_textobject('@local.scope', 'locals') end,
    { desc = 'Select around [s]cope' }
  )

  -- keymaps
  -- You can use the capture groups defined in `textobjects.scm`
  vim.keymap.set(
    { 'n', 'x', 'o' },
    ']m',
    function() require('nvim-treesitter-textobjects.move').goto_next_start('@function.outer', 'textobjects') end,
    { desc = 'Next [m]ethod start' }
  )
  vim.keymap.set(
    { 'n', 'x', 'o' },
    ']c',
    function() require('nvim-treesitter-textobjects.move').goto_next_start('@class.outer', 'textobjects') end,
    { desc = 'Next [c]lass start' }
  )
  -- You can also pass a list to group multiple queries.
  vim.keymap.set(
    { 'n', 'x', 'o' },
    ']o',
    function() require('nvim-treesitter-textobjects.move').goto_next_start({ '@loop.inner', '@loop.outer' }, 'textobjects') end,
    { desc = 'Next [o]uter/inner loop start' }
  )
  -- You can also use captures from other query groups like `locals.scm` or `folds.scm`
  vim.keymap.set(
    { 'n', 'x', 'o' },
    ']s',
    function() require('nvim-treesitter-textobjects.move').goto_next_start('@local.scope', 'locals') end,
    { desc = 'Next [s]cope start' }
  )
  vim.keymap.set(
    { 'n', 'x', 'o' },
    ']z',
    function() require('nvim-treesitter-textobjects.move').goto_next_start('@fold', 'folds') end,
    { desc = 'Next [z]fold start' }
  )

  vim.keymap.set(
    { 'n', 'x', 'o' },
    ']M',
    function() require('nvim-treesitter-textobjects.move').goto_next_end('@function.outer', 'textobjects') end,
    { desc = 'Next [M]ethod end' }
  )
  vim.keymap.set(
    { 'n', 'x', 'o' },
    ']C',
    function() require('nvim-treesitter-textobjects.move').goto_next_end('@class.outer', 'textobjects') end,
    { desc = 'Next [C]lass end' }
  )

  vim.keymap.set(
    { 'n', 'x', 'o' },
    '[m',
    function() require('nvim-treesitter-textobjects.move').goto_previous_start('@function.outer', 'textobjects') end,
    { desc = 'Previous [m]ethod start' }
  )
  vim.keymap.set(
    { 'n', 'x', 'o' },
    '[c',
    function() require('nvim-treesitter-textobjects.move').goto_previous_start('@class.outer', 'textobjects') end,
    { desc = 'Previous [c]lass start' }
  )

  vim.keymap.set(
    { 'n', 'x', 'o' },
    '[M',
    function() require('nvim-treesitter-textobjects.move').goto_previous_end('@function.outer', 'textobjects') end,
    { desc = 'Previous [M]ethod end' }
  )
  vim.keymap.set(
    { 'n', 'x', 'o' },
    '[C',
    function() require('nvim-treesitter-textobjects.move').goto_previous_end('@class.outer', 'textobjects') end,
    { desc = 'Previous [C]lass end' }
  )

  -- Go to either the start or the end, whichever is closer.
  -- Use if you want more granular movements
  vim.keymap.set(
    { 'n', 'x', 'o' },
    ']]',
    function() require('nvim-treesitter-textobjects.move').goto_next_end('@conditional.outer', 'textobjects') end,
    { desc = 'Next conditional end' }
  )
  vim.keymap.set(
    { 'n', 'x', 'o' },
    '][',
    function() require('nvim-treesitter-textobjects.move').goto_next_start('@conditional.outer', 'textobjects') end,
    { desc = 'Next conditional start' }
  )

  vim.keymap.set(
    { 'n', 'x', 'o' },
    '[[',
    function() require('nvim-treesitter-textobjects.move').goto_previous_start('@conditional.outer', 'textobjects') end,
    { desc = 'Previous conditional start' }
  )
  vim.keymap.set(
    { 'n', 'x', 'o' },
    '[]',
    function() require('nvim-treesitter-textobjects.move').goto_previous_start('@conditional.outer', 'textobjects') end,
    { desc = 'Previous conditional start' }
  )
  local ts_repeat_move = require 'nvim-treesitter-textobjects.repeatable_move'

  -- Repeat movement with ; and ,
  -- ensure ; goes forward and , goes backward regardless of the last direction
  vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move_next)
  vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_previous)

  -- vim way: ; goes to the direction you were moving.
  -- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
  -- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

  -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
  vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f_expr, { expr = true })
  vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F_expr, { expr = true })
  vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t_expr, { expr = true })
  vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T_expr, { expr = true })
end

vim.keymap.set('n', '<leader>j', function()
  local ok = pcall(function() vim.cmd 'lnext' end)
  if not ok then
    local ok2 = pcall(function() vim.cmd 'lfirst' end)
    if not ok2 then vim.notify('No more jumps', vim.log.levels.INFO) end
  end
  vim.cmd 'normal! zz'
end, { desc = 'Next [j]ump' })

vim.keymap.set('n', '<leader>k', function()
  local ok = pcall(function() vim.cmd 'lprev' end)
  if not ok then
    local ok2 = pcall(function() vim.cmd 'llast' end)
    if not ok2 then vim.notify('No more jumps', vim.log.levels.INFO) end
  end
end, { desc = 'Previous [k]ump' })

vim.keymap.set('n', '<C-f>', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- ============================================================================
-- Better window navigation
-- ============================================================================

-- Toggle project tree
vim.keymap.set('n', '<leader>E', '<cmd>NvimTreeToggle<CR>', {
  desc = 'Toggle file [E]xplorer',
})

-- Focus tree
vim.keymap.set('n', '<leader>e', function()
  if vim.bo.filetype == 'NvimTree' then
    vim.cmd 'wincmd p'
  else
    vim.cmd 'NvimTreeFocus'
  end
end, {
  desc = 'Toggle focus file [e]xplorer',
})

do
  local smart_splits = require 'smart-splits'

  vim.keymap.set('n', '<C-h>', smart_splits.move_cursor_left)
  vim.keymap.set('n', '<C-j>', smart_splits.move_cursor_down)
  vim.keymap.set('n', '<C-k>', smart_splits.move_cursor_up)
  vim.keymap.set('n', '<C-l>', smart_splits.move_cursor_right)

  vim.keymap.set('n', '<A-h>', smart_splits.resize_left)
  vim.keymap.set('n', '<A-j>', smart_splits.resize_down)
  vim.keymap.set('n', '<A-k>', smart_splits.resize_up)
  vim.keymap.set('n', '<A-l>', smart_splits.resize_right)
end

-- Bufferline Next/Prev
vim.keymap.set('n', '<TAB>', function() vim.cmd 'BufferLineCycleNext' end, {
  desc = 'Next buffer/terminal',
})

vim.keymap.set('n', '<S-TAB>', function() vim.cmd 'BufferLineCyclePrev' end, {
  desc = 'Previous buffer/terminal',
})

vim.keymap.set('n', '<C-w>', function()
  local current = vim.api.nvim_get_current_buf()

  vim.cmd 'BufferLineMovePrev'

  -- if new_current is current -> vim.cmd 'BufferLineCycleNext' to move to next buffer
  if vim.api.nvim_get_current_buf() == current then vim.cmd 'BufferLineCycleNext' end

  if vim.api.nvim_get_current_buf() ~= current then
    vim.api.nvim_buf_delete(current, {})
  else
    -- case where we have only one buffer left, we can't delete it, so add signal to user that we can't delete it
    vim.notify('Cannot delete the last buffer', vim.log.levels.WARN)
  end
end, {
  desc = 'Close buffer/terminal',
})

-- Cycle windows
vim.keymap.set({ 'n', 'v' }, '<leader><Tab>', '<C-w>w', {
  desc = 'Next window',
})

-- Escape terminal mode easily
vim.keymap.set('t', '<Esc><Esc>', [[<C-\><C-n>]], {
  desc = 'Exit terminal mode',
})

-- split window
vim.keymap.set({ 'n', 'v' }, '<leader>wc', '<C-w>c', { desc = '[W]indow [C]lose' })

vim.keymap.set({ 'n', 'v' }, '<leader>wv', ':vsplit<CR>', { desc = 'Split [W]indow [V]ertically' })
vim.keymap.set({ 'n', 'v' }, '<leader>wh', ':split<CR>', { desc = 'Split [W]indow [H]orizontally' })

-- ============================================================================
-- Session
-- ============================================================================

do
  local session = require 'fool.04-session'
  vim.keymap.set('n', '<leader>ss', session.save_session, { desc = 'Create session' })

  vim.keymap.set('n', '<leader>sl', session.load_session, { desc = 'Load session' })
end

-- ============================================================================
-- Libs Keymaps
-- ============================================================================

-- Undotree Keymap
vim.keymap.set('n', '<leader>u', require('undotree').toggle, { noremap = true, silent = true, desc = 'Toggle [U]ndoTree' })

-- Conform Keymap
vim.keymap.set({ 'n', 'v' }, '<leader>f', function() require('conform').format { async = true } end, { desc = '[F]ormat buffer' })

-- Trouble Keymap

local a = 3

do
  local trouble = require 'trouble'
  ---@diagnostic disable-next-line: missing-fields
  vim.keymap.set('n', '<leader>dd', function() trouble.toggle { mode = 'open_buffers' } end, { desc = 'Toggle [D]iagnostics' })
  ---@diagnostic disable-next-line: missing-parameter, missing-fields
  vim.keymap.set('n', '<leader>dn', function() trouble.next { mode = 'diagnostics' } end, { desc = '[D]iagnostic [N]ext' })
  ---@diagnostic disable-next-line: missing-parameter, missing-fields
  vim.keymap.set('n', '<leader>dp', function() trouble.prev { mode = 'diagnostics' } end, { desc = '[D]iagnostic [P]revious' })
  -- vim.keymap.set('n', '<leader>dp', '<cmd>Trouble previous<CR>', { desc = 'Previous [D]iagnostic' })
end
-- ============================================================================
-- Git Keymaps
-- ============================================================================

---@diagnostic disable-next-line: deprecated
vim.keymap.set('n', '<leader>td', function() require('gitsigns').toggle_deleted() end, { desc = 'Toggle [T]oggle [D]eleted' })
