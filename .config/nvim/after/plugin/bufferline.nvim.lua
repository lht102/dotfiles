local bufferline = require("bufferline")

bufferline.setup({
  options = {
    separator_style = "slant",
    show_buffer_close_icons = false,
    show_close_icon = false,
  },
})

vim.keymap.set("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", {})
vim.keymap.set("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", {})
