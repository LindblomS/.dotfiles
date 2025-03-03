return {
    {
        'rebelot/kanagawa.nvim',
        lazy = false,
        commit = "988082eb00b845e4afbcaa4fd8e903da8a3ab3b9",
        priority = 1000,
        enabled = true,
        config = function()
            local opts = {
                colors = {
                    theme = {
                        all = {
                            ui = {
                                bg_gutter = 'none',
                            },
                        },
                    },
                },
                undercurl = false,
                commentStyle = { italic = false },
                keywordStyle = { italic = false },
                statementStyle = { bold = false },
                background = {
                    dark = 'dragon',
                },
                overrides = function(colors)
                    local normal = colors.palette.fujiWhite
                    local special = colors.palette.springViolet1
                    -- return, throw etc
                    local very_special = colors.palette.waveRed
                    local comments = colors.palette.fujiGrey
                    local types = colors.palette.waveAqua2

                    return {
                        FloatBorder = { bg = "none" },
                        NormalFloat = { bg = "none" },
                        FloatTitle = { bg = "none" },
                        -- syntax
                        Boolean = { fg = colors.palette.carpYellow, bold = false },
                        Number = { fg = colors.palette.sakuraPink },
                        Constant = { fg = normal },
                        Identifier = { fg = normal },
                        Function = { fg = colors.theme.syn.fun },
                        Statement = { fg = normal },
                        Operator = { fg = normal },
                        Keyword = { fg = special },
                        Exception = { fg = very_special },
                        PreProc = { fg = normal },
                        Type = { fg = types },
                        Special = { fg = special },
                        Delimiter = { fg = normal },
                        Underlined = { fg = normal },
                        Bold = { bold = false },
                        Italic = { italic = false },
                        Comment = { fg = comments },
                        String = { fg = colors.palette.springGreen },

                        -- treesitter
                        ["@variable"] = { fg = normal },
                        ["@variable.builtin"] = { fg = normal, italic = false },
                        ["@variable.parameter"] = { fg = normal },
                        ["@variable.member"] = { fg = normal },
                        ["@string.special.symbol"] = { fg = normal },
                        ["@attribute"] = { fg = normal },
                        ["@constructor"] = { fg = types },
                        ["@operator"] = { fg = normal },
                        ["@keyword.operator"] = { fg = special, bold = false },
                        ["@keyword.return"] = { fg = special },
                        ["@keyword.import"] = { fg = special },
                        ["@keyword.exception"] = { fg = special },
                        ["@punctuation.delimiter"] = { fg = normal },
                        ["@punctuation.bracket"] = { fg = normal },
                        ["@punctuation.special"] = { fg = normal },

                        -- c#
                        ["@keyword.operator.c_sharp"] = { link = "Special" },
                        ["@variable.builtin.c_sharp"] = { link = "Special" },
                        ["@keyword.return.c_sharp"] = { link = "Exception" },

                        -- lua
                        ["@keyword.operator.lua"] = { link = "Special" },
                        ["@keyword.return.lua"] = { link = "Exception" },
                        ["@keyword.import.c_sharp"] = { link = "Special" },
                        ["@constructor.lua"] = { fg = normal },

                        -- rust
                        ["@keyword.return.rust"] = { link = "Exception" },
                        ["@keyword.import.rust"] = { link = "Special" },

                        -- vim
                        ["@function.macro.vim"] = { link = "String" },
                    }
                end,
            }
            require('kanagawa').setup(opts)
            vim.opt.background = 'dark'
            vim.cmd('colorscheme kanagawa')
        end
    },
}
