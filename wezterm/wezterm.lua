-- Pull in the wezterm API
local wezterm = require("wezterm")

local config = wezterm.config_builder()
-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
config.default_prog = { "pwsh" }

-- For example, changing the color scheme:
-- config.color_scheme = "Solarized (light) (terminal.sexy)"
-- config.color_scheme = "tokyonight_night"
-- config.color_scheme = "Catppuccin Latte"
-- config.color_scheme = "tokyonight_day"
config.color_scheme = "Rosé Pine Dawn (Gogh)"

config.font = wezterm.font("IosevkaTerm Nerd Font Mono")
config.font_size = 12

config.window_decorations = "RESIZE"

-- tmux
config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 2000 }
config.keys = {
  {
    mods = "LEADER",
    key = "c",
    action = wezterm.action.SpawnTab("CurrentPaneDomain"),
  },
  { key = "t", mods = "ALT", action = wezterm.action.SpawnTab({ DomainName = "WSL:Debian" }) },
  {
    mods = "ALT",
    key = "w",
    action = wezterm.action.CloseCurrentPane({ confirm = true }),
  },
  {
    mods = "ALT",
    key = "h",
    action = wezterm.action.ActivateTabRelative(-1),
  },
  {
    mods = "ALT",
    key = "l",
    action = wezterm.action.ActivateTabRelative(1),
  },

  { key = "[", mods = "ALT", action = wezterm.action.MoveTabRelative(-1) },
  { key = "]", mods = "ALT", action = wezterm.action.MoveTabRelative(1) },

  { key = "s", mods = "LEADER", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "v", mods = "LEADER", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  {
    mods = "LEADER",
    key = "h",
    action = wezterm.action.ActivatePaneDirection("Left"),
  },
  {
    mods = "LEADER",
    key = "j",
    action = wezterm.action.ActivatePaneDirection("Down"),
  },
  {
    mods = "LEADER",
    key = "k",
    action = wezterm.action.ActivatePaneDirection("Up"),
  },
  {
    mods = "LEADER",
    key = "l",
    action = wezterm.action.ActivatePaneDirection("Right"),
  },
  {
    mods = "LEADER",
    key = "LeftArrow",
    action = wezterm.action.AdjustPaneSize({ "Left", 5 }),
  },
  {
    mods = "LEADER",
    key = "RightArrow",
    action = wezterm.action.AdjustPaneSize({ "Right", 5 }),
  },
  {
    mods = "LEADER",
    key = "DownArrow",
    action = wezterm.action.AdjustPaneSize({ "Down", 5 }),
  },
  {
    mods = "LEADER",
    key = "UpArrow",
    action = wezterm.action.AdjustPaneSize({ "Up", 5 }),
  },

  -- 	-- activate copy mode or vim mode
  {
    key = "Enter",
    mods = "LEADER",
    action = wezterm.action.ActivateCopyMode,
  },
  {
    key = "E",
    mods = "CTRL|SHIFT",
    action = wezterm.action.PromptInputLine({
      description = "Enter new name for tab",
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          window:active_tab():set_title(line)
        end
      end),
    }),
  },
}

for i = 0, 9 do
  -- leader + number to activate that tab
  table.insert(config.keys, {
    key = tostring(i),
    mods = "ALT",
    action = wezterm.action.ActivateTab(i),
  })
end

-- tab bar
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = false
config.tab_bar_at_bottom = true

config.colors = {
  tab_bar = {
    -- The color of the strip that goes along the top of the window
    -- (does not apply when fancy tab bar is in use)
    background = "#eff1f5",

    -- The active tab is the one that has focus in the window
    active_tab = {
      -- The color of the background area for the tab
      bg_color = "#1e66f5",
      -- The color of the text for the tab
      fg_color = "#eff1f5",

      -- Specify whether you want "Half", "Normal" or "Bold" intensity for the
      -- label shown for this tab.
      -- The default is "Normal"
      intensity = "Normal",

      -- Specify whether you want "None", "Single" or "Double" underline for
      -- label shown for this tab.
      -- The default is "None"
      underline = "None",

      -- Specify whether you want the text to be italic (true) or not (false)
      -- for this tab.  The default is false.
      italic = false,

      -- Specify whether you want the text to be rendered with strikethrough (true)
      -- or not for this tab.  The default is false.
      strikethrough = false,
    },

    -- Inactive tabs are the tabs that do not have focus
    inactive_tab = {
      bg_color = "#eff1f5",
      fg_color = "#8c8fa1",

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `inactive_tab`.
    },

    -- You can configure some alternate styling when the mouse pointer
    -- moves over inactive tabs
    inactive_tab_hover = {
      bg_color = "#1e66f5",
      fg_color = "#bcc0cc",
      italic = true,

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `inactive_tab_hover`.
    },

    -- The new tab button that let you create new tabs
    new_tab = {
      bg_color = "#1e66f5",
      fg_color = "#eff1f5",

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `new_tab`.
    },

    -- You can configure some alternate styling when the mouse pointer
    -- moves over the new tab button
    new_tab_hover = {
      bg_color = "#3b3052",
      fg_color = "#909090",
      italic = true,

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `new_tab_hover`.
    },
  },
}

-- tmux status
wezterm.on("update-right-status", function(window, _)
  local SOLID_LEFT_ARROW = ""
  local ARROW_FOREGROUND = { Foreground = { Color = "#c6a0f6" } }
  local prefix = ""

  if window:leader_is_active() then
    prefix = " " .. utf8.char(0x1f30a) -- ocean wave
    SOLID_LEFT_ARROW = utf8.char(0xe0b2)
  end

  if window:active_tab():tab_id() ~= 0 then
    ARROW_FOREGROUND = { Foreground = { Color = "#1e2030" } }
  end -- arrow color based on if tab is first pane

  window:set_left_status(wezterm.format({
    { Background = { Color = "#b7bdf8" } },
    { Text = prefix },
    ARROW_FOREGROUND,
    { Text = SOLID_LEFT_ARROW },
  }))
end)

-- and finally, return the configuration to wezterm
return config
