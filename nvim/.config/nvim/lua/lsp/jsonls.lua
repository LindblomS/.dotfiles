return {
    -- Install with "npm install -g vscode-json-languageserver"
    -- https://github.com/Microsoft/vscode-json-languageservice
    cmd = { "vscode-json-languageserver", "--stdio" },
    filetypes = { 'json', 'jsonc' },
    init_options = {
        provideFormatter = true,
    },
    root_dir = function(_, on_dir)
        on_dir(vim.fn.getcwd())
    end
}
