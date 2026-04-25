-- Reviewed by Claude
-- variables reassigned
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
local RuntimeComponent = Roact.PureComponent:extend("Runtime")
RuntimeComponent.defaultProps = {
	gridPosition = UDim2.new(1, -10, 1, -70)
}
function RuntimeComponent.init(p1)
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
function RuntimeComponent._updateViewType(p1)
	p1:setState({
		touchControls = InputUtils_2.isTouch(),
		isSmallScreen = Utils.isSmallScreen()
	})
end
function RuntimeComponent._fetchInputType(p1)
	local lastInputType = UserInputService:GetLastInputType()
	if lastInputType == Enum.UserInputType.Gamepad1 or (lastInputType == Enum.UserInputType.Keyboard or lastInputType == Enum.UserInputType.Touch) then
		p1:setState({
			inputType = lastInputType
		})
	end
end
function RuntimeComponent._fetchStateButton(p1, p2, p3, p4, p5)
	local onReleasedKey = ("%s_%d_%s"):format(p4, p5, "onReleased")
	local onPressedKey = ("%s_%d_%s"):format(p4, p5, "onPressed")
	local imageKey = ("%s_%d_%s"):format(p4, p5, "image")
	local keyCodeKey = ("%s_%d_%s"):format(p4, p5, "keyCode")
	local buttonKey = ("%s_%d_%s"):format(p4, p5, "button")
	p2[keyCodeKey] = InputUtils.getBestKeyCode(p3.keyCodes, p1.state.inputType) or Roact.None
	if p3.useEvery and not p3.progressBinding then
		local progressBinding, updateProgressBinding = Roact.createBinding(0)
		p3.progressBinding = progressBinding
		p3.updateProgressBinding = updateProgressBinding
	end
	local function releaseState(...)
		local v1 = p3
		local _inputTypePressed = v1._inputTypePressed
		if not if _inputTypePressed == Enum.UserInputType.Touch or _inputTypePressed == Enum.UserInputType.MouseButton1 then if v1.touchIsToggle then true else _inputTypePressed == Enum.UserInputType.Gamepad1 and v1.gamepadIsToggle and true or false else _inputTypePressed == Enum.UserInputType.Gamepad1 and v1.gamepadIsToggle and true or false and p3._i then
			local pressedKey = ("%s_%d_%s"):format(p3._groupKey, p3._i, "pressed")
			if p1.state[pressedKey] then
				p1:setState({
					[pressedKey] = false
				})
				p3._pressed = false
				if p3.onReleased then
					p3.onReleased(...)
				end
			end
		end
	end
	p2[onReleasedKey] = releaseState
	p3._releaseState = releaseState
	local function pressState(...)
		local pressedKey = ("%s_%d_%s"):format(p3._groupKey, p3._i, "pressed")
		local v2 = true
		local v3 = p3
		local _inputTypePressed = v3._inputTypePressed
		if if _inputTypePressed == Enum.UserInputType.Touch or _inputTypePressed == Enum.UserInputType.MouseButton1 then (v3.touchIsToggle or _inputTypePressed == Enum.UserInputType.Gamepad1 and v3.gamepadIsToggle) and true or false else _inputTypePressed == Enum.UserInputType.Gamepad1 and v3.gamepadIsToggle and true or false then
			v2 = not p1.state[pressedKey]
		end
		if (p1.state[pressedKey] and true or false) ~= v2 then
			p1:setState({
				[pressedKey] = v2
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
				elseif p3.onReleased then
					p3.onReleased(...)
				end
			end
		end
	end
	p2[onPressedKey] = pressState
	p3._pressState = pressState
	p2[imageKey] = p3.image or Roact.None
	p2[buttonKey] = p3
	local buttonPressedStateKey = ("%s_%d_%s"):format(p4, p5, "pressed")
	if p3._pressed then
		p2[buttonPressedStateKey] = true
	else
		p2[buttonPressedStateKey] = false
	end
	p3._groupKey = p4
	p3._i = p5
end
function RuntimeComponent._fetchState(p1)
	for i, v in ipairs(ActionButtonService.active) do
		v._groupKey = nil
		v._i = nil
		v._releaseState = nil
		v._pressState = nil
		if not v._maid then
			v._maid = Maid.new()
		end
	end
	local stateTable = {}
	local innerData = ActionButtonService.getDataInner()
	stateTable.countInner = #innerData
	for i, v in ipairs(innerData) do
		p1:_fetchStateButton(stateTable, v, "inner", i)
	end
	local outerData = ActionButtonService.getDataOuter()
	stateTable.countOuter = #outerData
	for i, v in ipairs(outerData) do
		p1:_fetchStateButton(stateTable, v, "outer", i)
	end
	p1:setState(stateTable)
end
function RuntimeComponent.didMount(p1)
	local lastMenuCloseTime = 0
	p1._maid:GiveTask(UserInputService.InputBegan:Connect(function(p1, p2)
		local pressedKeyCode, matchingButtons, buttonKeyCodes, v4, currentButton
		if p2 then
			if (p1.KeyCode == Enum.KeyCode.ButtonA or p1.KeyCode == Enum.KeyCode.ButtonR3) and ((p1.KeyCode ~= Enum.KeyCode.ButtonA or not (GuiService.SelectedObject or (GuiService.MenuIsOpen or os.clock() - lastMenuCloseTime < 0.1))) and (p1.UserInputType == Enum.UserInputType.Keyboard or p1.UserInputType == Enum.UserInputType.Gamepad1)) then
				pressedKeyCode = p1.KeyCode
				matchingButtons = {}
				for i2, v in ipairs(ActionButtonService.active) do
					if not v.disabled and v.keyCodes then
						buttonKeyCodes = v.keyCodes
						v4 = typeof(buttonKeyCodes) == "table"
						assert(v4, "keyCodes was not a table")
						if table.find(v.keyCodes, pressedKeyCode) then
							table.insert(matchingButtons, v)
						end
					end
				end
				if #matchingButtons ~= 0 then
					table.sort(matchingButtons, function(p1_2, p2_2)
						return (p1_2.priority or 1) > (p2_2.priority or 1)
					end)
					for i = 1, #matchingButtons do
						currentButton = matchingButtons[i]
						currentButton._keyCodePressed = pressedKeyCode
						currentButton._inputTypePressed = p1.UserInputType
						if currentButton._pressState then
							currentButton._pressState(p1.UserInputType)
						end
						if not currentButton.allowPassThrough then
							break
						end
					end
				end
			end
		elseif p1.UserInputType == Enum.UserInputType.Keyboard or p1.UserInputType == Enum.UserInputType.Gamepad1 then
			pressedKeyCode = p1.KeyCode
			matchingButtons = {}
			for i2, v in ipairs(ActionButtonService.active) do
				if not v.disabled and v.keyCodes then
					buttonKeyCodes = v.keyCodes
					v4 = typeof(buttonKeyCodes) == "table"
					assert(v4, "keyCodes was not a table")
					if table.find(v.keyCodes, pressedKeyCode) then
						table.insert(matchingButtons, v)
					end
				end
			end
			if #matchingButtons ~= 0 then
				table.sort(matchingButtons, function(p1_2, p2_2)
					return (p1_2.priority or 1) > (p2_2.priority or 1)
				end)
				for i = 1, #matchingButtons do
					currentButton = matchingButtons[i]
					currentButton._keyCodePressed = pressedKeyCode
					currentButton._inputTypePressed = p1.UserInputType
					if currentButton._pressState then
						currentButton._pressState(p1.UserInputType)
					end
					if not currentButton.allowPassThrough then
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
		lastMenuCloseTime = os.clock()
	end))
end
function RuntimeComponent._copyStateButton(p1, p2, p3, p4)
	local onReleasedKey = ("%s_%d_%s"):format(p3, p4, "onReleased")
	local onPressedKey = ("%s_%d_%s"):format(p3, p4, "onPressed")
	local imageKey = ("%s_%d_%s"):format(p3, p4, "image")
	local pressedKey = ("%s_%d_%s"):format(p3, p4, "pressed")
	local keyCodeKey = ("%s_%d_%s"):format(p3, p4, "keyCode")
	local buttonKey = ("%s_%d_%s"):format(p3, p4, "button")
	p2[onReleasedKey] = p1.state[onReleasedKey]
	p2[onPressedKey] = p1.state[onPressedKey]
	p2[imageKey] = p1.state[imageKey]
	p2[pressedKey] = p1.state[pressedKey]
	p2[keyCodeKey] = p1.state[keyCodeKey]
	p2[buttonKey] = p1.state[buttonKey]
end
function RuntimeComponent.render(p1)
	if ActionButtonService.enabled then
		local stateTable = {}
		if p1.state.countInner then
			for i = 1, p1.state.countInner do
				p1:_copyStateButton(stateTable, "inner", i)
			end
		end
		if p1.state.countOuter then
			for j = 1, p1.state.countOuter do
				p1:_copyStateButton(stateTable, "outer", j)
			end
		end
		if p1.props.DEBUG_forceRadial or p1.state.touchControls then
			local size, position
			if p1.state.isSmallScreen then
				local smallScreenSize = UDim2.new(0.6, 0, 0.6, 0)
				size, position = smallScreenSize, UDim2.new(1, 10, 1, -10)
			else
				local normalScreenSize = UDim2.new(0.4, 0, 0.4, 0)
				size, position = normalScreenSize, UDim2.new(1, 10, 1, 10)
			end
			return createElement(Radial, Dictionary.merge({
				anchorPoint = Vector2.new(1, 1),
				size = size,
				position = position,
				countInner = p1.state.countInner,
				countOuter = p1.state.countOuter,
				enabled = p1.props.enabled,
				color = p1.props.color
			}, stateTable))
		else
			return createElement(Grid, Dictionary.merge({
				anchorPoint = Vector2.new(1, 1),
				size = UDim2.new(0.07, 0, 0.5, 0),
				position = p1.props.gridPosition,
				countInner = p1.state.countInner,
				countOuter = p1.state.countOuter,
				enabled = p1.props.enabled,
				color = p1.props.color
			}, stateTable))
		end
	else
		return nil
	end
end
function RuntimeComponent.willUnmount(p1)
	p1._maid:Destroy()
end
return RuntimeComponent
