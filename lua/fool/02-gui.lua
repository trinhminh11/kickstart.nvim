-- ============================================================
-- Terminal manager
-- One bottom panel, multiple terminal buffers
-- ============================================================

local terminal_manager = {
  terminals = {},
  current = nil,
  win = nil,
  next_id = 1,
  height = 12,
}

local function terminal_win_valid() return terminal_manager.win and vim.api.nvim_win_is_valid(terminal_manager.win) end

local function update_terminal_winbar()
  if not terminal_win_valid() then return end

  local parts = {}

  for i, term in ipairs(terminal_manager.terminals) do
    if i == terminal_manager.current then
      table.insert(parts, string.format('[ %s ]', term.name))
    else
      table.insert(parts, string.format('  %s  ', term.name))
    end
  end

  vim.wo[terminal_manager.win].winbar = table.concat(parts, ' │ ')
end

local function open_terminal_panel(buf)
  -- Already visible
  if terminal_win_valid() then
    if buf and vim.api.nvim_buf_is_valid(buf) then vim.api.nvim_win_set_buf(terminal_manager.win, buf) end

    update_terminal_winbar()
    return
  end

  -- Create ONE bottom split
  vim.cmd 'botright split'
  vim.cmd('resize ' .. terminal_manager.height)

  terminal_manager.win = vim.api.nvim_get_current_win()

  if buf and vim.api.nvim_buf_is_valid(buf) then vim.api.nvim_win_set_buf(terminal_manager.win, buf) end

  update_terminal_winbar()
end

local function create_terminal(name)
  local id = terminal_manager.next_id
  terminal_manager.next_id = terminal_manager.next_id + 1

  name = name or ('Terminal ' .. id)

  local buf = vim.api.nvim_create_buf(false, true)

  -- Keep terminal alive when switching buffers
  vim.bo[buf].bufhidden = 'hide'

  open_terminal_panel(buf)

  vim.api.nvim_win_set_buf(terminal_manager.win, buf)

  local job = vim.fn.termopen(vim.o.shell)

  local term = {
    id = id,
    name = name,
    buf = buf,
    job = job,
  }

  table.insert(terminal_manager.terminals, term)
  terminal_manager.current = #terminal_manager.terminals

  vim.api.nvim_buf_set_name(buf, string.format('terminal://%s', name))

  update_terminal_winbar()

  return term
end

local function get_current_terminal()
  if not terminal_manager.current then return nil end

  return terminal_manager.terminals[terminal_manager.current]
end

local function show_terminal(index)
  local term = terminal_manager.terminals[index]

  if not term then return end

  if not vim.api.nvim_buf_is_valid(term.buf) then return end

  terminal_manager.current = index

  open_terminal_panel(term.buf)

  vim.api.nvim_win_set_buf(terminal_manager.win, term.buf)

  update_terminal_winbar()
end

local function toggle_terminal_panel()
  -- Close panel, but DON'T kill terminals
  if terminal_win_valid() then
    vim.api.nvim_win_close(terminal_manager.win, true)
    terminal_manager.win = nil
    return
  end

  -- No terminals yet
  if #terminal_manager.terminals == 0 then
    create_terminal()
    return
  end

  local term = get_current_terminal()

  if term then open_terminal_panel(term.buf) end
end

local function next_terminal()
  if #terminal_manager.terminals == 0 then
    create_terminal()
    return
  end

  local next_index = (terminal_manager.current % #terminal_manager.terminals) + 1

  show_terminal(next_index)
end

local function previous_terminal()
  if #terminal_manager.terminals == 0 then
    create_terminal()
    return
  end

  local prev_index = terminal_manager.current - 1

  if prev_index < 1 then prev_index = #terminal_manager.terminals end

  show_terminal(prev_index)
end

local function close_current_terminal()
  local index = terminal_manager.current

  if not index then return end

  local term = terminal_manager.terminals[index]

  if term and vim.api.nvim_buf_is_valid(term.buf) then vim.api.nvim_buf_delete(term.buf, {
    force = true,
  }) end

  table.remove(terminal_manager.terminals, index)

  -- No terminals remaining
  if #terminal_manager.terminals == 0 then
    terminal_manager.current = nil

    if terminal_win_valid() then
      vim.api.nvim_win_close(terminal_manager.win, true)
      terminal_manager.win = nil
    end

    return
  end

  -- Fix current index
  if index > #terminal_manager.terminals then index = #terminal_manager.terminals end

  show_terminal(index)
end

local M = {}

-- Export only the public functions
M.terminal = {}
M.terminal.toggle = toggle_terminal_panel
M.terminal.create = create_terminal
M.terminal.next = next_terminal
M.terminal.previous = previous_terminal
M.terminal.close = close_current_terminal

return M
