-- Reviewed by Claude
-- variables reassigned
local Type = require(script.Parent.Type)
local ElementKind = require(script.Parent.ElementKind)
local ElementUtils = require(script.Parent.ElementUtils)
local Children = require(script.Parent.PropMarkers.Children)
local Symbol = require(script.Parent.Symbol)
local internalAssert = require(script.Parent.internalAssert)
local config = require(script.Parent.GlobalConfig).get()
local typeSymbol = Symbol.named("InternalData")
return function(self)
	local internalData = nil
	local derivedState = nil
	local newState = nil
	local currentState = nil
	local function replaceVirtualNode(self, callback)
 local depth = self.depth
 local parent = self.parent
 if not self.wasUnmounted then
 currentState(self)
 end
 local typeSymbol = derivedState(callback, self.hostParent, self.hostKey, self.originalContext or self.context, self.parentLegacyContext)
 if typeSymbol ~= nil then
 typeSymbol.depth = depth
 typeSymbol.parent = parent
 end
 return typeSymbol
	end
	local function updateChildren(self, callback, p3)
 if config.internalTypeChecks then
 local isVirtualNode = Type.of(self) == Type.VirtualNode
 internalAssert(isVirtualNode, "Expected arg #1 to be of type VirtualNode")
 end
 self.updateChildrenCount = self.updateChildrenCount + 1
 local updateChildrenCount = self.updateChildrenCount
 local tableObj = {}
 for k, v in pairs(self.children) do
 local typeSymbol = newState(v, (ElementUtils.getElementByKey(p3, k)))
 if self.updateChildrenCount ~= updateChildrenCount then
 if typeSymbol and typeSymbol ~= self.children[k] then
 currentState(typeSymbol)
 end
 return
 end
 if typeSymbol == nil then
 tableObj[k] = true
 else
 self.children[k] = typeSymbol
 end
 end
 for k in pairs(tableObj) do
 self.children[k] = nil
 end
 for v42, nextState in ElementUtils.iterateElements(p3) do
 local v32
 v32 = if v42 == ElementUtils.UseParentKey then self.hostKey else v42
 if self.children[v42] == nil then
 local tempState = derivedState(nextState, callback, v32, self.context, self.legacyContext)
 if self.updateChildrenCount ~= updateChildrenCount then
 if tempState then
 currentState(tempState)
 end
 break
 end
 if tempState ~= nil then
 tempState.depth = self.depth + 1
 tempState.parent = self
 self.children[v42] = tempState
 end
 end
 end
	end
	local function updateVirtualNodeWithChildren(self, callback, p3)
 updateChildren(self, callback, p3)
	end
	local function updateVirtualNodeWithRenderResult(self, callback, p3)
 if Type.of(p3) == Type.Element or (p3 == nil or typeof(p3) == "boolean") then
 updateChildren(self, callback, p3)
 else
 error(("%s\n%s"):format("Component returned invalid children:", self.currentElement.source or "<enable element tracebacks>"), 0)
 end
	end
	currentState = function(param12)
 if config.internalTypeChecks then
 local isVirtualNode = Type.of(param12) == Type.VirtualNode
 internalAssert(isVirtualNode, "Expected arg #1 to be of type VirtualNode")
 end
 param12.wasUnmounted = true
 local typeSymbol = ElementKind.of(param12.currentElement)
 if typeSymbol == ElementKind.Host then
 self.unmountHostNode(internalData, param12)
 elseif typeSymbol == ElementKind.Function then
 for k, v in pairs(param12.children) do
 currentState(v)
 end
 elseif typeSymbol == ElementKind.Stateful then
 param12.instance:__unmount()
 elseif typeSymbol == ElementKind.Portal then
 for k, v in pairs(param12.children) do
 currentState(v)
 end
 elseif typeSymbol == ElementKind.Fragment then
 for k, v in pairs(param12.children) do
 currentState(v)
 end
 else
 error(("Unknown ElementKind %q"):format((tostring(typeSymbol))), 2)
 end
	end
	local function updateFunctionVirtualNode(self, callback)
 updateVirtualNodeWithRenderResult(self, self.hostParent, (callback.component(callback.props)))
 return self
	end
	local function updatePortalVirtualNode(param12, callback)
 local target_2 = callback.props.target
 assert(self.isHostObject(target_2), "Expected target to be host object")
 if target_2 == param12.currentElement.props.target then
 updateChildren(param12, target_2, callback.props[Children])
 return param12
 else
 local depth = param12.depth
 local parent = param12.parent
 if not param12.wasUnmounted then
 currentState(param12)
 end
 local newState = derivedState(callback, param12.hostParent, param12.hostKey, param12.originalContext or param12.context, param12.parentLegacyContext)
 if newState ~= nil then
 newState.depth = depth
 newState.parent = parent
 end
 return newState
 end
	end
	local function updateFragmentVirtualNode(self, callback)
 updateChildren(self, self.hostParent, callback.elements)
 return self
	end
	newState = function(param12, callback, p3)
 if config.internalTypeChecks then
 local isVirtualNode = Type.of(param12) == Type.VirtualNode
 internalAssert(isVirtualNode, "Expected arg #1 to be of type VirtualNode")
 end
 if config.typeChecks then
 assert(Type.of(callback) == Type.Element or typeof(callback) == "boolean" or callback == nil, "Expected arg #2 to be of type Element, boolean, or nil")
 end
 if param12.currentElement == callback and p3 == nil then
 return param12
 elseif typeof(callback) == "boolean" or callback == nil then
 currentState(param12)
 return nil
 elseif param12.currentElement.component == callback.component then
 local newState = ElementKind.of(callback)
 local v42 = true
 if newState == ElementKind.Host then
 param12 = self.updateHostNode(internalData, param12, callback)
 elseif newState == ElementKind.Function then
 updateVirtualNodeWithRenderResult(param12, param12.hostParent, (callback.component(callback.props)))
 elseif newState == ElementKind.Stateful then
 v42 = param12.instance:__update(callback, p3)
 elseif newState == ElementKind.Portal then
 local target_2 = callback.props.target
 assert(self.isHostObject(target_2), "Expected target to be host object")
 if target_2 == param12.currentElement.props.target then
 updateChildren(param12, target_2, callback.props[Children])
 else
 local depth = param12.depth
 local parent = param12.parent
 local var10 = param12
 if not var10.wasUnmounted then
 currentState(var10)
 end
 local var11 = derivedState(callback, param12.hostParent, param12.hostKey, param12.originalContext or param12.context, var10.parentLegacyContext)
 if var11 ~= nil then
 var11.depth = depth
 var11.parent = parent
 end
 param12 = var11
 end
 elseif newState == ElementKind.Fragment then
 updateChildren(param12, param12.hostParent, callback.elements)
 else
 error(("Unknown ElementKind %q"):format((tostring(newState))), 2)
 end
 if v42 then
 param12.currentElement = callback
 end
 return param12
 else
 local depth = param12.depth
 local parent = param12.parent
 local v13 = param12
 if not v13.wasUnmounted then
 currentState(v13)
 end
 local v14 = derivedState(callback, param12.hostParent, param12.hostKey, param12.originalContext or param12.context, v13.parentLegacyContext)
 if v14 ~= nil then
 v14.depth = depth
 v14.parent = parent
 end
 return v14
 end
	end
	local function createVirtualNode(param12, callback, p3, p4, p5)
 if config.internalTypeChecks then
 local typeSymbol = self.isHostObject(callback)
 if not typeSymbol then
 typeSymbol = callback == nil
 end
 internalAssert(typeSymbol, "Expected arg #2 to be a host object")
 internalAssert(typeof(p4) == "table" or p4 == nil, "Expected arg #4 to be of type table or nil")
 internalAssert(typeof(p5) == "table" or p5 == nil, "Expected arg #5 to be of type table or nil")
 end
 if config.typeChecks then
 assert(p3 ~= nil, "Expected arg #3 to be non-nil")
 assert(Type.of(param12) == Type.Element or typeof(param12) == "boolean", "Expected arg #1 to be of type Element or boolean")
 end
 local t = {
 [Type] = Type.VirtualNode,
 currentElement = param12,
 depth = 1,
 parent = nil,
 children = {},
 hostParent = callback,
 hostKey = p3,
 updateChildrenCount = 0,
 wasUnmounted = false,
 legacyContext = p5,
 parentLegacyContext = p5
 }
 t.context = p4 or {}
 t.originalContext = nil
 return t
	end
	local function mountFunctionVirtualNode(self)
 local currentElement = self.currentElement
 updateVirtualNodeWithRenderResult(self, self.hostParent, (currentElement.component(currentElement.props)))
	end
	local function mountPortalVirtualNode(param12)
 local currentElement = param12.currentElement
 local target = currentElement.props.target
 assert(self.isHostObject(target), "Expected target to be host object")
 updateChildren(param12, target, currentElement.props[Children])
	end
	local function mountFragmentVirtualNode(self)
 updateChildren(self, self.hostParent, self.currentElement.elements)
	end
	derivedState = function(param12, callback, p3, p4, p5)
 if config.internalTypeChecks then
 local typeSymbol = self.isHostObject(callback)
 if not typeSymbol then
 typeSymbol = callback == nil
 end
 internalAssert(typeSymbol, "Expected arg #2 to be a host object")
 internalAssert(typeof(p5) == "table" or p5 == nil, "Expected arg #5 to be of type table or nil")
 end
 if config.typeChecks then
 assert(p3 ~= nil, "Expected arg #3 to be non-nil")
 assert(Type.of(param12) == Type.Element or typeof(param12) == "boolean", "Expected arg #1 to be of type Element or boolean")
 end
 if typeof(param12) == "boolean" then
 return nil
 else
 local mergedState = ElementKind.of(param12)
 local updatedState = createVirtualNode(param12, callback, p3, p4, p5)
 if mergedState == ElementKind.Host then
 self.mountHostNode(internalData, updatedState)
 elseif mergedState == ElementKind.Function then
 local currentElement = updatedState.currentElement
 updateVirtualNodeWithRenderResult(updatedState, updatedState.hostParent, (currentElement.component(currentElement.props)))
 elseif mergedState == ElementKind.Stateful then
 param12.component:__mount(internalData, updatedState)
 elseif mergedState == ElementKind.Portal then
 local currentElement = updatedState.currentElement
 local target = currentElement.props.target
 assert(self.isHostObject(target), "Expected target to be host object")
 updateChildren(updatedState, target, currentElement.props[Children])
 elseif mergedState == ElementKind.Fragment then
 updateChildren(updatedState, updatedState.hostParent, updatedState.currentElement.elements)
 else
 error(("Unknown ElementKind %q"):format((tostring(mergedState))), 2)
 end
 return updatedState
 end
	end
	internalData = {
 mountVirtualTree = function(param12, callback, p3)
 if config.typeChecks then
 local isElement = Type.of(param12) == Type.Element
 assert(isElement, "Expected arg #1 to be of type Element")
 local internalData = self.isHostObject(callback)
 if not internalData then
 internalData = callback == nil
 end
 assert(internalData, "Expected arg #2 to be a host object")
 end
 if p3 == nil then
 p3 = "RoactTree"
 end
 local t = {
 [Type] = Type.VirtualTree,
 [typeSymbol] = {
 rootNode = nil,
 mounted = true
 }
 }
 t[typeSymbol].rootNode = derivedState(param12, callback, p3)
 return t
 end,
 unmountVirtualTree = function(self)
 local internalData = self[typeSymbol]
 if config.typeChecks then
 local isVirtualTree = Type.of(self) == Type.VirtualTree
 assert(isVirtualTree, "Expected arg #1 to be a Roact handle")
 assert(internalData.mounted, "Cannot unmounted a Roact tree that has already been unmounted")
 end
 internalData.mounted = false
 if internalData.rootNode ~= nil then
 currentState(internalData.rootNode)
 end
 end,
 updateVirtualTree = function(self, callback)
 local internalData = self[typeSymbol]
 if config.typeChecks then
 local isVirtualTree = Type.of(self) == Type.VirtualTree
 assert(isVirtualTree, "Expected arg #1 to be a Roact handle")
 assert(Type.of(callback) == Type.Element, "Expected arg #2 to be a Roact Element")
 end
 internalData.rootNode = newState(internalData.rootNode, callback)
 return self
 end,
 createVirtualNode = createVirtualNode,
 mountVirtualNode = derivedState,
 unmountVirtualNode = currentState,
 updateVirtualNode = newState,
 updateVirtualNodeWithChildren = updateVirtualNodeWithChildren,
 updateVirtualNodeWithRenderResult = updateVirtualNodeWithRenderResult
	}
	return internalData
end
