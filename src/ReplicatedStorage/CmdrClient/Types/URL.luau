-- Reviewed by Claude
local Util = require(script.Parent.Parent.Shared.Util)
local t = {
	Validate = function(p1)
		if p1:match("^https?://.+$") then
			return true
		else
			return false, "URLs must begin with http:// or https://"
		end
	end,
	Parse = function(p1)
		return p1
	end
}
return function(p1)
	p1:RegisterType("url", t)
	p1:RegisterType("urls", Util.MakeListableType(t))
end
