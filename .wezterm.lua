-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

config.automatically_reload_config = true

config.window_decorations = 'RESIZE'
config.color_scheme = 'Dracula'

-- turn off unicode composition dialog
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

-- Toggle opacity on keybind
local opacity = 0.7
config.window_background_opacity = 1
wezterm.on('toggle-opacity', function(window, pane)
    local overrides = window:get_config_overrides() or {}
    if not overrides.window_background_opacity then
        overrides.window_background_opacity = opacity
    else
        overrides.window_background_opacity = nil
    end
    window:set_config_overrides(overrides)
end)


config.keys = {
    { -- Ctrl+Shift+b
        key = 'B',
        mods = 'CTRL',
        action = wezterm.action.EmitEvent 'toggle-opacity',
    },
    -- {
    --     key = 'u',
    --     mods = 'SHIFT|CTRL',
    --     action = wezterm.action.DisableDefaultAssignment,
    -- },
}


return config
