-- Reviewed by Claude
local assign = require(script.Parent.assign)
local None = require(script.Parent.None)
local Ref = require(script.Parent.PropMarkers.Ref)
local v1 = require(script.Parent.GlobalConfig).get()
local t = {
	[Ref] = None
}
return function(p1)
	if v1.typeChecks then
 assert(typeof(p1) == "function", "Expected arg #1 to be a function")
	end
	return function(p12)
 return p1(assign({}, p12, t), p12[Ref])
	end
end