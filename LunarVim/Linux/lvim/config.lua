 --[[lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.log.level = "warn"
lvim.format_on_save = false
lvim.colorscheme = "rose-pine"
lvim.transparrent_window = false
lvim.line_numbers = true
lvim.cursorline = true
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["<S-w>"] = ":bdelete %<CR>"
lvim.keys.normal_mode["<S-n>"] = "ggVG:SnipRun<CR>"
lvim.keys.normal_mode["<C-a>"] = "ggVG"

-- lvim.keys.normal_mode["<S-x>"] = ":BufferClose<CR>"

-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")

-- lvim.keys.normal_mode["<C-h>"] = false
-- lvim.keys.normal_mode["<C-j>"] = false
-- lvim.keys.normal_mode["<C-k>"] = false
-- lvim.keys.normal_mode["<C-l>"] = false
-- lvim.keys.normal_mode["s"] = "<C-w>"
-- override a default keymapping
lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
local _, actions = pcall(require, "telescope.actions")

lvim.builtin.telescope.defaults.mappings = {
  -- for input mode
  i = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-n>"] = actions.cycle_history_next,
    ["<C-p>"] = actions.cycle_history_prev,
  },
  -- for normal mode
  n = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
  },
}

-- Change theme settings
-- lvim.builtin.theme.options.dim_inactive = true
-- lvim.builtin.theme.options.style = "storm"

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
}

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true

-- generic LSP settings

-- -- make sure server will always be installed even if the server is in skipped_servers list
-- lvim.lsp.installer.setup.ensure_installed = {
--     "sumneko_lua",
--     "jsonls",
-- }
-- -- change UI setting of `LspInstallInfo`
-- -- see <https://github.com/williamboman/nvim-lsp-installer#default-configuration>
-- lvim.lsp.installer.setup.ui.check_outdated_servers_on_open = false
-- lvim.lsp.installer.setup.ui.border = "rounded"
-- lvim.lsp.installer.setup.ui.keymaps = {
--     uninstall_server = "d",
--     toggle_server_expand = "o",
-- }

-- ---@usage--[[   ]]disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })"
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end
-- Additional Plugins
lvim.plugins = {
  {
    "sindrets/diffview.nvim",
    event = "BufRead",
  },
  { "wakatime/vim-wakatime" },
  { "marko-cerovac/material.nvim" },
  { "mhartington/oceanic-next" },
  { "rafamadriz/neon" },
  {
    'rose-pine/neovim',
    as = 'rose-pine',
    config = function()
      vim.cmd('colorscheme rose-pine')
    end
  },
  { "rebelot/kanagawa.nvim" },
  { "ojroques/nvim-hardline" },
  {"stevearc/dressing.nvim"},
  {
    "ziontee113/icon-picker.nvim",
    config = function()
      require("icon-picker").setup({
        disable_legacy_commands = true
      })
    end,
  },
  { 'michaelb/sniprun', run = 'bash ./install.sh'},
  { "ggandor/lightspeed.nvim"},
  { "LintaoAmons/scratch.nvim"},
}
-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "black", filetypes = { "python" } },
  { command = "isort", filetypes = { "python" } },
  -- {
  --   -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
  --   --
  --   command = "prettier",
  --   ---@usage arguments to pass to the formatter
  --   -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
  --   extra_args = { "--print-with", "100" },
  --   ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
  --   filetypes = { "typescript", "typescriptreact" },
  -- },
  { command = "clang_format", filetypes = { "c", "c++", "cuda"} }
}

-- -- set additional linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "flake8", filetypes = { "python" } },
  {
    -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "shellcheck",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    extra_args = { "--severity", "warning" },
  },
  {
    command = "codespell",
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "javascript", "python" },
  },
}

require("scratch").setup {
	scratch_file_dir = vim.fn.stdpath("cache") .. "/scratch.nvim",  -- Where the scratch files will be saved
	filetypes = { "json", "xml", "go", "lua", "js", "py", "sh", "c", "cuda", "cpp" },   -- filetypes to select from
}

