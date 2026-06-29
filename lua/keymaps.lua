local function escape_pattern(text)
    return (text:gsub("([^%w])", "%%%1"))
end

local function get_paragraph_range()
    local cursor_row = vim.api.nvim_win_get_cursor(0)[1]
    local line_count = vim.api.nvim_buf_line_count(0)
    local start_row = cursor_row
    local end_row = cursor_row

    while start_row > 1 do
        local prev_line = vim.api.nvim_buf_get_lines(0, start_row - 2, start_row - 1, false)[1]
        if prev_line == nil or prev_line:match("^%s*$") then
            break
        end
        start_row = start_row - 1
    end

    while end_row < line_count do
        local next_line = vim.api.nvim_buf_get_lines(0, end_row, end_row + 1, false)[1]
        if next_line == nil or next_line:match("^%s*$") then
            break
        end
        end_row = end_row + 1
    end

    while start_row <= end_row do
        local line = vim.api.nvim_buf_get_lines(0, start_row - 1, start_row, false)[1]
        if line ~= nil and not line:match("^%s*$") then
            break
        end
        start_row = start_row + 1
    end

    while end_row >= start_row do
        local line = vim.api.nvim_buf_get_lines(0, end_row - 1, end_row, false)[1]
        if line ~= nil and not line:match("^%s*$") then
            break
        end
        end_row = end_row - 1
    end

    if start_row > end_row then
        return nil
    end

    return start_row, end_row
end

local function get_comment_parts()
    local commentstring = vim.bo.commentstring
    local left, right = commentstring:match("^(.*)%%s(.*)$")
    if left == nil then
        return nil
    end

    return left, right
end

local function apply_paragraph_comment(uncomment)
    local start_row, end_row = get_paragraph_range()
    if start_row == nil then
        return
    end

    local left, right = get_comment_parts()
    if left == nil then
        return
    end

    local escaped_left = escape_pattern(left)
    local lines = vim.api.nvim_buf_get_lines(0, start_row - 1, end_row, false)

    for index, line in ipairs(lines) do
        if not line:match("^%s*$") then
            if uncomment then
                if line:match("^%s*" .. escaped_left) then
                    local content = line:gsub("^%s*" .. escaped_left .. "%s?", "", 1)
                    if right ~= "" and content:sub(-#right) == right then
                        content = content:sub(1, -#right - 1)
                    end
                    lines[index] = content
                end
            else
                local rest = line:gsub("^%s+", "", 1)
                if not rest:match("^" .. escaped_left) then
                    lines[index] = left .. rest .. right
                end
            end
        end
    end

    vim.api.nvim_buf_set_lines(0, start_row - 1, end_row, false, lines)
end

local function comment_paragraph()
    apply_paragraph_comment(false)
end

local function uncomment_paragraph()
    apply_paragraph_comment(true)
end

vim.keymap.set("n", "<leader>cr", "<cmd>CordToggle<CR>", { desc = "Toggle Discord RPC" })
vim.keymap.set("n", "gap", comment_paragraph, { silent = true, desc = "Comment around paragraph" })
vim.keymap.set("n", "gau", uncomment_paragraph, { silent = true, desc = "Uncomment around paragraph" })



vim.api.nvim_create_autocmd("TermOpen", {
    callback = function(args)
        local opts = { buffer = args.buf, noremap = true, silent = true }
        vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], opts)
        vim.keymap.set("t", "<C-w><C-w>", [[<C-\><C-n><C-w>w]], opts)
        vim.keymap.set("n", "i", "<cmd>startinsert<CR>", opts)
    end,
})
