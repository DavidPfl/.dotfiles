return {
  "christoomey/vim-tmux-navigator",
  -- the following does not work, since these keymaps are already used by lazyvim (https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua)
  -- instead, I set the keymaps in ../config/keymaps.lua
  vim.keymap.set("n", "C-h", ":TmuxNavigateLeft<CR>"),
  vim.keymap.set("n", "C-j", ":TmuxNavigateDown<CR>"),
  vim.keymap.set("n", "C-k", ":TmuxNavigateUp<CR>"),
  vim.keymap.set("n", "C-l", ":TmuxNavigateRight<CR>"),
}
