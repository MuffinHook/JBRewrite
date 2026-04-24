-- Reviewed by Claude
local Symbol = require(script.Parent.Symbol)
local strict = require(script.Parent.strict)
local Portal = require(script.Parent.Portal)
local v1 = newproxy(true)
local t = {
	Portal = Symbol.named("Portal"),
	Host = Symbol.named("Host"),
	Function = Symbol.named("Function"),
	Stateful = Symbol.named("Stateful"),
	Fragment = Symbol.named("Fragment"),
	of = function(p1)
		if typeof(p1) == "table" then
			return p1[v1]
		else
			return nil
		end
	end
}
local t2 = {
	string = t.Host,
	["function"] = t.Function,
	table = t.Stateful
}
function t.fromComponent(p1)
	if p1 == Portal then
		return v1.Portal
	else
		return t2[typeof(p1)]
	end
end
getmetatable(v1).__index = t
strict(t, "ElementKind")
return v1
