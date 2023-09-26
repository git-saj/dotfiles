return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        bashls = {},
        marksman = {},
        powershell_es = {},
        azure_pipelines_ls = {},
        terraformls = {},
      },
    },
  },
}
