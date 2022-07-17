local M = {}

---Apply the colorscheme (same as ':colorscheme terra')
M.colorscheme = function()
	local sync_vim_opt_background_with_terra_time =
		require(
			"terra.actions.config"
		).sync_vim_opt_background_with_terra_time

	-- Clear all highlights
	vim.cmd("hi clear")

	-- Reset syntax highlighting
	if vim.fn.exists("syntax_on") then
		vim.cmd("syntax reset")
	end

	-- Set vim options
	vim.o.termguicolors = true

	-- Set "terra" to the vim `colors_name` global variable
	vim.g.colors_name = "terra"

	sync_vim_opt_background_with_terra_time(vim.o.background)

	-- Now set up the highlights and terminal
	require("terra.highlights").setup()
	require("terra.terminal").setup()
end

---Setup terra.nvim options, without applying colorscheme
---@param opts table: a table containing options
---@return nil
M.setup = function(opts)
	local actions = require("terra.actions")

	local default_config = require("terra.config").default_config

	-- If it's the first time setup() is called, load the default config
	if not vim.g.terra_config or not vim.g.terra_config.loaded then
		vim.g.terra_config = vim.tbl_deep_extend(
			"keep",
			-- FIX: is this really correct? `vim.g.terra_config` must be undefined at this point
			vim.g.terra_config or {},
			default_config
		)

		-- Mark the theme as loaded
		actions.config.set_options({
			loaded = true,
		})
	end

	-- If there are defined options, set them in the global config
	if opts then
		actions.config.set_options(opts)
	end

	-- Set the select season binding from config
	vim.api.nvim_set_keymap(
		"n",
		vim.g.terra_config.select_season,
		'<cmd>lua require("terra.actions.config").select_season()<CR>',
		{ noremap = true, silent = true }
	)
end

---Loads the colorscheme
---@return nil
M.load = function()
	vim.api.nvim_command("colorscheme terra")
end

return M
