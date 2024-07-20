local conditions = require("heirline.conditions")

local colors = require("heirline.colors." .. vim.g.colorscheme)

local Git = {
    condition = conditions.is_git_repo,

    init = function(self)
        self.status_dict = vim.b.gitsigns_status_dict
        self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
    end,

    hl = { fg = colors.orange, bg = colors.left1 },


    { -- git branch name
        provider = function(self)
            return "  " .. self.status_dict.head
        end,
        -- hl = { bold = true }
    },
    -- You could handle delimiters, icons and counts similar to Diagnostics
    {
        condition = function(self)
            return self.has_changes
        end,
        provider = " "
    },
    {
        condition = function(self)
            return self.has_changes
        end,
        provider = "("
    },
    {
        provider = function(self)
            local count = self.status_dict.added or 0
            return count > 0 and ("+" .. count)
        end,
        hl = { fg = colors.git_add },
    },
    {
        condition = function(self)
            local add = self.status_dict.added or 0
            local del = self.status_dict.removed or 0
            local change = self.status_dict.changed or 0
            return (del > 0 or change > 0) and add ~= 0
        end,
        provider = " "
    },
    {
        provider = function(self)
            local count = self.status_dict.removed or 0
            return count > 0 and ("-" .. count)
        end,
        hl = { fg = colors.git_del },
    },
    {
        condition = function(self)
            local del = self.status_dict.removed or 0
            local change = self.status_dict.changed or 0
            return del > 0 and change > 0
        end,
        provider = " "
    },
    {
        provider = function(self)
            local count = self.status_dict.changed or 0
            return count > 0 and ("~" .. count)
        end,
        hl = { colors.git_change },
    },
    {
        condition = function(self)
            return self.has_changes
        end,
        provider = ")",
    },
    -- hl = { bg = colors.left1 }
}

return Git
