-- path = ~/AppData/Local/lvim/
package.path = package.path .. ";C:/Users/Asthestarsfall/AppData/Local/lvim/ftplugin/?.lua"

--[[
 THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
`lvim` is the global options object
]]

-- Enable powershell as your default shell
vim.opt.shell = "pwsh.exe -NoLogo"
vim.opt.shellcmdflag =
"-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
vim.cmd [[
		let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
		let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
		set shellquote= shellxquote=
  ]]
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10
local opts = { noremap = true, silent = true }

-- vim.keymap.set("n", "<C-i>", "<cmd>IconPickerNormal<cr>", opts)
vim.keymap.set("n", "<Leader><Leader>y", "<cmd>IconPickerYank<cr>", opts) --> Yank the selected icon into register
-- vim.keymap.set("i", "<C-i>", "<cmd>IconPickerInsert<cr>", opts)
vim.keymap.set("i", "<C-h>", "<Left>")
vim.keymap.set("i", "<C-j>", "<Down>")
vim.keymap.set("i", "<C-k>", "<Up>")
vim.keymap.set("i", "<C-l>", "<Right>")

-- Set a compatible clipboard manager
vim.g.clipboard = {
  copy = {
    ["+"] = "win32yank.exe -i --crlf",
    ["*"] = "win32yank.exe -i --crlf",
  },
  paste = {
    ["+"] = "win32yank.exe -o --lf",
    ["*"] = "win32yank.exe -o --lf",
  },
}


-- general
lvim.log.level = "warn"
lvim.format_on_save.enabled = false
lvim.colorscheme = "rose-pine"
lvim.transparent_window = false
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping

lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<S-w>"] = ":bdelete %<CR>"
lvim.keys.normal_mode["<S-n>"] = "ggVG:SnipRun<CR>"
lvim.keys.normal_mode["<C-a>"] = "ggVG"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")
-- override a default keymapping
lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )
-- lvim.keys.normal_mode["<S-w>"] = ":BufferKill<CR>"
lvim.builtin.which_key.mappings["u"] = {
  name = "+User keymap",
  c = { "<cmd>cd %:p:h<CR>:pwd<CR>", "change current file directory" }
}
lvim.builtin.which_key.mappings.l = vim.tbl_extend("keep", lvim.builtin.which_key.mappings.l,
  {
    o = { "<cmd>SymbolsOutline<cr>", "Open Outline" }
  }
)

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
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
}

-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = false
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
-- lvim.builtin.terminal.shell = "pwsh.exe -NoLogo"

-- nvim-tree has some performance issues on windows, see kyazdani42/nvim-tree.lua#549
lvim.builtin.nvimtree.setup.diagnostics.enable = nil
lvim.builtin.nvimtree.setup.filters.custom = nil
lvim.builtin.nvimtree.setup.git.enable = nil
lvim.builtin.nvimtree.setup.update_cwd = nil
lvim.builtin.nvimtree.setup.update_focused_file.update_cwd = nil
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.highlight_git = nil
lvim.builtin.nvimtree.setup.renderer.icons.show.git = nil

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  -- "javascript",
  "json",
  "lua",
  "python",
  -- "typescript",
  -- "tsx",
  -- "css",
  -- "rust",
  -- "java",
  "yaml",
}
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true

-- generic LSP settings

-- -- make sure server will always be installed even if the server is in skipped_servers list
lvim.lsp.installer.setup.ensure_installed = {
  "sumneko_lua",
  "jsonls",
  "pyright",
  "clangd"
}
-- -- change UI setting of `LspInstallInfo`
-- -- see <https://github.com/williamboman/nvim-lsp-installer#default-configuration>
-- lvim.lsp.installer.setup.ui.check_outdated_servers_on_open = false
-- lvim.lsp.installer.setup.ui.border = "rounded"
-- lvim.lsp.installer.setup.ui.keymaps = {
--     uninstall_server = "d",
--     toggle_server_expand = "o",
-- }

-- ---@usage disable automatic installation of servers
lvim.lsp.installer.setup.automatic_installation = true

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options

-- require("lvim.lsp.manager").setup("clangd")
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup({
--   { command = "black", filetypes = { "python" } },
--   { command = "isort", filetypes = { "python" } },
-- -- {
-- --   -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
-- --   command = "prettier",
-- --   ---@usage arguments to pass to the formatter
-- --   -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
-- --   extra_args = { "--print-with", "100" },
-- --   ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
-- --   filetypes = { "typescript", "typescriptreact" },
-- -- },
-- })

