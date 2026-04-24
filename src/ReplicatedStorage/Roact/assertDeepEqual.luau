-- Reviewed by Claude
-- variables reassigned
local function state1(self, callback)
	if typeof(self) == typeof(callback) then
 if typeof(self) == "table" then
 local tableObj = {}
 for k, v in pairs(self) do
 tableObj[k] = true
 local internalData, result2 = state1(v, callback[k])
 if not internalData and result2 then
 return false, result2:gsub("{1}", ("{1}[%s]"):format((tostring(k)))):gsub("{2}", ("{2}[%s]"):format((tostring(k))))
 end
 end
 for k, v in pairs(callback) do
 if not tableObj[k] then
 local newState, currentState = state1(v, self[k])
 if not newState and currentState then
 return false, currentState:gsub("{1}", ("{1}[%s]"):format((tostring(k)))):gsub("{2}", ("{2}[%s]"):format((tostring(k))))
 end
 end
 end
 return true, nil
 elseif self == callback then
 return true, nil
 else
 return false, "{1} ~= {2}"
 end
	else
 return false, ("{1} is of type %s, but {2} is of type %s"):format(typeof(self), (typeof(callback)))
	end
end
return function(self, callback)
	local internalData, result2 = state1(self, callback)
	if not internalData and result2 then
 error(("Values were not deep-equal.\n%s"):format((result2:gsub("{1}", "first"):gsub("{2}", "second"))), 2)
	end
end
