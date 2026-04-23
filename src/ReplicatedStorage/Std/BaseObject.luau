local Maid = require(script.Parent.Maid)
local t = {
	ClassName = "BaseObject"
}
t.__index = t
function t.new(p1) --[[ Line: 8 | Upvalues: t (copy), Maid (copy) ]]
	local v2 = setmetatable({}, t)
	v2.maid = Maid.new()
	v2.obj = p1
	return v2
end
function t.Destroy(p1) --[[ Line: 17 ]]
	p1.maid:DoCleaning()
	setmetatable(p1, nil)
end
return t