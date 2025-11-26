-- ~/.config/wezterm/wezterm.lua (Linux/WSL)
-- %USERPROFILE%\.config\wezterm\wezterm.lua (Windows)

local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

-- Detect platform
local is_windows = wezterm.target_triple:find("windows") ~= nil
local is_linux = wezterm.target_triple:find("linux") ~= nil

-- ============================================================================
-- Shell Configuration
-- ============================================================================
if is_windows then
	-- Use WSL as default shell on Windows
	config.default_prog = { "wsl.exe", "~" }
	-- Uncomment below to use PowerShell instead:
	-- config.default_prog = { 'pwsh.exe', '-NoLogo' }
end

-- ============================================================================
-- Appearance
-- ============================================================================
-- Color scheme - choose one that matches your LazyVim theme
config.color_scheme = "Catppuccin Mocha" -- Popular with LazyVim
-- Other good options: 'Tokyo Night', 'Gruvbox Dark', 'nord'

-- Font configuration
config.font = wezterm.font_with_fallback({
	{ family = "JetBrains Mono", weight = "Medium" },
	{ family = "FiraCode Nerd Font", weight = "Medium" },
	{ family = "Cascadia Code", weight = "Medium" },
})
config.font_size = is_windows and 11.0 or 12.0

-- Window appearance
config.window_decorations = "RESIZE"
config.window_padding = {
	left = 8,
	right = 8,
	top = 8,
	bottom = 8,
}

-- Tab bar
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
config.hide_tab_bar_if_only_one_tab = false

-- Cursor
config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 700

-- Background opacity (optional)
config.window_background_opacity = 0.95
config.text_background_opacity = 1.0

-- ============================================================================
-- Keybindings - Designed to work with LazyVim
-- ============================================================================
-- Leader key matching LazyVim (Space)
config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 1000 }

config.keys = {
	-- ========================================================================
	-- Tabs (similar to LazyVim buffer navigation)
	-- ========================================================================
	-- Create new tab
	{ key = "t", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },

	-- Navigate tabs (like LazyVim's <S-h> and <S-l> for buffers)
	{ key = "H", mods = "SHIFT|CTRL", action = act.ActivateTabRelative(-1) },
	{ key = "L", mods = "SHIFT|CTRL", action = act.ActivateTabRelative(1) },

	-- Move tabs
	{ key = "H", mods = "LEADER|SHIFT", action = act.MoveTabRelative(-1) },
	{ key = "L", mods = "LEADER|SHIFT", action = act.MoveTabRelative(1) },

	-- Close tab
	{ key = "w", mods = "LEADER", action = act.CloseCurrentTab({ confirm = true }) },

	-- Quick tab switching (Alt+number, won't conflict with nvim)
	{ key = "1", mods = "ALT", action = act.ActivateTab(0) },
	{ key = "2", mods = "ALT", action = act.ActivateTab(1) },
	{ key = "3", mods = "ALT", action = act.ActivateTab(2) },
	{ key = "4", mods = "ALT", action = act.ActivateTab(3) },
	{ key = "5", mods = "ALT", action = act.ActivateTab(4) },
	{ key = "6", mods = "ALT", action = act.ActivateTab(5) },
	{ key = "7", mods = "ALT", action = act.ActivateTab(6) },
	{ key = "8", mods = "ALT", action = act.ActivateTab(7) },
	{ key = "9", mods = "ALT", action = act.ActivateTab(8) },

	-- ========================================================================
	-- Panes (matching LazyVim window splits)
	-- ========================================================================
	-- Split panes (matches LazyVim's <leader>wv and <leader>ws)
	{ key = "v", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "s", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },

	-- Navigate panes with Ctrl+hjkl (complementary to LazyVim's window nav)
	{ key = "h", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Left") },
	{ key = "j", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Down") },
	{ key = "k", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Up") },
	{ key = "l", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Right") },

	-- Resize panes
	{ key = "h", mods = "LEADER|SHIFT", action = act.AdjustPaneSize({ "Left", 5 }) },
	{ key = "j", mods = "LEADER|SHIFT", action = act.AdjustPaneSize({ "Down", 5 }) },
	{ key = "k", mods = "LEADER|SHIFT", action = act.AdjustPaneSize({ "Up", 5 }) },
	{ key = "l", mods = "LEADER|SHIFT", action = act.AdjustPaneSize({ "Right", 5 }) },

	-- Close pane
	{ key = "x", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },

	-- Zoom pane (toggle fullscreen, like LazyVim's <leader>wm)
	{ key = "z", mods = "LEADER", action = act.TogglePaneZoomState },

	-- ========================================================================
	-- Copy/Paste (these won't conflict with LazyVim)
	-- ========================================================================
	{ key = "c", mods = "CTRL|SHIFT", action = act.CopyTo("Clipboard") },
	{ key = "v", mods = "CTRL|SHIFT", action = act.PasteFrom("Clipboard") },

	-- ========================================================================
	-- Terminal Utilities
	-- ========================================================================
	-- Clear scrollback (like clear command)
	{ key = "k", mods = "CTRL|SHIFT", action = act.ClearScrollback("ScrollbackAndViewport") },

	-- Search (like LazyVim's /)
	{ key = "f", mods = "LEADER", action = act.Search("CurrentSelectionOrEmptyString") },

	-- Toggle fullscreen
	{ key = "F11", mods = "NONE", action = act.ToggleFullScreen },

	-- Quick select mode (for URLs, file paths, etc.)
	{ key = "Space", mods = "LEADER", action = act.QuickSelect },

	-- Font size adjustment
	{ key = "+", mods = "CTRL|SHIFT", action = act.IncreaseFontSize },
	{ key = "_", mods = "CTRL|SHIFT", action = act.DecreaseFontSize },
	{ key = "0", mods = "CTRL", action = act.ResetFontSize },

	-- Show launcher menu
	{ key = "p", mods = "LEADER", action = act.ShowLauncherArgs({ flags = "FUZZY|TABS" }) },

	-- Rename tab (like LazyVim's rename)
	{
		key = "r",
		mods = "LEADER",
		action = act.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
}

-- ============================================================================
-- Mouse Bindings
-- ============================================================================
config.mouse_bindings = {
	-- Open URLs with Ctrl+Click
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = act.OpenLinkAtMouseCursor,
	},
	-- Paste on right click
	{
		event = { Down = { streak = 1, button = "Right" } },
		mods = "NONE",
		action = act.PasteFrom("Clipboard"),
	},
}

-- ============================================================================
-- WSL Domain Configuration (Windows only)
-- ============================================================================
if is_windows then
	config.wsl_domains = {
		{
			name = "WSL:Ubuntu",
			distribution = "Ubuntu",
			default_cwd = "~",
		},
	}

	-- Set WSL as default domain
	config.default_domain = "WSL:Ubuntu"
end

-- ============================================================================
-- Performance Tweaks
-- ============================================================================
config.max_fps = 120
config.animation_fps = 60
config.scrollback_lines = 10000

-- ============================================================================
-- Tab Bar Customization
-- ============================================================================
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local title = tab.tab_title
	-- If the tab title is not set, use the active pane's title
	if not title or #title == 0 then
		title = tab.active_pane.title
	end

	local index = tab.tab_index + 1
	return {
		{ Text = " " .. index .. ": " .. title .. " " },
	}
end)

-- ============================================================================
-- Smart Working Directory (for new splits/tabs)
-- ============================================================================
config.default_cwd = wezterm.home_dir

return config
