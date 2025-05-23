return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- 可以在这里添加 which-key 的默认配置
      -- 如果不需要特殊配置，可以保持为空
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
      -- 添加主题切换的根快捷键
      {
        "<leader>t",
        "<cmd>WhichKey '<leader>t'<cr>",
        desc = "主题切换菜单",
      },
    },
    config = function(_, opts)
      -- 设置 which-key
      local wk = require("which-key")
      wk.setup(opts)

      -- 注册主题切换子菜单
      wk.register({
        ["<leader>t"] = {
          name = "+theme switch",
          b = { "<cmd>colorscheme base16-default-dark<cr>", "Base16 主题" },
          c = { "<cmd>colorscheme catppuccin<cr>", "Catppuccin 主题" },
          s = { "<cmd>colorscheme sonokai<cr>", "Sonokai 主题" },
        },
      })

      -- 可以在这里添加其他快捷键注册
      -- wk.register({...})
    end,
  },
}
