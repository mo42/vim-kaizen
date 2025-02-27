_G.vim_kaizen_buffer = {}

_G.vim_kaizen_enabled = true

_G.vim_kaizen_patterns = {
  ['d$'] = "D",
  ['y$'] = "Y",
  ['ggVG'] = 'yG',
  ['cc'] = 'S',
  ['xi'] = 's',
  ['cl'] = 's',
  ['dwi'] = 'cw',
  ['dsi'] = 'cs',
  ['dpi'] = 'cp',
  ['d2wi'] = 'c2w',
  ['d3wi'] = 'c3w',
  ['<Right>'] = 'h',
  ['<Left>'] = 'l',
  ['<Up>'] = 'k',
  ['<Down>'] = 'j',
  ['$a'] = 'A',
  ['^o'] = 'o',
  ['^i'] = 'I',
  ['$a'] = 'A',
  ['^j'] = '+',
  ['^k'] = '-',
  ['jjj'] = '3j',
  ['kkk'] = '3k',
  ['~~~'] = '3~',

}

function vim_kaizen_keypress(key)
  local max_buffer_length = 3
  table.insert(_G.vim_kaizen_buffer, key)
  if #_G.vim_kaizen_buffer > max_buffer_length then
    table.remove(_G.vim_kaizen_buffer, 1)
  end
  if #_G.vim_kaizen_buffer > 1 then
    for i = 1, #_G.vim_kaizen_buffer do
      local pat = table.concat(_G.vim_kaizen_buffer, "", i, #_G.vim_kaizen_buffer)
      if _G.vim_kaizen_patterns[pat] then
          vim_kaizen(pat)
      end
    end
  end
end

vim.on_key(function(key)
  local mode = vim.api.nvim_get_mode().mode
  if _G.vim_kaizen_enabled and mode ~= 'i' and mode ~= 'c' then
    vim_kaizen_keypress(vim.fn.keytrans(key))
  end
end, vim.api.nvim_create_namespace("global_key_listener"))

function vim_kaizen(pat)
  local alt = _G.vim_kaizen_patterns[pat]
  local txt1 = string.format('You entered "%s".', pat)
  local txt2 = string.format('Consider using "%s" from now on.', alt)
  local txt3 = 'Press "q" or Esc to close window.'
  local txt4 = ''
  if #alt == 1 then
    txt4 = string.format('Try ":h %s" to see the Vim help.', alt)
  end
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, {txt1, txt2, '', txt3, '', txt4})
  vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
  vim.api.nvim_buf_set_option(buf, "modifiable", false)
  vim.api.nvim_buf_set_option(buf, "readonly", true)
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

function vim_kaizen_toggle()
  _G.vim_kaizen_enabled = not _G.vim_kaizen_enabled
  if _G.vim_kaizen_enabled then
    print('VimKaizen plugin enabled')
  else
    print('VimKaizen plugin disabled')
  end
end

function vim_kaizen_clear()
  _G.vim_plug_patterns = {}
  print("Cleared all vim-kaizen patterns")
end

function vim_kaizen_add(key, value)
  if key and value then
    _G.vim_kaizen_patterns[key] = value
  end
end

vim.api.nvim_create_user_command("VimKaizenToggle", vim_kaizen_toggle, {})
vim.api.nvim_create_user_command("VimKaizenClear", vim_kaizen_clear, {})
vim.api.nvim_create_user_command('VimKaizenAdd', function(opts)
  local k, v = opts.fargs[1], opts.fargs[2]
  vim_kaizen_add(k, v)
end, { nargs = '*' })
