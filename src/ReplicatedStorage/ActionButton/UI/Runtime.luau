-- Reviewed by Claude
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")
local Dictionary = require(ReplicatedStorage.EzUi.Dictionary)
local Utils = require(ReplicatedStorage.EzUi.Utils)
local createElement = Roact.createElement
local Maid = require(ReplicatedStorage.Std.Maid)
local InputUtils = require(script.Parent.InputUtils)
local InputUtils_2 = require(ReplicatedStorage.Std.InputUtils)
local Radial = require(script.Parent.Radial)
local Grid = require(script.Parent.Grid)
local ActionButtonService = require(script.Parent.Parent.ActionButtonService)
local function isToggle(p1)
	local _inputTypePressed = p1._inputTypePressed
	if (_inputTypePressed == Enum.UserInputType.Touch or _inputTypePressed == Enum.UserInputType.MouseButton1) and p1.touchIsToggle then
		return true
	else
		return _inputTypePressed == Enum.UserInputType.Gamepad1 and p1.gamepadIsToggle and true or false
	end
end
local v1 = Roact.PureComponent:extend("Runtime")
v1.defaultProps = {
	gridPosition = UDim2.new(1, -10, 1, -70)
}
function v1.init(p1)
	p1._maid = Maid.new()
	p1:_fetchInputType()
	p1._maid:GiveTask(UserInputService.LastInputTypeChanged:Connect(function()
		p1:_fetchInputType()
		p1:_fetchState()
		task.delay(0, function()
			p1:_updateViewType()
		end)
	end))
	p1:_fetchState()
	p1._maid:GiveTask(ActionButtonService.triggerUpdate:Connect(function()
		p1:_fetchState()
	end))
	p1._maid:GiveTask(workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
		p1:_updateViewType()
	end))
	p1:_updateViewType()
end
function v1._updateViewType(p1)
	p1:setState({
		touchControls = InputUtils_2.isTouch(),
		isSmallScreen = Utils.isSmallScreen()
	})
end
function v1._fetchInputType(p1)
	local v1 = UserInputService:GetLastInputType()
	if v1 == Enum.UserInputType.Gamepad1 or (v1 == Enum.UserInputType.Keyboard or v1 == Enum.UserInputType.Touch) then
		p1:setState({
			inputType = v1
		})
	end
