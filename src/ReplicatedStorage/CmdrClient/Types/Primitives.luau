-- Reviewed by Claude
-- variables reassigned
local Util = require(script.Parent.Parent.Shared.Util)
local stringType = {
	Validate = function(value)
		return value ~= nil
	end,
	Parse = function(value)
		return tostring(value)
	end
}
local numberType = {
	Transform = function(value)
		return tonumber(value)
	end,
	Validate = function(value)
		return value ~= nil
	end,
	Parse = function(value)
		return value
	end
}
local integerType = {
	Transform = function(value)
		return tonumber(value)
	end,
	Validate = function(value)
		return if value == nil then false else value == math.floor(value), "Only whole numbers are valid."
	end,
	Parse = function(value)
		return value
	end
}
local positiveIntegerType = {
	Transform = function(value)
		return tonumber(value)
	end,
	Validate = function(value)
		return if value == nil or value ~= math.floor(value) then false else value > 0, "Only positive whole numbers are valid."
	end,
	Parse = function(value)
		return value
	end
}
local nonNegativeIntegerType = {
	Transform = function(value)
		return tonumber(value)
	end,
	Validate = function(value)
		return if value == nil or value ~= math.floor(value) then false else value >= 0, "Only non-negative whole numbers are valid."
	end,
	Parse = function(value)
		return value
	end
}
local byteType = {
	Transform = function(value)
		return tonumber(value)
	end,
	Validate = function(value)
		return if value == nil or (value ~= math.floor(value) or not (value >= 0)) then false else value <= 255, "Only bytes are valid."
	end,
	Parse = function(value)
		return value
	end
}
local digitType = {
	Transform = function(value)
		return tonumber(value)
	end,
	Validate = function(value)
		return if value == nil or (value ~= math.floor(value) or not (value >= 0)) then false else value <= 9, "Only digits are valid."
	end,
	Parse = function(value)
		return value
	end
}
local trueValues = Util.MakeDictionary({
	"true",
	"t",
	"yes",
	"y",
	"on",
	"enable",
	"enabled",
	"1",
	"+"
})
local falseValues = Util.MakeDictionary({
	"false",
	"f",
	"no",
	"n",
	"off",
	"disable",
	"disabled",
	"0",
	"-"
})
local booleanType = {
	Transform = function(value)
		return value:lower()
	end,
	Validate = function(value)
		return if trueValues[value] == nil then falseValues[value] ~= nil else true, "Please use true/yes/on or false/no/off."
	end,
	Parse = function(value)
		if trueValues[value] then
			return true
		elseif falseValues[value] then
			return false
		else
			return nil
		end
	end
}
return function(typeRegistry)
	typeRegistry:RegisterType("string", stringType)
	typeRegistry:RegisterType("number", numberType)
	typeRegistry:RegisterType("integer", integerType)
	typeRegistry:RegisterType("positiveInteger", positiveIntegerType)
	typeRegistry:RegisterType("nonNegativeInteger", nonNegativeIntegerType)
	typeRegistry:RegisterType("byte", byteType)
	typeRegistry:RegisterType("digit", digitType)
	typeRegistry:RegisterType("boolean", booleanType)
	typeRegistry:RegisterType("strings", Util.MakeListableType(stringType))
	typeRegistry:RegisterType("numbers", Util.MakeListableType(numberType))
	typeRegistry:RegisterType("integers", Util.MakeListableType(integerType))
	typeRegistry:RegisterType("positiveIntegers", Util.MakeListableType(positiveIntegerType))
	typeRegistry:RegisterType("nonNegativeIntegers", Util.MakeListableType(nonNegativeIntegerType))
	typeRegistry:RegisterType("bytes", Util.MakeListableType(byteType))
	typeRegistry:RegisterType("digits", Util.MakeListableType(digitType))
	typeRegistry:RegisterType("booleans", Util.MakeListableType(booleanType))
end
