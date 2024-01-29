-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local utils = require("lazyvim.util")

local lazyterm = function()
  utils.terminal(nil, {
    cwd = utils.root(),
    ctrl_hjkl = false,
    border = "single",
  })
end

-- 打开浮动终端，配置好的样式
vim.keymap.set("n", "<C-_>", lazyterm, { desc = "Terminal (root dir)" })
vim.keymap.set("n", "<C-/>", lazyterm, { desc = "Terminal (root dir)" })
vim.keymap.set("t", "<C-_>", "<cmd>close<cr>", { desc = "Hide Terminal" })
vim.keymap.set("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })

vim.keymap.set("n", "<leader>p", '"+p')
vim.keymap.set("n", "<leader>y", '"+y')
