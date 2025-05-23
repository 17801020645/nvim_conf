return {
  {
    "sainnhe/sonokai",
    lazy = true,
    priority = 1000,
    config = function()
      -- 设置主题风格
      vim.g.sonokai_style = "andromeda"

      -- 启用更好的性能
      vim.g.sonokai_better_performance = 1

      -- 禁用透明背景
      vim.g.sonokai_transparent_background = 1

      -- 启用终端真彩色
      vim.g.sonokai_enable_italic = 1
      vim.g.sonokai_disable_italic_comment = 0

      -- 自定义高亮组 (可选)
      vim.g.sonokai_custom_highlights = {}

      -- 诊断颜色设置 (可选)
      vim.g.sonokai_diagnostic_line_highlight = 1
      vim.g.sonokai_diagnostic_text_highlight = 1
      vim.g.sonokai_diagnostic_virtual_text = "colored"

      -- 应用颜色方案
      vim.cmd.colorscheme("sonokai")

      -- 可选：为特定文件类型设置不同的风格
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          vim.g.sonokai_style = "shusia"
          vim.cmd.colorscheme("sonokai")
        end,
      })
    end,
  },
}
