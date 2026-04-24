-- Reviewed by Claude
local Type = require(script.Parent.Type)
local ElementKind = require(script.Parent.ElementKind)
local ElementUtils = require(script.Parent.ElementUtils)
local Children = require(script.Parent.PropMarkers.Children)
local Symbol = require(script.Parent.Symbol)
local internalAssert = require(script.Parent.internalAssert)
local v1 = require(script.Parent.GlobalConfig).get()
local typeSymbol = Symbol.named("InternalData")
return function(p1)
	local v12 = nil
	local v22 = nil
	local v3 = nil
	local v4 = nil
	local function replaceVirtualNode(p1, p2)
 local depth = p1.depth
 local parent = p1.parent
 if not p1.wasUnmounted then
 v4(p1)
 end
 local typeSymbol = v22(p2, p1.hostParent, p1.hostKey, p1.originalContext or p1.context, p1.parentLegacyContext)
 if typeSymbol ~= nil then
 typeSymbol.depth = depth
 typeSymbol.parent = parent
 end
 return typeSymbol
	end
	local function updateChildren(p1, p2, p3)
 if v1.internalTypeChecks then
 local isVirtualNode = Type.of(p1) == Type.VirtualNode
 internalAssert(isVirtualNode, "Expected arg #1 to be of type VirtualNode")
 end
 p1.updateChildrenCount = p1.updateChildrenCount + 1
 local updateChildrenCount = p1.updateChildrenCount
 local tbl = {}
 for k, v in pairs(p1.children) do
 local typeSymbol = v3(v, (ElementUtils.getElementByKey(p3, k)))
 if p1.updateChildrenCount ~= updateChildrenCount then
 if typeSymbol and typeSymbol ~= p1.children[k] then
 v4(typeSymbol)
 end
 return
 end
 if typeSymbol == nil then
 tbl[k] = true
 else
 p1.children[k] = typeSymbol
 end
 end
 for k in pairs(tbl) do
 p1.children[k] = nil
 end
 for v42, v5 in ElementUtils.iterateElements(p3) do
 local v32
 v32 = if v42 == ElementUtils.UseParentKey then p1.hostKey else v42
 if p1.children[v42] == nil then
 local v6 = v22(v5, p2, v32, p1.context, p1.legacyContext)
 if p1.updateChildrenCount ~= updateChildrenCount then
 if v6 then
 v4(v6)
 end
 break
 end
 if v6 ~= nil then
 v6.depth = p1.depth + 1
 v6.parent = p1
 p1.children[v42] = v6
 end
 end
 end
	end
	local function updateVirtualNodeWithChildren(p1, p2, p3)
 updateChildren(p1, p2, p3)
	end
	local function updateVirtualNodeWithRenderResult(p1, p2, p3)
 if Type.of(p3) == Type.Element or (p3 == nil or typeof(p3) == "boolean") then
 updateChildren(p1, p2, p3)
 else
 error(("%s\n%s"):format("Component returned invalid children:", p1.currentElement.source or "<enable element tracebacks>"), 0)
 end
	end
	v4 = function(p12)
 if v1.internalTypeChecks then
 local isVirtualNode = Type.of(p12) == Type.VirtualNode
 internalAssert(isVirtualNode, "Expected arg #1 to be of type VirtualNode")
 end
 p12.wasUnmounted = true
 local typeSymbol = ElementKind.of(p12.currentElement)
 if typeSymbol == ElementKind.Host then
 p1.unmountHostNode(v12, p12)
 elseif typeSymbol == ElementKind.Function then
 for k, v in pairs(p12.children) do
 v4(v)
 end
 elseif typeSymbol == ElementKind.Stateful then
 p12.instance:__unmount()
 elseif typeSymbol == ElementKind.Portal then
 for k, v in pairs(p12.children) do
 v4(v)
 end
 elseif typeSymbol == ElementKind.Fragment then
 for k, v in pairs(p12.children) do
 v4(v)
 end
 else
 error(("Unknown ElementKind %q"):format((tostring(typeSymbol))), 2)
 end
	end
	local function updateFunctionVirtualNode(p1, p2)
 updateVirtualNodeWithRenderResult(p1, p1.hostParent, (p2.component(p2.props)))
 return p1
	end
	local function updatePortalVirtualNode(p12, p2)
 local target_2 = p2.props.target
 assert(p1.isHostObject(target_2), "Expected target to be host object")
 if target_2 == p12.currentElement.props.target then
 updateChildren(p12, target_2, p2.props[Children])
 return p12
 else
 local depth = p12.depth
 local parent = p12.parent
 if not p12.wasUnmounted then
 v4(p12)
 end
 local v3 = v22(p2, p12.hostParent, p12.hostKey, p12.originalContext or p12.context, p12.parentLegacyContext)
 if v3 ~= nil then
 v3.depth = depth
 v3.parent = parent
 end
 return v3
 end
	end
	local function updateFragmentVirtualNode(p1, p2)
 updateChildren(p1, p1.hostParent, p2.elements)
 return p1
	end
	v3 = function(p12, p2, p3)
 if v1.internalTypeChecks then
 local isVirtualNode = Type.of(p12) == Type.VirtualNode
 internalAssert(isVirtualNode, "Expected arg #1 to be of type VirtualNode")
 end
 if v1.typeChecks then
 assert(Type.of(p2) == Type.Element or typeof(p2) == "boolean" or p2 == nil, "Expected arg #2 to be of type Element, boolean, or nil")
 end
 if p12.currentElement == p2 and p3 == nil then
 return p12
 elseif typeof(p2) == "boolean" or p2 == nil then
 v4(p12)
 return nil
 elseif p12.currentElement.component == p2.component then
 local v3 = ElementKind.of(p2)
 local v42 = true
 if v3 == ElementKind.Host then
 p12 = p1.updateHostNode(v12, p12, p2)
 elseif v3 == ElementKind.Function then
 updateVirtualNodeWithRenderResult(p12, p12.hostParent, (p2.component(p2.props)))
 elseif v3 == ElementKind.Stateful then
 v42 = p12.instance:__update(p2, p3)
 elseif v3 == ElementKind.Portal then
 local target_2 = p2.props.target
 assert(p1.isHostObject(target_2), "Expected target to be host object")
 if target_2 == p12.currentElement.props.target then
 updateChildren(p12, target_2, p2.props[Children])
 else
 local depth = p12.depth
 local parent = p12.parent
 local v10 = p12
 if not v10.wasUnmounted then
 v4(v10)
 end
 local v11 = v22(p2, p12.hostParent, p12.hostKey, p12.originalContext or p12.context, v10.parentLegacyContext)
 if v11 ~= nil then
 v11.depth = depth
 v11.parent = parent
 end
 p12 = v11
 end
 elseif v3 == ElementKind.Fragment then
 updateChildren(p12, p12.hostParent, p2.elements)
 else
 error(("Unknown ElementKind %q"):format((tostring(v3))), 2)
 end
 if v42 then
 p12.currentElement = p2
 end
 return p12
 else
 local depth = p12.depth
 local parent = p12.parent
 local v13 = p12
 if not v13.wasUnmounted then
 v4(v13)
 end
 local v14 = v22(p2, p12.hostParent, p12.hostKey, p12.originalContext or p12.context, v13.parentLegacyContext)
 if v14 ~= nil then
 v14.depth = depth
 v14.parent = parent
 end
 return v14
 end
	end
	local function createVirtualNode(p12, p2, p3, p4, p5)
 if v1.internalTypeChecks then
 local typeSymbol = p1.isHostObject(p2)
 if not typeSymbol then
 typeSymbol = p2 == nil
 end
 internalAssert(typeSymbol, "Expected arg #2 to be a host object")
 internalAssert(typeof(p4) == "table" or p4 == nil, "Expected arg #4 to be of type table or nil")
 internalAssert(typeof(p5) == "table" or p5 == nil, "Expected arg #5 to be of type table or nil")
 end
 if v1.typeChecks then
 assert(p3 ~= nil, "Expected arg #3 to be non-nil")
 assert(Type.of(p12) == Type.Element or typeof(p12) == "boolean", "Expected arg #1 to be of type Element or boolean")
 end
 local t = {
 [Type] = Type.VirtualNode,
 currentElement = p12,
 depth = 1,
 parent = nil,
 children = {},
 hostParent = p2,
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
	local function mountFunctionVirtualNode(p1)
 local currentElement = p1.currentElement
 updateVirtualNodeWithRenderResult(p1, p1.hostParent, (currentElement.component(currentElement.props)))
	end
	local function mountPortalVirtualNode(p12)
 local currentElement = p12.currentElement
 local target = currentElement.props.target
 assert(p1.isHostObject(target), "Expected target to be host object")
 updateChildren(p12, target, currentElement.props[Children])
	end
	local function mountFragmentVirtualNode(p1)
 updateChildren(p1, p1.hostParent, p1.currentElement.elements)
	end
	v22 = function(p12, p2, p3, p4, p5)
 if v1.internalTypeChecks then
 local typeSymbol = p1.isHostObject(p2)
 if not typeSymbol then
 typeSymbol = p2 == nil
 end
 internalAssert(typeSymbol, "Expected arg #2 to be a host object")
 internalAssert(typeof(p5) == "table" or p5 == nil, "Expected arg #5 to be of type table or nil")
 end
 if v1.typeChecks then
 assert(p3 ~= nil, "Expected arg #3 to be non-nil")
 assert(Type.of(p12) == Type.Element or typeof(p12) == "boolean", "Expected arg #1 to be of type Element or boolean")
 end
 if typeof(p12) == "boolean" then
 return nil
 else
 local v7 = ElementKind.of(p12)
 local v8 = createVirtualNode(p12, p2, p3, p4, p5)
 if v7 == ElementKind.Host then
 p1.mountHostNode(v12, v8)
 elseif v7 == ElementKind.Function then
 local currentElement = v8.currentElement
 updateVirtualNodeWithRenderResult(v8, v8.hostParent, (currentElement.component(currentElement.props)))
 elseif v7 == ElementKind.Stateful then
 p12.component:__mount(v12, v8)
 elseif v7 == ElementKind.Portal then
 local currentElement = v8.currentElement
 local target = currentElement.props.target
 assert(p1.isHostObject(target), "Expected target to be host object")
 updateChildren(v8, target, currentElement.props[Children])
 elseif v7 == ElementKind.Fragment then
 updateChildren(v8, v8.hostParent, v8.currentElement.elements)
 else
 error(("Unknown ElementKind %q"):format((tostring(v7))), 2)
 end
 return v8
 end
	end
	v12 = {
 mountVirtualTree = function(p12, p2, p3)
 if v1.typeChecks then
 local isElement = Type.of(p12) == Type.Element
 assert(isElement, "Expected arg #1 to be of type Element")
 local v12 = p1.isHostObject(p2)
 if not v12 then
 v12 = p2 == nil
 end
 assert(v12, "Expected arg #2 to be a host object")
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
 t[typeSymbol].rootNode = v22(p12, p2, p3)
 return t
 end,
 unmountVirtualTree = function(p1)
 local v12 = p1[typeSymbol]
 if v1.typeChecks then
 local isVirtualTree = Type.of(p1) == Type.VirtualTree
 assert(isVirtualTree, "Expected arg #1 to be a Roact handle")
 assert(v12.mounted, "Cannot unmounted a Roact tree that has already been unmounted")
 end
 v12.mounted = false
 if v12.rootNode ~= nil then
 v4(v12.rootNode)
 end
 end,
 updateVirtualTree = function(p1, p2)
 local v12 = p1[typeSymbol]
 if v1.typeChecks then
 local isVirtualTree = Type.of(p1) == Type.VirtualTree
 assert(isVirtualTree, "Expected arg #1 to be a Roact handle")
 assert(Type.of(p2) == Type.Element, "Expected arg #2 to be a Roact Element")
 end
 v12.rootNode = v3(v12.rootNode, p2)
 return p1
 end,
 createVirtualNode = createVirtualNode,
 mountVirtualNode = v22,
 unmountVirtualNode = v4,
 updateVirtualNode = v3,
 updateVirtualNodeWithChildren = updateVirtualNodeWithChildren,
 updateVirtualNodeWithRenderResult = updateVirtualNodeWithRenderResult
	}
	return v12
end