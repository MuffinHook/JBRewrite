-- Reviewed by Claude
return function(...)
	local tbl = {}
	for i = 1, select("#", ...) do
 local vararg = select(i, ...)
 if vararg ~= nil then
 for k, v in pairs(vararg) do
 tbl[k] = v
 end
 end
	end
	return tbl
end