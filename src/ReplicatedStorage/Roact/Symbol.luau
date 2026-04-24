-- Reviewed by Claude
return {
	named = function(self)
 assert(type(self) == "string", "Symbols must be created using a string name!")
 local metaProxy = newproxy(true)
 local newState = ("Symbol(%s)"):format(self)
 getmetatable(metaProxy).__tostring = function()
 return newState
 end
 return metaProxy
	end
}
