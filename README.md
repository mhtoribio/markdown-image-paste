# :warning: this is a pre alpha MVP plugin, i made it in 5 hours!
# Markdown-image-paste
Markdown-image-paste is a neovim plugin, that saves an in your clipboard to a folder local to your markdown file, and then includes it in said markdown file.

# Usage
don't

but if you do:

install using whatever plugin manager you want.

### Lazy
```
require('lazy').setup({
    'fred441a/markdown-image-paste'
})
```

### Packer
```
use 'fred441a/markdown-image-paste'
```

### plug
```
Plug 'fred441a/markdown-image-paste'
```


## config
use code snippet to bind to ctrl-i
```lua
vim.api.nvim_set_keymap('n','<C-i>', "<cmd>lua require('markdown-image-paste').pasteImage()<CR>", {noremap = true})
```


# Future feature list
 - [x] check if data in clipboard is image before pasting
 - [ ] check if file is markdown file
 - [ ] check if image in clipboard already has been saved to file before ( reuse old files )
 - [x] file name collision detection and resolution
 - [x] prompt user for custom file name
 - [ ] support for other rich text formats (fx latex, RTF)
