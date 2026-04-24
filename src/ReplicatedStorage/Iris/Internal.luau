-- Reviewed by Claude
require(script.Parent.Types)
return function(p1)
	local t = {
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
	t._rootWidget = {
		ID = "R",
		type = "Root",
		Instance = t._rootInstance,
		ZIndex = 0,
		ZOffset = 0
	}
	t._lastWidget = t._rootWidget
	t._rootConfig = {}
	t._config = t._rootConfig
	t._IDStack = { "R" }
	t._usedIDs = {}
	t._pushedIds = {}
	t._newID = false
	t._nextWidgetId = nil
	t._states = {}
	t._postCycleCallbacks = {}
	t._connectedFunctions = {}
	t._connections = {}
	t._initFunctions = {}
	t._fullErrorTracebacks = game:GetService("RunService"):IsStudio()
	t._cycleCoroutine = coroutine.create(function()
		while t._started do
			for signal, v2 in t._connectedFunctions do
				debug.profilebegin("Iris/Connection")
				local var3, var4 = pcall(v2)
				debug.profileend()
				if not var3 then
					t._stackIndex = 1
					coroutine.yield(false, var4)
				end
			end
			coroutine.yield(true)
		end
	end)
	local t2 = {}
	t2.__index = t2
	function t2.get(p1)
		return p1.value
	end
	function t2.set(p12, p2, p3)
		if p2 ~= p12.value or p3 == true then
			p12.value = p2
			p12.lastChangeTick = p1.Internal._cycleTick
			for signal, v2 in p12.ConnectedWidgets do
				if v2.lastCycleTick ~= -1 then
					t._widgets[v2.type].UpdateState(v2)
				end
			end
			for var3, var4 in p12.ConnectedFunctions do
				var4(p2)
			end
		end
		return p12.value
	end
	function t2.onChange(p1, p2)
		local signal = #p1.ConnectedFunctions + 1
		p1.ConnectedFunctions[signal] = p2
		return function()
			p1.ConnectedFunctions[signal] = nil
		end
	end
	function t2.changed(p1)
		return p1.lastChangeTick + 1 == t._cycleTick
	end
	t.StateClass = t2
	function t._cycle(p12)
		if not p1.Disabled then
			t._rootWidget.lastCycleTick = t._cycleTick
			if t._rootInstance == nil or t._rootInstance.Parent == nil then
				p1.ForceRefresh()
			end
			for signal, v2 in t._lastVDOM do
				if v2.lastCycleTick ~= t._cycleTick and v2.lastCycleTick ~= -1 then
					t._DiscardWidget(v2)
				end
			end
			setmetatable(t._lastVDOM, {
				__mode = "kv"
			})
			t._lastVDOM = t._VDOM
			t._VDOM = t._generateEmptyVDOM()
			task.spawn(function()
				for signal, v2 in t._postCycleCallbacks do
					v2()
				end
			end)
			if t._globalRefreshRequested then
				t._generateSelectionImageObject()
				t._globalRefreshRequested = false
				for var3, var4 in t._lastVDOM do
					t._DiscardWidget(var4)
				end
				t._generateRootInstance()
				t._lastVDOM = t._generateEmptyVDOM()
			end
			local var5 = t
			var5._cycleTick = var5._cycleTick + 1
			t._deltaTime = p12
			table.clear(t._usedIDs)
			if (t.parentInstance:IsA("GuiBase2d") or t.parentInstance:IsA("BasePlayerGui")) == false then
				error("The Iris parent instance will not display any GUIs.")
			end
			if t._fullErrorTracebacks then
				for var7, var8 in t._connectedFunctions do
					var8()
				end
			else
				local var9 = coroutine.status(t._cycleCoroutine)
				if var9 == "suspended" then
					local _, v10, v11 = coroutine.resume(t._cycleCoroutine)
					if v10 == false then
						error(v11, 0)
					end
				elseif var9 == "running" then
					error("Iris cycleCoroutine took to long to yield. Connected functions should not yield.")
				else
					error("unrecoverable state")
				end
			end
			if t._stackIndex ~= 1 then
				t._stackIndex = 1
				error("Too few calls to Iris.End().", 0)
			end
			if #t._pushedIds ~= 0 then
				error("Too few calls to Iris.PopId().", 0)
			end
		end
	end
	function t._NoOp() end
	function t.WidgetConstructor(p12, p2)
		local t2 = {
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
		local t3 = {}
		for v2, var3 in t2.All.Required do
			local signal
			signal = p2[var3] ~= nil
			assert(signal, (("field %* is missing from widget %*, it is required for all widgets"):format(var3, p12)))
			t3[var3] = p2[var3]
		end
		for var5, v6 in t2.All.Optional do
			if p2[v6] == nil then
				t3[v6] = t._NoOp
			else
				t3[v6] = p2[v6]
			end
		end
		if p2.hasState then
			for var8, var9 in t2.IfState.Required do
				local var7
				var7 = p2[var9] ~= nil
				assert(var7, (("field %* is missing from widget %*, it is required for all widgets with state"):format(var9, p12)))
				t3[var9] = p2[var9]
			end
			for v11, v12 in t2.IfState.Optional do
				if p2[v12] == nil then
					t3[v12] = t._NoOp
				else
					t3[v12] = p2[v12]
				end
			end
		end
		if p2.hasChildren then
			for v14, v15 in t2.IfChildren.Required do
				local v13
				v13 = p2[v15] ~= nil
				assert(v13, (("field %* is missing from widget %*, it is required for all widgets with children"):format(v15, p12)))
				t3[v15] = p2[v15]
			end
			for v17, v18 in t2.IfChildren.Optional do
				if p2[v18] == nil then
					t3[v18] = t._NoOp
				else
					t3[v18] = p2[v18]
				end
			end
		end
		t._widgets[p12] = t3
		p1.Args[p12] = t3.Args
		local t4 = {}
		for v19, v20 in t3.Args do
			t4[v20] = v19
		end
		t3.ArgNames = t4
		for v21, v22 in t3.Events do
			if p1.Events[v21] == nil then
				p1.Events[v21] = function()
					return t._EventCall(t._lastWidget, v21)
				end
			end
		end
	end
	function t._Insert(p1, p2, p3)
		local signal = t._getID(3)
		local v2 = t._widgets[p1]
		if t._VDOM[signal] then
			return t._ContinueWidget(signal, p1)
		else
			local t2 = {}
			if p2 ~= nil then
				if type(p2) ~= "table" then
					p2 = { p2 }
				end
				for var3, var4 in p2 do
					assert(var3 > 0, (("Widget Arguments must be a positive number, not %* of type %* for %*."):format(var3, typeof(var3), var4)))
					t2[v2.ArgNames[var3]] = var4
				end
			end
			table.freeze(t2)
			local var7 = t._lastVDOM[signal]
			if var7 and (p1 == var7.type and t._refreshCounter > 0) then
				t._DiscardWidget(var7)
				var7 = nil
			end
			local var8 = if var7 == nil then t._GenNewWidget(p1, t2, p3, signal) else var7
			local parentWidget = var8.parentWidget
			if var8.type ~= "Window" and var8.type ~= "Tooltip" then
				if var8.ZIndex ~= parentWidget.ZOffset then
					parentWidget.ZUpdate = true
				end
				if parentWidget.ZUpdate then
					var8.ZIndex = parentWidget.ZOffset
					if var8.Instance then
						var8.Instance.ZIndex = var8.ZIndex
						var8.Instance.LayoutOrder = var8.ZIndex
					end
				end
			end
			if parentWidget.type == "Table" then
				parentWidget._rowCycles[parentWidget._rowIndex] = t._cycleTick
			end
			if t._deepCompare(var8.providedArguments, t2) == false then
				var8.arguments = t._deepCopy(t2)
				var8.providedArguments = t2
				v2.Update(var8)
			end
			var8.lastCycleTick = t._cycleTick
			parentWidget.ZOffset = parentWidget.ZOffset + 1
			if v2.hasChildren then
				var8.ZOffset = 0
				var8.ZUpdate = false
				local var9 = t
				var9._stackIndex = var9._stackIndex + 1
				t._IDStack[t._stackIndex] = var8.ID
			end
			t._VDOM[signal] = var8
			t._lastWidget = var8
			return var8
		end
	end
	function t._GenNewWidget(p1, p2, p3, p4)
		local v2 = t._VDOM[t._IDStack[t._stackIndex]]
		local var3 = t._widgets[p1]
		local t2 = {}
		setmetatable(t2, t2)
		t2.ID = p4
		t2.type = p1
		t2.parentWidget = v2
		t2.trackedEvents = {}
		t2.ZIndex = v2.ZOffset
		t2.Instance = var3.Generate(t2)
		local parentWidget = t2.parentWidget
		if t._config.Parent then
			t2.Instance.Parent = t._config.Parent
		else
			t2.Instance.Parent = t._widgets[parentWidget.type].ChildAdded(parentWidget, t2)
		end
		t2.providedArguments = p2
		t2.arguments = t._deepCopy(p2)
		var3.Update(t2)
		local var4
		if var3.hasState then
			if p3 then
				for var5, v6 in p3 do
					if type(v6) ~= "table" or getmetatable(v6) ~= t.StateClass then
						p3[var5] = t._widgetState(t2, var5, v6)
					end
					p3[var5].lastChangeTick = t._cycleTick
				end
				t2.state = p3
				for var7, var8 in p3 do
					var8.ConnectedWidgets[t2.ID] = t2
				end
			else
				t2.state = {}
			end
			var3.GenerateState(t2)
			var3.UpdateState(t2)
			t2.stateMT = {}
			setmetatable(t2.state, t2.stateMT)
			t2.__index = t2.state
			var4 = t2.stateMT
		else
			var4 = t2
		end
		function var4.__index(p1, p2)
			return function()
				return t._EventCall(t2, p2)
			end
		end
		return t2
	end
	function t._ContinueWidget(p1, p2)
		local v2 = t._VDOM[p1]
		if t._widgets[p2].hasChildren then
			local var3 = t
			var3._stackIndex = var3._stackIndex + 1
			t._IDStack[t._stackIndex] = v2.ID
		end
		t._lastWidget = v2
		return v2
	end
	function t._DiscardWidget(p1)
		local parentWidget = p1.parentWidget
		if parentWidget then
			t._widgets[parentWidget.type].ChildDiscarded(parentWidget, p1)
		end
		t._widgets[p1.type].Discard(p1)
		p1.lastCycleTick = -1
	end
	function t._widgetState(p1, p2, p3)
		local signal = p1.ID .. p2
		if t._states[signal] then
			t._states[signal].ConnectedWidgets[p1.ID] = p1
			t._states[signal].lastChangeTick = t._cycleTick
			return t._states[signal]
		else
			local t2 = {
				ID = signal,
				value = p3,
				lastChangeTick = t._cycleTick,
				ConnectedWidgets = {
					[p1.ID] = p1
				},
				ConnectedFunctions = {}
			}
			setmetatable(t2, t.StateClass)
			t._states[signal] = t2
			return t2
		end
	end
	function t._EventCall(p1, p2)
		local signal = t._widgets[p1.type].Events[p2]
		assert(signal ~= nil, (("widget %* has no event of name %*"):format(p1.type, p2)))
		if p1.trackedEvents[p2] == nil then
			signal.Init(p1)
			p1.trackedEvents[p2] = true
		end
		return signal.Get(p1)
	end
	function t._GetParentWidget()
		return t._VDOM[t._IDStack[t._stackIndex]]
	end
	function t._generateEmptyVDOM()
		return {
			R = t._rootWidget
		}
	end
	function t._generateRootInstance()
		t._rootInstance = t._widgets.Root.Generate(t._widgets.Root)
		t._rootInstance.Parent = t.parentInstance
		t._rootWidget.Instance = t._rootInstance
	end
	function t._generateSelectionImageObject()
		if t.SelectionImageObject then
			t.SelectionImageObject:Destroy()
		end
		local Frame = Instance.new("Frame")
		Frame.Position = UDim2.fromOffset(-1, -1)
		Frame.Size = UDim2.new(1, 2, 1, 2)
		Frame.BackgroundColor3 = t._config.SelectionImageObjectColor
		Frame.BackgroundTransparency = t._config.SelectionImageObjectTransparency
		Frame.BorderSizePixel = 0
		t._utility.UIStroke(Frame, 1, t._config.SelectionImageObjectBorderColor, t._config.SelectionImageObjectBorderTransparency)
		t._utility.UICorner(Frame, 2)
		t.SelectionImageObject = Frame
	end
	function t._getID(p1)
		if t._nextWidgetId then
			local _nextWidgetId = t._nextWidgetId
			t._nextWidgetId = nil
			return _nextWidgetId
		else
			local count = 1 + (p1 or 1)
			local signal = debug.info(count, "l")
			local v2 = ""
			while signal ~= -1 and signal ~= nil do
				count = count + 1
				signal, v2 = debug.info(count, "l"), v2 .. "+" .. signal
			end
			local var4 = t._usedIDs[v2]
			local var5
			if var4 then
				local _usedIDs = t._usedIDs
				_usedIDs[v2] = _usedIDs[v2] + 1
				var5 = var4 + 1
			else
				t._usedIDs[v2] = 1
				var5 = 1
			end
			if #t._pushedIds == 0 then
				return v2 .. ":" .. var5
			elseif t._newID then
				t._newID = false
				return v2 .. "::" .. table.concat(t._pushedIds, "\\")
			else
				return v2 .. ":" .. var5 .. ":" .. table.concat(t._pushedIds, "\\")
			end
		end
	end
	function t._deepCompare(p1, p2)
		for signal, v2 in p1 do
			local var3 = p2[signal]
			if type(v2) == "table" then
				if not var3 or type(var3) ~= "table" then
					return false
				end
				if t._deepCompare(v2, var3) == false then
					return false
				end
			elseif type(v2) ~= type(var3) or v2 ~= var3 then
				return false
			end
		end
		return true
	end
	function t._deepCopy(p1)
		local signal = table.clone(p1)
		for v2, var3 in p1 do
			if type(var3) == "table" then
				signal[v2] = t._deepCopy(var3)
			end
		end
		return signal
	end
	t._lastVDOM = t._generateEmptyVDOM()
	t._VDOM = t._generateEmptyVDOM()
	p1.Internal = t
	p1._config = t._config
	return t
end
