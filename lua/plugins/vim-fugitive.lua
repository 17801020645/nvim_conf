return {
  "tpope/vim-fugitive",
  -- 因为是 Vim 插件，需要声明为 Vim 插件格式
  lazy = false, -- 建议立即加载，方便随时使用 Git 命令
  keys = {
    -- 定义常用快捷键
    { "<leader>gs", "<cmd>Git<CR>", desc = "打开Git状态窗口" },
    { "<leader>gc", "<cmd>Git commit<CR>", desc = "提交变更" },
    { "<leader>gp", "<cmd>Git push<CR>", desc = "推送代码" },
    { "<leader>gl", "<cmd>Git pull<CR>", desc = "拉取代码" },
    { "<leader>gd", "<cmd>Gdiffsplit<CR>", desc = "对比文件差异" },
  },
  config = function()
    -- 自动关闭 fugitive 缓冲区时恢复布局
    vim.api.nvim_create_autocmd("BufWinEnter", {
      pattern = "fugitive://*",
      callback = function()
        if vim.bo.ft == "fugitive" then
          vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = true })
        end
      end,
    })

    -- 自定义状态栏显示分支信息（需配合 lualine 配置）
    vim.api.nvim_create_autocmd("User", {
      pattern = "FugitiveChanged",
      callback = function()
        require("lualine").refresh() -- 刷新状态栏
      end,
    })
  end,
}
