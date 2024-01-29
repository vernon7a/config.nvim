local M = {
  "RRethy/vim-illuminate",
  event = "LazyFile",
  opts = {
    delay = 200,
    large_file_cutoff = 2000,
    large_file_overrides = {
      providers = { "lsp" },
    },
  },
  config = function(_, opts)
    local illuminate = require("illuminate")
    illuminate.configure(opts)

    local function map(key, dirfn, desc, buffer)
      vim.keymap.set("n", key, function()
        dirfn(false)
      end, { desc = desc, buffer = buffer })
    end

    map("]r", illuminate.goto_next_reference, "Next Reference")
    map("[r", illuminate.goto_prev_reference, "Prev Reference")

    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        local buffer = vim.api.nvim_get_current_buf()
        map("]r", illuminate.goto_next_reference, "Next Reference", buffer)
        map("[r", illuminate.goto_prev_reference, "Prev Reference", buffer)
      end,
    })
  end,
  keys = {
    { "]r", desc = "Next Reference" },
    { "[r", desc = "Prev Reference" },
  },
}

return M
