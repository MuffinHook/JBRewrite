-- Reviewed by Claude
local Symbol = require(script.Parent.Symbol)
local strict = require(script.Parent.strict)
local metaProxy = newproxy(true)
local tableObj = {}
local function addType(self)
	tableObj[self] = Symbol.named("Roact" .. self)
end
tableObj.Binding = Symbol.named("RoactBinding")
tableObj.Element = Symbol.named("RoactElement")
tableObj.HostChangeEvent = Symbol.named("RoactHostChangeEvent")
tableObj.HostEvent = Symbol.named("RoactHostEvent")
tableObj.StatefulComponentClass = Symbol.named("RoactStatefulComponentClass")
tableObj.StatefulComponentInstance = Symbol.named("RoactStatefulComponentInstance")
tableObj.VirtualNode = Symbol.named("RoactVirtualNode")
tableObj.VirtualTree = Symbol.named("RoactVirtualTree")
function tableObj.of(self)
	if typeof(self) == "table" then
 return self[metaProxy]
	else
 return nil
	end
end
getmetatable(metaProxy).__index = tableObj
getmetatable(metaProxy).__tostring = function()
	return "RoactType"
end
strict(tableObj, "Type")
return metaProxy
