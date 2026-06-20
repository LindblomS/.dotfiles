vim.pack.add({
    {
        src = "https://github.com/nvim-treesitter/nvim-treesitter",
        version = "4916d6592ede8c07973490d9322f187e07dfefac",
    }
})

require("nvim-treesitter").setup()
require("nvim-treesitter").install({ "c_sharp", "lua", "rust" })

vim.api.nvim_create_autocmd('FileType', {
    pattern = { "cs", "lua", "rust" },
    callback = function()
        vim.treesitter.start()
    end,
})


local light_palette = {
    fg = "#16161d",
    fg_1 = "#54546D",

    bg = "#e6e6e6",
    bg_1 = "#d1cfcf",

    green = "#6f894e",
    light_green = "#c0e396",

    blue = "#3c31b2",
    light_blue = "#c7d7e0",

    red = "#e82424",
    red_2 = "#c84053",
    light_red = "#d9a594",

    orange = "#e98a00",
    orange_2 = "#cc6d00",
    light_orange = "#f3c786",
}

local dark_palette = {
    fg = "#DCD7BA",
    fg_1 = "#C8C093",

    bg = "#1F1F28",
    bg_1 = "#2A2A37",

    green = "#98BB6C",
    light_green = "#2B3328",

    blue = "#658594",
    light_blue = "#2D4F67",

    red = "#E82424",
    red_2 = "#E46876",
    light_red = "#43242B",

    orange = "#FF9E3B",
    orange_2 = "#FFA066",
    light_orange = "#f3c786",
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

    local function get_search_text_fg()
        if vim.o.bg == "dark" then
            return palette.bg
        else
            return palette.fg
        end
    end

    local highlights = {
        Normal                                   = { fg = palette.fg, bg = palette.bg },
        Comment                                  = { fg = palette.fg_1 },
        Visual                                   = { fg = palette.fg, bg = palette.light_blue },
        IncSearch                                = { bg = palette.orange, fg = palette.bg },
        Search                                   = { bg = palette.light_orange, fg = get_search_text_fg() },
        CurSearch                                = { link = "IncSearch" },
        Substitute                               = { bg = palette.light_blue },
        StatusLine                               = { fg = palette.fg, bg = palette.bg_1 },
        StatusLineNC                             = { fg = palette.fg, bg = palette.bg_1 },
        VertSplit                                = { link = "WinSeparator" },
        MoreMsg                                  = { fg = palette.blue },
        WarningMsg                               = { fg = palette.orange },
        ErrorMsg                                 = { fg = palette.red },
        Question                                 = { link = "MoreMsg" },
        QuickFixLine                             = { bg = palette.light_blue },
        WinBar                                   = { fg = palette.fg, bg = palette.fg },
        WinBarNC                                 = { fg = palette.fg },
        WildMenu                                 = { link = "Pmenu" },
        LineNrAbove                              = { fg = palette.fg_1 },
        LineNrBelow                              = { fg = palette.fg_1 },

        -- language syntax
        Function                                 = { fg = palette.orange_2 },
        Parameter                                = { fg = palette.fg },
        String                                   = { fg = palette.green },
        Number                                   = { fg = palette.blue },
        Float                                    = { fg = palette.orange },
        Boolean                                  = { link = "Number" },
        Keyword                                  = { fg = palette.red_2 },

        ["@variable.member"]                     = { link = "Normal" },
        ["@keyword"]                             = { link = "Keyword" },
        ["@number"]                              = { link = "Number" },
        ["@number.float"]                        = { link = "Number" },
        ["@boolean"]                             = { link = "Boolean" },
        ["@function"]                            = { link = "Function" },
        ["@string.escape"]                       = { link = "String" },
        ["@markup.link"]                         = { underline = true },
        ["@comment"]                             = { link = "Comment" },

        -- lua
        ["@function.call.lua"]                   = {},
        ["@string.lua"]                          = { link = "String" },
        ["@boolean.lua"]                         = { link = "Boolean" },
        ["@variable.member.lua"]                 = { link = "Normal" },
        ["@function.method.call.lua"]            = {},
        ["@variable.parameter.lua"]              = { link = "Parameter" },

        -- csharp
        ["@function.method.c_sharp"]             = { link = "Function" },
        ["@variable.parameter.c_sharp"]          = { link = "Parameter" },
        ["@variable.c_sharp"]                    = { link = "Normal" },
        ["@function.method.call.c_sharp"]        = {},
        ["@variable.member.c_sharp"]             = { link = "Normal" },
        ["@keyword.conditional.ternary.c_sharp"] = { link = "Normal" },

        -- rust
        ["@function.call.rust"]                  = { link = "Normal" },
        ["@function.macro.rust"]                 = { link = "Normal" },
        ["@variable.parameter.rust"]             = { link = "Parameter" },
        ["@variable.rust"]                       = { link = "Normal" },
        ["@keyword.exception.rust"]              = { link = "Normal" },
        ["@keyword.debug.rust"]                  = { link = "Normal" },
        ["rustFuncCall"]                         = { link = "Normal" },

        -- typescript
        ["typescriptBraces"]                     = { link = "Normal" },
        ["typescriptNull"]                       = { link = "Normal" },
        ["typescriptSpecial"]                    = {},

        -- javascript
        ["javaScriptBraces"]                     = { link = "Normal" },

        -- syntax
        DiagnosticUnnecessary                    = { fg = "none", bg = "none" },

        -- This is not perfect but good enough.
        -- See fzf-colors in lua/plugins/searching.lua
        FzfLuaFzfMatch                           = { fg = palette.blue, bg = palette.light_blue },
        FzfLuaFzfCursorLine                      = { bg = palette.bg_1 },
        FzfLuaLivePrompt                         = { fg = palette.fg },
        FzfLuaPathColNr                          = { fg = palette.fg },
        FzfLuaPathLineNr                         = { fg = palette.fg },
        FzfLuaHeaderText                         = { fg = palette.fg },
        FzfLuaHeaderBind                         = { fg = palette.fg },
        FzfLuaBufNr                              = { fg = palette.fg },
        FzfLuaBufFlagCur                         = { fg = palette.fg },
        FzfLuaBufFlagAlt                         = { fg = palette.fg },
        FzfLuaTabTitle                           = { fg = palette.fg },
        FzfLuaTabMarker                          = { fg = palette.fg },
        FzfLuaLiveSym                            = { fg = palette.fg },

        DiagnosticError                          = { fg = palette.red },
        DiagnosticWarn                           = { fg = palette.orange },
        DiagnosticInfo                           = { fg = palette.blue },
        DiagnosticHint                           = { fg = palette.fg },
        DiagnosticOk                             = { fg = palette.green },

        DiagnosticFloatingError                  = { fg = palette.red, },
        DiagnosticFloatingWarn                   = { fg = palette.orange, },
        DiagnosticFloatingInfo                   = { fg = palette.blue, },
        DiagnosticFloatingHint                   = { fg = palette.fg, },
        DiagnosticFloatingOk                     = { fg = palette.green, },

        DiagnosticSignError                      = { fg = palette.red, bg = "none" },
        DiagnosticSignWarn                       = { fg = palette.orange, bg = "none" },
        DiagnosticSignInfo                       = { fg = palette.blue, bg = "none" },
        DiagnosticSignHint                       = { fg = palette.fg, bg = "none" },

        DiagnosticVirtualTextError               = { link = "DiagnosticError" },
        DiagnosticVirtualTextWarn                = { link = "DiagnosticWarn" },
        DiagnosticVirtualTextInfo                = { link = "DiagnosticInfo" },
        DiagnosticVirtualTextHint                = { link = "DiagnosticHint" },

        DiagnosticUnderlineError                 = { undercurl = true, sp = palette.red },
        DiagnosticUnderlineWarn                  = { undercurl = true, sp = palette.orange },
        DiagnosticUnderlineInfo                  = { undercurl = true, sp = palette.blue },
        DiagnosticUnderlineHint                  = { undercurl = true, sp = palette.fg },

        diffAdded                                = { bg = palette.light_green },
        diffRemoved                              = { bg = palette.light_red },
        diffDeleted                              = { bg = palette.light_red },
        diffChanged                              = { bg = palette.light_orange },
        diffOldFile                              = { bg = palette.light_red },
        diffNewFile                              = { bg = palette.light_green },

        ["@diff.plus"]                           = { bg = palette.light_green },
        ["@diff.minus"]                          = { bg = palette.light_red },
        ["@diff.delta"]                          = { bg = palette.light_orange },

        DiffAdd                                  = { bg = palette.light_green },
        DiffChange                               = { bg = palette.light_orange },
        DiffDelete                               = { bg = palette.light_red },
        DiffText                                 = { bg = palette.orange },

        -- blink (completion)
        BlinkCmpMenuSelection                    = { bg = palette.light_blue },
        BlinkCmpLabelMatch                       = { bg = palette.light_blue },
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
