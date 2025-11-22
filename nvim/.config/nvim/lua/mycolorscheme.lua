local palette = {
    black = "#16161d",
    black2 = "#54546D",
    paper_white = "#f2ecbc",
    paper_white_dark = "#d5cea3",
    light_grey = "#dcd7ba",
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
}

return {
    palette = palette,
    setup = function()
        if vim.g.colors_name then
            vim.cmd("hi clear")
        end

        vim.g.colors_name = "mycolorscheme"

        -- Override defaults so that all highligts are the same.
        for hl, _ in pairs(vim.api.nvim_get_hl(0, {})) do
            vim.api.nvim_set_hl(0, hl, { fg = palette.black, bg = "none" })
        end

        local highlights = {
            Normal                      = { fg = palette.black, bg = palette.paper_white },
            Comment                     = { fg = palette.black2 },
            Visual                      = { fg = palette.black, bg = palette.light_blue },
            IncSearch                   = { bg = palette.light_yellow },
            Search                      = { bg = palette.light_blue },
            CurSearch                   = { bg = palette.light_yellow },
            Substitute                  = { bg = palette.light_blue },
            StatusLine                  = { fg = palette.black, bg = palette.paper_white_dark },
            StatusLineNC                = { fg = palette.black, bg = palette.paper_white_dark },
            -- MsgArea                     = { link = 'StatusLine' },
            VertSplit                   = { link = "WinSeparator" },
            MoreMsg                     = { fg = palette.blue },
            WarningMsg                  = { fg = palette.orange },
            ErrorMsg                    = { fg = palette.red },
            Question                    = { link = "MoreMsg" },
            QuickFixLine                = { bg = palette.light_blue },
            WinBar                      = { fg = palette.black, bg = palette.black },
            WinBarNC                    = { fg = palette.black },
            WildMenu                    = { link = "Pmenu" },

            -- syntax
            -- Function                    = { fg = palette.blue },
            Exception                   = { fg = palette.red },
            DiagnosticUnnecessary       = { fg = "none", bg = "none" },

            ["@markup.link"]            = { underline = true },
            ["@comment"]                = { link = "Comment" },
            ["@lsp.type.comment"]       = { link = "Comment" },

            ["@keyword.return"]         = { fg = palette.red },
            ["@keyword.exception"]      = { fg = palette.red },
            -- ["@function"]               = { fg = palette.blue },
            -- ["@lsp.type.function"]      = { fg = palette.blue },

            -- c#
            ["@keyword.return.c_sharp"] = { fg = palette.red },

            -- This is not perfect but good enough.
            -- See fzf-colors in lua/plugins/searching.lua
            FzfLuaFzfMatch              = { fg = palette.blue, bg = palette.light_blue },
            FzfLuaFzfCursorLine         = { bg = palette.paper_white_dark },
            FzfLuaLivePrompt            = { fg = palette.black },
            FzfLuaPathColNr             = { fg = palette.black },
            FzfLuaPathLineNr            = { fg = palette.black },
            FzfLuaHeaderText            = { fg = palette.black },
            FzfLuaHeaderBind            = { fg = palette.black },
            FzfLuaBufNr                 = { fg = palette.black },
            FzfLuaBufFlagCur            = { fg = palette.black },
            FzfLuaBufFlagAlt            = { fg = palette.black },
            FzfLuaTabTitle              = { fg = palette.black },
            FzfLuaTabMarker             = { fg = palette.black },
            FzfLuaLiveSym               = { fg = palette.black },

            DiagnosticError             = { fg = palette.red },
            DiagnosticWarn              = { fg = palette.orange },
            DiagnosticInfo              = { fg = palette.blue },
            DiagnosticHint              = { fg = palette.black },
            DiagnosticOk                = { fg = palette.green },

            DiagnosticFloatingError     = { fg = palette.red, },
            DiagnosticFloatingWarn      = { fg = palette.orange, },
            DiagnosticFloatingInfo      = { fg = palette.blue, },
            DiagnosticFloatingHint      = { fg = palette.black, },
            DiagnosticFloatingOk        = { fg = palette.green, },

            DiagnosticSignError         = { fg = palette.red, bg = "none" },
            DiagnosticSignWarn          = { fg = palette.orange, bg = "none" },
            DiagnosticSignInfo          = { fg = palette.blue, bg = "none" },
            DiagnosticSignHint          = { fg = palette.black, bg = "none" },

            DiagnosticVirtualTextError  = { link = "DiagnosticError" },
            DiagnosticVirtualTextWarn   = { link = "DiagnosticWarn" },
            DiagnosticVirtualTextInfo   = { link = "DiagnosticInfo" },
            DiagnosticVirtualTextHint   = { link = "DiagnosticHint" },

            DiagnosticUnderlineError    = { undercurl = true, sp = palette.red },
            DiagnosticUnderlineWarn     = { undercurl = true, sp = palette.orange },
            DiagnosticUnderlineInfo     = { undercurl = true, sp = palette.blue },
            DiagnosticUnderlineHint     = { undercurl = true, sp = palette.black },

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
}