end
function v1._fetchStateButton(p1, p2, p3, p4, p5)
	local v1 = ("%s_%d_%s"):format(p4, p5, "onReleased")
	local v2 = ("%s_%d_%s"):format(p4, p5, "onPressed")
	local v3 = ("%s_%d_%s"):format(p4, p5, "image")
	local v4 = ("%s_%d_%s"):format(p4, p5, "keyCode")
	local v5 = ("%s_%d_%s"):format(p4, p5, "button")
	p2[v4] = InputUtils.getBestKeyCode(p3.keyCodes, p1.state.inputType) or Roact.None
	if p3.useEvery and not p3.progressBinding then
		local v7, v8 = Roact.createBinding(0)
		p3.progressBinding = v7
		p3.updateProgressBinding = v8
	end
	local function releaseState(...)
		local v1 = p3
		local _inputTypePressed = v1._inputTypePressed
		if not if _inputTypePressed == Enum.UserInputType.Touch or _inputTypePressed == Enum.UserInputType.MouseButton1 then if v1.touchIsToggle then true else _inputTypePressed == Enum.UserInputType.Gamepad1 and v1.gamepadIsToggle and true or false else _inputTypePressed == Enum.UserInputType.Gamepad1 and v1.gamepadIsToggle and true or false and p3._i then
			local v3 = ("%s_%d_%s"):format(p3._groupKey, p3._i, "pressed")
			if p1.state[v3] then
				p1:setState({
					[v3] = false
				})
				p3._pressed = false
				if p3.onReleased then
					p3.onReleased(...)
				end
			end
		end
	end
	p2[v1] = releaseState
	p3._releaseState = releaseState
	local function pressState(...)
		local v1 = ("%s_%d_%s"):format(p3._groupKey, p3._i, "pressed")
		local v2 = true
		local v3 = p3
		local _inputTypePressed = v3._inputTypePressed
		if if _inputTypePressed == Enum.UserInputType.Touch or _inputTypePressed == Enum.UserInputType.MouseButton1 then (v3.touchIsToggle or _inputTypePressed == Enum.UserInputType.Gamepad1 and v3.gamepadIsToggle) and true or false else _inputTypePressed == Enum.UserInputType.Gamepad1 and v3.gamepadIsToggle and true or false then
			v2 = not p1.state[v1]
		end
		if (p1.state[v1] and true or false) ~= v2 then
			p1:setState({
				[v1] = v2
			})
			p3._pressed = v2
			if v2 then
				if p3.useEvery and (p3._lastUsed and os.clock() - p3._lastUsed < p3.useEvery) then
				elseif p3.onPressed then
					local v5 = p3.onPressed(...)
					if p3.useEvery then
						assert(typeof(v5) == "boolean", "onPressed must return a boolean is there is also a useEvery so that useEvery knows whether to set it as used or not")
					end
					if v5 == false then
					elseif p3.useEvery then
						p3._lastUsed = os.clock()
						p3._maid.progress = RunService.Heartbeat:Connect(function()
							p3.updateProgressBinding((os.clock() - p3._lastUsed) / p3.useEvery)
						end)
						p3._maid.removeProgress = task.delay(p3.useEvery, function()
							p3._maid.progress = nil
							p3.updateProgressBinding(0)
						end)
					end
				elseif p3.useEvery then
					p3._lastUsed = os.clock()
					p3._maid.progress = RunService.Heartbeat:Connect(function()
						p3.updateProgressBinding((os.clock() - p3._lastUsed) / p3.useEvery)
					end)
					p3._maid.removeProgress = task.delay(p3.useEvery, function()
						p3._maid.progress = nil
						p3.updateProgressBinding(0)
					end)
				end
			elseif p3.onReleased then
				p3.onReleased(...)
			end
		end
	end
	p2[v2] = pressState
	p3._pressState = pressState
	p2[v3] = p3.image or Roact.None
	p2[v5] = p3
	local v10 = ("%s_%d_%s"):format(p4, p5, "pressed")
	if p3._pressed then
		p2[v10] = true
	else
		p2[v10] = false
	end
	p3._groupKey = p4
	p3._i = p5
end
function v1._fetchState(p1)
	for i, v in ipairs(ActionButtonService.active) do
		v._groupKey = nil
		v._i = nil
		v._releaseState = nil
		v._pressState = nil
		if not v._maid then
			v._maid = Maid.new()
		end
	end
	local t = {}
	local v1 = ActionButtonService.getDataInner()
	t.countInner = #v1
	for i, v in ipairs(v1) do
		p1:_fetchStateButton(t, v, "inner", i)
	end
	local v2 = ActionButtonService.getDataOuter()
	t.countOuter = #v2
	for i, v in ipairs(v2) do
		p1:_fetchStateButton(t, v, "outer", i)
	end
	p1:setState(t)
