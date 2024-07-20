return {
    "nvim-treesitter/nvim-treesitter",
    opts = {
        -- ensure_installed = { "lua", "python", "bash", "c++", "rust",
        --     "javascript", "css", "typescript" },
        -- sync_install = false,
        -- auto_install = true,
    },
    build = function()
        require("nvim-treesitter.install").update({ with_sync = true })
    end,
    config = function()
        if vim.fn.has("win32") == 1 then
            require 'nvim-treesitter.install'.compilers = { "clang" }
        end
        require 'nvim-treesitter.configs'.setup {
            -- A list of parser names, or "all"
            ensure_installed = { "lua", "python", "rust", "bash", "cpp",
                "javascript", "css", "typescript" },
            context_commentstring = {
                enable = true
            },
            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,
            -- Automatically install missing parsers when entering buffer
            -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
            auto_install = false,
            -- List of parsers to ignore installing (for "all")
            ignore_install = {},
            ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
            -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!
            highlight = {
                -- `false` will disable the whole extension
                enable = true,
                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Instead of true it can also be a list of languages
                additional_vim_regex_highlighting = false,
            },
        }
    end
}
