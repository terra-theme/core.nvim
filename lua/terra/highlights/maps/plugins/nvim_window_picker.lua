-- Repository: https://github.com/s1n7ax/nvim-window-picker

---@type TerraHighlightsSpec
local highlight_map_spec = {
    enabled = true,

    map = function(colors)
        ---@type TerraHighlights
        local highlights_map = {
            -- these doesnt work. I commented on a closed issue about this
            -- [fix highlight not modifiable #27](https://github.com/s1n7ax/nvim-window-picker/pull/27)
            NvimWindoSwitch = { fg = colors.semantics.fg.primary.main, bg = colors.semantics.bg.secondary.main },
            NvimWindoSwitchNC = { fg = colors.semantics.fg.invert, bg = colors.semantics.bg.active },
        }

        return highlights_map
    end,
}

return highlight_map_spec
