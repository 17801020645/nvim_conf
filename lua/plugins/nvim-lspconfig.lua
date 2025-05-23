-- 配置 lazy.nvim 插件
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- 自动安装 LSP 服务器
      { "mason-org/mason.nvim", config = true },
      { "mason-org/mason-lspconfig.nvim" },

      -- 有用的附加组件
      { "j-hui/fidget.nvim", tag = "legacy", event = "LspAttach", opts = {} }, -- LSP 进度指示器
      { "folke/neodev.nvim" }, -- Neovim Lua 开发工具
    },

    config = function()
      -- 设置 Neodev 用于 Neovim Lua 开发
      require("neodev").setup()

      -- 设置 Mason 自动安装 LSP 服务器
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls", -- Lua
          "pyright", -- Python
          "rust_analyzer", -- Rust
          "tsserver", -- TypeScript/JavaScript
          "gopls", -- Go
          "clangd", -- C/C++
          "bashls", -- Bash
          "jsonls", -- JSON
          "yamlls", -- YAML
          "html", -- HTML
          "cssls", -- CSS
          "dockerls", -- Docker
          "taplo", -- TOML
        },
        automatic_installation = true,
      })

      -- LSP 配置
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- 为每个语言服务器设置配置

      -- Lua
      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              globals = { "vim" }, -- 识别 vim 全局变量
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true), -- 使 Neovim 运行时库可用
              checkThirdParty = false, -- 不提示第三方库
            },
            telemetry = {
              enable = false, -- 禁用遥测
            },
          },
        },
      })

      -- Python
      lspconfig.pyright.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic", -- 基本类型检查
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
            },
          },
        },
      })

      -- TypeScript/JavaScript
      lspconfig.tsserver.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        init_options = {
          preferences = {
            importModuleSpecifierPreference = "relative", -- 使用相对路径导入
          },
        },
      })

      -- Rust
      lspconfig.rust_analyzer.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
            },
            checkOnSave = {
              command = "clippy",
            },
          },
        },
      })

      -- Go
      lspconfig.gopls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
          },
        },
      })

      -- C/C++
      lspconfig.clangd.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=never",
          "--all-scopes-completion",
          "--completion-style=detailed",
        },
      })

      -- 其他语言服务器的通用配置
      local servers = {
        "bashls",
        "jsonls",
        "yamlls",
        "html",
        "cssls",
        "dockerls",
        "taplo",
      }

      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end

      -- 设置 LSP 符号的图标
      local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      -- 诊断配置
      vim.diagnostic.config({
        virtual_text = {
          prefix = "●", -- 可以是 '■', '▎', 'x'
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          source = "always", -- 或 "if_many"
        },
      })

      -- 自定义悬停窗口的外观
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

      -- 自定义签名帮助窗口的外观
      vim.lsp.handlers["textDocument/signatureHelp"] =
        vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
    end,
  },
}
