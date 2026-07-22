local vue_language_server_path = ""
if vim.uv.os_uname().sysname == "Linux" then
    Logger.info("setup ts_ls on linux")
    vue_language_server_path =
    "/home/samuel-lindblom-stratsys/.nvm/versions/node/v24.13.0/lib/node_modules/@vue/typescript-plugin"
else
    Logger.info("setup ts_ls on Windows")
    vue_language_server_path =
    "C:/Users/samuel.lindblom/Appdata/Roaming/npm/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin"
end


vim.api.nvim_create_autocmd('FileType', {
    pattern = { "typescript", "javascript", "vue" },
    callback = function()
        -- In .cs files we can add "<esc>T(i" at the end to go back into (). But for some reason it just won't
        -- work for .ts files.)
        vim.api.nvim_buf_set_keymap(0, "ia", "print@", "console.log()", {});
        vim.api.nvim_buf_set_keymap(0, "ia", "aaa@", "// arrange\n// act\n// assert", {});
    end,
})

return {
    init_options = {
        plugins = {
            {
                name = "@vue/typescript-plugin",
                location = vue_language_server_path,
                languages = { "vue" },
            },
        },
    },
    filetypes = {
        "vue",
        'javascript',
        'javascriptreact',
        'javascript.jsx',
        'typescript',
        'typescriptreact',
        'typescript.tsx',
    },
    cmd = { "typescript-language-server", "--stdio" },
    root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
}
