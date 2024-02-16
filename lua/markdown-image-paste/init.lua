local M = {}

M.dirname = "images"
M.filename = "img"

function M.setup(config)
    M.dirname = config.dirname
    M.filename = config.filename
end

function M.createImageFile()
    math.randomseed(os.time())
    local filename = M.filename..math.random(1,9999)..'.png'
    local filepath = vim.fn.expand('%:h')..'/'..M.dirname..'/'.. filename
    image = io.open(filepath,"w")
    for key,imgpart in pairs(vim.fn.getreg('+',1,1)) do
        image:write(imgpart:gsub('\n','\0').."")
        image:write('\n')
    end
    image:close()
    return filename
end

local function insertText(text)
    local current_line = vim.api.nvim_win_get_cursor(0)[1]
    local current_col = vim.api.nvim_win_get_cursor(0)[2]
    local current_buf = vim.api.nvim_get_current_buf()

    -- Insert the text at the cursor position
    vim.api.nvim_buf_set_text(current_buf, current_line - 1, current_col, current_line - 1, current_col, {text})
end

function M.pasteImage()
    vim.print("mkdir -p " .. vim.fn.expand('%:h').."/"..M.dirname..'/' )
    os.execute("mkdir -p " .. vim.fn.expand('%:h').."/"..M.dirname..'/' )
    local imgName = M.createImageFile()
    insertText("!["..imgName.."]("..M.dirname.."/"..imgName..")")
end

return M
