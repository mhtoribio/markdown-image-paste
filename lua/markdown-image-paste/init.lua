local M = {}

M.dirname = "images"
M.filename = "img"
M.custom_filename = false

function M.setup(config)
    M.dirname = config.dirname
    M.filename = config.filename
    M.custom_filename = config.custom_filename
end

function M.relative_path(filename)
    return M.dirname .. "/" .. filename
end

function M.file_exists(filename)
   local f = io.open(filename, "r")
   return f ~= nil and io.close(f)
end

function M.getfilename()
    local filename
    math.randomseed(os.time())
    while true do
        if M.custom_filename then
            -- Prompt the user for a filename if custom filename is enabled.
            filename = vim.fn.input("Filename (without extension): "..M.dirname.."/") .. '.png'
        else
            -- Generate a random filename.
            filename = M.filename .. math.random(1, 9999) .. '.png'
        end

        -- Check if the generated filename is unique, and exit the loop if it is.
        if not M.file_exists(M.relative_path(filename)) and filename ~= ".png" then
            break -- Unique filename found, exit the loop.
        elseif M.custom_filename then
            -- Inform the user if the chosen custom filename already exists.
            vim.print("\nFile already exists. Please try a different name.")
        end
    end
    return filename
end

function M.createImageFile()
    local filename = M.getfilename()
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
