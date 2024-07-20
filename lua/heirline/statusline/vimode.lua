local colors = require("heirline.colors." .. vim.g.colorscheme)

local ViMode = {
    -- get vim current mode, this information will be required by the provider
    -- and the highlight functions, so we compute it only once per component
    -- evaluation and store it as a component attribute
    init = function(self)
        self.mode = vim.fn.mode(1) -- :h mode()
    end,
    -- Now we define some dictionaries to map the output of mode() to the
    -- corresponding string and color. We can put these into `static` to compute
    -- them at initialisation time.
    static = {
        mode_names = { -- change the strings if you like it vvvvverbose!
            n = "NORMAL",
            no = "O-PENDING",
            nov = "N?",
            noV = "N?",
            ["no\22"] = "N?",
            niI = "Ni",
            niR = "Nr",
            niV = "Nv",
            nt = "Nt",
            v = "VISUAL",
            vs = "Vs",
            V = "V-LINE",
            Vs = "Vs",
            ["\22"] = "^V",
            ["\22s"] = "^V",
            s = "S",
            S = "S_",
            ["\19"] = "^S",
            i = "INSERT",
            ic = "Ic",
            ix = "Ix",
            R = "REPLACE",
            Rc = "Rc",
            Rx = "Rx",
            Rv = "Rv",
            Rvc = "Rv",
            Rvx = "Rv",
            c = "COMMAND",
            cv = "Ex",
            r = "...",
            rm = "M",
            ["r?"] = "?",
            ["!"] = "!",
            t = "TERMINAL",
        },
        mode_fg = {
            n = colors.normal_fg,
            i = colors.insert_fg,
            v = colors.visual_fg,
            V = colors.visual_fg,
            ["\22"] = colors.normal_fg,
            c = colors.command_fg,
            s = colors.normal_fg,
            S = colors.normal_fg,
            ["\19"] = colors.normal_fg,
            R = colors.replace_fg,
            r = colors.visual_fg,
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
            r = colors.replace_bg,
            ["!"] = "red",
            t = colors.normal_bg,
        }
    },
    -- We can now access the value of mode() that, by now, would have been
    -- computed by `init()` and use it to index our strings dictionary.
    -- note how `static` fields become just regular attributes once the
    -- component is instantiated.
    -- To be extra meticulous, we can also add some vim statusline syntax to
    -- control the padding and make sure our string is always at least 2
    -- characters long. Plus a nice Icon.
    provider = function(self)
        -- return "  %2(" .. self.mode_names[self.mode] .. "%) "
        return " %2(" .. self.mode_names[self.mode] .. "%) "
    end,
    -- Same goes for the highlight. Now the foreground will change according to the current mode.
    hl = function(self)
        local mode = self.mode:sub(1, 1) -- get only the first mode character
        return { fg = self.mode_fg[mode], bg = self.mode_bg[mode], bold = true, }
    end,
    -- Re-evaluate the component only on ModeChanged event!
    -- Also allows the statusline to be re-evaluated when entering operator-pending mode
    update = {
        "ModeChanged",
        pattern = "*:*",
        callback = vim.schedule_wrap(function()
            vim.cmd("redrawstatus")
        end),
    },
}

return ViMode
