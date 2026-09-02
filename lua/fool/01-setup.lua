vim.pack.add({
  'https://github.com/nvim-tree/nvim-web-devicons', -- file icons
  'https://github.com/akinsho/bufferline.nvim', -- for buffer line
  'https://github.com/nvim-tree/nvim-tree.lua', -- file explorer
  'https://github.com/nvim-lualine/lualine.nvim', -- status line
  'https://github.com/github/copilot.vim', -- github copilot
  'https://github.com/MeanderingProgrammer/render-markdown.nvim', -- markdown preview
  'https://github.com/lervag/vimtex', -- latex support
  'https://github.com/nvim-treesitter/nvim-treesitter-textobjects', -- treesitter textobjects
  'https://github.com/mrjones2014/smart-splits.nvim', -- smart splits to split between tmux and nvim
  'https://github.com/laytan/cloak.nvim', -- cloak to hide sensitive information
  'https://github.com/folke/trouble.nvim', -- quickfix list replacement
  "https://github.com/HiPhish/rainbow-delimiters.nvim", -- rainbow delimiters for better readability
})

-- ============================================================================
-- Basic setup
-- ============================================================================

-- Cloak:
-- Plugin that allows you to hide sensitive information in your code, such as API keys or passwords
-- by replacing them with a placeholder. This can be useful when sharing your code with others or when working in a public repository.
require('cloak').setup({})

require('trouble').setup({
  modes = {
    open_buffers = {
      mode = 'diagnostics',
      filter = function(items)
        return vim.tbl_filter(function(item) return item.buf and vim.api.nvim_buf_is_valid(item.buf) and vim.bo[item.buf].buflisted end, items)
      end,
    },
  },
})

-- VimTeX
do
  vim.g.vimtex_view_method = 'skim'
  vim.g.vimtex_compiler_method = 'latexmk'
end

-- Mini nvim
require('mini.comment').setup({})
require('mini.move').setup({})
require('mini.cursorword').setup({})
require('mini.indentscope').setup({})
require('mini.pairs').setup({})
require('mini.trailspace').setup({})
require('mini.bufremove').setup({})
require('mini.icons').setup({})

-- Treesitter Textobjects
-- configuration
require('nvim-treesitter-textobjects').setup({
  move = {
    -- whether to set jumps in the jumplist
    set_jumps = true,
  },
})

-- ============================================================================
-- File Explorer
-- ============================================================================

-- NvimTree
require('nvim-tree').setup({
  on_attach = function(bufnr)
    local api = require('nvim-tree.api')

    local function opts(desc) return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true } end

    -- Load the default mappings first
    api.map.on_attach.default(bufnr)

    -- Remove the default Ctrl+] mapping
    vim.keymap.del('n', '<C-]>', { buffer = bufnr })

    -- Map Shift+Enter to change the directory to the node under the cursor
    vim.keymap.set('n', '<S-CR>', api.tree.change_root_to_node, opts('CD'))
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
})

-- ============================================================================
-- Linters, Formatters, and LSP
-- ============================================================================

require('bufferline').setup({
  options = {
    mode = 'buffers',
    diagnostics = 'nvim_lsp',
    separator_style = 'thin',
    always_show_bufferline = false,
  },
})

do
  local servers = {
    -- clangd = {},
    -- gopls = {},
    -- sql
    postgres_lsp = {},

    -- python
    -- basedpyright = {
    --   settings = {
    --     basedpyright = {
    --       analysis = {
    --         typeCheckingMode = 'basic',
    --       },
    --     },
    --   },
    -- },

    pyrefly = {
      settings = {
        pyrefly = {
          analysis = {
            typeCheckingMode = 'auto',
          },
        },
      },
    },

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

  require('mason-tool-installer').setup({ ensure_installed = ensure_installed })

  for name, server in pairs(servers) do
    vim.lsp.config(name, server)
    vim.lsp.enable(name)
  end
end

do
  -- [[ Formatting ]]
  require('conform').setup({
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- You can specify filetypes to autoformat on save here:
      local enabled_filetypes = {
        lua = true,
        python = true,
        markdown = true,
        cpp = true,
        c = true,
        tex = true,
        bib = true,
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
    formatters = {
      stylua = {
        prepend_args = {
          '--indent-type',
          'Spaces',
          '--indent-width',
          '2',
          '--call-parentheses',
          'Always',
        },
      },
    },
    -- You can also specify external formatters in here.
    formatters_by_ft = {
      -- rust = { 'rustfmt' },
      -- Conform can also run multiple formatters sequentially
      lua = { 'stylua' },
      python = { 'ruff_organize_imports', 'ruff_format' },
      bib = { 'bibtex_tidy' },
      bibtex = { 'bibtex_tidy' },
      -- You can use 'stop_after_first' to run the first available formatter from the list
      -- javascript = { "prettierd", "prettier", stop_after_first = true },
    },
  })
end

-- ============================================================================
-- Undo Tree
-- ============================================================================

-- UndoTree
do
  require('undotree').setup({
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
  })
end

-- ============================================================================
-- Statusline
-- ============================================================================

-- Lualine (Statusline)
require('lualine').setup({
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
        local size = vim.fn.getfsize(vim.fn.expand('%'))
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
})

-- ============================================================================
-- FILETYPE SPECIFIC CONFIGS
-- ============================================================================

-- Markdown
require('render-markdown').setup({
  completions = { lsp = { enabled = true } },
  heading = {
    icons = { '' },
  },

  width = 'block',
  left_pad = 1,
  right_pad = 1,
})
