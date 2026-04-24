-- Reviewed by Claude
return function()
	local t = {}
	local t2 = {}
	local v1 = false
	return {
 subscribe = function(p1, p2)
 assert(typeof(p2) == "function", "Can only subscribe to signals with a function.")
 local t3 = {
 callback = p2,
 disconnected = false
 }
 if v1 and not t[p2] then
 t2[p2] = t3
 end
 t[p2] = t3
 return function()
 assert(not t3.disconnected, "Listeners can only be disconnected once.")
 t3.disconnected = true
 t[p2] = nil
 t2[p2] = nil
 end
 end,
 fire = function(p1, ...)
 v1 = true
 for k, v in pairs(t) do
 if not (v.disconnected or t2[k]) then
 k(...)
 end
 end
 v1 = false
 for k, v in pairs(t2) do
 t2[k] = nil
 end
 end
	}
end