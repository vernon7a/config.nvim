return {
  {
    "CRAG666/code_runner.nvim",
    keys = {
      { "<leader>rr", "<cmd>RunCode<cr>", desc = "Runs based on file type" },
      { "<leader>rf", "<cmd>RunFile<cr>", desc = "Runs the current file" },
      { "<leader>rp", "<cmd>RunProject<cr>", desc = "Runs the current project" },
    },
    opts = {
      filetype = {
        python = "python -u",
        typescript = "deno run -A",
      },
    },
  },
}
