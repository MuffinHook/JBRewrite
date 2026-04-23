local Binding = require(script.Parent.Binding)
local Children = require(script.Parent.PropMarkers.Children)
local ElementKind = require(script.Parent.ElementKind)
local SingleEventManager = require(script.Parent.SingleEventManager)
local getDefaultInstanceProperty = require(script.Parent.getDefaultInstanceProperty)
local Ref = require(script.Parent.PropMarkers.Ref)
local Type = require(script.Parent.Type)
local internalAssert = require(script.Parent.internalAssert)
local v1 = require(script.Parent.GlobalConfig).get()
local function identity(...) --[[ Line: 32 ]]
	return ...
end
local function applyRef(p1, p2) --[[ Line: 36 | Upvalues: Type (copy), Binding (copy) ]]
	if p1 == nil then
	elseif typeof(p1) == "function" then
		p1(p2)
	elseif Type.of(p1) == Type.Binding then
		Binding.update(p1, p2)
	else
		error(("Invalid ref: Expected type Binding but got %s"):format((typeof(p1))))
	end
end
local function setRobloxInstanceProperty(p1, p2, p3) --[[ Line: 51 | Upvalues: getDefaultInstanceProperty (copy) ]]
	if p3 == nil then
		local _, v1 = getDefaultInstanceProperty(p1.ClassName, p2)
		p3 = v1
	end
	p1[p2] = p3
end
local function removeBinding(p1, p2) --[[ Line: 64 ]]
	p1.bindings[p2]()
	p1.bindings[p2] = nil
end
local function attachBinding(p1, p2, p3) --[[ Line: 70 | Upvalues: getDefaultInstanceProperty (copy), identity (copy), Binding (copy) ]]
	local function updateBoundProperty(p12) --[[ Line: 71 | Upvalues: p1 (copy), p2 (copy), getDefaultInstanceProperty (ref), identity (ref) ]]
		local v1, v2 = xpcall(function() --[[ Line: 72 | Upvalues: p1 (ref), p2 (ref), p12 (copy), getDefaultInstanceProperty (ref) ]]
			local hostObject = p1.hostObject
			local v1 = p2
			local v2 = p12
			if v2 == nil then
				local _, v3 = getDefaultInstanceProperty(hostObject.ClassName, v1)
				v2 = v3
			end
			hostObject[v1] = v2
		end, identity)
		if not v1 then
			local source = p1.currentElement.source
			if source == nil then
				source = "<enable element tracebacks>"
			end
			error(("Error updating props:\n\t%s\nIn element:\n%s\n"):format(v2, source), 0)
		end
	end
	if p1.bindings == nil then
		p1.bindings = {}
	end
	p1.bindings[p2] = Binding.subscribe(p3, updateBoundProperty)
	updateBoundProperty(p3:getValue())
end
local function detachAllBindings(p1) --[[ Line: 97 ]]
	if p1.bindings ~= nil then
		for k, v in pairs(p1.bindings) do
			v()
		end
		p1.bindings = nil
	end
end
local function applyProp(p1, p2, p3, p4) --[[ Line: 106 | Upvalues: Ref (copy), Children (copy), Type (copy), SingleEventManager (copy), attachBinding (copy), getDefaultInstanceProperty (copy) ]]
	if p3 == p4 or (p2 == Ref or p2 == Children) then
		return
	end
	local v1 = Type.of(p2)
	if v1 == Type.HostEvent or v1 == Type.HostChangeEvent then
		if p1.eventManager == nil then
			p1.eventManager = SingleEventManager.new(p1.hostObject)
		end
		local name = p2.name
		if v1 == Type.HostChangeEvent then
			p1.eventManager:connectPropertyChange(name, p3)
		else
			p1.eventManager:connectEvent(name, p3)
		end
	else
		local isBinding = Type.of(p3) == Type.Binding
		if Type.of(p4) == Type.Binding then
			p1.bindings[p2]()
			p1.bindings[p2] = nil
		end
		if isBinding then
			attachBinding(p1, p2, p3)
		else
			local hostObject = p1.hostObject
			local v3
			if p3 == nil then
				local _, v4 = getDefaultInstanceProperty(hostObject.ClassName, p2)
				v3 = v4
			else
				v3 = p3
			end
			hostObject[p2] = v3
		end
	end
