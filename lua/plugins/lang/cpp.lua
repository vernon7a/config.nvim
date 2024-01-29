local M = {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      local root = nil

      dap.adapters.codelldb = {
        type = "server",
        host = "127.0.0.1",
        cwd = "${workspaceFolder}",
        port = "${port}",
        executable = {
          command = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb.exe",
          args = { "--port", "${port}" },
          -- On windows you may have to uncomment this:
          detached = false,
        },
      }

      dap.configurations.cpp = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          program = function()
            root = vim.fn.input({
              prompt = "Path to executable: ",
              default = root or require("lazyvim.util").root(),
              completion = "file",
            })
            return root
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }

      dap.configurations.c = dap.configurations.cpp
      dap.configurations.rust = dap.configurations.cpp
    end,
  },
}

return M
