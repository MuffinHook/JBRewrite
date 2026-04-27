require(script.Parent.Types)
return function(config)
	local irisInternal = {
		_version = " 2.5.0 ",
		_started = false,
		_shutdown = false,
		_cycleTick = 0,
		_deltaTime = 0,
		_globalRefreshRequested = false,
		_refreshCounter = 0,
		_refreshLevel = 1,
		_refreshStack = table.create(16),
		_widgets = {},
		_stackIndex = 1,
		_rootInstance = nil
	}
	irisInternal._rootWidget = {
		ID = "R",
		type = "Root",
		Instance = irisInternal._rootInstance,
		ZIndex = 0,
		ZOffset = 0
	}
	irisInternal._lastWidget = irisInternal._rootWidget
	irisInternal._rootConfig = {}
	irisInternal._config = irisInternal._rootConfig
	irisInternal._IDStack = { "R" }
	irisInternal._usedIDs = {}
	irisInternal._pushedIds = {}
	irisInternal._newID = false
	irisInternal._nextWidgetId = nil
	irisInternal._states = {}
	irisInternal._postCycleCallbacks = {}
	irisInternal._connectedFunctions = {}
	irisInternal._connections = {}
	irisInternal._initFunctions = {}
	irisInternal._fullErrorTracebacks = game:GetService("RunService"):IsStudio()
	irisInternal._cycleCoroutine = coroutine.create(function()
		while irisInternal._started do
			for connectionId, connectedFunction in irisInternal._connectedFunctions do
				debug.profilebegin("Iris/Connection")
				local success, errorMessage = pcall(connectedFunction)
				debug.profileend()
				if not success then
					irisInternal._stackIndex = 1
					coroutine.yield(false, errorMessage)
				end
			end
			coroutine.yield(true)
		end
	end)
	local StateClass = {}
	StateClass.__index = StateClass
	function StateClass.get(state)
		return state.value
	end
	function StateClass.set(state, newValue, forceUpdate)
		if newValue ~= state.value or forceUpdate == true then
			state.value = newValue
			state.lastChangeTick = config.Internal._cycleTick
			for widgetId, connectedWidget in state.ConnectedWidgets do
				if connectedWidget.lastCycleTick ~= -1 then
					irisInternal._widgets[connectedWidget.type].UpdateState(connectedWidget)
				end
			end
			for functionIndex, connectedFunction in state.ConnectedFunctions do
				connectedFunction(newValue)
			end
		end
		return state.value
	end
	function StateClass.onChange(state, callback)
		local connectionId = #state.ConnectedFunctions + 1
		state.ConnectedFunctions[connectionId] = callback
		return function()
			state.ConnectedFunctions[connectionId] = nil
		end
	end
	function StateClass.changed(state)
		return state.lastChangeTick + 1 == irisInternal._cycleTick
	end
	irisInternal.StateClass = StateClass
	function irisInternal._cycle(deltaTime)
		if not config.Disabled then
			irisInternal._rootWidget.lastCycleTick = irisInternal._cycleTick
			if irisInternal._rootInstance == nil or irisInternal._rootInstance.Parent == nil then
				config.ForceRefresh()
			end
			for elementId, vdomElement in irisInternal._lastVDOM do
				if vdomElement.lastCycleTick ~= irisInternal._cycleTick and vdomElement.lastCycleTick ~= -1 then
					irisInternal._DiscardWidget(vdomElement)
				end
			end
			setmetatable(irisInternal._lastVDOM, {
				__mode = "kv"
			})
			irisInternal._lastVDOM = irisInternal._VDOM
			irisInternal._VDOM = irisInternal._generateEmptyVDOM()
			task.spawn(function()
				for callbackId, postCycleCallback in irisInternal._postCycleCallbacks do
					postCycleCallback()
				end
			end)
			if irisInternal._globalRefreshRequested then
				irisInternal._generateSelectionImageObject()
				irisInternal._globalRefreshRequested = false
				for elementId, vdomElement in irisInternal._lastVDOM do
					irisInternal._DiscardWidget(vdomElement)
				end
				irisInternal._generateRootInstance()
				irisInternal._lastVDOM = irisInternal._generateEmptyVDOM()
			end
			local cycleTicker = irisInternal
			cycleTicker._cycleTick = cycleTicker._cycleTick + 1
			irisInternal._deltaTime = deltaTime
			table.clear(irisInternal._usedIDs)
			if (irisInternal.parentInstance:IsA("GuiBase2d") or irisInternal.parentInstance:IsA("BasePlayerGui")) == false then
				error("The Iris parent instance will not display any GUIs.")
			end
			if irisInternal._fullErrorTracebacks then
				for functionId, connectedFunction in irisInternal._connectedFunctions do
					connectedFunction()
				end
			else
				local coroutineStatus = coroutine.status(irisInternal._cycleCoroutine)
				if coroutineStatus == "suspended" then
					local _, didSucceed, errorOrResult = coroutine.resume(irisInternal._cycleCoroutine)
					if didSucceed == false then
						error(errorOrResult, 0)
					end
				elseif coroutineStatus == "running" then
					error("Iris cycleCoroutine took to long to yield. Connected functions should not yield.")
				else
					error("unrecoverable state")
				end
			end
			if irisInternal._stackIndex ~= 1 then
				irisInternal._stackIndex = 1
				error("Too few calls to Iris.End().", 0)
			end
			if #irisInternal._pushedIds ~= 0 then
				error("Too few calls to Iris.PopId().", 0)
			end
		end
	end
	function irisInternal._NoOp() end
	function irisInternal.WidgetConstructor(widgetType, widgetDefinition)
		local validationSchema = {
			All = {
				Required = { "Generate", "Discard", "Update", "Args", "Events", "hasChildren", "hasState" },
				Optional = {}
			},
			IfState = {
				Required = { "GenerateState", "UpdateState" },
				Optional = {}
			},
			IfChildren = {
				Required = { "ChildAdded" },
				Optional = { "ChildDiscarded" }
			}
		}
		local widgetClass = {}
		for requiredFieldIndex, requiredFieldName in validationSchema.All.Required do
			local fieldExists
			fieldExists = widgetDefinition[requiredFieldName] ~= nil
			assert(fieldExists, (("field %* is missing from widget %*, it is required for all widgets"):format(requiredFieldName, widgetType)))
			widgetClass[requiredFieldName] = widgetDefinition[requiredFieldName]
		end
		for optionalFieldIndex, optionalFieldName in validationSchema.All.Optional do
			if widgetDefinition[optionalFieldName] == nil then
				widgetClass[optionalFieldName] = irisInternal._NoOp
			else
				widgetClass[optionalFieldName] = widgetDefinition[optionalFieldName]
			end
		end
		if widgetDefinition.hasState then
			for stateFieldIndex, stateFieldName in validationSchema.IfState.Required do
				local stateFieldExists
				stateFieldExists = widgetDefinition[stateFieldName] ~= nil
				assert(stateFieldExists, (("field %* is missing from widget %*, it is required for all widgets with state"):format(stateFieldName, widgetType)))
				widgetClass[stateFieldName] = widgetDefinition[stateFieldName]
			end
			for stateOptionalIndex, stateOptionalName in validationSchema.IfState.Optional do
				if widgetDefinition[stateOptionalName] == nil then
					widgetClass[stateOptionalName] = irisInternal._NoOp
				else
					widgetClass[stateOptionalName] = widgetDefinition[stateOptionalName]
				end
			end
		end
		if widgetDefinition.hasChildren then
			for childFieldIndex, childFieldName in validationSchema.IfChildren.Required do
				local childFieldExists
				childFieldExists = widgetDefinition[childFieldName] ~= nil
				assert(childFieldExists, (("field %* is missing from widget %*, it is required for all widgets with children"):format(childFieldName, widgetType)))
				widgetClass[childFieldName] = widgetDefinition[childFieldName]
			end
			for childOptionalIndex, childOptionalName in validationSchema.IfChildren.Optional do
				if widgetDefinition[childOptionalName] == nil then
					widgetClass[childOptionalName] = irisInternal._NoOp
				else
					widgetClass[childOptionalName] = widgetDefinition[childOptionalName]
				end
			end
		end
		irisInternal._widgets[widgetType] = widgetClass
		config.Args[widgetType] = widgetClass.Args
		local argNameMapping = {}
		for argIndex, argName in widgetClass.Args do
			argNameMapping[argName] = argIndex
		end
		widgetClass.ArgNames = argNameMapping
		for eventIndex, eventName in widgetClass.Events do
			if config.Events[eventIndex] == nil then
				config.Events[eventIndex] = function()
					return irisInternal._EventCall(irisInternal._lastWidget, eventIndex)
				end
			end
		end
	end
	function irisInternal._Insert(widgetType, providedArgs, stateDict)
		local widgetId = irisInternal._getID(3)
		local widgetClass = irisInternal._widgets[widgetType]
		if irisInternal._VDOM[widgetId] then
			return irisInternal._ContinueWidget(widgetId, widgetType)
		else
			local processedArgs = {}
			if providedArgs ~= nil then
				if type(providedArgs) ~= "table" then
					providedArgs = { providedArgs }
				end
				for argIndex, argValue in providedArgs do
					assert(argIndex > 0, (("Widget Arguments must be a positive number, not %* of type %* for %*."):format(argIndex, typeof(argIndex), argValue)))
					processedArgs[widgetClass.ArgNames[argIndex]] = argValue
				end
			end
			table.freeze(processedArgs)
			local previousVDOMElement = irisInternal._lastVDOM[widgetId]
			if previousVDOMElement and (widgetType == previousVDOMElement.type and irisInternal._refreshCounter > 0) then
				irisInternal._DiscardWidget(previousVDOMElement)
				previousVDOMElement = nil
			end
			local currentWidget = if previousVDOMElement == nil then irisInternal._GenNewWidget(widgetType, processedArgs, stateDict, widgetId) else previousVDOMElement
			local parentWidget = currentWidget.parentWidget
			if currentWidget.type ~= "Window" and currentWidget.type ~= "Tooltip" then
				if currentWidget.ZIndex ~= parentWidget.ZOffset then
					parentWidget.ZUpdate = true
				end
				if parentWidget.ZUpdate then
					currentWidget.ZIndex = parentWidget.ZOffset
					if currentWidget.Instance then
						currentWidget.Instance.ZIndex = currentWidget.ZIndex
						currentWidget.Instance.LayoutOrder = currentWidget.ZIndex
					end
				end
			end
			if parentWidget.type == "Table" then
				parentWidget._rowCycles[parentWidget._rowIndex] = irisInternal._cycleTick
			end
			if irisInternal._deepCompare(currentWidget.providedArguments, processedArgs) == false then
				currentWidget.arguments = irisInternal._deepCopy(processedArgs)
				currentWidget.providedArguments = processedArgs
				widgetClass.Update(currentWidget)
			end
			currentWidget.lastCycleTick = irisInternal._cycleTick
			parentWidget.ZOffset = parentWidget.ZOffset + 1
			if widgetClass.hasChildren then
				currentWidget.ZOffset = 0
				currentWidget.ZUpdate = false
				local stackIncrementor = irisInternal
				stackIncrementor._stackIndex = stackIncrementor._stackIndex + 1
				irisInternal._IDStack[irisInternal._stackIndex] = currentWidget.ID
			end
			irisInternal._VDOM[widgetId] = currentWidget
			irisInternal._lastWidget = currentWidget
			return currentWidget
		end
	end
	function irisInternal._GenNewWidget(widgetType, processedArgs, stateDict, widgetId)
		local parentWidgetVDOM = irisInternal._VDOM[irisInternal._IDStack[irisInternal._stackIndex]]
		local widgetClass = irisInternal._widgets[widgetType]
		local newWidget = {}
		setmetatable(newWidget, newWidget)
		newWidget.ID = widgetId
		newWidget.type = widgetType
		newWidget.parentWidget = parentWidgetVDOM
		newWidget.trackedEvents = {}
		newWidget.ZIndex = parentWidgetVDOM.ZOffset
		newWidget.Instance = widgetClass.Generate(newWidget)
		local parentWidget = newWidget.parentWidget
		if irisInternal._config.Parent then
			newWidget.Instance.Parent = irisInternal._config.Parent
		else
			newWidget.Instance.Parent = irisInternal._widgets[parentWidget.type].ChildAdded(parentWidget, newWidget)
		end
		newWidget.providedArguments = processedArgs
		newWidget.arguments = irisInternal._deepCopy(processedArgs)
		widgetClass.Update(newWidget)
		local metatable
		if widgetClass.hasState then
			if stateDict then
				for stateKey, stateValue in stateDict do
					if type(stateValue) ~= "table" or getmetatable(stateValue) ~= irisInternal.StateClass then
						stateDict[stateKey] = irisInternal._widgetState(newWidget, stateKey, stateValue)
					end
					stateDict[stateKey].lastChangeTick = irisInternal._cycleTick
				end
				newWidget.state = stateDict
				for stateKey, stateObject in stateDict do
					stateObject.ConnectedWidgets[newWidget.ID] = newWidget
				end
			else
				newWidget.state = {}
			end
			widgetClass.GenerateState(newWidget)
			widgetClass.UpdateState(newWidget)
			newWidget.stateMT = {}
			setmetatable(newWidget.state, newWidget.stateMT)
			newWidget.__index = newWidget.state
			metatable = newWidget.stateMT
		else
			metatable = newWidget
		end
		function metatable.__index(widget, eventName)
			return function()
				return irisInternal._EventCall(newWidget, eventName)
			end
		end
		return newWidget
	end
	function irisInternal._ContinueWidget(widgetId, widgetType)
		local existingWidget = irisInternal._VDOM[widgetId]
		if irisInternal._widgets[widgetType].hasChildren then
			local stackIncrementor = irisInternal
			stackIncrementor._stackIndex = stackIncrementor._stackIndex + 1
			irisInternal._IDStack[irisInternal._stackIndex] = existingWidget.ID
		end
		irisInternal._lastWidget = existingWidget
		return existingWidget
	end
	function irisInternal._DiscardWidget(widget)
		local parentWidget = widget.parentWidget
		if parentWidget then
			irisInternal._widgets[parentWidget.type].ChildDiscarded(parentWidget, widget)
		end
		irisInternal._widgets[widget.type].Discard(widget)
		widget.lastCycleTick = -1
	end
	function irisInternal._widgetState(widget, stateKey, stateValue)
		local stateId = widget.ID .. stateKey
		if irisInternal._states[stateId] then
			irisInternal._states[stateId].ConnectedWidgets[widget.ID] = widget
			irisInternal._states[stateId].lastChangeTick = irisInternal._cycleTick
			return irisInternal._states[stateId]
		else
			local newState = {
				ID = stateId,
				value = stateValue,
				lastChangeTick = irisInternal._cycleTick,
				ConnectedWidgets = {
					[widget.ID] = widget
				},
				ConnectedFunctions = {}
			}
			setmetatable(newState, irisInternal.StateClass)
			irisInternal._states[stateId] = newState
			return newState
		end
	end
	function irisInternal._EventCall(widget, eventName)
		local eventDefinition = irisInternal._widgets[widget.type].Events[eventName]
		assert(eventDefinition ~= nil, (("widget %* has no event of name %*"):format(widget.type, eventName)))
		if widget.trackedEvents[eventName] == nil then
			eventDefinition.Init(widget)
			widget.trackedEvents[eventName] = true
		end
		return eventDefinition.Get(widget)
	end
	function irisInternal._GetParentWidget()
		return irisInternal._VDOM[irisInternal._IDStack[irisInternal._stackIndex]]
	end
	function irisInternal._generateEmptyVDOM()
		return {
			R = irisInternal._rootWidget
		}
	end
	function irisInternal._generateRootInstance()
		irisInternal._rootInstance = irisInternal._widgets.Root.Generate(irisInternal._widgets.Root)
		irisInternal._rootInstance.Parent = irisInternal.parentInstance
		irisInternal._rootWidget.Instance = irisInternal._rootInstance
	end
	function irisInternal._generateSelectionImageObject()
		if irisInternal.SelectionImageObject then
			irisInternal.SelectionImageObject:Destroy()
		end
		local Frame = Instance.new("Frame")
		Frame.Position = UDim2.fromOffset(-1, -1)
		Frame.Size = UDim2.new(1, 2, 1, 2)
		Frame.BackgroundColor3 = irisInternal._config.SelectionImageObjectColor
		Frame.BackgroundTransparency = irisInternal._config.SelectionImageObjectTransparency
		Frame.BorderSizePixel = 0
		irisInternal._utility.UIStroke(Frame, 1, irisInternal._config.SelectionImageObjectBorderColor, irisInternal._config.SelectionImageObjectBorderTransparency)
		irisInternal._utility.UICorner(Frame, 2)
		irisInternal.SelectionImageObject = Frame
	end
	function irisInternal._getID(depthOffset)
		if irisInternal._nextWidgetId then
			local nextId = irisInternal._nextWidgetId
			irisInternal._nextWidgetId = nil
			return nextId
		else
			local stackDepth = 1 + (depthOffset or 1)
			local lineNumber = debug.info(stackDepth, "l")
			local lineTraceKey = ""
			while lineNumber ~= -1 and lineNumber ~= nil do
				stackDepth = stackDepth + 1
				lineNumber, lineTraceKey = debug.info(stackDepth, "l"), lineTraceKey .. "+" .. lineNumber
			end
			local existingIdCount = irisInternal._usedIDs[lineTraceKey]
			local newIdNum
			if existingIdCount then
				local idCounter = irisInternal._usedIDs
				idCounter[lineTraceKey] = idCounter[lineTraceKey] + 1
				newIdNum = existingIdCount + 1
			else
				irisInternal._usedIDs[lineTraceKey] = 1
				newIdNum = 1
			end
			if #irisInternal._pushedIds == 0 then
				return lineTraceKey .. ":" .. newIdNum
			elseif irisInternal._newID then
				irisInternal._newID = false
				return lineTraceKey .. "::" .. table.concat(irisInternal._pushedIds, "\\")
			else
				return lineTraceKey .. ":" .. newIdNum .. ":" .. table.concat(irisInternal._pushedIds, "\\")
			end
		end
	end
	function irisInternal._deepCompare(originalTable, comparisonTable)
		for key, value in originalTable do
			local comparisonValue = comparisonTable[key]
			if type(value) == "table" then
				if not comparisonValue or type(comparisonValue) ~= "table" then
					return false
				end
				if irisInternal._deepCompare(value, comparisonValue) == false then
					return false
				end
			elseif type(value) ~= type(comparisonValue) or value ~= comparisonValue then
				return false
			end
		end
		return true
	end
	function irisInternal._deepCopy(sourceTable)
		local copiedTable = table.clone(sourceTable)
		for key, value in sourceTable do
			if type(value) == "table" then
				copiedTable[key] = irisInternal._deepCopy(value)
			end
		end
		return copiedTable
	end
	irisInternal._lastVDOM = irisInternal._generateEmptyVDOM()
	irisInternal._VDOM = irisInternal._generateEmptyVDOM()
	config.Internal = irisInternal
	config._config = irisInternal._config
	return irisInternal
end
