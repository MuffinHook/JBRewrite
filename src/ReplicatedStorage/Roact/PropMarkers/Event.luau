-- Reviewed by Claude
-- variables reassigned
local Type = require(script.Parent.Parent.Type)
local tableObj = {}
local tbl2 = {
	__tostring = function(self)
 return ("RoactHostEvent(%s)"):format(self.name)
	end
}
setmetatable(tableObj, {
	__index = function(self, callback)
 local metadata = {
 [Type] = Type.HostEvent,
 name = callback
 }
 setmetatable(metadata, tbl2)
 tableObj[callback] = metadata
 return metadata
	end
})
return tableObj
