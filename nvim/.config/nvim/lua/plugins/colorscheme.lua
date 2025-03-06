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
                    local comment = colors.palette.fujiGrey
                    local type = colors.palette.waveAqua2
                    local functions = colors.palette.carpYellow
                    local boolean = colors.palette.surimiOrange
                    local number = colors.palette.sakuraPink

                    -- lsp semantic tokens takes priority over treesitter.
                    -- This disables highlighting for given tokens
                    local function disable_lsp_semantic_token(tokens_by_lsp_client)
                        vim.api.nvim_create_autocmd("LspAttach", {
                            callback = function(args)
                                local client = vim.lsp.get_client_by_id(args.data.client_id)
                                local tokens = tokens_by_lsp_client[client.name]
                                if tokens then
                                    for _, token in pairs(tokens) do
                                        vim.api.nvim_set_hl(0, token, {})
                                    end
                                end
                            end
                        })
                    end

                    disable_lsp_semantic_token({
                        lua_ls = {
                            "@lsp.type.property.lua",
                        },
                    })

                    return {
                        FloatBorder = { bg = "none" },
                        NormalFloat = { bg = "none" },
                        FloatTitle = { bg = "none" },
                        -- syntax
                        Boolean = { fg = boolean, bold = false },
                        Number = { fg = number },
                        Constant = { fg = normal },
                        Identifier = { fg = normal },
                        Function = { fg = functions },
                        Statement = { fg = normal },
                        Operator = { fg = normal },
                        Keyword = { fg = special },
                        Exception = { fg = very_special },
                        PreProc = { fg = normal },
                        Type = { fg = type },
                        Special = { fg = special },
                        Delimiter = { fg = normal },
                        Underlined = { fg = normal },
                        Bold = { bold = false },
                        Italic = { italic = false },
                        Comment = { fg = comment },
                        String = { fg = colors.palette.springGreen },

                        -- treesitter
                        ["@variable"] = { fg = normal },
                        ["@variable.builtin"] = { fg = normal, italic = false },
                        ["@variable.parameter"] = { fg = normal },
                        ["@variable.member"] = { fg = normal },
                        ["@string.special.symbol"] = { fg = normal },
                        ["@attribute"] = { fg = normal },
                        ["@constructor"] = { fg = type },
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
                        ["@attribute.c_sharp"] = { link = "Type" },

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
