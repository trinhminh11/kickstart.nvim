vim.pack.add {
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/akinsho/bufferline.nvim',
  'https://github.com/nvim-tree/nvim-tree.lua',
  'https://github.com/nvim-lualine/lualine.nvim',
  'https://github.com/github/copilot.vim',
  'https://github.com/MeanderingProgrammer/render-markdown.nvim',
  'https://github.com/lervag/vimtex',
}

-- ============================================================================
-- Basic setup
-- ============================================================================

-- VimTeX
vim.g.vimtex_view_method = 'skim'
vim.g.vimtex_compiler_method = 'latexmk'

-- Mini nvim
require('mini.comment').setup {}
require('mini.move').setup {}
require('mini.cursorword').setup {}
require('mini.indentscope').setup {}
require('mini.pairs').setup {}
require('mini.trailspace').setup {}
require('mini.bufremove').setup {}
require('mini.icons').setup {}

-- NvimTree
require('nvim-tree').setup {
  on_attach = function(bufnr)
    local api = require 'nvim-tree.api'

    local function opts(desc) return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true } end

    -- Load the default mappings first
    api.map.on_attach.default(bufnr)

    -- Remove the default Ctrl+] mapping
    vim.keymap.del('n', '<C-]>', { buffer = bufnr })

    -- Map Shift+Enter to change the directory to the node under the cursor
    vim.keymap.set('n', '<S-CR>', api.tree.change_root_to_node, opts 'CD')
  end,
  view = {
    side = 'right',
    width = 35,
  },

  update_focused_file = {
    enable = true,
  },

  git = {
    enable = true,
    ignore = false,
  },

  renderer = {
    highlight_git = 'all',
    group_empty = true,

    icons = {
      show = {
        git = true,
        file = true,
        folder = true,
        folder_arrow = true,
      },

      git_placement = 'right_align',

      glyphs = {
        git = {
          unstaged = 'M',
          staged = 'S',
          unmerged = 'U',
          renamed = 'R',
          untracked = 'A',
          deleted = 'D',
          ignored = 'I',
        },
      },
    },
  },
}

require('bufferline').setup {
  options = {
    mode = 'buffers',
    diagnostics = 'nvim_lsp',
    separator_style = 'thin',
  },
}

do
  local servers = {
    -- clangd = {},
    -- gopls = {},
    -- sql
    postgres_lsp = {},

    -- python
    basedpyright = {
      settings = {
        basedpyright = {
          analysis = {
            typeCheckingMode = 'off',
          },
        },
      },
    },

    pyrefly = {},

    ruff = {},

    --other languages
    jsonls = {},
    markdown_oxide = {},
    -- masksman = {},
    bashls = {},
    yamlls = {},
    docker_language_server = {},

    ltex_plus = { filetypes = { 'tex', 'bib' } },

    -- rust_analyzer = {},
    -- Some languages (like typescript) have entire language plugins that can be useful:
    --    https://github.com/pmizio/typescript-tools.nvim
    --
    -- But for many setups, the LSP (`ts_ls`) will work just fine
    -- ts_ls = {},
  }

  local ensure_installed = vim.tbl_keys(servers or {})
  vim.list_extend(ensure_installed, {
    -- You can add other tools here that you want Mason to install
  })

  require('mason-tool-installer').setup { ensure_installed = ensure_installed }

  for name, server in pairs(servers) do
    vim.lsp.config(name, server)
    vim.lsp.enable(name)
  end
end

do
  -- [[ Formatting ]]
  require('conform').setup {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- You can specify filetypes to autoformat on save here:
      local enabled_filetypes = {
        lua = true,
        python = true,
      }
      if enabled_filetypes[vim.bo[bufnr].filetype] then
        return { timeout_ms = 500 }
      else
        return nil
      end
    end,
    default_format_opts = {
      lsp_format = 'fallback', -- Use external formatters if configured below, otherwise use LSP formatting. Set to `false` to disable LSP formatting entirely.
    },
    -- You can also specify external formatters in here.
    formatters_by_ft = {
      -- rust = { 'rustfmt' },
      -- Conform can also run multiple formatters sequentially
      python = { 'ruff_organize_imports', 'ruff_format' },
      bib = { 'bibtex_tidy' },
      bibtex = { 'bibtex_tidy' },
      -- You can use 'stop_after_first' to run the first available formatter from the list
      -- javascript = { "prettierd", "prettier", stop_after_first = true },
    },
  }
end

-- UndoTree
do
  require('undotree').setup {
    float_diff = true, -- set this `true` will disable layout option
    --- @type "left_bottom" | "left_left_bottom"
    layout = 'left_bottom', -- {left}_{bottom} {left}_{left_bottom}
    --- @type "left" | "right"
    position = 'left',
    window = {
      width = 0.25, -- the `undotree` window width percentage related to the editor
      height = 0.25, -- the `preview`(not floating) window height percentage related to the editor
      border = 'rounded', -- float window
    },

    ignore_filetype = {},
    --- @type "compact" | "legacy"
    parser = 'compact',

    keymaps = {
      move_next = 'j',
      move_prev = 'k',
      move2parent = 'gj',
      move_change_next = 'J',
      move_change_prev = 'K',
      action_enter = '<cr>',
      enter_diffbuf = 'p', -- is defined for both undotree and preview buffers, so it works as a toggle
      quit = 'q', -- is defined for both undotree and preview buffers
      update_undotree_view = 'S',
    },
  }
end

-- Lualine (Statusline)
require('lualine').setup {
  options = {
    -- theme = "melange", -- melange-nvim ships a dedicated lualine theme
    icons_enabled = true,
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    globalstatus = false, -- keep per-window active/inactive styling
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { { 'branch', icon = '\u{e725}' } }, -- nf-dev-git_branch
    lualine_c = { { 'filename', path = 0 } },
    lualine_x = {
      function()
        local size = vim.fn.getfsize(vim.fn.expand '%')
        if size < 0 then
          return ''
        elseif size < 1024 then
          return size .. 'B'
        elseif size < 1024 * 1024 then
          return string.format('%.1fK', size / 1024)
        else
          return string.format('%.1fM', size / 1024 / 1024)
        end
      end,
      { 'filetype', icon_only = false },
    },
    lualine_y = { 'location' }, -- %l:%c equivalent
    lualine_z = { 'progress' }, -- %P equivalent
  },
  inactive_sections = {
    lualine_c = { { 'filename', path = 0 } },
    lualine_x = { 'filetype' },
  },
}

-- ============================================================================
-- FILETYPE SPECIFIC CONFIGS
-- ============================================================================

-- Markdown
require('render-markdown').setup {
  completions = { lsp = { enabled = true } },
  heading = {
    icons = { '' },
  },

  width = 'block',
  left_pad = 1,
  right_pad = 1,
}

-- ============================================================================
-- AUTOCMDS
-- ============================================================================

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

vim.diagnostic.config {
  update_in_insert = true,

  underline = true,

  virtual_text = {
    spacing = 2,
    source = 'if_many',
  },

  signs = true,
}

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

    vim.keymap.set('n', '<leader>m', function() goto_heading(true) end, {
      buffer = ev.buf,
      desc = 'Next markdown heading',
    })

    vim.keymap.set('n', '<leader>M', function() goto_heading(false) end, {
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
    if vim.bo.modified and vim.fn.expand '%' ~= '' and vim.bo.buftype == '' then vim.cmd 'silent write' end
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