end
local function applyProps(p1, p2) --[[ Line: 148 | Upvalues: applyProp (copy) ]]
	for k, v in pairs(p2) do
		applyProp(p1, k, v, nil)
	end
end
local function updateProps(p1, p2, p3) --[[ Line: 154 | Upvalues: applyProp (copy) ]]
	for k, v in pairs(p3) do
		applyProp(p1, k, v, p2[k])
	end
	for k, v in pairs(p2) do
		if p3[k] == nil then
			applyProp(p1, k, nil, v)
		end
	end
end
return {
	isHostObject = function(p1) --[[ Name: isHostObject | Line: 174 ]]
		return typeof(p1) == "Instance"
	end,
	mountHostNode = function(p1, p2) --[[ Name: mountHostNode | Line: 178 | Upvalues: v1 (copy), internalAssert (copy), ElementKind (copy), applyProps (copy), identity (copy), Children (copy), applyRef (copy), Ref (copy) ]]
		local currentElement = p2.currentElement
		local hostParent = p2.hostParent
		local hostKey = p2.hostKey
		if v1.internalTypeChecks then
			local isHost = ElementKind.of(currentElement) == ElementKind.Host
			internalAssert(isHost, "Element at given node is not a host Element")
		end
		if v1.typeChecks then
			assert(currentElement.props.Name == nil, "Name can not be specified as a prop to a host component in Roact.")
			assert(currentElement.props.Parent == nil, "Parent can not be specified as a prop to a host component in Roact.")
		end
		local v3 = Instance.new(currentElement.component)
		p2.hostObject = v3
		local v4, v5 = xpcall(function() --[[ Line: 194 | Upvalues: applyProps (ref), p2 (copy), currentElement (copy) ]]
			applyProps(p2, currentElement.props)
		end, identity)
		if not v4 then
			local source = currentElement.source
			if source == nil then
				source = "<enable element tracebacks>"
			end
			error(("Error applying props:\n\t%s\nIn element:\n%s\n"):format(v5, source), 0)
		end
		v3.Name = tostring(hostKey)
		local v7 = currentElement.props[Children]
		if v7 ~= nil then
			p1.updateVirtualNodeWithChildren(p2, p2.hostObject, v7)
		end
		v3.Parent = hostParent
		p2.hostObject = v3
		applyRef(currentElement.props[Ref], v3)
		if p2.eventManager ~= nil then
			p2.eventManager:resume()
		end
	end,
	unmountHostNode = function(p1, p2) --[[ Name: unmountHostNode | Line: 227 | Upvalues: applyRef (copy), Ref (copy) ]]
		applyRef(p2.currentElement.props[Ref], nil)
		for k, v in pairs(p2.children) do
			p1.unmountVirtualNode(v)
		end
		if p2.bindings ~= nil then
			for k, v in pairs(p2.bindings) do
				v()
			end
			p2.bindings = nil
		end
		p2.hostObject:Destroy()
	end,
	updateHostNode = function(p1, p2, p3) --[[ Name: updateHostNode | Line: 241 | Upvalues: Ref (copy), applyRef (copy), updateProps (copy), identity (copy), Children (copy) ]]
		local props = p2.currentElement.props
		local props_2 = p3.props
		if p2.eventManager ~= nil then
			p2.eventManager:suspend()
		end
		if props[Ref] ~= props_2[Ref] then
			applyRef(props[Ref], nil)
			applyRef(props_2[Ref], p2.hostObject)
		end
		local v1, v2 = xpcall(function() --[[ Line: 255 | Upvalues: updateProps (ref), p2 (copy), props (copy), props_2 (copy) ]]
			updateProps(p2, props, props_2)
		end, identity)
		if not v1 then
			local source = p3.source
			if source == nil then
				source = "<enable element tracebacks>"
			end
			error(("Error updating props:\n\t%s\nIn element:\n%s\n"):format(v2, source), 0)
		end
		local v4 = p3.props[Children]
		if v4 ~= nil or props[Children] ~= nil then
			p1.updateVirtualNodeWithChildren(p2, p2.hostObject, v4)
		end
		if p2.eventManager ~= nil then
			p2.eventManager:resume()
		end
		return p2
	end
}