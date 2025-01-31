-- Pull in the wezterm API
local wezterm = require 'wezterm'
-- This will hold the configuration.
local config = wezterm.config_builder()

config.automatically_reload_config = true

config.window_decorations = 'RESIZE'
config.color_scheme = 'Dracula'

-- TODO: turn off unicode composition dialog
-- config.use_ime = false
-- config.use_dead_keys = true
-- config.ime_preedit_rendering = 'System'
-- config.send_composed_key_when_right_alt_is_pressed = false

config.font = wezterm.font_with_fallback({
    'JetBrains Mono',
    { family = 'Symbols Nerd Font Mono', scale = 0.75 }
})
config.font_size = 16

config.window_padding = { left = 1, right = 1, top = 0, bottom = 0, }
config.enable_tab_bar = false

config.default_prog = { '/usr/bin/fish' }

return config
