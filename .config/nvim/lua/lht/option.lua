vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.background = "dark"

vim.opt.shell = "zsh"

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.hlsearch = true
vim.opt.ignorecase = true

vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

vim.opt.formatoptions:remove("o")
vim.opt.formatoptions:remove("r")

vim.opt.title = true
vim.opt.showcmd = true
vim.opt.cmdheight = 1
vim.opt.inccommand = "split"
vim.opt.laststatus = 2
vim.opt.wrap = false

vim.opt.completeopt = "menu,menuone,noinsert"
