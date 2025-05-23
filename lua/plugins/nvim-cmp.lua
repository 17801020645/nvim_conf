-- 在 lazy.nvim 配置中添加 nvim-cmp
{
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp", -- LSP 源
    "hrsh7th/cmp-buffer",   -- 缓冲区源
    "hrsh7th/cmp-path",     -- 路径源
    "hrsh7th/cmp-cmdline",  -- 命令行源
    "saadparwaiz1/cmp_luasnip", -- Snippets 源
    "L3MON4D3/LuaSnip",     -- Snippets 引擎
  },
  config = function()
    local cmp = require("cmp")
    
    cmp.setup({
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
      }, {
        { name = "buffer" },
        { name = "path" },
      }),
    })
  end,
}
