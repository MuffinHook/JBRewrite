local InventoryUtils = require(script.Parent.InventoryUtils)
local t = {}
t.__index = t
function t.new(p1) --[[ Line: 6 | Upvalues: t (copy) ]]
	local t2 = {}
	setmetatable(t2, t)
	t2.obj = p1
	return t2
end
function t.HasItem(p1, p2) --[[ Line: 14 | Upvalues: InventoryUtils (copy) ]]
	return InventoryUtils.doesInventoryValueHave(p1.obj, p2)
end
function t.Destroy(p1) --[[ Line: 17 ]] end
return t