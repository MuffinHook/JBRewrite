-- Reviewed by Claude
require(script.Types)
local t = {}
local module = require(script.Internal)(t)
t.Disabled = false
t.Args = {}
t.Events = {}
function t.Init(p1, p2, p3)
	assert(module._shutdown == false, "Iris.Init() cannot be called once shutdown.")
	assert(if module._started == false then true else p3 == true, "Iris.Init() can only be called once.")
	if not module._started then
		if p1 == nil then
			p1 = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
		end
		if p2 == nil then
			p2 = game:GetService("RunService").Heartbeat
		end
		module.parentInstance = p1
		module._started = true
		module._generateRootInstance()
		module._generateSelectionImageObject()
		for var3, v4 in module._initFunctions do
			v4()
		end
		task.spawn(function()
			if typeof(p2) == "function" then
				while module._started do
					module._cycle((p2()))
				end
			elseif p2 ~= nil and p2 ~= false then
				module._eventConnection = p2:Connect(function(...)
					module._cycle(...)
				end)
			end
		end)
	end
	return t
end
function t.Shutdown()
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
	for var12, v2 in module._connections do
		v2:Disconnect()
	end
end
function t.Connect(p1, p2)
	if module._started == false then
		warn("Iris:Connect() was called before calling Iris.Init(); always initialise Iris first.")
	end
	local var12 = #module._connectedFunctions + 1
	module._connectedFunctions[var12] = p2
	return function()
		module._connectedFunctions[var12] = nil
	end
end
function t.Append(p1)
	local var12 = module._GetParentWidget()
	p1.Parent = module._config.Parent or module._widgets[var12.type].ChildAdded(var12, {
		type = "userInstance"
	})
end
function t.End()
	if module._stackIndex == 1 then
		error("Too many calls to Iris.End().", 2)
	end
	module._IDStack[module._stackIndex] = nil
	local var12 = module
	var12._stackIndex = var12._stackIndex - 1
end
function t.ForceRefresh()
	module._globalRefreshRequested = true
end
function t.UpdateGlobalConfig(p1)
	for var12, v2 in p1 do
		module._rootConfig[var12] = v2
	end
	t.ForceRefresh()
end
function t.PushConfig(p1)
	local var12 = t.State(-1)
	if var12.value == -1 then
		var12:set(p1)
	elseif module._deepCompare(var12:get(), p1) == false then
		var12:set(p1)
		module._refreshStack[module._refreshLevel] = true
		local v2 = module
		v2._refreshCounter = v2._refreshCounter + 1
	end
	local var3 = module
	var3._refreshLevel = var3._refreshLevel + 1
	module._config = setmetatable(p1, {
		__index = module._config
	})
end
function t.PopConfig()
	local var12 = module
	var12._refreshLevel = var12._refreshLevel - 1
	if module._refreshStack[module._refreshLevel] == true then
		local v2 = module
		v2._refreshCounter = v2._refreshCounter - 1
		module._refreshStack[module._refreshLevel] = nil
	end
	module._config = getmetatable(module._config).__index
end
t.TemplateConfig = require(script.config)
t.UpdateGlobalConfig(t.TemplateConfig.colorDark)
t.UpdateGlobalConfig(t.TemplateConfig.sizeDefault)
t.UpdateGlobalConfig(t.TemplateConfig.utilityDefault)
module._globalRefreshRequested = false
function t.PushId(p1)
	assert(typeof(p1) == "string", "The ID argument to Iris.PushId() to be a string.")
	module._newID = true
	table.insert(module._pushedIds, p1)
end
function t.PopId()
	if #module._pushedIds ~= 0 then
		table.remove(module._pushedIds)
	end
end
function t.SetNextWidgetID(p1)
	module._nextWidgetId = p1
end
function t.State(p1)
	local var12 = module._getID(2)
	if module._states[var12] then
		return module._states[var12]
	else
		local t2 = {
			ID = var12,
			value = p1,
			lastChangeTick = t.Internal._cycleTick,
			ConnectedWidgets = {},
			ConnectedFunctions = {}
		}
		setmetatable(t2, module.StateClass)
		module._states[var12] = t2
		return t2
	end
end
function t.WeakState(p1)
	local var12 = module._getID(2)
	if module._states[var12] then
		if next(module._states[var12].ConnectedWidgets) == nil then
			module._states[var12] = nil
		else
			return module._states[var12]
		end
	end
	local t2 = {
		ID = var12,
		value = p1,
		lastChangeTick = t.Internal._cycleTick,
		ConnectedWidgets = {},
		ConnectedFunctions = {}
	}
	setmetatable(t2, module.StateClass)
	module._states[var12] = t2
	return t2
end
function t.VariableState(p1, p2)
	local var12 = module._getID(2)
	local v2 = module._states[var12]
	if v2 then
		if p1 ~= v2.value then
			v2:set(p1)
		end
		return v2
	else
		local t2 = {
			ID = var12,
			value = p1,
			lastChangeTick = t.Internal._cycleTick,
			ConnectedWidgets = {},
			ConnectedFunctions = {}
		}
		setmetatable(t2, module.StateClass)
		module._states[var12] = t2
		t2:onChange(p2)
		return t2
	end
end
function t.TableState(p1, p2, p3)
	local var12 = p1[p2]
	local v2 = module._getID(2)
	local var3 = module._states[v2]
	if var3 then
		if var12 ~= var3.value then
			var3:set(var12)
		end
		return var3
	else
		local t2 = {
			ID = v2,
			value = var12,
			lastChangeTick = t.Internal._cycleTick,
			ConnectedWidgets = {},
			ConnectedFunctions = {}
		}
		setmetatable(t2, module.StateClass)
		module._states[v2] = t2
		t2:onChange(function()
			if p3 == nil then
				p1[p2] = t2.value
			elseif p3(t2.value) then
				p1[p2] = t2.value
			end
		end)
		return t2
	end
end
function t.ComputedState(p1, p2)
	local var12 = module._getID(2)
	if module._states[var12] then
		return module._states[var12]
	else
		local t2 = {
			ID = var12,
			value = p2(p1.value),
			lastChangeTick = t.Internal._cycleTick,
			ConnectedWidgets = {},
			ConnectedFunctions = {}
		}
		setmetatable(t2, module.StateClass)
		module._states[var12] = t2
		p1:onChange(function(p1)
			t2:set(p2(p1))
		end)
		return t2
	end
end
t.ShowDemoWindow = require(script.demoWindow)(t)
require(script.widgets)(module)
require(script.API)(t)
return t
