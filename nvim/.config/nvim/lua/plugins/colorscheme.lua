return {
    {
        'rebelot/kanagawa.nvim',
        lazy = false,
        commit = "cc3b68b08e6a0cb6e6bf9944932940091e49bb83",
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
                    light = "lotus"

                },
                overrides = function(colors)
                    local normal = colors.palette.sumiInk0 -- i.e. regular text
                    local special = colors.palette.lotusBlue5
                    -- return, throw etc
                    local very_special = colors.palette.samuraiRed
                    local comment = colors.palette.lotusInk1
                    local type = normal
                    local functions = normal
                    local boolean = normal
                    local number = normal
                    local bg = colors.palette.lotusWhite3

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
                        rust_analyzer = {
                            "@lsp.type.keyword.rust",
                        }
                    })

                    -- disable highlights for tokens.
                    local tokens = { "@keyword.vim" }
                    for _, token in pairs(tokens) do
                        vim.api.nvim_set_hl(0, token, {})
                    end

                    return {
                        FloatBorder                                         = { bg = "none" },
                        NormalFloat                                         = { bg = "none", fg = normal },
                        FloatTitle                                          = { bg = "none" },
                        CurSearch                                           = { bg = colors.palette.lotusOrange2, fg = normal, bold = false },
                        CursorLineNr                                        = { fg = colors.palette.lotusOrange2 },
                        IncSearch                                           = { fg = normal, bg = colors.palette.lotusOrange2 },
                        Search                                              = { fg = normal, bg = colors.palette.lotusWhite5 },
                        Substitute                                          = { fg = normal, bg = colors.palette.lotusOrange2 },
                        LineNr                                              = { fg = normal },
                        Visual                                              = { bg = colors.palette.lotusWhite5 },

                        -- blink (completion)
                        BlinkCmpMenu                                        = { bg = bg, },
                        BlinkCmpMenuBorder                                  = { bg = "none", },
                        BlinkCmpMenuSelection                               = { link = "Visual" },
                        BlinkCmpLabel                                       = { bg = bg, },
                        BlinkCmpDoc                                         = { bg = "none", },
                        BlinkCmpDocBorder                                   = { bg = "none", },
                        BlinkCmpLabelMatch                                  = { fg = colors.palette.lotusOrange2 },

                        -- fzf
                        FzfLuaBufLineNr                                     = { fg = normal, bg = "none" },
                        FzfLuaFzfNormal                                     = { fg = normal, bg = "none" },
                        FzfLuaNormal                                        = { fg = normal, bg = "none" },
                        FzfLuaSearch                                        = { link = "CurSearch" },
                        FzfLuaBufName                                       = { fg = normal },
                        FzfLuaLivePrompt                                    = { fg = normal, bg = "none" },
                        FzfLuaDirPart                                       = { fg = normal, bg = "none" },
                        FzfLuaFilePart                                      = { fg = normal, bg = "none" },
                        FzfLuaFzfMatch                                      = { fg = colors.palette.lotusOrange2 },
                        FzfLuaFzfPrompt                                     = { fg = normal, bg = "none" },
                        FzfLuaFzfPointer                                    = { fg = normal, bg = "none" },
                        FzfLuaFzfInfo                                       = { fg = normal, bg = "none" },
                        FzfLuaLiveSym                                       = { fg = normal, bg = "none" },
                        FzfLuaTabTitle                                      = { fg = normal, bg = "none" },
                        FzfLuaBufNr                                         = { fg = normal, bg = "none" },
                        FzfLuaCursorLineNr                                  = { fg = normal, bg = "none" },
                        FzfLuaTitleFlags                                    = { fg = normal, bg = "none" },

                        -- syntax
                        Boolean                                             = { fg = boolean, bold = false },
                        Number                                              = { fg = number },
                        Constant                                            = { fg = normal },
                        Identifier                                          = { fg = normal },
                        Function                                            = { fg = functions, bold = true },
                        Statement                                           = { fg = normal },
                        Operator                                            = { fg = normal },
                        Keyword                                             = { fg = special },
                        Exception                                           = { fg = very_special },
                        PreProc                                             = { fg = normal },
                        Type                                                = { fg = type, bold = false },
                        Special                                             = { fg = special },
                        Delimiter                                           = { fg = normal },
                        Underlined                                          = { fg = normal },
                        Bold                                                = { bold = false },
                        Italic                                              = { italic = false },
                        Comment                                             = { fg = comment },
                        String                                              = { fg = normal },
                        yamlPlainScalar                                     = { fg = normal },

                        -- treesitter
                        ["@variable"]                                       = { fg = normal },
                        ["@variable.builtin"]                               = { fg = normal, italic = false },
                        ["@variable.parameter"]                             = { fg = normal },
                        ["@variable.member"]                                = { fg = normal },
                        ["@string.special.symbol"]                          = { fg = normal },
                        ["@attribute"]                                      = { fg = normal },
                        ["@constructor"]                                    = { fg = type },
                        ["@operator"]                                       = { fg = normal },
                        ["@keyword.operator"]                               = { fg = special, bold = false },
                        ["@keyword.return"]                                 = { fg = special },
                        ["@keyword.import"]                                 = { fg = special },
                        ["@keyword.exception"]                              = { fg = special },
                        ["@punctuation.delimiter"]                          = { fg = normal },
                        ["@punctuation.bracket"]                            = { fg = normal },
                        ["@punctuation.special"]                            = { fg = normal },

                        -- c#
                        ["@keyword.operator.c_sharp"]                       = { link = "Special" },
                        ["@variable.builtin.c_sharp"]                       = { link = "Special" },
                        ["@keyword.return.c_sharp"]                         = { link = "Exception" },
                        ["@attribute.c_sharp"]                              = { link = "Type" },

                        -- lua
                        ["@keyword.operator.lua"]                           = { link = "Special" },
                        ["@keyword.return.lua"]                             = { link = "Exception" },
                        ["@keyword.import.c_sharp"]                         = { link = "Special" },
                        ["@constructor.lua"]                                = { fg = normal },
                        ["@string.regexp.lua"]                              = { fg = normal },
                        ["@string.escape.lua"]                              = { fg = normal },

                        -- rust
                        ["@keyword.return.rust"]                            = { link = "Exception" },
                        ["@keyword.import.rust"]                            = { link = "Special" },
                        ["@lsp.type.enumMember.rust"]                       = { fg = type },
                        ["@lsp.type.macro.rust"]                            = { fg = functions },
                        ["@lsp.typemod.method.defaultLibrary.rust"]         = { fg = functions },
                        ["@lsp.typemod.function.defaultLibrary.rust"]       = { fg = functions },
                        ["@character.special.rust"]                         = { fg = normal },
                        ["@lsp.type.decorator.rust"]                        = { fg = functions },
                        ["@function.call.rust"]                             = { fg = normal },

                        -- vue
                        ["@lsp.typemod.function.readonly.vue"]              = { fg = functions },
                        ["@lsp.typemod.variable.defaultLibrary.vue"]        = { fg = normal },

                        -- typescript
                        ["@lsp.typemod.function.readonly.typescript"]       = { fg = functions },
                        ["@lsp.typemod.function.readonly.javascript"]       = { fg = functions },
                        ["@lsp.typemod.variable.defaultLibrary.typescript"] = { fg = normal },
                        ["@keyword.return.typescript"]                      = { fg = very_special },

                        -- vim
                        ["@function.macro.vim"]                             = { link = "String" },
                    }
                end,
            }
            require('kanagawa').setup(opts)
            vim.opt.background = 'light'
            vim.cmd('colorscheme kanagawa')
        end
    },
}
