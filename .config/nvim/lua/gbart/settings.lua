local opt = vim.opt
local global = vim.g

vim.g.mapleader = ","

vim.keymap.set("n", "<M-q>", ":bp<CR>", { noremap = true })
vim.keymap.set("n", "<M-w>", ":bn<CR>", { noremap = true })
-- vim.keymap.set("n", "<M-d>", ":bd<CR>", { noremap = true })
vim.keymap.set("n", "<leader>bd", ":bd<CR>", { noremap = true })
vim.keymap.set("n", "<leader>ba", ":bd!<CR>", { noremap = true})

vim.scriptencoding = "utf-8"

opt.number = true
opt.relativenumber = true
opt.cursorline = true

opt.autoindent = true
-- opt.smartindent = true
-- opt.smarttab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

opt.termguicolors = true
opt.encoding = "utf-8"

opt.splitright = true
opt.splitbelow = true
