-- Reviewed by Claude
return {
	named = function(p1)
 assert(type(p1) == "string", "Symbols must be created using a string name!")
 local v2 = newproxy(true)
 local v3 = ("Symbol(%s)"):format(p1)
 getmetatable(v2).__tostring = function()
 return v3
 end
 return v2
	end,
	unnamed = function()
 local v1 = newproxy(true)
 getmetatable(v1).__tostring = function()
 return "Unnamed Symbol"
 end
 return v1
	end
}