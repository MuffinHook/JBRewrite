-- Reviewed by Claude
-- variables reassigned
local assign = require(script.Parent.assign)
local ComponentLifecyclePhase = require(script.Parent.ComponentLifecyclePhase)
local Type = require(script.Parent.Type)
local Symbol = require(script.Parent.Symbol)
local invalidSetStateMessages = require(script.Parent.invalidSetStateMessages)
local internalAssert = require(script.Parent.internalAssert)
local config = require(script.Parent.GlobalConfig).get()
local typeSymbol = Symbol.named("InternalData")
local t = {
	__tostring = function(self)
		return self.__componentName
	end
}
local tableObj = {}
setmetatable(tableObj, t)
tableObj[Type] = Type.StatefulComponentClass
tableObj.__index = tableObj
tableObj.__componentName = "Component"
function tableObj.extend(self, callback)
	if config.typeChecks then
		local isStatefulComponentClass = Type.of(self) == Type.StatefulComponentClass
		assert(isStatefulComponentClass, "Invalid `self` argument to `extend`.")
		assert(typeof(callback) == "string", "Component class name must be a string")
	end
	local tableObj = {}
	for k, v in pairs(self) do
		if k ~= "extend" then
			tableObj[k] = v
		end
	end
	tableObj[Type] = Type.StatefulComponentClass
	tableObj.__index = tableObj
	tableObj.__componentName = callback
	setmetatable(tableObj, t)
	return tableObj
end
function tableObj.__getDerivedState(self, callback, p3)
	if config.internalTypeChecks then
		local isStatefulComponentInstance = Type.of(self) == Type.StatefulComponentInstance
		internalAssert(isStatefulComponentInstance, "Invalid use of `__getDerivedState`")
	end
	local componentClass = self[typeSymbol].componentClass
	if componentClass.getDerivedStateFromProps == nil then
		return nil
	else
		local derivedState = componentClass.getDerivedStateFromProps(callback, p3)
		if derivedState == nil then
			return nil
		else
			if config.typeChecks then
				assert(typeof(derivedState) == "table", "getDerivedStateFromProps must return a table!")
			end
			return derivedState
		end
	end
end
function tableObj.setState(self, callback)
	if config.typeChecks then
		local isStatefulComponentInstance = Type.of(self) == Type.StatefulComponentInstance
		assert(isStatefulComponentInstance, "Invalid `self` argument to `extend`.")
	end
	local internalData = self[typeSymbol]
	local lifecyclePhase = internalData.lifecyclePhase
	if lifecyclePhase == ComponentLifecyclePhase.ShouldUpdate or (lifecyclePhase == ComponentLifecyclePhase.WillUpdate or lifecyclePhase == ComponentLifecyclePhase.Render) then
		error(invalidSetStateMessages[internalData.lifecyclePhase]:format((tostring(internalData.componentClass))), 2)
	end
	local derivedState, newState, mergedState
	if lifecyclePhase == ComponentLifecyclePhase.WillUnmount then
		return
	end
	derivedState = internalData.pendingState
	if typeof(callback) == "function" then
		local currentState, nextState
		currentState = derivedState or self.state
		nextState = callback(currentState, self.props)
		if nextState == nil then
			return
		end
		newState = nextState
	elseif typeof(callback) == "table" then
		newState = callback
	else
		error("Invalid argument to setState, expected function or table", 2)
	end
	if derivedState == nil then
		local tempState
		tempState = assign({}, self.state, newState)
		mergedState = tempState
	else
		local updatedState
		updatedState = assign(derivedState, newState)
		mergedState = updatedState
	end
	if lifecyclePhase == ComponentLifecyclePhase.Init then
		self.state = assign(mergedState, (self:__getDerivedState(self.props, mergedState)))
	else
		local finalState, var10, var11
		if lifecyclePhase == ComponentLifecyclePhase.DidMount or (lifecyclePhase == ComponentLifecyclePhase.DidUpdate or lifecyclePhase == ComponentLifecyclePhase.ReconcileChildren) then
			internalData.pendingState = assign(mergedState, (self:__getDerivedState(self.props, mergedState)))
		elseif lifecyclePhase == ComponentLifecyclePhase.Idle then
			self:__update(nil, mergedState)
		else
			finalState = invalidSetStateMessages.default
			var10 = internalData.componentClass
			var11 = finalState:format((tostring(var10)))
			error(var11, 2)
		end
	end