end
function v1.didMount(p1)
	local v1 = 0
	p1._maid:GiveTask(UserInputService.InputBegan:Connect(function(p1, p2)
		local v12, v2, v3, v4, v5
		if p2 then
			if (p1.KeyCode == Enum.KeyCode.ButtonA or p1.KeyCode == Enum.KeyCode.ButtonR3) and ((p1.KeyCode ~= Enum.KeyCode.ButtonA or not (GuiService.SelectedObject or (GuiService.MenuIsOpen or os.clock() - v1 < 0.1))) and (p1.UserInputType == Enum.UserInputType.Keyboard or p1.UserInputType == Enum.UserInputType.Gamepad1)) then
				v12 = p1.KeyCode
				v2 = {}
				for i2, v in ipairs(ActionButtonService.active) do
					if not v.disabled and v.keyCodes then
						v3 = v.keyCodes
						v4 = typeof(v3) == "table"
						assert(v4, "keyCodes was not a table")
						if table.find(v.keyCodes, v12) then
							table.insert(v2, v)
						end
					end
				end
				if #v2 ~= 0 then
					table.sort(v2, function(p1_2, p2_2)
						return (p1_2.priority or 1) > (p2_2.priority or 1)
					end)
					for i = 1, #v2 do
						v5 = v2[i]
						v5._keyCodePressed = v12
						v5._inputTypePressed = p1.UserInputType
						if v5._pressState then
							v5._pressState(p1.UserInputType)
						end
						if not v5.allowPassThrough then
							break
						end
					end
				end
			end
		elseif p1.UserInputType == Enum.UserInputType.Keyboard or p1.UserInputType == Enum.UserInputType.Gamepad1 then
			v12 = p1.KeyCode
			v2 = {}
			for i2, v in ipairs(ActionButtonService.active) do
				if not v.disabled and v.keyCodes then
					v3 = v.keyCodes
					v4 = typeof(v3) == "table"
					assert(v4, "keyCodes was not a table")
					if table.find(v.keyCodes, v12) then
						table.insert(v2, v)
					end
				end
			end
			if #v2 ~= 0 then
				table.sort(v2, function(p1_2, p2_2)
					return (p1_2.priority or 1) > (p2_2.priority or 1)
				end)
				for i = 1, #v2 do
					v5 = v2[i]
					v5._keyCodePressed = v12
					v5._inputTypePressed = p1.UserInputType
					if v5._pressState then
						v5._pressState(p1.UserInputType)
					end
					if not v5.allowPassThrough then
						break
					end
				end
			end
		end
	end))
	p1._maid:GiveTask(UserInputService.InputEnded:Connect(function(p1)
		if p1.UserInputType == Enum.UserInputType.Keyboard or p1.UserInputType == Enum.UserInputType.Gamepad1 then
			local KeyCode = p1.KeyCode
			for i, v in ipairs(ActionButtonService.active) do
				if v._keyCodePressed == KeyCode then
					v._keyCodePressed = nil
					if v._releaseState then
						v._releaseState(p1.UserInputType)
					end
				end
			end
		end
	end))
	p1._maid:GiveTask(GuiService.MenuClosed:Connect(function()
		v1 = os.clock()
	end))
end
function v1._copyStateButton(p1, p2, p3, p4)
	local v1 = ("%s_%d_%s"):format(p3, p4, "onReleased")
	local v2 = ("%s_%d_%s"):format(p3, p4, "onPressed")
	local v3 = ("%s_%d_%s"):format(p3, p4, "image")
	local v4 = ("%s_%d_%s"):format(p3, p4, "pressed")
	local v5 = ("%s_%d_%s"):format(p3, p4, "keyCode")
	local v6 = ("%s_%d_%s"):format(p3, p4, "button")
	p2[v1] = p1.state[v1]
	p2[v2] = p1.state[v2]
	p2[v3] = p1.state[v3]
	p2[v4] = p1.state[v4]
	p2[v5] = p1.state[v5]
	p2[v6] = p1.state[v6]
end
function v1.render(p1)
	if ActionButtonService.enabled then
		local t = {}
		if p1.state.countInner then
			for i = 1, p1.state.countInner do
				p1:_copyStateButton(t, "inner", i)
			end
		end
		if p1.state.countOuter then
			for j = 1, p1.state.countOuter do
				p1:_copyStateButton(t, "outer", j)
			end
		end
		if p1.props.DEBUG_forceRadial or p1.state.touchControls then
			local v1, v2
			if p1.state.isSmallScreen then
				local v3 = UDim2.new(0.6, 0, 0.6, 0)
				v1, v2 = v3, UDim2.new(1, 10, 1, -10)
			else
				local v5 = UDim2.new(0.4, 0, 0.4, 0)
				v1, v2 = v5, UDim2.new(1, 10, 1, 10)
			end
			return createElement(Radial, Dictionary.merge({
				anchorPoint = Vector2.new(1, 1),
				size = v1,
				position = v2,
				countInner = p1.state.countInner,
				countOuter = p1.state.countOuter,
				enabled = p1.props.enabled,
				color = p1.props.color
			}, t))
		else
			return createElement(Grid, Dictionary.merge({
				anchorPoint = Vector2.new(1, 1),
				size = UDim2.new(0.07, 0, 0.5, 0),
				position = p1.props.gridPosition,
				countInner = p1.state.countInner,
				countOuter = p1.state.countOuter,
				enabled = p1.props.enabled,
				color = p1.props.color
			}, t))
		end
	else
		return nil
	end
end
function v1.willUnmount(p1)
	p1._maid:Destroy()
end
return v1