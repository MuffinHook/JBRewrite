local Util = require(script.Parent.Parent.Shared.Util)
local t = {
	Validate = function(p1) --[[ Name: Validate | Line: 4 ]]
		return p1 ~= nil
	end,
	Parse = function(p1) --[[ Name: Parse | Line: 8 ]]
		return tostring(p1)
	end
}
local t2 = {
	Transform = function(p1) --[[ Name: Transform | Line: 14 ]]
		return tonumber(p1)
	end,
	Validate = function(p1) --[[ Name: Validate | Line: 18 ]]
		return p1 ~= nil
	end,
	Parse = function(p1) --[[ Name: Parse | Line: 22 ]]
		return p1
	end
}
local t3 = {
	Transform = function(p1) --[[ Name: Transform | Line: 28 ]]
		return tonumber(p1)
	end,
	Validate = function(p1) --[[ Name: Validate | Line: 32 ]]
		return if p1 == nil then false else p1 == math.floor(p1), "Only whole numbers are valid."
	end,
	Parse = function(p1) --[[ Name: Parse | Line: 36 ]]
		return p1
	end
}
local t4 = {
	Transform = function(p1) --[[ Name: Transform | Line: 42 ]]
		return tonumber(p1)
	end,
	Validate = function(p1) --[[ Name: Validate | Line: 46 ]]
		return if p1 == nil or p1 ~= math.floor(p1) then false else p1 > 0, "Only positive whole numbers are valid."
	end,
	Parse = function(p1) --[[ Name: Parse | Line: 50 ]]
		return p1
	end
}
local t5 = {
	Transform = function(p1) --[[ Name: Transform | Line: 56 ]]
		return tonumber(p1)
	end,
	Validate = function(p1) --[[ Name: Validate | Line: 60 ]]
		return if p1 == nil or p1 ~= math.floor(p1) then false else p1 >= 0, "Only non-negative whole numbers are valid."
	end,
	Parse = function(p1) --[[ Name: Parse | Line: 64 ]]
		return p1
	end
}
local t6 = {
	Transform = function(p1) --[[ Name: Transform | Line: 70 ]]
		return tonumber(p1)
	end,
	Validate = function(p1) --[[ Name: Validate | Line: 74 ]]
		return if p1 == nil or (p1 ~= math.floor(p1) or not (p1 >= 0)) then false else p1 <= 255, "Only bytes are valid."
	end,
	Parse = function(p1) --[[ Name: Parse | Line: 78 ]]
		return p1
	end
}
local t7 = {
	Transform = function(p1) --[[ Name: Transform | Line: 84 ]]
		return tonumber(p1)
	end,
	Validate = function(p1) --[[ Name: Validate | Line: 88 ]]
		return if p1 == nil or (p1 ~= math.floor(p1) or not (p1 >= 0)) then false else p1 <= 9, "Only digits are valid."
	end,
	Parse = function(p1) --[[ Name: Parse | Line: 92 ]]
		return p1
	end
}
local v1 = Util.MakeDictionary({
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
local v2 = Util.MakeDictionary({
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
local t8 = {
	Transform = function(p1) --[[ Name: Transform | Line: 103 ]]
		return p1:lower()
	end,
	Validate = function(p1) --[[ Name: Validate | Line: 107 | Upvalues: v1 (copy), v2 (copy) ]]
		return if v1[p1] == nil then v2[p1] ~= nil else true, "Please use true/yes/on or false/no/off."
	end,
	Parse = function(p1) --[[ Name: Parse | Line: 111 | Upvalues: v1 (copy), v2 (copy) ]]
		if v1[p1] then
			return true
		elseif v2[p1] then
			return false
		else
			return nil
		end
	end
}
return function(p1) --[[ Line: 123 | Upvalues: t (copy), t2 (copy), t3 (copy), t4 (copy), t5 (copy), t6 (copy), t7 (copy), t8 (ref), Util (copy) ]]
	p1:RegisterType("string", t)
	p1:RegisterType("number", t2)
	p1:RegisterType("integer", t3)
	p1:RegisterType("positiveInteger", t4)
	p1:RegisterType("nonNegativeInteger", t5)
	p1:RegisterType("byte", t6)
	p1:RegisterType("digit", t7)
	p1:RegisterType("boolean", t8)
	p1:RegisterType("strings", Util.MakeListableType(t))
	p1:RegisterType("numbers", Util.MakeListableType(t2))
	p1:RegisterType("integers", Util.MakeListableType(t3))
	p1:RegisterType("positiveIntegers", Util.MakeListableType(t4))
	p1:RegisterType("nonNegativeIntegers", Util.MakeListableType(t5))
	p1:RegisterType("bytes", Util.MakeListableType(t6))
	p1:RegisterType("digits", Util.MakeListableType(t7))
	p1:RegisterType("booleans", Util.MakeListableType(t8))
end