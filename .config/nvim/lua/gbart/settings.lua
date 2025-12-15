local opt = vim.opt

vim.g.mapleader = ","

vim.keymap.set("n", "<M-q>", ":bp<CR>", { noremap = true, desc = "Previous buffer" })
vim.keymap.set("n", "<M-w>", ":bn<CR>", { noremap = true, desc = "Next buffer" })
-- vim.keymap.set("n", "<M-d>", ":bd<CR>", { noremap = true })
vim.keymap.set("n", "<leader>bd", ":bd<CR>", { noremap = true, desc = "Delete buffer" })
vim.keymap.set("n", "<leader>ba", ":bd!<CR>", { noremap = true, desc = "Force delete buffer" })

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

-- Search improvements
opt.ignorecase = true
opt.smartcase = true

-- Persistent undo
opt.undofile = true

-- UI improvements
opt.signcolumn = "yes"
opt.scrolloff = 8
opt.updatetime = 250
