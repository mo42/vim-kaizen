# vim-kaizen

`vim-kaizen` is a NeoVim plugin to encourage continuous improvement in your Vim keybindings.
It reminds you to use alternative and better keys for increased productivity and efficiency.

## Features

- Reminds you to unlearn inefficient commands.
- Provides suggestions for better commands.

![vim-kaizen example in Vim editor](.example.png)

Vim commands and their alternatives:

| Command  | Alternative |
| -------- | ----------- |
| d$       | D           |
| y$       | Y           |
| ggVG     | yg          |
| cc       | S           |
| xi       | s           |
| cl       | s           |
| dwi      | cw          |
| dsi      | cs          |
| dpi      | cp          |
| d2wi     | c2w         |
| d3wi     | c3w         |
| ⬅️        | h           |
| ➡️        | l           |
| ⬆️        | k           |
| ⬇️        | j           |
| $a       | A           |
| ^o       | o           |
| ca)      | cab         |
| ca)      | cab         |
| ci)      | cib         |
| ci)      | cib         |
| ca(      | cab         |
| ca(      | cab         |
| ci(      | cib         |
| ^i       | I           |
| $a       | A           |
| j^       | +           |
 
## Installation

#### `vim-plug`

```vim
Plug 'mo42/vim-kaizen'
```
