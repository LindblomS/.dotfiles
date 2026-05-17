return {
    -- Install with "npm install -g vscode-json-languageserver"
    -- https://github.com/microsoft/vscode/blob/main/extensions/json-language-features/server/README.md
    cmd = { "vscode-json-languageserver", "--stdio" },
    filetypes = { 'json', 'jsonc' },
    init_options = {
        provideFormatter = true,
    },
    root_dir = function(_, on_dir)
        on_dir(vim.fn.getcwd())
    end
}
