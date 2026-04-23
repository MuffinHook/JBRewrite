require(script.Types)
local t = {}
local v1 = require(script.Internal)(t)
t.Disabled = false
t.Args = {}
t.Events = {}
function t.Init(p1, p2, p3) --[[ Line: 73 | Upvalues: v1 (copy), t (copy) ]]
	assert(v1._shutdown == false, "Iris.Init() cannot be called once shutdown.")
	assert(if v1._started == false then true else p3 == true, "Iris.Init() can only be called once.")
	if not v1._started then
		if p1 == nil then
			p1 = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
		end
		if p2 == nil then
			p2 = game:GetService("RunService").Heartbeat
		end
		v1.parentInstance = p1
		v1._started = true
		v1._generateRootInstance()
		v1._generateSelectionImageObject()
		for v3, v4 in v1._initFunctions do
			v4()
		end
		task.spawn(function() --[[ Line: 100 | Upvalues: p2 (ref), v1 (ref) ]]
			if typeof(p2) == "function" then
				while v1._started do
					v1._cycle((p2()))
				end
			elseif p2 ~= nil and p2 ~= false then
				v1._eventConnection = p2:Connect(function(...) --[[ Line: 107 | Upvalues: v1 (ref) ]]
					v1._cycle(...)
				end)
			end
		end)
	end
	return t
end
function t.Shutdown() --[[ Line: 122 | Upvalues: v1 (copy) ]]
	v1._started = false
	v1._shutdown = true
	if v1._eventConnection then
		v1._eventConnection:Disconnect()
	end
	v1._eventConnection = nil
	if v1._rootWidget then
		if v1._rootWidget.Instance then
			v1._widgets.Root.Discard(v1._rootWidget)
		end
		v1._rootInstance = nil
	end
	if v1.SelectionImageObject then
		v1.SelectionImageObject:Destroy()
	end
	for v12, v2 in v1._connections do
		v2:Disconnect()
	end
end
function t.Connect(p1, p2) --[[ Line: 159 | Upvalues: v1 (copy) ]]
	if v1._started == false then
		warn("Iris:Connect() was called before calling Iris.Init(); always initialise Iris first.")
	end
	local v12 = #v1._connectedFunctions + 1
	v1._connectedFunctions[v12] = p2
	return function() --[[ Line: 165 | Upvalues: v1 (ref), v12 (copy) ]]
		v1._connectedFunctions[v12] = nil
	end
end
function t.Append(p1) --[[ Line: 180 | Upvalues: v1 (copy) ]]
	local v12 = v1._GetParentWidget()
	p1.Parent = v1._config.Parent or v1._widgets[v12.type].ChildAdded(v12, {
		type = "userInstance"
	})
end
function t.End() --[[ Line: 218 | Upvalues: v1 (copy) ]]
	if v1._stackIndex == 1 then
		error("Too many calls to Iris.End().", 2)
	end
	v1._IDStack[v1._stackIndex] = nil
	local v12 = v1
	v12._stackIndex = v12._stackIndex - 1
end
function t.ForceRefresh() --[[ Line: 243 | Upvalues: v1 (copy) ]]
	v1._globalRefreshRequested = true
end
function t.UpdateGlobalConfig(p1) --[[ Line: 265 | Upvalues: v1 (copy), t (copy) ]]
	for v12, v2 in p1 do
		v1._rootConfig[v12] = v2
	end
	t.ForceRefresh()
end
function t.PushConfig(p1) --[[ Line: 290 | Upvalues: t (copy), v1 (copy) ]]
	local v12 = t.State(-1)
	if v12.value == -1 then
		v12:set(p1)
	elseif v1._deepCompare(v12:get(), p1) == false then
		v12:set(p1)
		v1._refreshStack[v1._refreshLevel] = true
		local v2 = v1
		v2._refreshCounter = v2._refreshCounter + 1
	end
	local v3 = v1
	v3._refreshLevel = v3._refreshLevel + 1
	v1._config = setmetatable(p1, {
		__index = v1._config
	})
end
function t.PopConfig() --[[ Line: 318 | Upvalues: v1 (copy) ]]
	local v12 = v1
	v12._refreshLevel = v12._refreshLevel - 1
	if v1._refreshStack[v1._refreshLevel] == true then
		local v2 = v1
		v2._refreshCounter = v2._refreshCounter - 1
		v1._refreshStack[v1._refreshLevel] = nil
	end
	v1._config = getmetatable(v1._config).__index
