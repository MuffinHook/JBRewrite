local Util = require(script.Parent.Parent.Shared.Util)
local urlType = {
	Validate = function(url)
		if url:match("^https?://.+$") then
			return true
		else
			return false, "URLs must begin with http:// or https://"
		end
	end,
	Parse = function(url)
		return url
	end
}
return function(typeRegistry)
	typeRegistry:RegisterType("url", urlType)
	typeRegistry:RegisterType("urls", Util.MakeListableType(urlType))
end
