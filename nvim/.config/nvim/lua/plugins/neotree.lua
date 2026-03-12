return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        lazy = false,
        keys = {
            { "<C-t>", ":Neotree toggle<CR>", mode = "n" }
        },
        opts = {
            window = {
                position = "right",
                width = 25,
            },
        }
    }
}
