local lspconfig = require("lspconfig")

local servers = { "pyright", "tsserver", "clangd", "rust-analyzer" }

for _, server in ipairs(servers) do
  lspconfig[server].setup {}
end
