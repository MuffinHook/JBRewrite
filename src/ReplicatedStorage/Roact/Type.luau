local Symbol = require(script.Parent.Symbol)
local strict = require(script.Parent.strict)
local v1 = newproxy(true)
local t = {}
local function addType(p1) --[[ Line: 19 | Upvalues: t (copy), Symbol (copy) ]]
	t[p1] = Symbol.named("Roact" .. p1)
end
t.Binding = Symbol.named("RoactBinding")
t.Element = Symbol.named("RoactElement")
t.HostChangeEvent = Symbol.named("RoactHostChangeEvent")
t.HostEvent = Symbol.named("RoactHostEvent")
t.StatefulComponentClass = Symbol.named("RoactStatefulComponentClass")
t.StatefulComponentInstance = Symbol.named("RoactStatefulComponentInstance")
t.VirtualNode = Symbol.named("RoactVirtualNode")
t.VirtualTree = Symbol.named("RoactVirtualTree")
function t.of(p1) --[[ Line: 32 | Upvalues: v1 (copy) ]]
	if typeof(p1) == "table" then
		return p1[v1]
	else
		return nil
	end
end
getmetatable(v1).__index = t
getmetatable(v1).__tostring = function() --[[ Line: 42 ]]
	return "RoactType"
end
strict(t, "Type")
return v1