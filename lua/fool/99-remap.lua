local gui = require 'fool.02-gui'

vim.keymap.set({ 'n', 'v' }, '<leader>pv', vim.cmd.Ex)

-- ============================================================================
-- Better default
-- ============================================================================

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
-- p and P only paste from yank register, not from delete register
vim.keymap.set('n', 'p', '"0p', { remap = false })
vim.keymap.set('n', 'P', '"0P', { remap = false })

-- Normal mode
vim.keymap.set('n', 'dx', '"0dd', { remap = false }) -- delete line + copy it

-- Visual mode
vim.keymap.set('x', 'x', '"0d', { remap = false }) -- delete selection + copy it

-- ============================================================================
-- Better movement
-- ============================================================================

-- Shift line or selection (in visual mode)
vim.keymap.set('n', '<S-j>', ':m .+1<CR>==', {})
vim.keymap.set('n', '<S-k>', ':m .-2<CR>==', {})
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

vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

vim.keymap.set('n', '<C-w>', function()
  if vim.bo.buftype == 'terminal' then
    gui.terminal.close()
    return
  end

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

-- Next buffer
vim.keymap.set('n', '<TAB>', function()
  print 'debug 1'
  if vim.bo.buftype == 'terminal' then
    gui.terminal.next()
  else
    print 'debug'
    vim.cmd 'BufferLineCycleNext'
  end
end, {
  desc = 'Next buffer/terminal',
})

vim.keymap.set('n', '<S-TAB>', function()
  if vim.bo.buftype == 'terminal' then
    gui.terminal.previous()
  else
    vim.cmd 'BufferLineCyclePrev'
  end
end, {
  desc = 'Previous buffer/terminal',
})

-- Cycle windows
vim.keymap.set({ 'n', 'v' }, '<leader><Tab>', '<C-w>w', {
  desc = 'Next window',
})

-- Toggle terminal panel
vim.keymap.set({ 'n', 'v' }, '<leader>`', gui.terminal.toggle, {
  desc = 'Toggle terminal panel',
})

-- New terminal
vim.keymap.set({ 'n', 'v' }, '<leader>tn', gui.terminal.create, { desc = 'New terminal' })

-- Escape terminal mode easily
vim.keymap.set('t', '<Esc><Esc>', [[<C-\><C-n>]], {
  desc = 'Exit terminal mode',
})

-- split window
vim.keymap.set({ 'n', 'v' }, '<leader>wc', '<C-w>c', { desc = '[W]indow [C]lose' })

vim.keymap.set({ 'n', 'v' }, '<leader>wv', ':vsplit<CR>', { desc = 'Split [W]indow [V]ertically' })
vim.keymap.set({ 'n', 'v' }, '<leader>wh', ':split<CR>', { desc = 'Split [W]indow [H]orizontally' })
-- Note: this won't work in MacOS
vim.keymap.set({ 'n', 'v' }, '<C-Up>', ':resize +2<CR>', { desc = 'Increase Window Height' })
vim.keymap.set({ 'n', 'v' }, '<C-Down>', ':resize -2<CR>', { desc = 'Decrease Window Height' })
vim.keymap.set({ 'n', 'v' }, '<C-Left>', ':vertical resize -2<CR>', { desc = 'Decrease Window Width' })
vim.keymap.set({ 'n', 'v' }, '<C-Right>', ':vertical resize +2<CR>', { desc = 'Increase Window Width' })

-- ============================================================================
-- Libs Keymaps
-- ============================================================================

vim.keymap.set('n', '<leader>u', require('undotree').toggle, { noremap = true, silent = true, desc = 'Toggle [U]ndoTree' })

vim.keymap.set({ 'n', 'v' }, '<leader>f', function() require('conform').format { async = true } end, { desc = '[F]ormat buffer' })
