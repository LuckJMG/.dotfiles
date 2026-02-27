local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- UI
config.front_end = "WebGpu"
config.font_size = 10
config.color_scheme = "Everforest Dark (Gogh)"
config.font = wezterm.font("FiraCode Nerd Font")
config.default_cursor_style = "SteadyBar"
config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = 0.95
config.window_close_confirmation = "NeverPrompt"

-- Profiles
config.default_domain = "WSL:FedoraLinux-43"
config.launch_menu = {
	{
		label = "PowerShell",
		args = { "powershell.exe", "-NoLogo" },
		domain = { DomainName = "local" },
	},
	{
		label = "CMD",
		args = { "cmd.exe", "/k" },
		domain = { DomainName = "local" },
	},
}

-- Keybindings
local action = wezterm.action
config.keys = {
	{
		key = "%",
		mods = "CTRL|SHIFT",
		action = action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = '"',
		mods = "CTRL|SHIFT",
		action = action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "w",
		mods = "CTRL|SHIFT",
		action = action.CloseCurrentPane({ confirm = false }),
	},
	{
		key = "t",
		mods = "CTRL|SHIFT",
		action = action.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "t",
		mods = "CTRL|SHIFT|ALT",
		action = action.ShowLauncher,
	},
}

local function is_vim(pane)
	local process_info = pane:get_foreground_process_info()
	local process_name = process_info and process_info.name

	return process_name == "nvim" or process_name == "vim"
end

local function make_nav_key(key, direction)
	return {
		key = key,
		mods = "CTRL",
		action = wezterm.action_callback(function(window, pane)
			if is_vim(pane) then
				window:perform_action(action.SendKey({ key = key, mods = "CTRL" }), pane)
			else
				window:perform_action(action.ActivatePaneDirection(direction), pane)
			end
		end),
	}
end

table.insert(config.keys, make_nav_key("h", "Left"))
table.insert(config.keys, make_nav_key("j", "Down"))
table.insert(config.keys, make_nav_key("k", "Up"))
table.insert(config.keys, make_nav_key("l", "Right"))

return config
