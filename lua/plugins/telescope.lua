-- 在 ~/.config/nvim/lua/plugins/telescope.lua 或类似路径创建此文件

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Telescope 依赖的异步库
      "nvim-telescope/telescope-fzf-native.nvim", -- 提供更快的搜索性能
      "nvim-tree/nvim-web-devicons", -- 文件图标支持 (可选但推荐)
      "debugloop/telescope-undo.nvim", -- 撤销历史浏览 (可选)
    },
    config = function()
      -- 加载 telescope 模块
      local telescope = require("telescope")
      local actions = require("telescope.actions") -- 内置操作

      -- 初始化 telescope 配置
      telescope.setup({
        -- 默认配置
        defaults = {
          -- 文件预览设置
          file_previewer = require("telescope.previewers").vim_buffer_cat.new,
          grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
          qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

          -- 快捷键映射
          mappings = {
            i = {
              -- 在插入模式下按 ESC 退出
              ["<esc>"] = actions.close,
              -- 垂直分割打开文件
              ["<C-v>"] = actions.file_vsplit,
              -- 水平分割打开文件
              ["<C-s>"] = actions.file_split,
              -- 在 quickfix 列表中添加选中项
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            },
            n = {
              -- 在普通模式下同样支持以上操作
              ["<C-v>"] = actions.file_vsplit,
              ["<C-s>"] = actions.file_split,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            },
          },

          -- 通用配置
          vimgrep_arguments = {
            "rg", -- 使用 ripgrep
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden", -- 搜索隐藏文件
            "--glob=!.git/", -- 忽略 .git 目录
          },
          pickers = {
            find_files = {
              theme = "dropdown",
            },
          },
          -- 布局配置
          layout_strategy = "horizontal", -- 水平布局
          layout_config = {
            horizontal = {
              preview_width = 0.6, -- 预览窗口宽度占比
              prompt_position = "top", -- 输入框位置
            },
            vertical = {
              mirror = false,
            },
            width = 0.95,
            height = 0.95,
          },

          -- 其他设置
          path_display = { "truncate" }, -- 路径显示方式
          set_env = { ["COLORTERM"] = "truecolor" }, -- 真彩色支持
          dynamic_preview_title = true, -- 动态预览标题
          winblend = 10, -- 窗口透明度混合
        },

        -- 扩展配置
        extensions = {
          fzf = {
            fuzzy = true, -- 启用模糊搜索
            override_generic_sorter = true, -- 覆盖默认排序器
            override_file_sorter = true, -- 覆盖文件排序器
            case_mode = "smart_case", -- 智能大小写
          },
          undo = {
            -- 撤销历史扩展配置
            use_delta = true,
            side_by_side = true,
            layout_strategy = "vertical",
            layout_config = {
              preview_height = 0.6,
            },
          },
        },
      })

      -- 加载扩展
      telescope.load_extension("fzf") -- 加载 fzf 扩展
      telescope.load_extension("undo") -- 加载撤销历史扩展

      -- 自定义快捷键
      local keymap = vim.keymap
      local builtin = require("telescope.builtin")

      -- 查找文件 (包括隐藏文件)
      keymap.set("n", "<leader>ff", function()
        builtin.find_files({ hidden = true })
      end, { desc = "Find files (including hidden)" })

      -- 仅查找 git 管理的文件
      keymap.set("n", "<leader>fg", builtin.git_files, { desc = "Find Git files" })

      -- 实时 grep 搜索
      keymap.set("n", "<leader>fs", function()
        builtin.live_grep({ additional_args = { "--hidden" } })
      end, { desc = "Live grep (including hidden)" })

      -- 查找缓冲区
      keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })

      -- 查找帮助标签
      keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help tags" })

      -- 查找最近打开的文件
      keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "Find recently opened files" })

      -- 查找当前缓冲区中的内容
      keymap.set("n", "<leader>fc", builtin.current_buffer_fuzzy_find, { desc = "Find in current buffer" })

      -- 查找命令历史
      keymap.set("n", "<leader>fm", builtin.command_history, { desc = "Find command history" })

      -- 查找标记
      keymap.set("n", "<leader>ft", builtin.marks, { desc = "Find marks" })

      -- 撤销历史
      keymap.set("n", "<leader>fu", telescope.extensions.undo.undo, { desc = "Undo history" })

      -- 查找 Neovim 配置
      keymap.set("n", "<leader>fn", function()
        builtin.find_files({ cwd = vim.fn.stdpath("config") })
      end, { desc = "Find Neovim config files" })
    end,
  },
  -- 编译 fzf-native 扩展 (可选但推荐)
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make", -- 需要安装 make 和 cmake
  },
}
