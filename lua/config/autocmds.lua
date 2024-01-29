-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local utils = require("util")

vim.api.nvim_create_user_command("FixMasonLinks", function()
  utils.FixMasonLinks()
end, {})
