# vim-kaizen
Inspired by the Japanese philosophy of kaizen (改善)—the practice of continuous
improvement—`vim-kaizen` helps you refine your keystrokes to make you a more
efficient Vim user.

Inspired by:
- [iBhagwan's (n)vim cheatsheet](https://github.com/ibhagwan/vim-cheatsheet)
- [vim-hardmonde](https://github.com/dusans/vim-hardmode)
- [vim-hardtime](https://github.com/takac/vim-hardtime)

## Features

- Reminds you to unlearn inefficient commands.
- Provides suggestions for better commands.

- `:VimKaizenToggle` allows the user enable or disable the plugin
- `:VimKaizenClear` clears all default patterns
- `:VimKaizenAdd pat alt` adds user-defined pattern "pat" and suggestion "alt"

![vim-kaizen example in Vim editor](.example.png)

Vim commands and their alternatives:

| Command  | Alternative | Command | Alternative |
| -------- | ----------- |-------- | ----------- | 
| d$       | D           | d2wi    | c2w         |
| y$       | Y           | d3wi    | c3w         |
| ggVG     | yg          | ⬅️       | h           |
| cc       | S           | ➡️       | l           |
| xi       | s           | ⬆️       | k           |
| cl       | s           | ⬇️       | j           |
| dwi      | cw          | $a      | A           |
| dsi      | cs          | ^o      | o           |
| dpi      | cp          | ^i      | I           |
| $a       | A           | ^j      | +           |
| ^k       | -           | jjj     | 3j          |
| kkk      | 3k          | ~~~     | 3~          |

## Installation

| Plugin Manager | Plugin Section |
| --- | --- |
| Packer | `use 'mo42/vim-kaizen'` |
| Lazy.nvim | `{ 'mo42/vim-kaizen' }` |
| Vim-Plug | `Plug 'mo42/vim-kaizen'` |
| Dein.vim | `call dein#add('mo42/vim-kaizen')` |

## Changelog

- v0.0.1 Initial release
- v0.0.2 User function for user-defined patterns

## License

This project is licensed under the MIT License - see the LICENSE file for details.
