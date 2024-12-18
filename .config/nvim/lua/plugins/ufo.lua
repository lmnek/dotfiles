-- Custom line handler - count lines in fold
local handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = (' 󰁂 %d '):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
        else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, { suffix, 'MoreMsg' })
    return newVirtText
end

return {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    opts = {
        fold_virt_text_handler = handler,
        provider_selector = function(bufnr, filetype, buftype)
            if filetype == 'tex' then
                return '' -- no provider from ufo -> vimtex
            else
                return { 'treesitter', 'indent' }
            end
        end,
        preview = {
            win_config = {
                winblend = 0
            }
        },
    },
    init = function()
        -- vim.o.foldcolumn = '1'
        vim.o.foldlevel = 99
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true
    end,
    config = function(_, opts)
        require('ufo').setup(opts)
    end,
    keys = {
        { 'za' }, -- toggle fold -> need to press twice to activate plugin
        { 'zR', function() require('ufo').openAllFolds() end,  desc = 'Open all folds' },
        { 'zM', function() require('ufo').closeAllFolds() end, desc = 'Close all folds' },
        {
            'zk',
            function()
                local winid = require('ufo').peekFoldedLinesUnderCursor(true)
                if not winid then
                    vim.lsp.buf.hover()
                end
            end,
            desc = 'Inspect fold'
        },
    }
}
