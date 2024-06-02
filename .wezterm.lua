local wezterm = require("wezterm")
local config = wezterm.config_builder()
local mux = wezterm.mux
config.color_scheme = "Abernathy"
config.font_size = 20.0
config.animation_fps = 70
config.enable_tab_bar = false
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
return config
