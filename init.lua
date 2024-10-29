-- Set the mapleader
vim.g.mapleader = ','

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  "direnv/direnv.vim",
  "nvim-treesitter/nvim-treesitter",
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
  { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true},
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    }
  },
  
  "github/copilot.vim",
    {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    opts = {
      debug = true, -- Enable debugging
      -- See Configuration section for rest
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
  "dense-analysis/ale",
  "hrsh7th/nvim-cmp",
  "tpope/vim-fugitive",
  "prettier/vim-prettier",
  "editorconfig/editorconfig-vim",
  "mileszs/ack.vim",
  "jiangmiao/auto-pairs",
  {
    'nanozuki/tabby.nvim',
    event = 'VimEnter',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      -- configs...
    end,
  },

  {
    'nvim-telescope/telescope.nvim', tag = '0.1.6',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-live-grep-args.nvim', verion = '^0.1.0' }
    },
    config = function()
      require('telescope').load_extension('live_grep_args')
    end
  }, 

  {
    "preservim/nerdcommenter"
  },

-- lsp start
  {
    'williamboman/mason.nvim',
    lazy = false,
    config = true,
  },
  { 'williamboman/mason-lspconfig.nvim' },
  {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
  {'neovim/nvim-lspconfig', commit = '0ef6459'},
  {'hrsh7th/cmp-nvim-lsp'},
  {'hrsh7th/nvim-cmp'},
  {'L3MON4D3/LuaSnip'},
-- end
  {'mhartington/formatter.nvim'}
}

require("lazy").setup(plugins)
require("neo-tree").setup({
  icon = {},
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
}) 
--require("neo-tree").setup({
  --icon = {}
--})
-- require('lspconfig').tsserver.setup{}
require("mylsp2")
require("tabby")
require("mytelescope")
require("gruvbox").setup({
  terminal_colors = true, -- add neovim terminal colors
  undercurl = true,
  underline = true,
  bold = true,
  italic = {
    strings = true,
    emphasis = true,
    comments = true,
    operators = false,
    folds = true,
  },
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "soft", -- can be "hard", "soft" or empty string
  palette_overrides = {},
  overrides = {},
  dim_inactive = false,
  transparent_mode = true,
  overrides = {
    SignColumn = { bg = "NONE" },
    ["@comment.lua"] = { bg = "#000000" },
  },
})

vim.o.background = "dark" -- or "light" for light mode
vim.cmd("let g:gruvbox_transparent_bg = 1")
vim.cmd("autocmd VimEnter * hi Normal ctermbg=NONE guibg=NONE")
vim.cmd([[colorscheme gruvbox]])
vim.opt.guicursor = ""
vim.o.showmatch = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.cursorline = true
vim.o.number = true
vim.o.showmode = true
vim.opt.wrap = false
--vim.opt.foldable = true
vim.o.clipboard = "unnamed"
vim.o.smartindent = true
vim.o.syntax = "on"
vim.o.termguicolors = true
vim.api.nvim_set_keymap("n", "<leader><space>", ":Neotree toggle reveal_force_cwd<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ch", ":CopilotChatToggle<CR>", { noremap = true, silent = true })
--vim.api.nvim_set_keymap("n", "<leader>ff", ":FZF<enter>", { noremap = true, silent = true })
vim.g.ale_fix_on_save = 1
