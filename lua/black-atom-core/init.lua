local config = require("black-atom-core.config")
local commands = require("black-atom-core.commands")
local highlights = require("black-atom-core.highlights")
local lib = require("black-atom-core.lib")

local M = {}

---Loads a theme definition into the editor
---@param theme BlackAtomCore.ThemeDefinition
---@return nil
function M.load(theme)
    config.set({ theme = theme.meta.key })
    lib.themes.dev_status_warning(theme.meta)

    highlights.reset()

    vim.termguicolors = true
    vim.g.colors_name = theme.meta.key
    vim.opt.background = theme.meta.appearance

    highlights.setup(theme.colors, config.get())
end

---@param opts BlackAtomCore.Config
---@return nil
function M.setup(opts)
    if not opts then
        config.set(config.default)
    else
        config.set(opts)
    end

    commands.register()
end

---Plugins can register their themes with this function
---@param themes table<string, BlackAtomCore.ThemeMeta>
---@return nil
function M.register_themes(themes)
    config.set({ registered_themes = themes })
end

return M
