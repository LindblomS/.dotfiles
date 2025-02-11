return {
    {
        'mfussenegger/nvim-lint',
        commit = "6e9dd545a1af204c4022a8fcd99727ea41ffdcc8",
        ft = { 'ts_ls', 'javascript', 'vue' },
        config = function(_, _)
            local lint = require('lint')
            lint.linters_by_ft = {
                typescript = { 'eslint' },
                javascript = { 'eslint' },
            }
            vim.api.nvim_create_autocmd(
                { 'InsertLeave', 'BufWritePost' },
                {
                    callback = function()
                        lint.try_lint()
                    end
                })
        end,
    }
}
