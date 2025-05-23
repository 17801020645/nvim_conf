return {
  {
    "RRethy/base16-nvim", --https://github.com/RRethy/base16-nvim
    lazy = true,
    priority = 1000,
    config = function()
      -- 启用透明背景（可选）
      vim.g.base16_transparent_background = true

      -- 启用终端颜色（可选）
      vim.g.base16_termcolors = 256

      -- 设置颜色方案
      vim.cmd("colorscheme base16-gruvbox-dark-hard") -- 示例主题

      -- 或者使用自动检测系统主题（需要额外的系统支持）
      -- vim.cmd("colorscheme base16-default-dark") -- 默认暗色
      -- vim.cmd("colorscheme base16-default-light") -- 默认亮色
    end,
  },
}
