-- Reviewed by Claude
return {
	named = function(p1)
 assert(type(p1) == "string", "Symbols must be created using a string name!")
 local metaProxy = newproxy(true)
 local v3 = ("Symbol(%s)"):format(p1)
 getmetatable(metaProxy).__tostring = function()
 return v3
 end
 return metaProxy
	end,
	unnamed = function()
 local metaProxy2 = newproxy(true)
 getmetatable(metaProxy2).__tostring = function()
 return "Unnamed Symbol"
 end
 return metaProxy2
	end
}