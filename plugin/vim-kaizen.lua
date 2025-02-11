function VimKaizen(pat, alt)
  local txt1 = string.format('You entered "%s", which is an anti-pattern.', pat)
  local txt2 = string.format('Consider using "%s" from now on.', alt)
  local txt3 = 'Press "q" or ESC to close window.'
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, {txt1, txt2, '', txt3})
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

vim.api.nvim_create_user_command('VimHabits', function(opts) VimHabits(opts.args) end, {nargs=1})

local vimKaizenPatterns = {
    {'n', 'd$', 'D'},
    {'n', 'y$', 'Y'},
    {'n', 'ggVG', 'yG'},
    {'n', 'cc', 'S'},
}

for _, tuple in ipairs(vimKaizenPatterns) do
  local map, pat, alt = table.unpack(tuple)
  vim.keymap.set(map, pat, function() VimKaizen(pat, alt) end, { noremap = true, silent = true })
end
