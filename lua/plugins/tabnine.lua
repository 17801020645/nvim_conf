-- lua/plugins/tabnine.lua
return {
  "codota/tabnine-nvim", -- 插件名称
  build = "./dl_binaries.sh", -- 构建命令，用于下载 TabNine 二进制文件
  config = function()
    -- TabNine 配置
    require("tabnine").setup({
      accept_keymap = "<C-]>",
      dismiss_keymap = "<C-]>",
      debounce_ms = 300,
      suggestion_color = { gui = "#808080", cterm = 244 },
      exclude_filetypes = { "TelescopePrompt" },
    })
  end,
}
