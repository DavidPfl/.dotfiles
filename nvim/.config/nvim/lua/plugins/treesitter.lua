return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    -- Add multiple parsers at once
    vim.list_extend(opts.ensure_installed, {
      "cpp",
      "vue",
      "html",
      "css",
      "java",
      "javascript",
      "typescript",
    })
    opts.textobjects = {
      swap = {
        enable = true,
        swap_next = { ["<leader>sa"] = "@parameter.inner" },
        swap_previous = { ["<leader>sA"] = "@parameter.inner" },
      },
    }
  end,
}
