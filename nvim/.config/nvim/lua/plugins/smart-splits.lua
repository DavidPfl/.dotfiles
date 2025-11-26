return {
  "mrjones2014/smart-splits.nvim",
  lazy = false, -- Don't lazy load for Wezterm integration
  opts = {
    -- Ignored buffer types (only while resizing)
    ignored_buftypes = {
      "nofile",
      "quickfix",
      "prompt",
    },
    -- Ignored filetypes (only while resizing)
    ignored_filetypes = { "NvimTree" },
    -- Default resize amount
    default_amount = 3,
    -- Behavior at edge: 'wrap', 'split', or 'stop'
    at_edge = "wrap",
    -- Behavior for floating windows
    float_win_behavior = "previous",
    -- Move cursor to same row when switching splits
    move_cursor_same_row = false,
    -- Cursor follows swapped buffers
    cursor_follows_swapped_bufs = false,
    -- Multiplexer integration (auto-detected)
    -- multiplexer_integration = nil,
    -- Disable multiplexer nav when zoomed
    disable_multiplexer_nav_when_zoomed = true,
  },
  keys = {
    -- Moving between splits
    {
      "<A-h>",
      function()
        require("smart-splits").move_cursor_left()
      end,
      desc = "Move to left split",
    },
    {
      "<A-j>",
      function()
        require("smart-splits").move_cursor_down()
      end,
      desc = "Move to below split",
    },
    {
      "<A-k>",
      function()
        require("smart-splits").move_cursor_up()
      end,
      desc = "Move to above split",
    },
    {
      "<A-l>",
      function()
        require("smart-splits").move_cursor_right()
      end,
      desc = "Move to right split",
    },
    {
      "<A-\\>",
      function()
        require("smart-splits").move_cursor_previous()
      end,
      desc = "Move to previous split",
    },

    -- Resizing splits
    {
      "<M-h>",
      function()
        require("smart-splits").resize_left()
      end,
      desc = "Resize split left",
    },
    {
      "<M-j>",
      function()
        require("smart-splits").resize_down()
      end,
      desc = "Resize split down",
    },
    {
      "<M-k>",
      function()
        require("smart-splits").resize_up()
      end,
      desc = "Resize split up",
    },
    {
      "<M-l>",
      function()
        require("smart-splits").resize_right()
      end,
      desc = "Resize split right",
    },

    -- Swapping buffers between windows (optional)
    {
      "<leader><leader>h",
      function()
        require("smart-splits").swap_buf_left()
      end,
      desc = "Swap buffer left",
    },
    {
      "<leader><leader>j",
      function()
        require("smart-splits").swap_buf_down()
      end,
      desc = "Swap buffer down",
    },
    {
      "<leader><leader>k",
      function()
        require("smart-splits").swap_buf_up()
      end,
      desc = "Swap buffer up",
    },
    {
      "<leader><leader>l",
      function()
        require("smart-splits").swap_buf_right()
      end,
      desc = "Swap buffer right",
    },
  },
}
