-- Reviewed by Claude
-- variables reassigned
return function(self, callback)
	local varType = callback or tostring(self)
	return setmetatable(self, {
 __index = function(self, callback)
 error(("%q (%s) is not a valid member of %s"):format(tostring(callback), typeof(callback), varType), 2)
 end,
 __newindex = function(self, callback, self)
 error(("%q (%s) is not a valid member of %s"):format(tostring(callback), typeof(callback), varType), 2)
 end
	})
end
