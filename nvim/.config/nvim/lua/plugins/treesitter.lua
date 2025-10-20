return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "cpp",
      "vue",
      "html",
      "css",
      "java",
      "javascript",
      "typescript",
    },
    textobjects = {
      swap = {
        enable = true,
        swap_next = { ["<leader>sa"] = "@parameter.inner" },
        swap_previous = { ["<leader>sA"] = "@parameter.inner" },
      },
    },
  },
}
