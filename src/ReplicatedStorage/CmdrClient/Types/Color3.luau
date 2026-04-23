local Util = require(script.Parent.Parent.Shared.Util)
local v1 = Util.MakeSequenceType({
	Prefixes = "# hexColor3 ! brickColor3",
	ValidateEach = function(p1, p2) --[[ Name: ValidateEach | Line: 5 ]]
		if p1 == nil then
			return false, ("Invalid or missing number at position %d in Color3 type."):format(p2)
		elseif p1 < 0 or p1 > 255 then
			return false, ("Number out of acceptable range 0-255 at position %d in Color3 type."):format(p2)
		elseif p1 % 1 == 0 then
			return true
		else
			return false, ("Number is not an integer at position %d in Color3 type."):format(p2)
		end
	end,
	TransformEach = tonumber,
	Constructor = Color3.fromRGB,
	Length = 3
})
local function parseHexDigit(p1) --[[ Line: 21 ]]
	if #p1 == 1 then
		p1 = p1 .. p1
	end
	return tonumber(p1, 16)
end
local t = {
	Transform = function(p1) --[[ Name: Transform | Line: 30 | Upvalues: Util (copy), parseHexDigit (copy) ]]
		local v1, v2, v3 = p1:match("^#?(%x%x?)(%x%x?)(%x%x?)$")
		return Util.Each(parseHexDigit, v1, v2, v3)
	end,
	Validate = function(p1, p2, p3) --[[ Name: Validate | Line: 35 ]]
		return if p1 == nil or p2 == nil then false else p3 ~= nil, "Invalid hex color"
	end,
	Parse = function(...) --[[ Name: Parse | Line: 39 ]]
		return Color3.fromRGB(...)
	end
}
return function(p1) --[[ Line: 44 | Upvalues: v1 (copy), Util (copy), t (copy) ]]
	p1:RegisterType("color3", v1)
	p1:RegisterType("color3s", Util.MakeListableType(v1, {
		Prefixes = "# hexColor3s ! brickColor3s"
	}))
	p1:RegisterType("hexColor3", t)
	p1:RegisterType("hexColor3s", Util.MakeListableType(t))
end