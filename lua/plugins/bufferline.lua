-- File: ~/.config/nvim/lua/plugins/bufferline.lua

return {
  -- 声明 bufferline.nvim 插件
  {
    "akinsho/bufferline.nvim",
    version = "*", -- 使用最新稳定版本
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- 可选：提供文件类型图标
    },
    config = function()
      -- 启用终端真彩色支持（确保图标和颜色正确显示）
      vim.opt.termguicolors = true

      -- 加载 bufferline 并设置配置
      require("bufferline").setup({
        options = {
          mode = "buffers", -- 设置为 "tabs" 可显示标签页模式
          numbers = "none", -- 可选项: "none" | "ordinal" | "buffer_id"
          close_command = "bdelete! %d", -- 关闭缓冲区的命令
          right_mouse_command = "bdelete! %d", -- 右键关闭缓冲区
          left_mouse_command = "buffer %d", -- 左键切换缓冲区
          middle_mouse_command = nil, -- 中键命令（默认无）
          indicator = {
            icon = "▎", -- 缓冲区指示器图标
            style = "underline", -- 或 'icon' | 'underline'
          },
          buffer_close_icon = "", -- 关闭按钮图标
          modified_icon = "●", -- 修改标记图标
          close_icon = "", -- 关闭图标
          left_trunc_marker = "", -- 左侧截断标记
          right_trunc_marker = "", -- 右侧截断标记
          max_name_length = 18, -- 最大名称长度
          max_prefix_length = 15, -- 最大前缀长度（用于唯一性）
          truncate_names = true, -- 是否截断长文件名
          tab_size = 18, -- 标签大小
          diagnostics = "nvim_lsp", -- 显示LSP诊断（需配置LSP）
          diagnostics_update_in_insert = false, -- 是否在插入模式更新诊断
          offsets = {
            {
              filetype = "NvimTree", -- 为 nvim-tree 设置偏移
              text = "File Explorer", -- 显示文本
              highlight = "Directory", -- 高亮组
              text_align = "left", -- 文本对齐方式
              separator = true, -- 使用分隔线
            },
          },
          color_icons = true, -- 是否使用彩色图标
          show_buffer_icons = true, -- 显示缓冲区图标
          show_buffer_close_icons = true, -- 显示关闭图标
          show_close_icon = true, -- 显示标签栏关闭图标
          show_tab_indicators = true, -- 显示标签指示器
          persist_buffer_sort = true, -- 保持缓冲区排序
          separator_style = "thin", -- 或 "slant" | "thick" | "thin" | { 'any', 'any' }
          enforce_regular_tabs = false, -- 强制常规标签
          always_show_bufferline = true, -- 总是显示缓冲区行
          sort_by = "insert_after_current", -- 排序方式: "id" | "extension" | "relative_directory" | "directory"
        },
      })

      -- 设置快捷键
      local map = vim.keymap.set
      local opts = { noremap = true, silent = true }

      -- 切换上一个/下一个缓冲区
      map("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", opts)
      map("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", opts)

      -- 关闭当前缓冲区
      map("n", "<leader>bc", "<Cmd>BufferLinePickClose<CR>", opts)

      -- 快速跳转到缓冲区（通过编号）
      map("n", "<leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>", opts)
      map("n", "<leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>", opts)
      map("n", "<leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>", opts)
      map("n", "<leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>", opts)
      map("n", "<leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>", opts)
      map("n", "<leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>", opts)
      map("n", "<leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>", opts)
      map("n", "<leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>", opts)
      map("n", "<leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>", opts)
    end,
  },
}
