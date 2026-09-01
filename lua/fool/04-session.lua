local session_dir = vim.fn.stdpath('data') .. '/sessions'
local current_session = nil

vim.fn.mkdir(session_dir, 'p')

local function write_session()
  if not current_session then return end

  vim.cmd('mksession! ' .. vim.fn.fnameescape(current_session))
end

local function save_session()
  local default_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')

  vim.ui.input({
    prompt = 'Session name: ',
    default = default_name,
  }, function(name)
    if not name or name == '' then return end

    local path = session_dir .. '/' .. name .. '.vim'

    if vim.fn.filereadable(path) == 1 then
      vim.notify("Session '" .. name .. "' already exists.", vim.log.levels.WARN)
      return
    end

    current_session = path
    write_session()

    vim.notify('Created session: ' .. name)
  end)
end

local function load_session()
  require('telescope.pickers')
    .new({}, {
      prompt_title = 'Sessions',

      finder = require('telescope.finders').new_oneshot_job({
        'find',
        session_dir,
        '-maxdepth',
        '1',
        '-type',
        'f',
        '-name',
        '*.vim',
      }, {}),

      sorter = require('telescope.config').values.file_sorter({}),

      attach_mappings = function(prompt_bufnr, map)
        local actions = require('telescope.actions')
        local action_state = require('telescope.actions.state')

        -- Enter = load session
        actions.select_default:replace(function()
          local entry = action_state.get_selected_entry()

          actions.close(prompt_bufnr)

          current_session = entry[1]

          vim.cmd('source ' .. vim.fn.fnameescape(current_session))

          vim.notify('Loaded session: ' .. vim.fn.fnamemodify(current_session, ':t:r'))
        end)

        -- Ctrl-d = delete session
        local function delete_selected()
          local entry = action_state.get_selected_entry()

          if not entry then return end

          local path = entry[1]
          local name = vim.fn.fnamemodify(path, ':t:r')

          local result = vim.fn.delete(path)

          if result ~= 0 then
            vim.notify('Failed to delete session: ' .. name, vim.log.levels.ERROR)
            return
          end

          if current_session == path then current_session = nil end

          vim.notify('Deleted session: ' .. name)

          -- Refresh Telescope list after deletion
          local current_picker = action_state.get_current_picker(prompt_bufnr)

          current_picker:refresh(
            require('telescope.finders').new_oneshot_job({
              'find',
              session_dir,
              '-maxdepth',
              '1',
              '-type',
              'f',
              '-name',
              '*.vim',
            }, {}),
            { reset_prompt = false }
          )
        end

        map('i', '<C-d>', delete_selected)
        map('n', '<C-d>', delete_selected)

        return true
      end,
    })
    :find()
end

-- Automatically update the active session when leaving Neovim
vim.api.nvim_create_autocmd('VimLeavePre', {
  callback = function() write_session() end,
})

local M = {}

M.save_session = save_session
M.load_session = load_session

return M

-- vim.keymap.set('n', '<leader>ss', save_session, { desc = 'Create session' })
-- vim.keymap.set('n', '<leader>sl', load_session, { desc = 'Load session' })
--
