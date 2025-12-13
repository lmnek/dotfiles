return {
    "chomosuke/typst-preview.nvim",
    cmd = { "TypstPreview", "TypstPreviewToggle", "TypstPreviewUpdate" },
    keys = {
        {
            "<leader>lt",
            ft = "typst",
            "<cmd>TypstPreviewToggle<cr>",
            desc = "Toggle Typst Preview",
        },
    },
    build = function() require("typst-preview").update() end,
    opts = {
        dependencies_bin = {
            tinymist = "tinymist",
        },
    },
}
