local treesitter = require("nvim-treesitter.configs")
local treesitter_context = require("treesitter-context")

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
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
      include_surrounding_whitespace = true,
    }
  }
})

treesitter_context.setup({
  enable = true
})
