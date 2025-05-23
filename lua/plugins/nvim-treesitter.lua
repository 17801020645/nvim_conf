return {
  -- 指定插件仓库地址
  "nvim-treesitter/nvim-treesitter",

  -- 插件依赖项（如果需要）
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects", -- 可选：文本对象支持
    "windwp/nvim-ts-autotag", -- 可选：自动标签补全
  },

  -- 构建命令（安装时执行）
  build = ":TSUpdate",

  -- 配置函数（插件加载后执行）
  config = function()
    -- 调用require加载插件主模块
    local treesitter = require("nvim-treesitter.configs")

    -- 配置参数表
    treesitter.setup({
      -- 语法高亮配置
      highlight = {
        enable = true, -- 启用语法高亮
        disable = { "help" }, -- 对某些文件类型禁用（可选）
        additional_vim_regex_highlighting = false, -- 禁用传统正则高亮
      },

      -- 缩进配置
      indent = {
        enable = true, -- 启用基于Treesitter的缩进
        disable = { "python" }, -- 对某些文件类型禁用（可选）
      },

      -- 增量选择配置
      incremental_selection = {
        enable = true, -- 启用增量选择
        keymaps = {
          init_selection = "gnn", -- 进入选择模式
          node_incremental = "grn", -- 增量扩大选择范围
          scope_incremental = "grc", -- 增量扩大选择作用域
          node_decremental = "grm", -- 增量缩小选择范围
        },
      },

      -- 文本对象配置
      textobjects = {
        select = {
          enable = true, -- 启用文本对象选择
          lookahead = true, -- 允许超前匹配
          keymaps = {
            ["af"] = "@function.outer", -- 选择整个函数（外层）
            ["if"] = "@function.inner", -- 选择函数体（内层）
            ["ac"] = "@class.outer", -- 选择整个类（外层）
            ["ic"] = "@class.inner", -- 选择类内容（内层）
          },
        },
      },

      -- 确保安装的语言解析器列表
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "css",
        "go",
        "html",
        "java",
        "javascript",
        "json",
        "lua",
        "python",
        "rust",
        "typescript",
        "vim",
        "markdown",
        "yaml",
      },

      -- 自动安装配置
      auto_install = true, -- 自动安装缺失的解析器

      -- 其他配置（可选）
      autotag = { -- nvim-ts-autotag集成
        enable = true, -- 启用自动标签补全
      },

      -- 同步安装解析器（推荐禁用）
      sync_install = false, -- 同步安装可能导致界面冻结

      -- 忽略安装的解析器（可选）
      ignore_install = { "php" }, -- 忽略特定解析器

      -- 模块配置（可选）
      modules = {}, -- 可添加其他Treesitter模块
    })

    -- 可选：自定义高亮组设置
    vim.cmd([[
      hi @function gui=bold
      hi @parameter gui=italic
    ]])
  end,

  -- 插件加载条件（可选）
  cond = function()
    return vim.fn.executable("tree-sitter") == 1 -- 确保系统安装了tree-sitter CLI
  end,

  -- 事件触发（可选）
  event = { "BufReadPost", "BufNewFile" }, -- 文件打开时加载

  -- 版本锁定（可选）
  version = "*", -- 使用最新版本，或指定如 "v0.9.2"
}
