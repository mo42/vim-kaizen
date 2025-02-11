function VimKaizen(pat, alt)
  local txt1 = string.format('You entered "%s", which is an anti-pattern.', pat)
  local txt2 = string.format('Consider using "%s" from now on.', alt)
  local txt3 = 'Press "q" or ESC to close window.'
  local txt4 = ''
  if #alt == 1 then
    txt4 = string.format('Try :h %s to see the Vim help.', alt)
  end
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, {txt1, txt2, '', txt3, '', txt4})
  local ui = vim.api.nvim_list_uis()[1] or vim.api.nvim_list_uis()[0]

  local width = 50
  local height = 10
  local opts = {
      relative = 'editor',
      width = width,
      height = height,
      col = (ui.width / 2) - (width / 2),
      row = (ui.height / 2) - (height / 2),
      anchor = 'NW',
      style = 'minimal',
      border = 'shadow'
  }

  local win = vim.api.nvim_open_win(buf, true, opts)
  vim.api.nvim_set_current_win(win)
  vim.api.nvim_buf_set_keymap(buf, 'n', '<Esc>', '<Cmd>bwipeout!<CR>', {noremap = true, silent = true})
  vim.api.nvim_buf_set_keymap(buf, 'n', 'q', '<Cmd>bwipeout!<CR>', {noremap = true, silent = true})
end

local vimKaizenPatterns = {
  {'n', 'd$', 'D'},
  {'n', 'y$', 'Y'},
  {'n', 'ggVG', 'yG'},
  {'n', 'cc', 'S'},
  {'n', 'xi', 's'},
  {'n', 'dwi', 'cw'},
  {'n', 'd2wi', 'c2w'},
  {'n', 'd3wi', 'c3w'},
  {'', '<Right>', 'h'},
  {'', '<Left>', 'l'},
  {'', '<Up>', 'k'},
  {'', '<Down>', 'j'},
  {'n', '$a', 'A'},
  {'n', '^o', 'o'},
}

for _, tuple in ipairs(vimKaizenPatterns) do
  local map, pat, alt = table.unpack(tuple)
  vim.keymap.set(map, pat, function() VimKaizen(pat, alt) end, { noremap = true, silent = true })
end
