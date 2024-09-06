local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

config.font = wezterm.font("JetBrains Mono")
config.color_scheme = "Abernathy"
config.font_size = 20.0
config.animation_fps = 70
config.enable_tab_bar = false
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }

config.disable_default_key_bindings = true

wezterm.on("update-right-status", function(window)
	window:set_right_status(window:active_workspace())
end)
config.keys = {

	{
		key = "c",
		mods = "CTRL|SHIFT",
		action = act.CopyTo("Clipboard"),
	},
	{
		key = "v",
		mods = "CTRL|SHIFT",
		action = act.PasteFrom("Clipboard"),
	},
}

return config
