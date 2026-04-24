-- Reviewed by Claude
-- variables reassigned
local Roact = require(script.Parent.Parent.Roact)
local shallowEqual = require(script.Parent.shallowEqual)
local join = require(script.Parent.join)
local StoreContext = require(script.Parent.StoreContext)
local function formatMessage(parts, args)
	return table.concat(parts, "\n"):format(unpack(args or {}))
end
local function noop()
	return nil
end
local function makeStateUpdater(mapStateToProps)
	return function(componentProps, componentState, mappedStoreState)
 if mappedStoreState == nil then
 mappedStoreState = mapStateToProps(componentState.store:getState(), componentProps)
 end
 return {
 mappedStoreState = mappedStoreState,
 propsForChild = join(componentProps, mappedStoreState, componentState.mappedStoreDispatch)
 }
	end
end
return function(mapStateToProps, mapDispatchToProps)
	local connectionTraceback = debug.traceback()
	if mapStateToProps == nil then
 mapStateToProps = noop
	else
 assert(typeof(mapStateToProps) == "function", "mapStateToProps must be a function or nil!")
	end
	local mapDispatchType = typeof(mapDispatchToProps)
	if mapDispatchToProps == nil then
 mapDispatchToProps = noop
	else
 assert(mapDispatchType == "function" or mapDispatchType == "table", "mapDispatchToProps must be a function, table, or nil!")
	end
	return function(WrappedComponent)
 if WrappedComponent == nil then
 error(table.concat({ "connect returns a function that must be passed a component.", "Check the connection at:", "%s" }, "\n"):format(unpack({ connectionTraceback } or {})), 2)
 end
 local componentName = ("RoduxConnection(%s)"):format((tostring(WrappedComponent)))
 local RoduxConnectedComponent = Roact.Component:extend(componentName)
 function RoduxConnectedComponent.getDerivedStateFromProps(newProps, state)
 if state.stateUpdater ~= nil then
 return state.stateUpdater(newProps.innerProps, state)
 end
 end
 function RoduxConnectedComponent.init(self, props)
 self.store = props.store
 if self.store == nil then
 local errorParts = {}
 errorParts[1] = tostring(WrappedComponent)
 error((table.concat({ "Cannot initialize Roact-Rodux connection without being a descendent of StoreProvider!", "Tried to wrap component %q", "Make sure there is a StoreProvider above this component in the tree." }, "\n"):format(unpack(errorParts or {}))))
 end
 local storeState = self.store:getState()
 local mapStateFunction = mapStateToProps
 local mappedState = mapStateFunction(storeState, self.props.innerProps)
 if typeof(mappedState) == "function" then
 mappedState, mapStateFunction = mappedState(storeState, self.props.innerProps), mappedState
 end
 if mappedState ~= nil and typeof(mappedState) ~= "table" then
 local errorArgs = { tostring(mappedState), (typeof(mappedState)) }
 error((table.concat({ "mapStateToProps must either return a table, or return another function that returns a table.", "Instead, it returned %q, which is of type %s." }, "\n"):format(unpack(errorArgs or {}))))
 end
 local function dispatch(...)
 return self.store:dispatch(...)
 end
 local dispatchMapping = nil
 if mapDispatchType == "table" then
 dispatchMapping = {}
 for k, v in pairs(mapDispatchToProps) do
 local isFunction
 isFunction = typeof(v) == "function"
 assert(isFunction, "mapDispatchToProps must contain function values")
 dispatchMapping[k] = function(...)
 dispatch(v(...))
 end
 end
 elseif mapDispatchType == "function" then
 dispatchMapping = mapDispatchToProps(dispatch)
 end
 local connectedStore = self.store
 local function createConnectedStateUpdater(componentProps, componentState, mappedStoreState)
 if mappedStoreState == nil then
 mappedStoreState = componentState.mapStateToProps(connectedStore:getState(), componentProps)
 end
 return {
 mappedStoreState = mappedStoreState,
 propsForChild = join(componentProps, mappedStoreState, componentState.mappedStoreDispatch)
 }
 end
 self.state = {
 stateUpdater = createConnectedStateUpdater,
 mapStateToProps = mapStateFunction,
 mappedStoreDispatch = dispatchMapping,
 propsForChild = nil
 }
 for k, v in pairs((createConnectedStateUpdater(self.props.innerProps, self.state, mappedState))) do
 self.state[k] = v
 end
 end
 function RoduxConnectedComponent.didMount(self)
 local function onStoreChanged(newStoreState)
 self:setState(function(state, props)
 local newMappedState = state.mapStateToProps(newStoreState, props.innerProps)
 if shallowEqual(newMappedState, state.mappedStoreState) then
 return nil
 else
 return state.stateUpdater(props.innerProps, state, newMappedState)
 end
 end)
 end
 local currentStoreState = self.store:getState()
 self:setState(function(state, props)
 local newMappedState = state.mapStateToProps(currentStoreState, props.innerProps)
 if shallowEqual(newMappedState, state.mappedStoreState) then
 return nil
 else
 return state.stateUpdater(props.innerProps, state, newMappedState)
 end
 end)
 self.storeChangedConnection = self.store.changed:connect(onStoreChanged)
 end
 function RoduxConnectedComponent.willUnmount(self)
 if self.storeChangedConnection then
 self.storeChangedConnection:disconnect()
 self.storeChangedConnection = nil
 end
 end
 function RoduxConnectedComponent.render(self)
 return Roact.createElement(WrappedComponent, self.state.propsForChild)
 end
 local StoreContextConsumer = Roact.Component:extend(componentName)
 function StoreContextConsumer.render(self)
 return Roact.createElement(StoreContext.Consumer, {
 render = function(storeFromContext)
 return Roact.createElement(RoduxConnectedComponent, {
 innerProps = self.props,
 store = storeFromContext
 })
 end
 })
 end
 return StoreContextConsumer
	end
end
