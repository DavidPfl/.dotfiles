return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      tailwindcss = {
        filetypes = {
          "html",
          "css",
          "scss",
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "vue",
          "svelte",
        },
        settings = {
          tailwindCSS = {
            experimental = {
              classRegex = {
                "class[:]\\s*['\"]([^'\"]*)['\"]",
                "className[:]\\s*['\"]([^'\"]*)['\"]",
              },
            },
          },
        },
      },
    },
  },
}
