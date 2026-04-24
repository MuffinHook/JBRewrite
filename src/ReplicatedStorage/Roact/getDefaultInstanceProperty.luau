-- Reviewed by Claude
-- variables reassigned
local module1 = require(script.Parent.Symbol).named("Nil")
local tableObj = {}
return function(self, callback)
	local internalData = tableObj[self]
	local state2, newState, currentState
	if internalData then
 local nextState = internalData[callback]
 if nextState == module1 then
 return true, nil
 elseif nextState == nil then
 state2 = Instance.new(self)
 newState, currentState = pcall(function()
 return state2[callback]
 end)
 state2:Destroy()
 if newState then
 if currentState == nil then
 internalData[callback] = module1
 return newState, currentState
 end
 internalData[callback] = currentState
 end
 return newState, currentState
 else
 return true, nextState
 end
	end
	internalData = {}
	tableObj[self] = internalData
	state2 = Instance.new(self)
	newState, currentState = pcall(function()
 return state2[callback]
	end)
	state2:Destroy()
	if newState then
 if currentState == nil then
 internalData[callback] = module1
 return newState, currentState
 end
 internalData[callback] = currentState
	end
	return newState, currentState
end
