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
	end
}