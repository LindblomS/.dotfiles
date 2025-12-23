local light_palette = {
    fg = "#16161d",
    fg_1 = "#54546D",

    bg = "#f4f1d9",
    bg_1 = "#ddd8b5",

    green = "#6aba0a",
    light_green = "#c0e396",

    blue = "#3c31b2",
    light_blue = "#c7d7e0",

    red = "#e82424",
    light_red = "#d9a594",

    orange = "#e98a00",
    light_orange = "#f3c786",

    yellow = "#de9800",
    light_yellow = "#f9d791",

    special = "#e82424",
}

local dark_palette = {
    fg = "#DCD7BA",
    fg_1 = "#C8C093",

    bg = "#1F1F28",
    bg_1 = "#1a1a22",

    green = "#98BB6C",
    light_green = "#2B3328",

    blue = "#658594",
    light_blue = "#2D4F67",

    red = "#E82424",
    light_red = "#43242B",

    orange = "#FF9E3B",
    light_orange = "#f3c786",

    yellow = "#938056",
    light_yellow = "#938056",

    special = "#E46876",
}

local function inner_setup(palette)
    if vim.g.colors_name then
        vim.cmd("hi clear")
    end

    vim.g.colors_name = "mycolorscheme"
    vim.o.termguicolors = true

    -- Override defaults so that all highligts are the same.
    for hl, _ in pairs(vim.api.nvim_get_hl(0, {})) do
        vim.api.nvim_set_hl(0, hl, { fg = palette.fg, bg = "none" })
    end

    local highlights = {
        Normal                      = { fg = palette.fg, bg = palette.bg },
        Comment                     = { fg = palette.fg_1 },
        Visual                      = { fg = palette.fg, bg = palette.light_blue },
        IncSearch                   = { bg = palette.light_yellow },
        Search                      = { bg = palette.light_blue },
        CurSearch                   = { bg = palette.light_yellow },
        Substitute                  = { bg = palette.light_blue },
        StatusLine                  = { fg = palette.fg, bg = palette.bg_1 },
        StatusLineNC                = { fg = palette.fg, bg = palette.bg_1 },
        VertSplit                   = { link = "WinSeparator" },
        MoreMsg                     = { fg = palette.blue },
        WarningMsg                  = { fg = palette.orange },
        ErrorMsg                    = { fg = palette.red },
        Question                    = { link = "MoreMsg" },
        QuickFixLine                = { bg = palette.light_blue },
        WinBar                      = { fg = palette.fg, bg = palette.fg },
        WinBarNC                    = { fg = palette.fg },
        WildMenu                    = { link = "Pmenu" },
        LineNrAbove                 = { fg = palette.fg_1 },
        LineNrBelow                 = { fg = palette.fg_1 },
        CursorLineNr                = { fg = palette.fg_1 },

        -- syntax
        Exception                   = { fg = palette.special },
        DiagnosticUnnecessary       = { fg = "none", bg = "none" },

        ["@markup.link"]            = { underline = true },
        ["@comment"]                = { link = "Comment" },
        ["@lsp.type.comment"]       = { link = "Comment" },

        ["@keyword.return"]         = { fg = palette.special },
        ["@keyword.exception"]      = { fg = palette.special },

        -- c#
        ["@keyword.return.c_sharp"] = { fg = palette.special },

        -- This is not perfect but good enough.
        -- See fzf-colors in lua/plugins/searching.lua
        FzfLuaFzfMatch              = { fg = palette.blue, bg = palette.light_blue },
        FzfLuaFzfCursorLine         = { bg = palette.bg_1 },
        FzfLuaLivePrompt            = { fg = palette.fg },
        FzfLuaPathColNr             = { fg = palette.fg },
        FzfLuaPathLineNr            = { fg = palette.fg },
        FzfLuaHeaderText            = { fg = palette.fg },
        FzfLuaHeaderBind            = { fg = palette.fg },
        FzfLuaBufNr                 = { fg = palette.fg },
        FzfLuaBufFlagCur            = { fg = palette.fg },
        FzfLuaBufFlagAlt            = { fg = palette.fg },
        FzfLuaTabTitle              = { fg = palette.fg },
        FzfLuaTabMarker             = { fg = palette.fg },
        FzfLuaLiveSym               = { fg = palette.fg },

        DiagnosticError             = { fg = palette.red },
        DiagnosticWarn              = { fg = palette.orange },
        DiagnosticInfo              = { fg = palette.blue },
        DiagnosticHint              = { fg = palette.fg },
        DiagnosticOk                = { fg = palette.green },

        DiagnosticFloatingError     = { fg = palette.red, },
        DiagnosticFloatingWarn      = { fg = palette.orange, },
        DiagnosticFloatingInfo      = { fg = palette.blue, },
        DiagnosticFloatingHint      = { fg = palette.fg, },
        DiagnosticFloatingOk        = { fg = palette.green, },

        DiagnosticSignError         = { fg = palette.red, bg = "none" },
        DiagnosticSignWarn          = { fg = palette.orange, bg = "none" },
        DiagnosticSignInfo          = { fg = palette.blue, bg = "none" },
        DiagnosticSignHint          = { fg = palette.fg, bg = "none" },

        DiagnosticVirtualTextError  = { link = "DiagnosticError" },
        DiagnosticVirtualTextWarn   = { link = "DiagnosticWarn" },
        DiagnosticVirtualTextInfo   = { link = "DiagnosticInfo" },
        DiagnosticVirtualTextHint   = { link = "DiagnosticHint" },

        DiagnosticUnderlineError    = { undercurl = true, sp = palette.red },
        DiagnosticUnderlineWarn     = { undercurl = true, sp = palette.orange },
        DiagnosticUnderlineInfo     = { undercurl = true, sp = palette.blue },
        DiagnosticUnderlineHint     = { undercurl = true, sp = palette.fg },

        diffAdded                   = { bg = palette.light_green },
        diffRemoved                 = { bg = palette.light_red },
        diffDeleted                 = { bg = palette.light_red },
        diffChanged                 = { bg = palette.light_yellow },
        diffOldFile                 = { bg = palette.light_red },
        diffNewFile                 = { bg = palette.light_green },

        ["@diff.plus"]              = { bg = palette.light_green },
        ["@diff.minus"]             = { bg = palette.light_red },
        ["@diff.delta"]             = { bg = palette.light_yellow },

        DiffAdd                     = { bg = palette.light_green },
        DiffChange                  = { bg = palette.light_yellow },
        DiffDelete                  = { bg = palette.light_red },
        DiffText                    = { bg = palette.yellow },

        -- blink (completion)
        BlinkCmpMenuSelection       = { bg = palette.light_blue },
        BlinkCmpLabelMatch          = { bg = palette.light_blue },
    }

    for hl, spec in pairs(highlights) do
        vim.api.nvim_set_hl(0, hl, spec)
    end
end

return {
    setup = function()
        if vim.o.bg == "dark" then
            inner_setup(dark_palette)
        else -- "light"
            inner_setup(light_palette)
        end
    end
}
