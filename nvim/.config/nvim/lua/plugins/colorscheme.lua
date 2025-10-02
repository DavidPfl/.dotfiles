return {
  -- { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  -- {},
  -- {
  --   "rebelot/kanagawa.nvim",
  --   init = function() --this is a fix to avoid black spludges in statusline,. from https://github.com/rebelot/kanagawa.nvim/issues/243#issuecomment-2614627261
  --     vim.api.nvim_create_autocmd("ColorScheme", {
  --       pattern = "kanagawa",
  --       callback = function()
  --         vim.api.nvim_set_hl(0, "StatusLine", { link = "lualine_c_normal" })
  --       end,
  --     })
  --   end,
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require("kanagawa").setup({
  --       -- Customization options here
  --       compile = false,
  --       undercurl = true,
  --       commentStyle = { italic = true },
  --       functionStyle = {},
  --       keywordStyle = { italic = true },
  --       statementStyle = { bold = true },
  --       typeStyle = {},
  --       transparent = false, -- Set to true for transparent background
  --       dimInactive = false,
  --       terminalColors = true,
  --       colors = {
  --         -- Customize palette or theme colors here
  --         palette = {},
  --         -- theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
  --         theme = { all = { ui = { bg_gutter = "none" } } },
  --       },
  --       overrides = function(colors)
  --         -- Add or modify highlight groups here
  --         -- return {}
  --         local theme = colors.theme
  --         return {
  --           -- NormalFloat = { bg = "none" },
  --           -- FloatBorder = { bg = "none" },
  --           -- FloatTitle = { bg = "none" },
  --
  --           -- Save an hlgroup with dark background and dimmed foreground
  --           -- so that you can use it where your still want darker windows.
  --           -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
  --           NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
  --
  --           -- Popular plugins that open floats will link to NormalFloat by default;
  --           -- set their background accordingly if you wish to keep them dark and borderless
  --           LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
  --           MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
  --           Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
  --           PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
  --           PmenuSbar = { bg = theme.ui.bg_m1 },
  --           PmenuThumb = { bg = theme.ui.bg_p2 },
  --         }
  --       end,
  --       theme = "wave", -- "wave", "dragon", or "lotus"
  --       background = {
  --         dark = "wave",
  --         light = "lotus",
  --       },
  --     })
  --     vim.cmd("colorscheme kanagawa")
  --   end,
  -- },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-moon",
    },
  },
}
