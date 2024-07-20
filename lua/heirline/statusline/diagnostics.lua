local conditions = require("heirline.conditions")
local colors = require("heirline.colors." .. vim.g.colorscheme)

local Diagnostics = {

    condition = conditions.has_diagnostics,

    static = {
        error_icon = vim.fn.sign_getdefined("DiagnosticSignError")[1].text,
        warn_icon = vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text,
        info_icon = vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text,
        hint_icon = vim.fn.sign_getdefined("DiagnosticSignHint")[1].text,
    },

    init = function(self)
        self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
        self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
        self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
    end,
    update = { "DiagnosticChanged", "BufEnter" },

    {
        provider = " ![",
    },
    -- error
    {
        provider = function(self)
            -- 0 is just another output, we can decide to print it or not!
            return self.errors > 0 and (self.error_icon .. self.errors)
        end,
        hl = { fg = colors.red },
    },
    {
        condition = function(self)
            -- local g = conditions.has_diagnostics
            local err = self.errors
            local warn = self.warnings
            local info = self.info
            return (warn > 0 or info > 0) and err ~= 0
        end,
        provider = " "
    },
    -- warning
    {
        provider = function(self)
            return self.warnings > 0 and (self.warn_icon .. self.warnings)
        end,
        hl = { fg = colors.yellow }

    },
    {
        condition = function(self)
            -- local g = conditions.has_diagnostics
            local err = self.errors > 0
            local inf = self.info > 0
            local warn = self.warnings > 0
            return inf and warn
        end,
        provider = " "
    },
    -- info
    {
        provider = function(self)
            return self.info > 0 and (self.info_icon .. self.info)
        end,
        hl = { fg = colors.green },
    },
    -- {
    --     condition = function(self)
    --         -- local g = conditions.has_diagnostics
    --         -- local err = self.errors > 0
    --         local warn = self.warnings > 0
    --         local info = self.info > 0
    --         return warn or info
    --     end,
    --     provider = " "
    -- },
    -- -- hint
    -- {
    --     provider = function(self)
    --         return self.hints > 0 and (self.hint_icon .. self.hints)
    --     end,
    --     hl = { fg = colors.blue },
    -- },
    {
        provider = "] ",
    }
}


return Diagnostics
