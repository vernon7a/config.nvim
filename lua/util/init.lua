-- Util: Init
-- https://github.com/rafi/vim-config

-- This is part of LazyVim's code, with my modifications.
-- See: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/util/init.lua

local LazyUtil = require("lazy.core.util")

local M = {}

local deprecated = {}

setmetatable(M, {
  __index = function(t, k)
    if LazyUtil[k] then
      return LazyUtil[k]
    end
    local dep = deprecated[k]
    if dep then
      local mod = type(dep) == "table" and dep[1] or dep
      local key = type(dep) == "table" and dep[2] or k
      M.deprecate([[require("util").]] .. k, [[require("util").]] .. mod .. "." .. key)
      ---@diagnostic disable-next-line: no-unknown
      t[mod] = require("util." .. mod) -- load here to prevent loops
      return t[mod][key]
    end
    ---@diagnostic disable-next-line: no-unknown
    t[k] = require("util." .. k)
    return t[k]
  end,
})

function M.deprecate(old, new)
  M.warn(("`%s` is deprecated. Please use `%s` instead"):format(old, new), {
    title = "Rafi",
    once = true,
    stacktrace = true,
    stacklevel = 6,
  })
end

return M
