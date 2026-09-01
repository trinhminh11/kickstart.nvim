local augroup = vim.api.nvim_create_augroup('UserConfig', { clear = true })

-- return to last cursor position
vim.api.nvim_create_autocmd('BufReadPost', {
  group = augroup,
  desc = 'Restore last cursor position',
  callback = function()
    if vim.o.diff then -- except in diff mode
      return
    end

    local last_pos = vim.api.nvim_buf_get_mark(0, '"') -- {line, col}
    local last_line = vim.api.nvim_buf_line_count(0)

    local row = last_pos[1]
    if row < 1 or row > last_line then return end

    pcall(vim.api.nvim_win_set_cursor, 0, last_pos)
  end,
})

-- wrap, linebreak and spellcheck on markdown and text files
vim.api.nvim_create_autocmd('FileType', {
  group = augroup,
  pattern = { 'markdown', 'text', 'gitcommit' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.spell = true
  end,
})

vim.diagnostic.config({
  update_in_insert = true,

  underline = true,

  virtual_text = {
    spacing = 2,
    source = 'if_many',
  },

  signs = true,
})

-- add <leader>m <leader>M to jump to next/previous markdown heading
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function(ev)
    local function goto_heading(next)
      local query = vim.treesitter.query.parse(
        'markdown',
        [[
          (atx_heading) @heading
        ]]
      )

      local parser = vim.treesitter.get_parser(ev.buf, 'markdown')

      if not parser then return end

      local tree = parser:parse()[1]
      local root = tree:root()

      local row = vim.api.nvim_win_get_cursor(0)[1] - 1

      local headings = {}

      for _, node in query:iter_captures(root, ev.buf, 0, -1) do
        local start_row = node:range()
        table.insert(headings, start_row)
      end

      if next then
        for _, heading_row in ipairs(headings) do
          if heading_row > row then
            vim.api.nvim_win_set_cursor(0, { heading_row + 1, 0 })
            return
          end
        end
        -- case where there is no next heading, go to the first heading
        if #headings > 0 then vim.api.nvim_win_set_cursor(0, { headings[1] + 1, 0 }) end
      else
        for i = #headings, 1, -1 do
          if headings[i] < row then
            vim.api.nvim_win_set_cursor(0, { headings[i] + 1, 0 })
            return
          end
        end

        -- case where there is no previous heading, go to the last heading
        if #headings > 0 then vim.api.nvim_win_set_cursor(0, { headings[#headings] + 1, 0 }) end
      end
    end

    vim.keymap.set('n', ']]', function() goto_heading(true) end, {
      buffer = ev.buf,
      desc = 'Next markdown heading',
    })

    vim.keymap.set('n', '[[', function() goto_heading(false) end, {
      buffer = ev.buf,
      desc = 'Previous markdown heading',
    })
  end,
})

-- AUTO SAVE on InsertLeave, BufLeave, FocusLost for certain filetypes
vim.api.nvim_create_autocmd({
  'InsertLeave',
  'BufLeave',
  'FocusLost',
  'TextChanged',
}, {
  pattern = {
    '*.py',
    '*.java',
    '*.c',
    '*.h',
    '*.cpp',
    '*.hpp',
    '*.cc',
    '*.js',
    '*.ts',
    '*.go',
    '*.rs',
    '*.md',
    '*.lua',
  },
  callback = function()
    if vim.bo.modified and vim.fn.expand('%') ~= '' and vim.bo.buftype == '' then vim.cmd('silent write') end
  end,
})

-- Make system clipboard sync with register 0 (yank) for normal and visual mode
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    local event = vim.v.event

    -- Normal yank -> implicitly writes to register 0
    -- Explicit "0 operation -> explicitly writes to register 0
    if (event.operator == 'y' and event.regname == '') or event.regname == '0' then vim.fn.setreg('+', event.regcontents, event.regtype) end
  end,
})
