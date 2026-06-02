local builtin = require('telescope.builtin')
local config = require('telescope.config')


require("telescope").setup {
  defaults = {
    path_display = function(opts, path)
      local tail = require("telescope.utils").path_tail(path)

      return string.format("%s (%s)", tail, path)
    end,
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        width = { padding = 0 },
        height = { padding = 0 },
        --preview_width = 0.99,
        --results_width = 0.90,
      },
    },
  }
}

local function grep_quickfix_files()
  -- Extract unique file paths from the quickfix list
  local qflist = vim.fn.getqflist()
  local files = {}
  local seen = {}
  
  for _, item in ipairs(qflist) do
    if item.bufnr and item.bufnr ~= 0 then
      local path = vim.fn.bufname(item.bufnr)
      if path ~= "" and not seen[path] then
        files[#files + 1] = path
        seen[path] = true
      end
    end
  end

  if #files == 0 then
    vim.notify("Quickfix list is empty", vim.log.levels.WARN)
    return
  end

  -- Build ripgrep arguments to search only these files
  local args = {}
  for _, v in ipairs(config.values.vimgrep_arguments) do
    table.insert(args, v)
  end
  
  -- Append glob flags for ripgrep targeting specific files
  for _, file in ipairs(files) do
    table.insert(args, "-g")
    table.insert(args, "/" .. file)
  end

  -- Trigger live_grep with the restricted file arguments
  builtin.live_grep({ vimgrep_arguments = args })
end


vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
--vim.keymap.set('n', '<leader>fg', ':lua require("telescope.builtin").live_grep({hidden = true})<CR>')
vim.keymap.set('n', '<leader>fg', ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, {})
vim.keymap.set('n', '<leader>fo', builtin.oldfiles, {})
vim.keymap.set('n', '<leader>fr', builtin.registers, {})
--vim.keymap.set('n', '<leader>fq', builtin.quickfix, {})
vim.keymap.set('n', '<leader>fq', grep_quickfix_files, { desc = 'Grep files in quickfix' })

