vim.g.have_nerd_fonts = true
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.signcolumn = 'yes'
vim.opt.colorcolumn = '100'
vim.opt.showmatch = true
vim.opt.cmdheight = 1
vim.opt.completeopt = 'menuone,noinsert,noselect'
vim.opt.showmode = false
vim.opt.conceallevel = 2
vim.opt.concealcursor = ''
vim.opt.synmaxcol = 300
vim.opt.fillchars = { eob = ' ' }

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.opt.undofile = true
vim.opt.updatetime = 300
vim.opt.autoread = true
vim.opt.autowrite = false

vim.opt.hidden = true
vim.opt.errorbells = false
vim.opt.backspace = 'indent,eol,start'
vim.opt.autochdir = false
vim.opt.iskeyword:append('-')
vim.opt.path:append('**')
vim.opt.selection = 'inclusive'
vim.opt.mouse = 'a'
vim.opt.modifiable = true
vim.opt.encoding = 'UTF-8'

vim.opt.guicursor = table.concat({
  'n-v-c:block', -- Normal, Visual, Command mode -> block cursor
  'i-ci-ve:ver25', -- Insert, Command-line Insert, Visual-Select mode -> vertical bar cursor
  'r-cr:hor20', -- Replace, Command-line Replace mode -> horizontal bar cursor
  'o:hor50', -- Operator-pending mode -> horizontal bar cursor
  'a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor', -- All modes -> blinking cursor
  'sm:block-blinkwait175-blinkoff150-blinkon175', -- Showmatch mode -> blinking block cursor
}, ',')

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldlevel = 90

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.wildmenu = true
vim.opt.wildmode = 'longest:full,full'
vim.opt.diffopt:append('linematch:60')
vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000

vim.opt.termguicolors = true

vim.opt.isfname:append('@-@')

-- Always write exactly one newline at EOF
vim.opt.endofline = true
vim.opt.fixendofline = true

vim.schedule(function() vim.o.clipboard = '' end)
