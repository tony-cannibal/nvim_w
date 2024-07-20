return {
    "nvim-tree/nvim-tree.lua",
    cmd = "NvimTreeToggle",
    config = function()
        local nvim_tree = require("nvim-tree")
        -- local nvim_tree_config = require("nvim-tree.config")
        -- local tree_cb = nvim_tree_config.nvim_tree_callback

        local function on_attach(bufnr)
            local api = require('nvim-tree.api')

            local function opts(desc)
                return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
            end
            vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
            vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
            vim.keymap.set('n', '<BS>', api.node.navigate.parent_close, opts('Close Directory'))
            vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Directory'))
            vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
            vim.keymap.set('n', 'r', api.fs.remove, opts('Remove'))
        end

        nvim_tree.setup {
            on_attach = on_attach,
            update_focused_file = {
                enable = true,
                update_cwd = true,
            },
            renderer = {
                root_folder_modifier = ":t",
                icons = {
                    glyphs = {
                        default = "",
                        symlink = "",
                        folder = {
                            arrow_open = "",
                            arrow_closed = "",
                            default = "",
                            open = "",
                            empty = "",
                            empty_open = "",
                            symlink = "",
                            symlink_open = "",
                        },
                        git = {
                            unstaged = "",
                            staged = "S",
                            unmerged = "",
                            renamed = "➜",
                            untracked = "U",
                            deleted = "",
                            ignored = "◌",
                        },
                    },
                },
                indent_markers = {
                    enable = true,
                },
            },
            diagnostics = {
                enable = true,
                show_on_dirs = true,
                icons = {
                    hint = "",
                    info = "",
                    warning = "",
                    error = "",
                },
            },
            view = {
                width = 30,
                side = "left",
                -- mappings = {
                --     list = {
                --         { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
                --         { key = "h",                  cb = tree_cb "close_node" },
                --         { key = "v",                  cb = tree_cb "vsplit" },
                --     },
                -- },
            },
            actions = {
                open_file = {
                    quit_on_open = true,
                },
            }
        }
    end
}
