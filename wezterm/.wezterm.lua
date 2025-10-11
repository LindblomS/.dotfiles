local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- set default shell to git bash when on windows
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
    config.default_prog = { "C:/Program Files/Git/bin/bash.exe" }
end

config.window_decorations = "RESIZE"
config.audible_bell = "Disabled"

config.font = wezterm.font("IBM Plex Mono", {})
config.font_size = 15
config.line_height = 1.1

config.keys = {
    {
        key = "n",
        mods = "CTRL|SHIFT",
        action = wezterm.action.DisableDefaultAssignment,
    },
    {
        key = "e",
        mods = "CTRL|SHIFT",
        action = wezterm.action.DisableDefaultAssignment,
    },
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
-- config.colors = {
--     foreground = "#c5c9c5",
--     background = "#181616",
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
--     ansi = {
--         "#0d0c0c",
--         "#c4746e",
--         "#8a9a7b",
--         "#c4b28a",
--         "#8ba4b0",
--         "#a292a3",
--         "#8ea4a2",
--         "#c8c093",
--     },
--     brights = {
--         "#a6a69c",
--         "#e46876",
--         "#87a987",
--         "#e6c384",
--         "#7fb4ca",
--         "#938aa9",
--         "#7aa89f",
--         "#c5c9c5",
--     },
-- }

-- kanagawa lotus
-- https://github.com/rebelot/kanagawa.nvim/pull/177/files#diff-5c0e0fd16bb531f1b19bf0dddbbb5fc6b9a4cca532d7d648125af8fdd58d7c80
config.colors = {
    foreground = "#16161D",
    background = "#f2ecbc",

    cursor_bg = "#43436c",
    cursor_fg = "#43436c",
    cursor_border = "#43436c",

    selection_fg = "#16161D",
    selection_bg = "#e4d794",

    scrollbar_thumb = "#b5cbd2",
    split = "#b5cbd2",

    ansi = {
        "#1F1F28",
        "#c84053",
        "#6f894e",
        "#77713f",
        "#4d699b",
        "#b35b79",
        "#597b75",
        "#545464",
    },

    brights = {
        "#8a8980",
        "#d7474b",
        "#6e915f",
        "#836f4a",
        "#6693bf",
        "#624c83",
        "#5e857a",
        "#43436c",
    },

    indexed = {
        [16] = "#e98a00", -- extended color 1
        [17] = "#e82424", -- extended color 2
    },

    tab_bar = {
        background = "#e4d794",

        active_tab = {
            bg_color = "#e4d794",
            fg_color = "#16161D",
        },

        inactive_tab = {
            bg_color = "#a6a69c",
            fg_color = "#e4d794",
        },

        inactive_tab_hover = {
            bg_color = "#9fb5c9",
            fg_color = "#43436c",
            italic = true,
        },

        new_tab = {
            bg_color = "#8a8980",
            fg_color = "#e4d794",
        },

        new_tab_hover = {
            bg_color = "#9fb5c9",
            fg_color = "#43436c",
            italic = true,
        },
    },
}

return config
