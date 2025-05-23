return {
  -- 声明使用的插件
  "nvim-lualine/lualine.nvim",
  -- 依赖的图标插件（需要安装 nerd font 字体）
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "catppuccin/nvim",
  },

  -- 插件加载后的配置函数
  config = function()
    require("lualine").setup({
      -- 全局配置选项
      options = {
        icons_enabled = true, -- 启用图标
        theme = "sonokai", -- 自动匹配当前配色主题,catppuccin 这个主题备选
        component_separators = { left = "", right = "" }, -- 组件之间的分隔符
        section_separators = { left = "", right = "" }, -- 大区块之间的分隔符
        disabled_filetypes = { -- 禁用状态栏的文件类型
          statusline = {}, -- 不禁用任何文件类型的状态栏
          winbar = {}, -- 不禁用任何文件类型的顶部栏
        },
        always_divide_middle = true, -- 始终在中间区域使用分隔符
        refresh = { statusline = 1000 }, -- 状态栏刷新频率（毫秒）
      },

      -- 活动窗口的显示组件配置
      sections = {
        -- 左侧区域配置（默认显示模式）
        lualine_a = { "mode" }, -- 显示 Vim 模式（正常/插入/可视等）

        -- 左侧中部区域配置
        lualine_b = {
          "branch", -- 显示 Git 分支

          -- 自定义文件名组件
          {
            "filename",
            path = 1, -- 显示相对路径（0=仅文件名，2=绝对路径）
            symbols = {
              modified = "[+]", -- 文件修改后的标识符号
              readonly = "[-]", -- 只读文件标识
              unnamed = "[No Name]", -- 未命名文件的显示文本
            },
          },

          -- Git 差异指示器
          {
            "diff",
            symbols = {
              added = " ", -- 新增文件图标
              modified = " ", -- 修改文件图标
              removed = " ", -- 删除文件图标
            },
          },

          -- LSP 诊断信息
          {
            "diagnostics",
            sources = { "nvim_diagnostic" }, -- 数据源为 Neovim 的诊断系统
            symbols = {
              error = " ", -- 错误级别图标
              warn = " ", -- 警告级别图标
              info = " ", -- 信息级别图标
              hint = " ", -- 提示级别图标
            },
          },
        },

        -- 中间区域留空
        lualine_c = {},

        -- 右侧区域配置
        lualine_x = {
          "encoding", -- 文件编码（如 UTF-8）

          -- 文件格式（换行符类型）
          {
            "fileformat",
            symbols = {
              unix = "", -- UNIX 格式（LF）
              dos = "", -- DOS 格式（CRLF）
              mac = "", -- MAC 格式（CR）
            },
          },
          "filetype", -- 文件类型（如 Lua、Python）
        },

        -- 右侧中部区域
        lualine_y = { "progress" }, -- 显示光标位置百分比

        -- 最右侧区域配置
        lualine_z = {
          -- 自定义时间显示（带时钟图标）
          function()
            return " " .. os.date("%Y-%m-%d %H:%M") --  是时钟图标，%H:%M 显示小时:分钟
          end,
          "location", -- 显示光标行列位置（如 10:20）
        },
      },

      -- 非活动窗口的显示配置
      inactive_sections = {
        lualine_a = {},
        lualine_b = { "filename" }, -- 仅显示文件名
        lualine_c = {},
        lualine_x = { "location" }, -- 仅显示位置
        lualine_y = {},
        lualine_z = {},
      },

      -- 扩展插件支持（需要安装对应插件）
      extensions = {
        "nvim-tree", -- 文件树插件支持
        "fugitive", -- Git 插件支持
      },
    })
  end,
}
