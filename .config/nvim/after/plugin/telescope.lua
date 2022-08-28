local telescope = require("telescope")
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

telescope.setup({
  defaults = {
    mappings = {
      ["n"] = {
        ["q"] = actions.close
      },
    },
  },
  extensions = {
    file_browser = {
      theme = "dropdown",
      hijack_netrw = true,
      mappings = {
        ["i"] = {
        },
        ["n"] = {
        },
      },
    },
  },
})

telescope.load_extension("file_browser")

vim.keymap.set("n", "<leader>ff", function()
  builtin.find_files({
    no_ignore = false,
    hidden = true
  })
end)

vim.keymap.set("n", "<leader>lg", function()
  builtin.live_grep()
end)

vim.keymap.set("n", "<leader>fb", function()
  telescope.extensions.file_browser.file_browser()
end)

vim.keymap.set("n", "<leader>vr", function()
  builtin.resume()
end)

vim.keymap.set("n", "<leader>vb", function()
  builtin.buffers()
end)

vim.keymap.set("n", "<leader>vk", function()
  builtin.keymaps()
end)

vim.keymap.set("n", "<leader>da", function()
  builtin.diagnostics()
end)

vim.keymap.set("n", "gd", function()
  builtin.lsp_definitions()
end)

vim.keymap.set("n", "<leader>lt", function()
  builtin.lsp_type_definitions()
end)

vim.keymap.set("n", "<leader>li", function()
  builtin.lsp_implementations()
end)

vim.keymap.set("n", "<leader>lr", function()
  builtin.lsp_references()
end)
