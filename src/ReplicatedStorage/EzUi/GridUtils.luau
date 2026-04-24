-- Reviewed by Claude
local GridUtils = {
	getRowRatio = function(config)
		local paddingScale = config.verticalPaddingRatio * config.aspectRatio
		return 1 / (1 / (config.aspectRatio * config.rowsPerPage) - 1 / paddingScale - 1 / (paddingScale * config.rowsPerPage))
	end
}
function GridUtils.getColRatio(config, rowRatio)
	local paddingScale = config.verticalPaddingRatio * config.aspectRatio
	local actualRowRatio = rowRatio or GridUtils.getRowRatio(config)
	return actualRowRatio / config.colsPerRow - actualRowRatio / paddingScale - actualRowRatio / paddingScale / config.colsPerRow
end
function GridUtils.getScaleX(config)
	local paddingScale = config.verticalPaddingRatio * config.aspectRatio
	return 1 / config.colsPerRow - 1 / paddingScale - 1 / paddingScale / config.colsPerRow
end
return GridUtils
