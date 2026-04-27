require(script.Types)
local iris = {}
local module = require(script.Internal)(iris)
iris.Disabled = false
iris.Args = {}
iris.Events = {}
function iris.Init(parentInstance, eventSignal, forceReinit)
	assert(module._shutdown == false, "Iris.Init() cannot be called once shutdown.")
	assert(if module._started == false then true else forceReinit == true, "Iris.Init() can only be called once.")
	if not module._started then
		if parentInstance == nil then
			parentInstance = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
		end
		if eventSignal == nil then
			eventSignal = game:GetService("RunService").Heartbeat
		end
		module.parentInstance = parentInstance
		module._started = true
		module._generateRootInstance()
		module._generateSelectionImageObject()
		for _, initFunction in module._initFunctions do
			initFunction()
		end
		task.spawn(function()
			if typeof(eventSignal) == "function" then
				while module._started do
					module._cycle((eventSignal()))
				end
			elseif eventSignal ~= nil and eventSignal ~= false then
				module._eventConnection = eventSignal:Connect(function(...)
					module._cycle(...)
				end)
			end
		end)
	end
	return iris
end
function iris.Shutdown()
	module._started = false
	module._shutdown = true
	if module._eventConnection then
		module._eventConnection:Disconnect()
	end
	module._eventConnection = nil
	if module._rootWidget then
		if module._rootWidget.Instance then
			module._widgets.Root.Discard(module._rootWidget)
		end
		module._rootInstance = nil
	end
	if module.SelectionImageObject then
		module.SelectionImageObject:Destroy()
	end
	for _, connection in module._connections do
		connection:Disconnect()
	end
end
function iris.Connect(signalName, callback)
	if module._started == false then
		warn("Iris:Connect() was called before calling Iris.Init(); always initialise Iris first.")
	end
	local callbackIndex = #module._connectedFunctions + 1
	module._connectedFunctions[callbackIndex] = callback
	return function()
		module._connectedFunctions[callbackIndex] = nil
	end
end
function iris.Append(userInstance)
	local parentWidget = module._GetParentWidget()
	userInstance.Parent = module._config.Parent or module._widgets[parentWidget.type].ChildAdded(parentWidget, {
		type = "userInstance"
	})
end
function iris.End()
	if module._stackIndex == 1 then
		error("Too many calls to Iris.End().", 2)
	end
	module._IDStack[module._stackIndex] = nil
	local stackManager = module
	stackManager._stackIndex = stackManager._stackIndex - 1
end
function iris.ForceRefresh()
	module._globalRefreshRequested = true
end
function iris.UpdateGlobalConfig(configTable)
	for key, configValue in configTable do
		module._rootConfig[key] = configValue
	end
	iris.ForceRefresh()
end
function iris.PushConfig(newConfig)
	local configState = iris.State(-1)
	if configState.value == -1 then
		configState:set(newConfig)
	elseif module._deepCompare(configState:get(), newConfig) == false then
		configState:set(newConfig)
		module._refreshStack[module._refreshLevel] = true
		local refreshManager = module
		refreshManager._refreshCounter = refreshManager._refreshCounter + 1
	end
	local levelManager = module
	levelManager._refreshLevel = levelManager._refreshLevel + 1
	module._config = setmetatable(newConfig, {
		__index = module._config
	})
end
function iris.PopConfig()
	local popManager = module
	popManager._refreshLevel = popManager._refreshLevel - 1
	if module._refreshStack[module._refreshLevel] == true then
		local refreshCounter = module
		refreshCounter._refreshCounter = refreshCounter._refreshCounter - 1
		module._refreshStack[module._refreshLevel] = nil
	end
	module._config = getmetatable(module._config).__index
end
iris.TemplateConfig = require(script.config)
iris.UpdateGlobalConfig(iris.TemplateConfig.colorDark)
iris.UpdateGlobalConfig(iris.TemplateConfig.sizeDefault)
iris.UpdateGlobalConfig(iris.TemplateConfig.utilityDefault)
module._globalRefreshRequested = false
function iris.PushId(idString)
	assert(typeof(idString) == "string", "The ID argument to Iris.PushId() to be a string.")
	module._newID = true
	table.insert(module._pushedIds, idString)
end
function iris.PopId()
	if #module._pushedIds ~= 0 then
		table.remove(module._pushedIds)
	end
end
function iris.SetNextWidgetID(widgetId)
	module._nextWidgetId = widgetId
end
function iris.State(initialValue)
	local stateID = module._getID(2)
	if module._states[stateID] then
		return module._states[stateID]
	else
		local stateObject = {
			ID = stateID,
			value = initialValue,
			lastChangeTick = iris.Internal._cycleTick,
			ConnectedWidgets = {},
			ConnectedFunctions = {}
		}
		setmetatable(stateObject, module.StateClass)
		module._states[stateID] = stateObject
		return stateObject
	end
end
function iris.WeakState(initialValue)
	local stateID = module._getID(2)
	if module._states[stateID] then
		if next(module._states[stateID].ConnectedWidgets) == nil then
			module._states[stateID] = nil
		else
			return module._states[stateID]
		end
	end
	local stateObject = {
		ID = stateID,
		value = initialValue,
		lastChangeTick = iris.Internal._cycleTick,
		ConnectedWidgets = {},
		ConnectedFunctions = {}
	}
	setmetatable(stateObject, module.StateClass)
	module._states[stateID] = stateObject
	return stateObject
end
function iris.VariableState(variableValue, changeCallback)
	local stateID = module._getID(2)
	local existingState = module._states[stateID]
	if existingState then
		if variableValue ~= existingState.value then
			existingState:set(variableValue)
		end
		return existingState
	else
		local stateObject = {
			ID = stateID,
			value = variableValue,
			lastChangeTick = iris.Internal._cycleTick,
			ConnectedWidgets = {},
			ConnectedFunctions = {}
		}
		setmetatable(stateObject, module.StateClass)
		module._states[stateID] = stateObject
		stateObject:onChange(changeCallback)
		return stateObject
	end
end
function iris.TableState(sourceTable, tableKey, validateCallback)
	local tableValue = sourceTable[tableKey]
	local stateID = module._getID(2)
	local existingTableState = module._states[stateID]
	if existingTableState then
		if tableValue ~= existingTableState.value then
			existingTableState:set(tableValue)
		end
		return existingTableState
	else
		local stateObject = {
			ID = stateID,
			value = tableValue,
			lastChangeTick = iris.Internal._cycleTick,
			ConnectedWidgets = {},
			ConnectedFunctions = {}
		}
		setmetatable(stateObject, module.StateClass)
		module._states[stateID] = stateObject
		stateObject:onChange(function()
			if validateCallback == nil then
				sourceTable[tableKey] = stateObject.value
			elseif validateCallback(stateObject.value) then
				sourceTable[tableKey] = stateObject.value
			end
		end)
		return stateObject
	end
end
function iris.ComputedState(dependencyState, computeFunction)
	local stateID = module._getID(2)
	if module._states[stateID] then
		return module._states[stateID]
	else
		local stateObject = {
			ID = stateID,
			value = computeFunction(dependencyState.value),
			lastChangeTick = iris.Internal._cycleTick,
			ConnectedWidgets = {},
			ConnectedFunctions = {}
		}
		setmetatable(stateObject, module.StateClass)
		module._states[stateID] = stateObject
		dependencyState:onChange(function(newDependencyValue)
			stateObject:set(computeFunction(newDependencyValue))
		end)
		return stateObject
	end
end
iris.ShowDemoWindow = require(script.demoWindow)(iris)
require(script.widgets)(module)
require(script.API)(iris)
return iris
