-- Reviewed by Claude
-- variables reassigned
return {
	named = function(symbolName)
 assert(type(symbolName) == "string", "Symbols must be created using a string name!")
 local metaProxy = newproxy(true)
 local symbolString = ("Symbol(%s)"):format(symbolName)
 getmetatable(metaProxy).__tostring = function()
 return symbolString
 end
 return metaProxy
	end,
	unnamed = function()
 local metaProxy = newproxy(true)
 getmetatable(metaProxy).__tostring = function()
 return "Unnamed Symbol"
 end
 return metaProxy
	end
}
