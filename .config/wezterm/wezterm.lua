local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- UI
config.font_size = 10
config.color_scheme = "Everforest Dark (Gogh)"
config.font = wezterm.font("FiraCode Nerd Font")
config.default_cursor_style = "SteadyBar"
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

-- Options
config.scrollback_lines = 10000
config.window_close_confirmation = "NeverPrompt"

-- Profiles
config.default_domain = "WSL:Ubuntu"
config.launch_menu = {
	{
		label = "PowerShell 7",
		args = { "pwsh.exe" },
	},
	{
		label = "CMD",
		args = { "cmd.exe" },
	},
}

-- Keybindings
local action = wezterm.action
config.leader = { key = "Space", mods = "CTRL" }
config.keys = {
	{
		key = "/",
		mods = "LEADER",
		action = action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "-",
		mods = "LEADER",
		action = action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "x",
		mods = "LEADER",
		action = action.CloseCurrentPane({ confirm = false }),
	},
	{
		key = "w",
		mods = "LEADER",
		action = action.CloseCurrentTab({ confirm = false }),
	},
	{
		key = "T",
		mods = "LEADER",
		action = action.ShowLauncher,
	},
	{
		key = "t",
		mods = "LEADER",
		action = action.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "v",
		mods = "LEADER",
		action = action.ActivateCopyMode,
	},
	{
		key = "m",
		mods = "CTRL|SHIFT",
		action = action.DisableDefaultAssignment,
	},
}

for i = 1, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = action.ActivateTab(i - 1),
	})
end

local function is_vim(pane)
	local process_info = pane:get_foreground_process_info()
	local process_name = process_info and process_info.name

	return process_name == "nvim" or process_name == "vim"
end

local direction_keys = {
	h = "Left",
	j = "Down",
	k = "Up",
	l = "Right",
}

for key, direction in pairs(direction_keys) do
	table.insert(config.keys, {
		key = key,
		mods = "CTRL",
		action = wezterm.action_callback(function(window, pane)
			if is_vim(pane) then
				window:perform_action(action.SendKey({ key = key, mods = "CTRL" }), pane)
			else
				window:perform_action(action.ActivatePaneDirection(direction), pane)
			end
		end),
	})
end

return config
