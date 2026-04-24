-- Reviewed by Claude
local Symbol = require(script.Parent.Symbol)
local strict = require(script.Parent.strict)
local metaProxy = newproxy(true)
local tbl = {}
local function addType(p1)
	tbl[p1] = Symbol.named("Roact" .. p1)
end
tbl.Binding = Symbol.named("RoactBinding")
tbl.Element = Symbol.named("RoactElement")
tbl.HostChangeEvent = Symbol.named("RoactHostChangeEvent")
tbl.HostEvent = Symbol.named("RoactHostEvent")
tbl.StatefulComponentClass = Symbol.named("RoactStatefulComponentClass")
tbl.StatefulComponentInstance = Symbol.named("RoactStatefulComponentInstance")
tbl.VirtualNode = Symbol.named("RoactVirtualNode")
tbl.VirtualTree = Symbol.named("RoactVirtualTree")
function tbl.of(p1)
	if typeof(p1) == "table" then
 return p1[metaProxy]
	else
 return nil
	end
end
getmetatable(metaProxy).__index = tbl
getmetatable(metaProxy).__tostring = function()
	return "RoactType"
end
strict(tbl, "Type")
return metaProxy