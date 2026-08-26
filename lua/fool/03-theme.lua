-- [[ Colorscheme ]]

vim.pack.add {
  'https://github.com/khoido2003/classic_monokai.nvim',
}

require('classic_monokai').setup {
  on_highlights = function(hl, c)
    -- Modules / namespaces -> function green
    hl['@module'] = { fg = c.green }

    -- Classes / user-defined types -> function green
    hl['@type'] = { fg = c.green }

    -- Keep builtin types (str, int, list, dict, ...) original Monokai blue
    hl['@type.builtin'] = { fg = c.blue, italic = true }

    -- Brackets: (), [], {} -> Monokai yellow
    hl['@punctuation.bracket'] = { fg = c.yellow }

    -- Python `class` / definition keywords
    hl['@keyword.type.python'] = { fg = c.blue }

    -- Python dunder methods: __init__, __str__, __repr__, ...
    hl['@function.dunder'] = { fg = c.blue }

    -- LSP semantic tokens
    -- Prevent LSP from changing classes/modules back to blue
    hl['@lsp.type.class'] = { fg = c.green }
    hl['@lsp.type.namespace'] = { fg = c.green }
    -- Keep builtin/default-library classes blue
    hl['@lsp.typemod.class.defaultLibrary'] = '@type.builtin'

    hl.DiagnosticUnnecessary = { fg = '#75715E' }

    hl.Search = {
      bg = '#505c78',
    }
  end,
}

vim.cmd.colorscheme 'classic-monokai'

vim.api.nvim_set_hl(0, 'NvimTreeGitFileDirtyHL', {
  fg = '#e0af68',
})

vim.api.nvim_set_hl(0, 'NvimTreeGitFolderDirtyHL', {
  fg = '#e0af68',
})

vim.api.nvim_set_hl(0, 'NvimTreeGitFileNewHL', {
  fg = '#9ece6a',
})

vim.api.nvim_set_hl(0, 'NvimTreeGitFolderNewHL', {
  fg = '#9ece6a',
})

vim.api.nvim_set_hl(0, 'NvimTreeGitFileDeletedHL', {
  fg = '#f7768e',
})

vim.api.nvim_set_hl(0, 'NvimTreeGitFolderDeletedHL', {
  fg = '#f7768e',
})

vim.api.nvim_set_hl(0, 'NvimTreeGitDirtyIcon', {
  fg = '#e0af68',
})

vim.api.nvim_set_hl(0, 'NvimTreeGitNewIcon', {
  fg = '#9ece6a',
})

vim.api.nvim_set_hl(0, 'NvimTreeGitDeletedIcon', {
  fg = '#f7768e',
})

vim.api.nvim_set_hl(0, 'Cursor', {
  fg = '#000000',
  bg = '#f5e0dc',
  blend = 0,
})

vim.api.nvim_set_hl(0, 'lCursor', {
  fg = '#000000',
  bg = '#f5e0dc',
  blend = 0,
})

-- local function set_transparent() -- set UI component to transparent
--   local groups = {
--     'Normal',
--     'NormalNC',
--     'EndOfBuffer',
--     'NormalFloat',
--     'FloatBorder',
--     'SignColumn',
--     'StatusLine',
--     'StatusLineNC',
--     'TabLine',
--     'TabLineFill',
--     'TabLineSel',
--     'ColorColumn',
--   }
--   for _, g in ipairs(groups) do
--     vim.api.nvim_set_hl(0, g, { bg = 'none' })
--   end
--   vim.api.nvim_set_hl(0, 'TabLineFill', { bg = 'none', fg = '#767676' })
-- end
--
-- set_transparent()
