local Type = require(script.Parent.Type)
local Symbol = require(script.Parent.Symbol)
local function noop() --[[ Line: 5 ]]
	return nil
end
local t = {
	UseParentKey = Symbol.named("UseParentKey")
}
function t.iterateElements(p1) --[[ Line: 43 | Upvalues: Type (copy), t (copy), noop (copy) ]]
	if Type.of(p1) == Type.Element then
		local v1 = false
		return function(p12, p2) --[[ Line: 50 | Upvalues: v1 (ref), t (ref), p1 (copy) ]]
			if v1 then
				return nil
			else
				v1 = true
				return t.UseParentKey, p1
			end
		end
	end
	local v2 = typeof(p1)
	if p1 == nil or v2 == "boolean" then
		return noop
	end
	if v2 == "table" then
		return pairs(p1)
	end
	error("Invalid elements")
end
function t.getElementByKey(p1, p2) --[[ Line: 82 | Upvalues: Type (copy), t (copy) ]]
	if p1 == nil or typeof(p1) == "boolean" then
		return nil
	elseif Type.of(p1) == Type.Element then
		if p2 == t.UseParentKey then
			return p1
		else
			return nil
		end
	else
		if typeof(p1) == "table" then
			return p1[p2]
		end
		error("Invalid elements")
	end
end
return t