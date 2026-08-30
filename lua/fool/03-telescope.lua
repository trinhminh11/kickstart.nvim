local builtin = require 'telescope.builtin'

vim.keymap.set('n', '<leader>sg', builtin.git_files, { desc = '[S]earch [G]it Files' })
vim.keymap.set('n', '<leader>sp', builtin.live_grep, { desc = '[S]earch [P]roject' })
vim.keymap.set(
  'n',
  '<leader>sb',
  function()
    builtin.live_grep {
      grep_open_files = true,
      prompt_title = 'Live Grep in Open Buffers',
    }
  end,
  { desc = '[S]earch [B]uffer' }
)
