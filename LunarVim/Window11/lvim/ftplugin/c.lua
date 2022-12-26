local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup({
  { command = "clang_format", filetypes = { "c", "c++", "cuda" } }
})

