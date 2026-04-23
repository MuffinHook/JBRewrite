local prettyPrint = require(script.Parent.prettyPrint)
local t = {
	outputFunction = print
}
function t.middleware(p1, p2) --[[ Line: 10 | Upvalues: t (copy), prettyPrint (copy) ]]
	return function(p12) --[[ Line: 11 | Upvalues: p1 (copy), t (ref), prettyPrint (ref), p2 (copy) ]]
		local v1 = p1(p12)
		t.outputFunction(("Action dispatched: %s\nState changed to: %s"):format(prettyPrint(p12), prettyPrint(p2:getState())))
		return v1
	end
end
return t