end
t.TemplateConfig = require(script.config)
t.UpdateGlobalConfig(t.TemplateConfig.colorDark)
t.UpdateGlobalConfig(t.TemplateConfig.sizeDefault)
t.UpdateGlobalConfig(t.TemplateConfig.utilityDefault)
v1._globalRefreshRequested = false
function t.PushId(p1) --[[ Line: 354 | Upvalues: v1 (copy) ]]
	assert(typeof(p1) == "string", "The ID argument to Iris.PushId() to be a string.")
	v1._newID = true
	table.insert(v1._pushedIds, p1)
end
function t.PopId() --[[ Line: 367 | Upvalues: v1 (copy) ]]
	if #v1._pushedIds ~= 0 then
		table.remove(v1._pushedIds)
	end
end
function t.SetNextWidgetID(p1) --[[ Line: 397 | Upvalues: v1 (copy) ]]
	v1._nextWidgetId = p1
end
function t.State(p1) --[[ Line: 439 | Upvalues: v1 (copy), t (copy) ]]
	local v12 = v1._getID(2)
	if v1._states[v12] then
		return v1._states[v12]
	else
		local t2 = {
			ID = v12,
			value = p1,
			lastChangeTick = t.Internal._cycleTick,
			ConnectedWidgets = {},
			ConnectedFunctions = {}
		}
		setmetatable(t2, v1.StateClass)
		v1._states[v12] = t2
		return t2
	end
end
function t.WeakState(p1) --[[ Line: 465 | Upvalues: v1 (copy), t (copy) ]]
	local v12 = v1._getID(2)
	if v1._states[v12] then
		if next(v1._states[v12].ConnectedWidgets) == nil then
			v1._states[v12] = nil
		else
			return v1._states[v12]
		end
	end
	local t2 = {
		ID = v12,
		value = p1,
		lastChangeTick = t.Internal._cycleTick,
		ConnectedWidgets = {},
		ConnectedFunctions = {}
	}
	setmetatable(t2, v1.StateClass)
	v1._states[v12] = t2
	return t2
end
function t.VariableState(p1, p2) --[[ Line: 524 | Upvalues: v1 (copy), t (copy) ]]
	local v12 = v1._getID(2)
	local v2 = v1._states[v12]
	if v2 then
		if p1 ~= v2.value then
			v2:set(p1)
		end
		return v2
	else
		local t2 = {
			ID = v12,
			value = p1,
			lastChangeTick = t.Internal._cycleTick,
			ConnectedWidgets = {},
			ConnectedFunctions = {}
		}
		setmetatable(t2, v1.StateClass)
		v1._states[v12] = t2
		t2:onChange(p2)
		return t2
	end
end
function t.TableState(p1, p2, p3) --[[ Line: 604 | Upvalues: v1 (copy), t (copy) ]]
	local v12 = p1[p2]
	local v2 = v1._getID(2)
	local v3 = v1._states[v2]
	if v3 then
		if v12 ~= v3.value then
			v3:set(v12)
		end
		return v3
	else
		local t2 = {
			ID = v2,
			value = v12,
			lastChangeTick = t.Internal._cycleTick,
			ConnectedWidgets = {},
			ConnectedFunctions = {}
		}
		setmetatable(t2, v1.StateClass)
		v1._states[v2] = t2
		t2:onChange(function() --[[ Line: 628 | Upvalues: p3 (copy), t2 (copy), p1 (copy), p2 (copy) ]]
			if p3 == nil then
				p1[p2] = t2.value
			elseif p3(t2.value) then
				p1[p2] = t2.value
			end
		end)
		return t2
	end
end
function t.ComputedState(p1, p2) --[[ Line: 657 | Upvalues: v1 (copy), t (copy) ]]
	local v12 = v1._getID(2)
	if v1._states[v12] then
		return v1._states[v12]
	else
		local t2 = {
			ID = v12,
			value = p2(p1.value),
			lastChangeTick = t.Internal._cycleTick,
			ConnectedWidgets = {},
			ConnectedFunctions = {}
		}
		setmetatable(t2, v1.StateClass)
		v1._states[v12] = t2
		p1:onChange(function(p1) --[[ Line: 673 | Upvalues: t2 (copy), p2 (copy) ]]
			t2:set(p2(p1))
		end)
		return t2
	end
end
t.ShowDemoWindow = require(script.demoWindow)(t)
require(script.widgets)(v1)
require(script.API)(t)
return t