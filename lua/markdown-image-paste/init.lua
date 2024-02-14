
local M = {}

function M.pasteImage()
    vim.print(getreg('+'))
end

return M
