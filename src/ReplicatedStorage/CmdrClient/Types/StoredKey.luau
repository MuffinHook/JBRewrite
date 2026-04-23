local Util = require(script.Parent.Parent.Shared.Util)
local t = { "^%a[%w_]*$", "^%$%a[%w_]*$", "^%.%a[%w_]*$", "^%$%.%a[%w_]*$" }
return function(p1) --[[ Line: 10 | Upvalues: t (copy), Util (copy) ]]
	local t2 = {
		Autocomplete = function(p12) --[[ Name: Autocomplete | Line: 12 | Upvalues: p1 (copy) ]]
			return p1.Cmdr.Util.MakeFuzzyFinder(p1.Cmdr.Util.DictionaryKeys(p1:GetStore("vars_used") or {}))(p12)
		end,
		Validate = function(p1) --[[ Name: Validate | Line: 20 | Upvalues: t (ref) ]]
			for i, v in ipairs(t) do
				if p1:match(v) then
					return true
				end
			end
			return false, "Key names must start with an optional modifier: . $ or $. and must begin with a letter."
		end,
		Parse = function(p1) --[[ Name: Parse | Line: 30 ]]
			return p1
		end
	}
	p1:RegisterType("storedKey", t2)
	p1:RegisterType("storedKeys", Util.MakeListableType(t2))
end