end
function tableObj.getElementTraceback(self)
	return self[typeSymbol].virtualNode.currentElement.source
end
function tableObj.render(self)
	error(("The component %q is missing the `render` method.\n`render` must be defined when creating a Roact component!"):format((tostring(self[typeSymbol].componentClass))), 0)
end
function tableObj.__getContext(self, callback)
	if config.internalTypeChecks then
		local isStatefulComponentInstance = Type.of(self) == Type.StatefulComponentInstance
		internalAssert(isStatefulComponentInstance, "Invalid use of `__getContext`")
		internalAssert(callback ~= nil, "Context key cannot be nil")
	end
	return self[typeSymbol].virtualNode.context[callback]
end
function tableObj.__addContext(self, callback, p3)
	if config.internalTypeChecks then
		local isStatefulComponentInstance = Type.of(self) == Type.StatefulComponentInstance
		internalAssert(isStatefulComponentInstance, "Invalid use of `__addContext`")
	end
	local virtualNode = self[typeSymbol].virtualNode
	if virtualNode.originalContext == nil then
		virtualNode.originalContext = virtualNode.context
	end
	virtualNode.context = assign({}, virtualNode.context, {
		[callback] = p3
	})
end
function tableObj.__validateProps(self, callback)
	if config.propValidation then
		local validateProps = self[typeSymbol].componentClass.validateProps
		if validateProps ~= nil then
			if typeof(validateProps) ~= "function" then
				error(("validateProps must be a function, but it is a %s.\nCheck the definition of the component %q."):format(typeof(validateProps), self.__componentName))
			end
			local internalData, derivedState = validateProps(callback)
			if not internalData then
				error(("Property validation failed in %s: %s\n\n%s"):format(self.__componentName, tostring(derivedState or "<Validator function did not supply a message>"), self:getElementTraceback() or "<enable element tracebacks>"), 0)
			end
		end
	end
end
function tableObj.__mount(self, callback, p3)
	if config.internalTypeChecks then
		local isStatefulComponentClass = Type.of(self) == Type.StatefulComponentClass
		internalAssert(isStatefulComponentClass, "Invalid use of `__mount`")
		internalAssert(Type.of(p3) == Type.VirtualNode, "Expected arg #2 to be of type VirtualNode")
	end
	local currentElement = p3.currentElement
	local hostParent = p3.hostParent
	local t = {
		reconciler = callback,
		virtualNode = p3,
		componentClass = self,
		lifecyclePhase = ComponentLifecyclePhase.Init,
		pendingState = nil
	}
	local tableObj = {
		[Type] = Type.StatefulComponentInstance,
		[typeSymbol] = t
	}
	setmetatable(tableObj, self)
	p3.instance = tableObj
	local props = currentElement.props
	if self.defaultProps ~= nil then
		props = assign({}, self.defaultProps, props)
	end
	tableObj:__validateProps(props)
	tableObj.props = props
	tableObj._context = assign({}, p3.legacyContext)
	tableObj.state = assign({}, tableObj:__getDerivedState(tableObj.props, {}))
	if tableObj.init ~= nil then
		tableObj:init(tableObj.props)
		assign(tableObj.state, tableObj:__getDerivedState(tableObj.props, tableObj.state))
	end
	p3.legacyContext = tableObj._context
	t.lifecyclePhase = ComponentLifecyclePhase.Render
	local nextState = tableObj:render()
	t.lifecyclePhase = ComponentLifecyclePhase.ReconcileChildren
	callback.updateVirtualNodeWithRenderResult(p3, hostParent, nextState)
	if tableObj.didMount ~= nil then
		t.lifecyclePhase = ComponentLifecyclePhase.DidMount
		tableObj:didMount()
	end
	if t.pendingState ~= nil then
		tableObj:__update(nil, nil)
	end
	t.lifecyclePhase = ComponentLifecyclePhase.Idle
end
function tableObj.__unmount(self)
	if config.internalTypeChecks then
		local isStatefulComponentInstance = Type.of(self) == Type.StatefulComponentInstance
		internalAssert(isStatefulComponentInstance, "Invalid use of `__unmount`")
	end
	local derivedState = self[typeSymbol]
	local virtualNode = derivedState.virtualNode
	local reconciler = derivedState.reconciler
	if self.willUnmount ~= nil then
		derivedState.lifecyclePhase = ComponentLifecyclePhase.WillUnmount
		self:willUnmount()
	end
	for k, v in pairs(virtualNode.children) do
		reconciler.unmountVirtualNode(v)
	end
