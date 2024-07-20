return {
    "windwp/nvim-autopairs",
    config = function()
        -- require("configs.autopairs")
        require("nvim-autopairs").setup({
            map_cr = false
        })
    end
}