-- -- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup({
--   { command = "flake8", filetypes = { "python" } },
-- -- {
-- --   -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
-- --   command = "shellcheck",
-- --   ---@usage arguments to pass to the formatter
-- --   -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
-- --   extra_args = { "--severity", "warning" },
-- -- },
-- -- {
-- --   command = "codespell",
-- --   ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
-- --   filetypes = { "javascript", "python" },
-- -- },
-- })
lvim.plugins = {
  -- Additional Plugins
  {
    "ziontee113/icon-picker.nvim",
    config = function()
      require("icon-picker").setup({
        disable_legacy_commands = true
      })
    end,
  },
  { "LintaoAmons/scratch.nvim" },
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
  },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  {
    'rose-pine/neovim',
    as = 'rose-pine',
    config = function()
      vim.cmd('colorscheme rose-pine')
    end
  },
  { "glepnir/lspsaga.nvim" },
  {"stevearc/dressing.nvim"},
  -- { 'glepnir/zephyr-nvim',
  --   config = function()
  --     require('zephyr')
  --   end
  -- },
  {
    "sindrets/diffview.nvim",
    event = "BufRead",
  },
  -- { "wakatime/vim-wakatime" },
  -- { 'neoclide/coc.nvim', branch = 'release' },
  -- {"nvim-lsp-installer"},
  -- {"lukas-reineke/indent-blankline.nvim"},
  -- {
  --   "glepnir/lspsaga.nvim",
  --   branch = "main",
  --   -- config = function()
  --   --   local saga = require("lspsaga")

  --   --   saga.init_lsp_saga({
  --   --     -- your configuration
  --   --   })
  --   -- end,
  -- }
}

-- opts = {
--   highlight_hovered_item = true,
--   show_guides = true,
--   auto_preview = false,
--   position = 'right',
--   relative_width = true,
--   width = 25,
--   auto_close = false,
--   show_numbers = false,
--   show_relative_numbers = false,
--   show_symbol_details = true,
--   preview_bg_highlight = 'Pmenu',
--   autofold_depth = nil,
--   auto_unfold_hover = true,
--   fold_markers = { '', '' },
--   wrap = false,
--   keymaps = { -- These keymaps can be a string or a table for multiple keys
--     close = { "<Esc>", "q" },
--     goto_location = "<Cr>",
--     focus_location = "o",
--     hover_symbol = "<S-space>",
--     toggle_preview = "K",
--     rename_symbol = "r",
--     code_actions = "a",
--     fold = "h",
--     unfold = "l",
--     fold_all = "W",
--     unfold_all = "E",
--     fold_reset = "R",
--   },
--   lsp_blacklist = {},
--   symbol_blacklist = {},
--   symbols = {
--     File = { icon = "", hl = "TSURI" },
--     Module = { icon = "", hl = "TSNamespace" },
--     Namespace = { icon = "", hl = "TSNamespace" },
--     Package = { icon = "", hl = "TSNamespace" },
--     Class = { icon = "𝓒", hl = "TSType" },
--     Method = { icon = "ƒ", hl = "TSMethod" },
--     Property = { icon = "", hl = "TSMethod" },
--     Field = { icon = "", hl = "TSField" },
--     Constructor = { icon = "", hl = "TSConstructor" },
--     Enum = { icon = "ℰ", hl = "TSType" },
--     Interface = { icon = "ﰮ", hl = "TSType" },
--     Function = { icon = "", hl = "TSFunction" },
--     Variable = { icon = "", hl = "TSConstant" },
--     Constant = { icon = "", hl = "TSConstant" },
--     String = { icon = "𝓐", hl = "TSString" },
--     Number = { icon = "#", hl = "TSNumber" },
--     Boolean = { icon = "⊨", hl = "TSBoolean" },
--     Array = { icon = "", hl = "TSConstant" },
--     Object = { icon = "⦿", hl = "TSType" },
--     Key = { icon = "🔐", hl = "TSType" },
--     Null = { icon = "NULL", hl = "TSType" },
--     EnumMember = { icon = "", hl = "TSField" },
--     Struct = { icon = "𝓢", hl = "TSType" },
--     Event = { icon = "🗲", hl = "TSType" },
--     Operator = { icon = "+", hl = "TSOperator" },
--     TypeParameter = { icon = "𝙏", hl = "TSParameter" }
--   }
-- }
-- require("Symbols-outline").setup(opts)
vim.opt.termguicolors = true
vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]

vim.opt.list = true
-- vim.opt.listchars:append "space:⋅"
-- vim.opt.listchars:append "eol:↴"
require("indent_blankline").setup({
  -- for example, context is off by default, use this to turn it on
  show_current_context = true,
  show_current_context_start = true,
  show_end_of_line = true,
  space_char_blankline = " ",
  char_highlight_list = {
    "IndentBlanklineIndent1",
    "IndentBlanklineIndent2",
    "IndentBlanklineIndent3",
    "IndentBlanklineIndent4",
    "IndentBlanklineIndent5",
    "IndentBlanklineIndent6",
  },
})

require("scratch").setup {
  scratch_file_dir = vim.fn.stdpath("cache") .. "/scratch.nvim", -- Where the scratch files will be saved
  filetypes = { "json", "xml", "go", "lua", "js", "py", "sh", "c", "cuda", "cpp" }, -- filetypes to select from
}

-- vim.keymap.set("n", "<S-n>", "<cmd>Scratch<cr>")
-- vim.keymap.set("n", "<S-m>", "<cmd>ScratchWithName<cr>")
-- vim.keymap.set("n", "<S-o>", "<cmd>ScratchOpen<cr>")


require("icon-picker").setup({ disable_legacy_commands = true })
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
