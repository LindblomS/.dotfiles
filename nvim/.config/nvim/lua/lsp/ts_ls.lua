local vue_language_server_path = ""
if vim.uv.os_uname().sysname == "Linux" then
    print("running ts_ls on os Linux")
    vue_language_server_path =
    "/home/samuel-lindblom-stratsys/.nvm/versions/node/v24.13.0/lib/node_modules/@vue/typescript-plugin"
else
    print("running ts_ls on os Windows")
    vue_language_server_path =
    "C:/Users/samuel.lindblom/Appdata/Roaming/npm/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin"
end

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
    docs = {
        description = [[
https://github.com/typescript-language-server/typescript-language-server

`ts_ls`, aka `typescript-language-server`, is a Language Server Protocol implementation for TypeScript wrapping `tsserver`. Note that `ts_ls` is not `tsserver`.

`typescript-language-server` depends on `typescript`. Both packages can be installed via `npm`:
```sh
npm install -g typescript typescript-language-server
```

To configure typescript language server, add a
[`tsconfig.json`](https://www.typescriptlang.org/docs/handbook/tsconfig-json.html) or
[`jsconfig.json`](https://code.visualstudio.com/docs/languages/jsconfig) to the root of your
project.

Here's an example that disables type checking in JavaScript files.

```json
{
  "compilerOptions": {
    "module": "commonjs",
    "target": "es6",
    "checkJs": false
  },
  "exclude": [
    "node_modules"
  ]
}
```

### Vue support

As of 2.0.0, Volar no longer supports TypeScript itself. Instead, a plugin
adds Vue support to this language server.

*IMPORTANT*: It is crucial to ensure that `@vue/typescript-plugin` and `volar `are of identical versions.

```lua
require'lspconfig'.ts_ls.setup{
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
        languages = {"javascript", "typescript", "vue"},
      },
    },
  },
  filetypes = {
    "javascript",
    "typescript",
    "vue",
  },
}

-- You must make sure volar is setup
-- e.g. require'lspconfig'.volar.setup{}
-- See volar's section for more information
```

`location` MUST be defined. If the plugin is installed in `node_modules`,
`location` can have any value.

`languages` must include `vue` even if it is listed in `filetypes`.

`filetypes` is extended here to include Vue SFC.
]],
    },
}
