-- Define an autocmd group to avoid duplicating the command
vim.api.nvim_create_augroup("PrettierOnSave", { clear = true })
 vim.api.nvim_create_augroup("FormatOnSave", { clear = true })

-- Set up the autocmd for TypeScript and TypeScript React files
vim.api.nvim_create_autocmd("BufWritePre", {
  group = "PrettierOnSave",
  pattern = {"*.ts", "*.tsx"},
  command = "Prettier",  -- You can use ':Prettier' if you have the Prettier plugin installed
})

vim.api.nvim_create_autocmd("BufWritePost", {
  group = "FormatOnSave",
  pattern = {"*.swift"},
  command = "sleep 100m | FormatWrite", 
})
