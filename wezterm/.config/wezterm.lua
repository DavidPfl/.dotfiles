local Config = require('config')
require('utils.backdrops'):set_images():random()
require('events.left-status').setup()
require('events.right-status').setup({ date_format = '%a %H:%M:%S' })
require('events.tab-title').setup({ hide_active_tab_unseen = false, unseen_icon = 'numbered_box' })
require('events.new-tab-button').setup()
require('events.gui-startup').setup()

local wezterm = require('wezterm')
local smart_splits = wezterm.plugin.require('https://github.com/mrjones2014/smart-splits.nvim')

local config = Config:init()
   :append(require('config.appearance'))
   :append(require('config.bindings'))
   :append(require('config.domains'))
   :append(require('config.fonts'))
   :append(require('config.general'))
   :append(require('config.launch'))

-- Apply smart-splits AFTER other config
smart_splits.apply_to_config(config.options, {
   direction_keys = {
      move = { 'h', 'j', 'k', 'l' },
      resize = { 'LeftArrow', 'DownArrow', 'UpArrow', 'RightArrow' },
   },
   modifiers = {
      move = 'CTRL', -- Use CTRL+hjkl for navigation
      resize = 'ALT', -- Use ALT+arrows for resizing
   },
   log_level = 'info',
})

return config.options
