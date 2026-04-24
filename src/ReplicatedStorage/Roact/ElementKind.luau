-- Reviewed by Claude
-- variables reassigned
local Symbol = require(script.Parent.Symbol)
local strict = require(script.Parent.strict)
local Portal = require(script.Parent.Portal)
local metaProxy = newproxy(true)
local t = {
	Portal = Symbol.named("Portal"),
	Host = Symbol.named("Host"),
	Function = Symbol.named("Function"),
	Stateful = Symbol.named("Stateful"),
	Fragment = Symbol.named("Fragment"),
	of = function(self)
		if typeof(self) == "table" then
			return self[metaProxy]
		else
			return nil
		end
	end
}
local tbl2 = {
	string = t.Host,
	["function"] = t.Function,
	table = t.Stateful
}
function t.fromComponent(self)
	if self == Portal then
		return metaProxy.Portal
	else
		return tbl2[typeof(self)]
	end
end
getmetatable(metaProxy).__index = t
strict(t, "ElementKind")
return metaProxy
