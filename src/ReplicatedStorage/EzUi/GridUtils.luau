local t = {
	getRowRatio = function(p1) --[[ Name: getRowRatio | Line: 3 ]]
		local v1 = p1.verticalPaddingRatio * p1.aspectRatio
		return 1 / (1 / (p1.aspectRatio * p1.rowsPerPage) - 1 / v1 - 1 / (v1 * p1.rowsPerPage))
	end
}
function t.getColRatio(p1, p2) --[[ Line: 7 | Upvalues: t (copy) ]]
	local v1 = p1.verticalPaddingRatio * p1.aspectRatio
	local v2 = p2 or t.getRowRatio(p1)
	return v2 / p1.colsPerRow - v2 / v1 - v2 / v1 / p1.colsPerRow
end
function t.getScaleX(p1) --[[ Line: 12 ]]
	local v1 = p1.verticalPaddingRatio * p1.aspectRatio
	return 1 / p1.colsPerRow - 1 / v1 - 1 / v1 / p1.colsPerRow
end
return t