vim.keymap.set("n", "<S-n>", "<cmd>Scratch<cr>")
vim.keymap.set("n", "<S-m>", "<cmd>ScratchWithName<cr>")
vim.keymap.set("n", "<S-o>", "<cmd>ScratchOpen<cr>")


require("icon-picker").setup({ disable_legacy_commands = true })

require'sniprun'.setup({
  selected_interpreters = {},     --# use those instead of the default for the current filetype
  repl_enable = {},               --# enable REPL-like behavior for the given interpreters
  repl_disable = {},              --# disable REPL-like behavior for the given interpreters

  interpreter_options = {         --# interpreter-specific options, see docs / :SnipInfo <name>

    --# use the interpreter name as key
    GFM_original = {
      use_on_filetypes = {"markdown.pandoc"}    --# the 'use_on_filetypes' configuration key is
                                                --# available for every interpreter
    },
    Python3_original = {
        error_truncate = "auto"         --# Truncate runtime errors 'long', 'short' or 'auto'
                                        --# the hint is available for every interpreter
                                        --# but may not be always respected
    }
  },  --# you can combo different display modes as desired and with the 'Ok' or 'Err' suffix

  --# to filter only sucessful runs (or errored-out runs respectively)
  display = {
    "Classic",                    --# display results in the command-line  area
    "VirtualTextOk",              --# display ok results as virtual text (multiline is shortened)

    -- "VirtualText",             --# display results as virtual text
    -- "TempFloatingWindow",      --# display results in a floating window
    -- "LongTempFloatingWindow",  --# same as above, but only long results. To use with VirtualText[Ok/Err]
    -- "Terminal",                --# display results in a vertical split
    -- "TerminalWithCode",        --# display results and code history in a vertical split
    -- "NvimNotify",              --# display with the nvim-notify plugin
    -- "Api"                      --# return output to a programming interface
  },

  live_display = { "VirtualTextOk" }, --# display mode used in live_mode

  display_options = {
    terminal_width = 45,       --# change the terminal display option width
    notification_timeout = 5   --# timeout for nvim_notify output
  },

  --# You can use the same keys to customize whether a sniprun producing
  --# no output should display nothing or '(no output)'
  show_no_output = {
    "Classic",
    "TempFloatingWindow",      --# implies LongTempFloatingWindow, which has no effect on its own
  },

  --# customize highlight groups (setting this overrides colorscheme)
  snipruncolors = {
    SniprunVirtualTextOk   =  {bg="#66eeff",fg="#000000",ctermbg="Cyan",cterfg="Black"},
    SniprunFloatingWinOk   =  {fg="#66eeff",ctermfg="Cyan"},
    SniprunVirtualTextErr  =  {bg="#881515",fg="#000000",ctermbg="DarkRed",cterfg="Black"},
    SniprunFloatingWinErr  =  {fg="#881515",ctermfg="DarkRed"},
  },

  --# miscellaneous compatibility/adjustement settings
  inline_messages = 0,             --# inline_message (0/1) is a one-line way to display messages
				                   --# to workaround sniprun not being able to display anything

  borders = 'single',              --# display borders around floating windows
                                   --# possible values are 'none', 'single', 'double', or 'shadow'
  live_mode_toggle='off'           --# live mode toggle, see Usage - Running for more info   
})

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.json", "*.jsonc" },
--   -- enable wrap mode for json files only
--   command = "setlocal wrap",
-- })
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })


-- Options
-- vim.opt.clipboard = "unnamedplus"
vim.opt.shell = '/bin/bash'
vim.opt.termguicolors = true
vim.g.material_style = 'palenight'
-- vim.o.background = 'dark'

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<C-i>", "<cmd>IconPickerNormal<cr>", opts)
vim.keymap.set("n", "<Leader><Leader>y", "<cmd>IconPickerYank<cr>", opts) --> Yank the selected icon into register
-- vim.keymap.set("i", "<C-i>", "<cmd>IconPickerInsert<cr>", opts)
vim.keymap.set("i", "<C-h>", "<Left>")
vim.keymap.set("i", "<C-j>", "<Down>")
