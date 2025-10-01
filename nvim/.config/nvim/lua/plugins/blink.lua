return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      preset = "default",
      ["<CR>"] = {}, -- Disable Enter for accepting completions
      ["<Tab>"] = { "select_and_accept" },
    },
  },
}
