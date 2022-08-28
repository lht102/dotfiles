local treesitter = require("nvim-treesitter.configs")

treesitter.setup({
  ensure_installed = {
    "lua",
    "go",
    "rust",
    "tsx",
    "json",
    "yaml",
  },
  highlight = {
    enable = true,
  },
  autotag = {
    enable = true,
  },
})
