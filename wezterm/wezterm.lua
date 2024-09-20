-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

local act = wezterm.action

local mod = {}

mod.SUPER = "ALT" -- to not conflict with Windows key shortcuts
mod.SUPER_REV = "ALT|CTRL"
mod.SUPER_SHIFT = "SHIFT|CTRL"

config.window_padding = {
	left = 0,
	right = 0,
	top = 2,
	bottom = 0,
}

-- This is where you actually apply your config choices
config.default_prog = { "pwsh" }

-- For example, changing the color scheme:
config.color_scheme = "tokyonight-storm"

config.font = wezterm.font("Hack Nerd Font")

config.font_size = 14.0

config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.scrollback_lines = 3000
config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1000 }

config.keys = {
	{
		key = "w",
		mods = mod.SUPER_REV,
		action = act.CloseCurrentTab({ confirm = true }),
	},

	{ key = "t", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },

	{
		key = "t",
		mods = mod.SUPER,
		action = act.SpawnTab("DefaultDomain"),
	},
	{ key = "t", mods = mod.SUPER_REV, action = act.SpawnTab({ DomainName = "WSL:Ubuntu-22.04" }) },

	-- tabs:Navigation
	{ key = "h", mods = mod.SUPER, action = act.ActivateTabRelative(-1) },
	{ key = "l", mods = mod.SUPER, action = act.ActivateTabRelative(1) },
	{ key = "h", mods = mod.SUPER_SHIFT, action = act.MoveTabRelative(-1) },
	{ key = "l", mods = mod.SUPER_SHIFT, action = act.MoveTabRelative(1) },

	-- new window
	{ key = "n", mods = mod.SUPER, action = act.SpawnWindow },

	-- panes: zoom+close pane
	{ key = "Enter", mods = mod.SUPER, action = act.TogglePaneZoomState },
	{ key = "w", mods = mod.SUPER, action = act.CloseCurrentPane({ confirm = false }) },

	-- panes --
	-- panes: split panes
	{ key = "s", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "v", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },

	-- panes: navigation
	{ key = "k", mods = mod.SUPER_REV, action = act.ActivatePaneDirection("Up") },
	{ key = "j", mods = mod.SUPER_REV, action = act.ActivatePaneDirection("Down") },
	{ key = "h", mods = mod.SUPER_REV, action = act.ActivatePaneDirection("Left") },
	{ key = "l", mods = mod.SUPER_REV, action = act.ActivatePaneDirection("Right") },
	{
		key = "p",
		mods = mod.SUPER_REV,
		action = act.PaneSelect({ alphabet = "1234567890", mode = "SwapWithActiveKeepFocus" }),
	},

	-- activate copy mode or vim mode
	{
		key = "Enter",
		mods = "LEADER",
		action = wezterm.action.ActivateCopyMode,
	},
}

-- and finally, return the configuration to wezterm
return config
