utils = {}
function installed(plugin)
	-- local plugin_table = packer_plugins[plugin]
	-- return plugin_table and plugin_table.loaded
	return true
end
utils.installed = installed

return utils
