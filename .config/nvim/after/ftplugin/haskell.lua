local ok, telescope = pcall(require, "telescope")
if ok then
    telescope.load_extension("ht")
end

local ht = require('haskell-tools')
local opts = {
    mode = 'n',
    prefix = ',',
    noremap = true,
    silent = true,
    buffer = vim.api.nvim_get_current_buf()
}

local toggle_repl_for_file = function()
    ht.repl.toggle(vim.api.nvim_buf_get_name(0))
    -- ht.repl.toggle(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()))
end

require('which-key').add({
    -- haskell-language-server relies heavily on codeLenses,
    -- so auto-refresh (see advanced configuration) is enabled by default
    { ",l",  vim.lsp.codelens.run,       desc = 'Use (run) lens' },
    -- Hoogle search for the type signature of the definition under the cursor
    { ",h",  ht.hoogle.hoogle_signature, desc = 'Hoogle this type sig.' },
    { ",e",  ht.lsp.buf_eval_all,        desc = 'Eval all snippets' },

    { ",r",  group = '+GHCi REPL' },
    { ",rt", ht.repl.toggle,             desc = 'Toggle for package' },
    { ",rr", toggle_repl_for_file,       desc = 'Toggle for buffer' },
    { ",rl", ht.repl.reload,             desc = 'Reload' },
    { ",rp", ht.repl.paste,              desc = 'Paste' },
    { ",rP", ht.repl.paste_type,         desc = 'Paste type' },
    { ",rw", ht.repl.cword_type,         desc = 'Type under cursor' },
    { ",rq", ht.repl.quit,               desc = 'Quit REPL' },

    -- { ",d",  "<Plug>HaskellHoverActionDocs", desc = "Open docs in browser" }
}, opts)

-- TODO:
-- vim.keymap.set('n', ',rd', '<Plug>HaskellHoverActionDocs')

-- dont know how to increase opacity?
vim.api.nvim_set_hl(0, 'LspCodeLens', { fg = '#5B4B8B', underline = false, italic = true, bold = true })
