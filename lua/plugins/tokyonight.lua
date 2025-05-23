-- lua/plugin/lualine.lua
return {
  {
    "folke/tokyonight.nvim",
    priority = 1000, -- 确保主题最后加载
    config = function()
      -- 配置主题
      vim.cmd("colorscheme tokyonight-moon")
    end,
  },
  -- 其他插件配置...
}

