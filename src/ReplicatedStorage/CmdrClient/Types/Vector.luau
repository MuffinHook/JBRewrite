-- Reviewed by Claude
local Util = require(script.Parent.Parent.Shared.Util)
local function validateVector(p1, p2)
	if p1 == nil then
		return false, ("Invalid or missing number at position %d in Vector type."):format(p2)
	else
		return true
	end
end
local v1 = Util.MakeSequenceType({
	ValidateEach = validateVector,
	TransformEach = tonumber,
	Constructor = Vector3.new,
	Length = 3
})
local v2 = Util.MakeSequenceType({
	ValidateEach = validateVector,
	TransformEach = tonumber,
	Constructor = Vector2.new,
	Length = 2
})
return function(p1)
	p1:RegisterType("vector3", v1)
	p1:RegisterType("vector3s", Util.MakeListableType(v1))
	p1:RegisterType("vector2", v2)
	p1:RegisterType("vector2s", Util.MakeListableType(v2))
end
