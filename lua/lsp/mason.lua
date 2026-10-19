local mason_servers = {
  "lua_ls",
  "clangd",
  "csharp_ls",
  "basedpyright",
  "bashls",
  "hls",
}

local manual_servers = {
  "prolog_ls",
}

local settings = {
  ui = {
    border = "none",
    icons = {
      package_installed = "◍",
      package_pending = "◍",
      package_uninstalled = "◍",
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
}

require("mason").setup(settings)
require("mason-lspconfig").setup({
  ensure_installed = mason_servers,
  automatic_enable = false,
})

for _, server in ipairs(vim.list_extend(vim.deepcopy(mason_servers), manual_servers)) do
  local opts = {
    on_attach = require("lsp.handlers").on_attach,
    capabilities = require("lsp.handlers").capabilities,
  }

  server = vim.split(server, "@")[1]

  local require_ok, conf_opts = pcall(require, "lsp.settings." .. server)
  if require_ok then
    opts = vim.tbl_deep_extend("force", conf_opts, opts)
  end

  vim.lsp.config(server, opts)
  vim.lsp.enable(server)
end
