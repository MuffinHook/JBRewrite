-- Reviewed by Claude
-- variables reassigned
return function()
	local tableObj = {}
	local tbl2 = {}
	local var1 = false
	return {
 subscribe = function(self, callback)
 assert(typeof(callback) == "function", "Can only subscribe to signals with a function.")
 local metadata = {
 callback = callback,
 disconnected = false
 }
 if var1 and not tableObj[callback] then
 tbl2[callback] = metadata
 end
 tableObj[callback] = metadata
 return function()
 assert(not metadata.disconnected, "Listeners can only be disconnected once.")
 metadata.disconnected = true
 tableObj[callback] = nil
 tbl2[callback] = nil
 end
 end,
 fire = function(self, ...)
 var1 = true
 for k, v in pairs(tableObj) do
 if not (v.disconnected or tbl2[k]) then
 k(...)
 end
 end
 var1 = false
 for k, v in pairs(tbl2) do
 tbl2[k] = nil
 end
 end
	}
end