end
function tableObj.__update(self, callback, p3)
	if config.internalTypeChecks then
		local isStatefulComponentInstance = Type.of(self) == Type.StatefulComponentInstance
		internalAssert(isStatefulComponentInstance, "Invalid use of `__update`")
		internalAssert(Type.of(callback) == Type.Element or callback == nil, "Expected arg #1 to be of type Element or nil")
		internalAssert(typeof(p3) == "table" or p3 == nil, "Expected arg #2 to be of type table or nil")
	end
	local tempState = self[typeSymbol]
	local componentClass = tempState.componentClass
	local props = self.props
	if callback ~= nil then
		props = callback.props
		if componentClass.defaultProps ~= nil then
			props = assign({}, componentClass.defaultProps, props)
		end
		self:__validateProps(props)
	end
	local count = 0
	while true do
		local updatedState, finalState, var10
		if tempState.pendingState == nil then
			updatedState = nil
		else
			updatedState = tempState.pendingState
			tempState.pendingState = nil
		end
		if p3 == nil and props == self.props then
			finalState = updatedState
		else
			if updatedState == nil then
				var10 = p3 or self.state
				finalState = var10
			else
				finalState = assign(updatedState, p3)
			end
			local internalData = self:__getDerivedState(props, finalState)
			if internalData ~= nil then
				finalState = assign({}, finalState, internalData)
			end
			p3 = nil
		end
		if not self:__resolveUpdate(props, finalState) then
			return false
		end
		count = count + 1
		if count > 100 then
			local v14 = error
			v14(("The component %q has reached the setState update recursion limit.\nWhen using `setState` in `didUpdate`, make sure that it won\'t repeat infinitely!"):format((tostring(tempState.componentClass))), 3)
		end
		if tempState.pendingState == nil then
			return true
		end
	end
end
function tableObj.__resolveUpdate(self, callback, p3)
	if config.internalTypeChecks then
		local isStatefulComponentInstance = Type.of(self) == Type.StatefulComponentInstance
		internalAssert(isStatefulComponentInstance, "Invalid use of `__resolveUpdate`")
	end
	local derivedState = self[typeSymbol]
	local virtualNode = derivedState.virtualNode
	local reconciler = derivedState.reconciler
	local props = self.props
	local state = self.state
	if callback == nil then
		callback = props
	end
	if p3 == nil then
		p3 = state
	end
	local newState
	if self.shouldUpdate == nil then
		if self.willUpdate ~= nil then
			derivedState.lifecyclePhase = ComponentLifecyclePhase.WillUpdate
			self:willUpdate(callback, p3)
		end
		derivedState.lifecyclePhase = ComponentLifecyclePhase.Render
		self.props = callback
		self.state = p3
		newState = virtualNode.instance:render()
		derivedState.lifecyclePhase = ComponentLifecyclePhase.ReconcileChildren
		reconciler.updateVirtualNodeWithRenderResult(virtualNode, virtualNode.hostParent, newState)
		if self.didUpdate ~= nil then
			derivedState.lifecyclePhase = ComponentLifecyclePhase.DidUpdate
			self:didUpdate(props, state)
		end
		derivedState.lifecyclePhase = ComponentLifecyclePhase.Idle
		return true
	else
		derivedState.lifecyclePhase = ComponentLifecyclePhase.ShouldUpdate
		if self:shouldUpdate(callback, p3) then
			if self.willUpdate ~= nil then
				derivedState.lifecyclePhase = ComponentLifecyclePhase.WillUpdate
				self:willUpdate(callback, p3)
			end
			derivedState.lifecyclePhase = ComponentLifecyclePhase.Render
			self.props = callback
			self.state = p3
			newState = virtualNode.instance:render()
			derivedState.lifecyclePhase = ComponentLifecyclePhase.ReconcileChildren
			reconciler.updateVirtualNodeWithRenderResult(virtualNode, virtualNode.hostParent, newState)
			if self.didUpdate ~= nil then
				derivedState.lifecyclePhase = ComponentLifecyclePhase.DidUpdate
				self:didUpdate(props, state)
			end
			derivedState.lifecyclePhase = ComponentLifecyclePhase.Idle
			return true
		else
			derivedState.lifecyclePhase = ComponentLifecyclePhase.Idle
			return false
		end
	end
end
return tableObj
