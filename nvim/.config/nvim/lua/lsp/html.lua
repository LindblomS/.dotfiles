return {
    -- Install with "npm install -g vscode-html-languageservice"
    -- https://github.com/microsoft/vscode-html-languageservice

    -- NOTE: The server needs further configuration to work. The npm install only "copies" the repo with no entrypoint.
    -- See how it is done in vscode, like here https://github.com/hrsh7th/vscode-langservers-extracted/tree/master
    cmd = { "vscode-html-languageserver", "--stdio" },
    filetypes = { 'html' },
    root_dir = function(_, on_dir)
        on_dir(vim.fn.getcwd())
    end,
    init_options = {
        provideFormatter = true,
        embeddedLanguages = { css = true, javascript = true },
        configurationSection = { 'html', 'css', 'javascript' },
    },
}
