local colors = require("heirline.colors." .. vim.g.colorscheme)

local M = {}


M.ScrollBar = {
    init = function(self)
        self.mode = vim.fn.mode(1) -- :h mode()
    end,
    static = {
        mode_fg = {
            n = colors.normal_fg,
            i = colors.insert_fg,
            v = colors.visual_fg,
            V = colors.visual_fg,
            ["\22"] = colors.normal_fg,
            c = colors.command_fg,
            s = colors.normal_fg,
            S = colors.normal_fg,
            ["\19"] = "purple",
            R = colors.replace_fg,
            r = colors.normal_fg,
            ["!"] = colors.normal_fg,
            t = colors.normal_fg,
        },
        mode_bg = {
            n = colors.normal_bg,
            i = colors.insert_bg,
            v = colors.visual_bg,
            V = colors.visual_bg,
            ["\22"] = "cyan",
            c = colors.command_bg,
            s = "purple",
            S = "purple",
            ["\19"] = "purple",
            R = colors.replace_bg,
            r = "orange",
            ["!"] = "red",
            t = colors.normal_bg,
        }
    },
    -- %l = current line number
    -- %L = number of lines in the buffer
    -- %c = column number
    -- %P = percentage through file of displayed window
    -- provider = " %7(%l/%3L%):%2c %P ",
    provider = " %P ",
    {
        static = {
            sbar = { '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█' }
            -- Another variant, because the more choice the better.
            -- sbar = { '🭶', '🭷', '🭸', '🭹', '🭺', '🭻' },
        },
        provider = function(self)
            local curr_line = vim.api.nvim_win_get_cursor(0)[1]
            local lines = vim.api.nvim_buf_line_count(0)
            local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
            return string.rep(self.sbar[i], 2)
        end,
        hl = { bg = "#ffffff" }
    },
    {
        provider = " "
    },
    hl = function(self)
        local mode = self.mode:sub(1, 1) -- get only the first mode character
        return { fg = self.mode_fg[mode], bg = self.mode_bg[mode], bold = false, }
    end,

}

M.Ruler = {
    provider = "%(%l/%L%):%2c"
}

return M
