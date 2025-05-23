local function fix_all(opts)
    opts = opts or {}

    local eslint_lsp_client = vim.lsp.get_clients({ name = "eslint" })[1] -- Should only be one
    if eslint_lsp_client == nil then
        return
    end

    local request
    if opts.sync then
        request = function(bufnr, method, params)
            eslint_lsp_client.request_sync(method, params, nil, bufnr)
        end
    else
        request = function(bufnr, method, params)
            eslint_lsp_client.request(method, params, nil, bufnr)
        end
    end

    local bufnr = opts.bufnr
    vim.validate("bufnr", bufnr, "number")
    bufnr = bufnr == 0 and vim.api.nvim_get_current_buf() or bufnr
    request(0, 'workspace/executeCommand', {
        command = 'eslint.applyAllFixes',
        arguments = {
            {
                uri = vim.uri_from_bufnr(bufnr),
                version = vim.lsp.util.buf_versions[bufnr],
            },
        },
    })
end

local root_files = {
    '.eslintrc',
    '.eslintrc.js',
    '.eslintrc.cjs',
    '.eslintrc.yaml',
    '.eslintrc.yml',
    '.eslintrc.json',
    'eslint.config.js',
    'eslint.config.mjs',
    'eslint.config.cjs',
    'eslint.config.ts',
    'eslint.config.mts',
    'eslint.config.cts',
}

return {
    cmd = { 'vscode-eslint-language-server', '--stdio' },
    filetypes = {
        'javascript',
        'javascriptreact',
        'javascript.jsx',
        'typescript',
        'typescriptreact',
        'typescript.tsx',
        'vue',
        'svelte',
        'astro',
    },
    root_markers = root_files,
    -- -- https://eslint.org/docs/user-guide/configuring/configuration-files#configuration-file-formats
    -- root_dir = function(fname)
    --     root_files = util.insert_package_json(root_files, 'eslintConfig', fname)
    --     return util.root_pattern(unpack(root_files))(fname)
    -- end,
    -- Refer to https://github.com/Microsoft/vscode-eslint#settings-options for documentation.
    settings = {
        validate = 'on',
        packageManager = nil,
        useESLintClass = false,
        experimental = {
            useFlatConfig = false,
        },
        codeActionOnSave = {
            enable = false,
            mode = 'all',
        },
        format = true,
        quiet = false,
        onIgnoredFiles = 'off',
        rulesCustomizations = {},
        run = 'onType',
        problems = {
            shortenToSingleLine = false,
        },
        -- nodePath configures the directory in which the eslint server should start its node_modules resolution.
        -- This path is relative to the workspace folder (root dir) of the server instance.
        nodePath = '',
        -- use the workspace folder location or the file location (if no workspace folder is open) as the working directory
        workingDirectory = { mode = 'location' },
        codeAction = {
            disableRuleComment = {
                enable = true,
                location = 'separateLine',
            },
            showDocumentation = {
                enable = true,
            },
        },
    },
    handlers = {
        ['eslint/openDoc'] = function(_, result)
            if result then
                vim.ui.open(result.url)
            end
            return {}
        end,
        ['eslint/confirmESLintExecution'] = function(_, result)
            if not result then
                return
            end
            return 4 -- approved
        end,
        ['eslint/probeFailed'] = function()
            vim.notify('[lspconfig] ESLint probe failed.', vim.log.levels.WARN)
            return {}
        end,
        ['eslint/noLibrary'] = function()
            vim.notify('[lspconfig] Unable to find ESLint library.', vim.log.levels.WARN)
            return {}
        end,
    },
    on_attach = function(_, bufnr)
        vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = bufnr,
            callback = function()
                fix_all({ sync = true, bufnr = 0 })
            end
        })
    end,
    docs = {
        description = [[
https://github.com/hrsh7th/vscode-langservers-extracted

`vscode-eslint-language-server` is a linting engine for JavaScript / Typescript.
It can be installed via `npm`:

```sh
npm i -g vscode-langservers-extracted
```

`vscode-eslint-language-server` provides an `EslintFixAll` command that can be used to format a document on save:
```lua
lspconfig.eslint.setup({
  --- ...
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
})
```

See [vscode-eslint](https://github.com/microsoft/vscode-eslint/blob/55871979d7af184bf09af491b6ea35ebd56822cf/server/src/eslintServer.ts#L216-L229) for configuration options.

Messages handled in lspconfig: `eslint/openDoc`, `eslint/confirmESLintExecution`, `eslint/probeFailed`, `eslint/noLibrary`

Additional messages you can handle: `eslint/noConfig`
]],
    },
}
