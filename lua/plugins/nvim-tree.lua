return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- 需要图标支持
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "切换文件树" }, -- 定义快捷键
  },
  config = function()
    -- 安全加载插件
    local nvim_tree = require("nvim-tree")

    nvim_tree.setup({
      -- 视图配置
      view = {
        width = 35, -- 文件树宽度
        side = "left", -- 显示在左侧
        number = false, -- 不显示行号
        relativenumber = false, -- 不显示相对行号
        signcolumn = "yes", -- 显示标记列（用于 git 状态）
      },
      -- 文件过滤器
      filters = {
        dotfiles = false, -- 显示 . 开头的隐藏文件
        custom = { ".git" }, -- 隐藏 .git 目录
      },
      -- 文件渲染配置
      renderer = {
        group_empty = true, -- 折叠空目录
        indent_markers = {
          enable = true, -- 显示缩进标记
          icons = {
            corner = "└ ", -- 目录折叠图标
            edge = "│ ", -- 垂直连接线
            item = "├ ", -- 文件连接线
            none = "  ", -- 空白填充
          },
        },
        icons = {
          git_placement = "after", -- git 状态图标位置
          show = {
            file = true, -- 显示文件图标
            folder = true, -- 显示文件夹图标
            folder_arrow = true, -- 显示文件夹箭头
          },
          glyphs = {
            default = "", -- 默认文件图标
            symlink = "", -- 符号链接图标
            git = {
              unstaged = "", -- 未暂存修改标识
              staged = "✓", -- 已暂存标识
              unmerged = "", -- 合并冲突标识
              renamed = "➜", -- 重命名标识
              untracked = "★", -- 未跟踪文件标识
              deleted = "", -- 删除文件标识
              ignored = "◌", -- 忽略文件标识
            },
          },
        },
      },
      -- 更新行为配置
      update_focused_file = {
        enable = true, -- 自动聚焦当前文件
        update_root = true, -- 自动更新根目录
      },
      -- 系统剪贴板集成
      system_open = {
        cmd = nil, -- 保持默认打开方式
        args = {}, -- 无额外参数
      },
      -- 诊断信息集成
      diagnostics = {
        enable = true, -- 显示诊断图标
        show_on_dirs = true, -- 在目录上显示诊断
        icons = {
          hint = "", -- 提示图标
          info = "", -- 信息图标
          warning = "", -- 警告图标
          error = "", -- 错误图标
        },
      },
      -- 文件操作配置
      actions = {
        open_file = {
          quit_on_open = false, -- 打开文件后不关闭文件树
          window_picker = {
            enable = true, -- 允许选择窗口打开文件
          },
        },
      },
    })

    -- 自动关闭功能（当打开最后一个文件时关闭文件树）
    vim.api.nvim_create_autocmd("BufEnter", {
      command = "if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif",
      nested = true,
    })
  end,
}
