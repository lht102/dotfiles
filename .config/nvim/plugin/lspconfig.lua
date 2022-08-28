local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")
local null_ls = require("null-ls")
local cmp = require("cmp")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")

mason.setup()
mason_lspconfig.setup({
  ensure_installed = { "sumneko_lua", "gopls", "rust_analyzer", "tsserver" },
})

local disable_formatting = function(client)
  client.resolved_capabilities.document_formatting = false
  client.resolved_capabilities.document_range_formatting = false
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
end

local disabled_formatting_ls_table = { gopls = true, tsserver = true }

local lsp_on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  if disabled_formatting_ls_table[client.name] then
    disable_formatting(client)
  end

  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
  vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
end

local lsp_flags = {
  debounce_text_changes = 150,
}

local lsp_capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())

lspconfig.sumneko_lua.setup({
  on_attach = lsp_on_attach,
  flags = lsp_flags,
  capabilities = lsp_capabilities,
  settings = {
    Lua = {
      format = {
        enable = true,
        defaultConfig = {
          indent_style = "space",
          indent_size = "2",
          quote_style = "double",
        }
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
    },
  },
})

lspconfig.tsserver.setup({
  on_attach = lsp_on_attach,
  flags = lsp_flags,
  capabilities = lsp_capabilities,
})

lspconfig.gopls.setup({
  on_attach = lsp_on_attach,
  flags = lsp_flags,
  capabilities = lsp_capabilities,
})

lspconfig.rust_analyzer.setup({
  on_attach = lsp_on_attach,
  flags = lsp_flags,
  capabilities = lsp_capabilities,
})

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.goimports,
    null_ls.builtins.diagnostics.golangci_lint,
    null_ls.builtins.formatting.eslint,
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.formatting_sync({}, 2000)
        end,
      })
    end
  end,
})

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources(
    {
      { name = "nvim_lsp" },
      { name = "nvim_lsp_signature_help" },
      { name = "luasnip" },
      { name = "path" }
    }
  ),
  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol_text",
      maxwidth = 80,
    })
  }
})
