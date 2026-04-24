-- Reviewed by Claude
-- variables reassigned
local Binding = require(script.Parent.Binding)
local Children = require(script.Parent.PropMarkers.Children)
local ElementKind = require(script.Parent.ElementKind)
local SingleEventManager = require(script.Parent.SingleEventManager)
local getDefaultInstanceProperty = require(script.Parent.getDefaultInstanceProperty)
local Ref = require(script.Parent.PropMarkers.Ref)
local Type = require(script.Parent.Type)
local internalAssert = require(script.Parent.internalAssert)
local config = require(script.Parent.GlobalConfig).get()
local function identity(...)
	return ...
end
local function applyRef(self, callback)
	if self == nil then
	elseif typeof(self) == "function" then
 self(callback)
	elseif Type.of(self) == Type.Binding then
 Binding.update(self, callback)
	else
 error(("Invalid ref: Expected type Binding but got %s"):format((typeof(self))))
	end
end
local function setRobloxInstanceProperty(self, callback, p3)
	if p3 == nil then
 local _, config = getDefaultInstanceProperty(self.ClassName, callback)
 p3 = config
	end
	self[callback] = p3
end
local function removeBinding(self, callback)
	self.bindings[callback]()
	self.bindings[callback] = nil
end
local function attachBinding(self, callback, p3)
	local function updateBoundProperty(param12)
 local config, v2 = xpcall(function()
 local hostObject = self.hostObject
 local config = callback
 local v2 = param12
 if v2 == nil then
 local _, newState = getDefaultInstanceProperty(hostObject.ClassName, config)
 v2 = newState
 end
 hostObject[config] = v2
 end, identity)
 if not config then
 local source = self.currentElement.source
 if source == nil then
 source = "<enable element tracebacks>"
 end
 error(("Error updating props:\n\t%s\nIn element:\n%s\n"):format(v2, source), 0)
 end
	end
	if self.bindings == nil then
 self.bindings = {}
	end
	self.bindings[callback] = Binding.subscribe(p3, updateBoundProperty)
	updateBoundProperty(p3:getValue())
end
local function detachAllBindings(self)
	if self.bindings ~= nil then
 for k, v in pairs(self.bindings) do
 v()
 end
 self.bindings = nil
	end
end
local function applyProp(self, callback, p3, p4)
	if p3 == p4 or (callback == Ref or callback == Children) then
 return
	end
	local config = Type.of(callback)
	if config == Type.HostEvent or config == Type.HostChangeEvent then
 if self.eventManager == nil then
 self.eventManager = SingleEventManager.new(self.hostObject)
 end
 local name = callback.name
 if config == Type.HostChangeEvent then
 self.eventManager:connectPropertyChange(name, p3)
 else
 self.eventManager:connectEvent(name, p3)
 end
	else
 local isBinding = Type.of(p3) == Type.Binding
 if Type.of(p4) == Type.Binding then
 self.bindings[callback]()
 self.bindings[callback] = nil
 end
 if isBinding then
 attachBinding(self, callback, p3)
 else
 local hostObject = self.hostObject
 local newState
 if p3 == nil then
 local _, currentState = getDefaultInstanceProperty(hostObject.ClassName, callback)
 newState = currentState
 else
 newState = p3
 end
 hostObject[callback] = newState
 end
	end
end
local function applyProps(self, callback)
	for k, v in pairs(callback) do
 applyProp(self, k, v, nil)
	end
end
local function updateProps(self, callback, p3)
	for k, v in pairs(p3) do
 applyProp(self, k, v, callback[k])
	end
	for k, v in pairs(callback) do
 if p3[k] == nil then
 applyProp(self, k, nil, v)
 end
	end
end
return {
	isHostObject = function(self)
 return typeof(self) == "Instance"
	end,
	mountHostNode = function(self, callback)
 local currentElement = callback.currentElement
 local hostParent = callback.hostParent
 local hostKey = callback.hostKey
 if config.internalTypeChecks then
 local isHost = ElementKind.of(currentElement) == ElementKind.Host
 internalAssert(isHost, "Element at given node is not a host Element")
 end
 if config.typeChecks then
 assert(currentElement.props.Name == nil, "Name can not be specified as a prop to a host component in Roact.")
 assert(currentElement.props.Parent == nil, "Parent can not be specified as a prop to a host component in Roact.")
 end
 local newState = Instance.new(currentElement.component)
 callback.hostObject = newState
 local currentState, nextState = xpcall(function()
 applyProps(callback, currentElement.props)
 end, identity)
 if not currentState then
 local source = currentElement.source
 if source == nil then
 source = "<enable element tracebacks>"
 end
 error(("Error applying props:\n\t%s\nIn element:\n%s\n"):format(nextState, source), 0)
 end
 newState.Name = tostring(hostKey)
 local mergedState = currentElement.props[Children]
 if mergedState ~= nil then
 self.updateVirtualNodeWithChildren(callback, callback.hostObject, mergedState)
 end
 newState.Parent = hostParent
 callback.hostObject = newState
 applyRef(currentElement.props[Ref], newState)
 if callback.eventManager ~= nil then
 callback.eventManager:resume()
 end
	end,
	unmountHostNode = function(self, callback)
 applyRef(callback.currentElement.props[Ref], nil)
 for k, v in pairs(callback.children) do
 self.unmountVirtualNode(v)
 end
 if callback.bindings ~= nil then
 for k, v in pairs(callback.bindings) do
 v()
 end
 callback.bindings = nil
 end
 callback.hostObject:Destroy()
	end,
	updateHostNode = function(self, callback, p3)
 local props = callback.currentElement.props
 local props_2 = p3.props
 if callback.eventManager ~= nil then
 callback.eventManager:suspend()
 end
 if props[Ref] ~= props_2[Ref] then
 applyRef(props[Ref], nil)
 applyRef(props_2[Ref], callback.hostObject)
 end
 local config, v2 = xpcall(function()
 updateProps(callback, props, props_2)
 end, identity)
 if not config then
 local source = p3.source
 if source == nil then
 source = "<enable element tracebacks>"
 end
 error(("Error updating props:\n\t%s\nIn element:\n%s\n"):format(v2, source), 0)
 end
 local currentState = p3.props[Children]
 if currentState ~= nil or props[Children] ~= nil then
 self.updateVirtualNodeWithChildren(callback, callback.hostObject, currentState)
 end
 if callback.eventManager ~= nil then
 callback.eventManager:resume()
 end
 return callback
	end
}
