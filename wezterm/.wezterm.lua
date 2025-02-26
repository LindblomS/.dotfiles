local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- set default shell to git bash when on windows
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
    config.default_prog = { "C:/Program Files/Git/bin/bash.exe" }
end

config.window_decorations = "RESIZE"

config.font = wezterm.font("IBM Plex Mono", {})
config.line_height = 1.1

-- kanagawa wave
-- config.colors = {
--     foreground = "#dcd7ba",
--     background = "#1f1f28",
--
--     cursor_bg = "#c8c093",
--     cursor_fg = "#c8c093",
--     cursor_border = "#c8c093",
--
--     selection_fg = "#c8c093",
--     selection_bg = "#2d4f67",
--
--     scrollbar_thumb = "#16161d",
--     split = "#16161d",
--
--     ansi = { "#090618", "#c34043", "#76946a", "#c0a36e", "#7e9cd8", "#957fb8", "#6a9589", "#c8c093" },
--     brights = { "#727169", "#e82424", "#98bb6c", "#e6c384", "#7fb4ca", "#938aa9", "#7aa89f", "#dcd7ba" },
--     indexed = { [16] = "#ffa066", [17] = "#ff5d62" },
--     tab_bar = {
--         background = "#1f1f28",
--         active_tab = {
--             fg_color = "#dcd7ba",
--             bg_color = "#1f1f28"
--         },
--     }
-- }

-- kanagawa dragon
config.colors = {
    foreground = "#c5c9c5",
    background = "#181616",

    cursor_bg = "#C8C093",
    cursor_fg = "#C8C093",
    cursor_border = "#C8C093",

    selection_fg = "#C8C093",
    selection_bg = "#2D4F67",

    scrollbar_thumb = "#16161D",
    split = "#16161D",

    ansi = {
        "#0D0C0C",
        "#C4746E",
        "#8A9A7B",
        "#C4B28A",
        "#8BA4B0",
        "#A292A3",
        "#8EA4A2",
        "#C8C093",
    },
    brights = {
        "#A6A69C",
        "#E46876",
        "#87A987",
        "#E6C384",
        "#7FB4CA",
        "#938AA9",
        "#7AA89F",
        "#C5C9C5",
    },
}


config.keys = {
    {
        key = "w",
        mods = "CTRL|SHIFT",
        action = wezterm.action.CloseCurrentPane { confirm = false }
    },
    {
        key = "v",
        mods = "CTRL|SHIFT|SUPER",
        action = wezterm.action.SplitHorizontal
    },
    {
        key = "s",
        mods = "CTRL|SHIFT|SUPER",
        action = wezterm.action.SplitVertical
    },
    {
        key = "p",
        mods = "CTRL|SHIFT|SUPER",
        action = wezterm.action.PaneSelect
    },
    {
        key = "LeftArrow",
        mods = "CTRL|SHIFT|SUPER|ALT",
        action = wezterm.action.AdjustPaneSize { "Left", 3 }
    },
    {
        key = "RightArrow",
        mods = "CTRL|SHIFT|SUPER|ALT",
        action = wezterm.action.AdjustPaneSize { "Right", 3 }
    },
    {
        key = "UpArrow",
        mods = "CTRL",
        action = wezterm.action.ScrollByLine(-3),
    },
    {
        key = "DownArrow",
        mods = "CTRL",
        action = wezterm.action.ScrollByLine(3),
    },
    {
        key = "DownArrow",
        mods = "CTRL|SHIFT",
        action = wezterm.action.ScrollByPage(0.5),
    },
    {
        key = "UpArrow",
        mods = "CTRL|SHIFT",
        action = wezterm.action.ScrollByPage(-0.5),
    }
}

return config
