return {
  "HakonHarnes/img-clip.nvim",
  event = "VeryLazy",
  opts = {
    -- add options here
    -- or leave it empty to use the default settings
    default = {
      use_absolute_path = false,
      relative_to_current_file = true,
      template = '<img src="$FILE_PATH" alt="$CURSOR">',
      -- prompt_for_file_name = false,
      -- file_name = "%y%m%d-%H%M%S",
    },
    filetypes = {
      markdown = {
        url_encode_path = true, ---@type boolean | fun(): boolean
        -- use html template if you want to enable easier resizing of images like <img src="assets/test.png" alt="test" width="40%">
        -- template = '<img src="$FILE_PATH" alt="$CURSOR">',
        download_images = false, ---@type boolean | fun(): boolean
      },
    },
  },
  keys = {
    -- suggested keymap
    { "<leader>i", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
  },
}
