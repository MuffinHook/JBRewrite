-- Reviewed by Claude
-- variables reassigned
local Util = require(script.Parent.Parent.Shared.Util)
local sequenceType = Util.MakeSequenceType({
	Prefixes = "# hexColor3 ! brickColor3",
	ValidateEach = function(value, position)
		if value == nil then
			return false, ("Invalid or missing number at position %d in Color3 type."):format(position)
		elseif value < 0 or value > 255 then
			return false, ("Number out of acceptable range 0-255 at position %d in Color3 type."):format(position)
		elseif value % 1 == 0 then
			return true
		else
			return false, ("Number is not an integer at position %d in Color3 type."):format(position)
		end
	end,
	TransformEach = tonumber,
	Constructor = Color3.fromRGB,
	Length = 3
})
local function parseHexDigit(hexString)
	if #hexString == 1 then
		hexString = hexString .. hexString
	end
	return tonumber(hexString, 16)
end
local hexColorType = {
	Transform = function(colorString)
		local redHex, greenHex, blueHex = colorString:match("^#?(%x%x?)(%x%x?)(%x%x?)$")
		return Util.Each(parseHexDigit, redHex, greenHex, blueHex)
	end,
	Validate = function(red, green, blue)
		return if red == nil or green == nil then false else blue ~= nil, "Invalid hex color"
	end,
	Parse = function(...)
		return Color3.fromRGB(...)
	end
}
return function(registry)
	registry:RegisterType("color3", sequenceType)
	registry:RegisterType("color3s", Util.MakeListableType(sequenceType, {
		Prefixes = "# hexColor3s ! brickColor3s"
	}))
	registry:RegisterType("hexColor3", hexColorType)
	registry:RegisterType("hexColor3s", Util.MakeListableType(hexColorType))
end
