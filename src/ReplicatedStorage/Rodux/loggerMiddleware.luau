-- Reviewed by Claude
local prettyPrint = require(script.Parent.prettyPrint)
local t = {
	outputFunction = print
}
function t.middleware(p1, p2)
	return function(p12)
 local v1 = p1(p12)
 t.outputFunction(("Action dispatched: %s\nState changed to: %s"):format(prettyPrint(p12), prettyPrint(p2:getState())))
 return v1
	end
end
return t