-- Reviewed by Claude
-- variables reassigned
local assign = require(script.Parent.assign)
local None = require(script.Parent.None)
local Ref = require(script.Parent.PropMarkers.Ref)
local config = require(script.Parent.GlobalConfig).get()
local t = {
	[Ref] = None
}
return function(self)
	if config.typeChecks then
 assert(typeof(self) == "function", "Expected arg #1 to be a function")
	end
	return function(param12)
 return self(assign({}, param12, t), param12[Ref])
	end
end
