-- ~/.config/nvim/lua/config/lsp.lua

-- 定义一个本地函数来简化键映射设置
local on_attach = function(client, bufnr)
  -- 启用 completion-triggered 的补全
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- 本地键映射函数
  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  -- LSP 相关键映射
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts) -- 跳转到声明
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts) -- 跳转到定义
  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts) -- 显示悬停信息
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts) -- 跳转到实现
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts) -- 签名帮助
  vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts) -- 添加工作区文件夹
  vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts) -- 移除工作区文件夹
  vim.keymap.set("n", "<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts) -- 列出工作区文件夹
  vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts) -- 类型定义
  vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts) -- 重命名
  vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts) -- 代码操作
  vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts) -- 查找引用
  vim.keymap.set("n", "<space>f", function()
    vim.lsp.buf.format({ async = true })
  end, bufopts) -- 格式化

  -- 如果客户端支持文档高亮，则设置文档高亮
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
    vim.api.nvim_create_autocmd("CursorHold", {
      group = "lsp_document_highlight",
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      group = "lsp_document_highlight",
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end
end
