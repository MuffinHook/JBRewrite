-- Reviewed by Claude
local InventoryUtils = require(script.Parent.InventoryUtils)
local t = {}
t.__index = t
function t.new(p1)
	local t2 = {}
	setmetatable(t2, t)
	t2.obj = p1
	return t2
end
function t.HasItem(p1, p2)
	return InventoryUtils.doesInventoryValueHave(p1.obj, p2)
end
function t.Destroy(p1) end
return t
