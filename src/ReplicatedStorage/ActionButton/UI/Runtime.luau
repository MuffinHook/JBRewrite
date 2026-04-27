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
local function isToggle(buttonData)
	local _inputTypePressed = buttonData._inputTypePressed
	if (_inputTypePressed == Enum.UserInputType.Touch or _inputTypePressed == Enum.UserInputType.MouseButton1) and buttonData.touchIsToggle then
		return true
	else
		return _inputTypePressed == Enum.UserInputType.Gamepad1 and buttonData.gamepadIsToggle and true or false
	end
end
local RuntimeComponent = Roact.PureComponent:extend("Runtime")
RuntimeComponent.defaultProps = {
	gridPosition = UDim2.new(1, -10, 1, -70)
}
function RuntimeComponent.init(self)
	self._maid = Maid.new()
	self:_fetchInputType()
	self._maid:GiveTask(UserInputService.LastInputTypeChanged:Connect(function()
		self:_fetchInputType()
		self:_fetchState()
		task.delay(0, function()
			self:_updateViewType()
		end)
	end))
	self:_fetchState()
	self._maid:GiveTask(ActionButtonService.triggerUpdate:Connect(function()
		self:_fetchState()
	end))
	self._maid:GiveTask(workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
		self:_updateViewType()
	end))
	self:_updateViewType()
end
function RuntimeComponent._updateViewType(self)
	self:setState({
		touchControls = InputUtils_2.isTouch(),
		isSmallScreen = Utils.isSmallScreen()
	})
end
function RuntimeComponent._fetchInputType(self)
	local lastInputType = UserInputService:GetLastInputType()
	if lastInputType == Enum.UserInputType.Gamepad1 or (lastInputType == Enum.UserInputType.Keyboard or lastInputType == Enum.UserInputType.Touch) then
		self:setState({
			inputType = lastInputType
		})
	end
end
function RuntimeComponent._fetchStateButton(self, stateTable, buttonData, groupKey, buttonIndex)
	local onReleasedKey = ("%s_%d_%s"):format(groupKey, buttonIndex, "onReleased")
	local onPressedKey = ("%s_%d_%s"):format(groupKey, buttonIndex, "onPressed")
	local imageKey = ("%s_%d_%s"):format(groupKey, buttonIndex, "image")
	local keyCodeKey = ("%s_%d_%s"):format(groupKey, buttonIndex, "keyCode")
	local buttonKey = ("%s_%d_%s"):format(groupKey, buttonIndex, "button")
	stateTable[keyCodeKey] = InputUtils.getBestKeyCode(buttonData.keyCodes, self.state.inputType) or Roact.None
	if buttonData.useEvery and not buttonData.progressBinding then
		local progressBinding, updateProgressBinding = Roact.createBinding(0)
		buttonData.progressBinding = progressBinding
		buttonData.updateProgressBinding = updateProgressBinding
	end
	local function releaseState(...)
		local button = buttonData
		local _inputTypePressed = button._inputTypePressed
		if not if _inputTypePressed == Enum.UserInputType.Touch or _inputTypePressed == Enum.UserInputType.MouseButton1 then if button.touchIsToggle then true else _inputTypePressed == Enum.UserInputType.Gamepad1 and button.gamepadIsToggle and true or false else _inputTypePressed == Enum.UserInputType.Gamepad1 and button.gamepadIsToggle and true or false and buttonData._i then
			local pressedKey = ("%s_%d_%s"):format(buttonData._groupKey, buttonData._i, "pressed")
			if self.state[pressedKey] then
				self:setState({
					[pressedKey] = false
				})
				buttonData._pressed = false
				if buttonData.onReleased then
					buttonData.onReleased(...)
				end
			end
		end
	end
	stateTable[onReleasedKey] = releaseState
	buttonData._releaseState = releaseState
	local function pressState(...)
		local pressedKey = ("%s_%d_%s"):format(buttonData._groupKey, buttonData._i, "pressed")
		local shouldToggle = true
		local button = buttonData
		local _inputTypePressed = button._inputTypePressed
		if if _inputTypePressed == Enum.UserInputType.Touch or _inputTypePressed == Enum.UserInputType.MouseButton1 then (button.touchIsToggle or _inputTypePressed == Enum.UserInputType.Gamepad1 and button.gamepadIsToggle) and true or false else _inputTypePressed == Enum.UserInputType.Gamepad1 and button.gamepadIsToggle and true or false then
			shouldToggle = not self.state[pressedKey]
		end
		if (self.state[pressedKey] and true or false) ~= shouldToggle then
			self:setState({
				[pressedKey] = shouldToggle
			})
			buttonData._pressed = shouldToggle
			if shouldToggle then
				if buttonData.useEvery and (buttonData._lastUsed and os.clock() - buttonData._lastUsed < buttonData.useEvery) then
				elseif buttonData.onPressed then
					local onPressedResult = buttonData.onPressed(...)
					if buttonData.useEvery then
						assert(typeof(onPressedResult) == "boolean", "onPressed must return a boolean is there is also a useEvery so that useEvery knows whether to set it as used or not")
					end
					if onPressedResult == false then
					elseif buttonData.useEvery then
						buttonData._lastUsed = os.clock()
						buttonData._maid.progress = RunService.Heartbeat:Connect(function()
							buttonData.updateProgressBinding((os.clock() - buttonData._lastUsed) / buttonData.useEvery)
						end)
						buttonData._maid.removeProgress = task.delay(buttonData.useEvery, function()
							buttonData._maid.progress = nil
							buttonData.updateProgressBinding(0)
						end)
					end
				elseif buttonData.useEvery then
					buttonData._lastUsed = os.clock()
					buttonData._maid.progress = RunService.Heartbeat:Connect(function()
						buttonData.updateProgressBinding((os.clock() - buttonData._lastUsed) / buttonData.useEvery)
					end)
					buttonData._maid.removeProgress = task.delay(buttonData.useEvery, function()
						buttonData._maid.progress = nil
						buttonData.updateProgressBinding(0)
					end)
				elseif buttonData.onReleased then
					buttonData.onReleased(...)
				end
			end
		end
	end
	stateTable[onPressedKey] = pressState
	buttonData._pressState = pressState
	stateTable[imageKey] = buttonData.image or Roact.None
	stateTable[buttonKey] = buttonData
	local buttonPressedStateKey = ("%s_%d_%s"):format(groupKey, buttonIndex, "pressed")
	if buttonData._pressed then
		stateTable[buttonPressedStateKey] = true
	else
		stateTable[buttonPressedStateKey] = false
	end
	buttonData._groupKey = groupKey
	buttonData._i = buttonIndex
end
function RuntimeComponent._fetchState(self)
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
		self:_fetchStateButton(stateTable, v, "inner", i)
	end
	local outerData = ActionButtonService.getDataOuter()
	stateTable.countOuter = #outerData
	for i, v in ipairs(outerData) do
		self:_fetchStateButton(stateTable, v, "outer", i)
	end
	self:setState(stateTable)
end
function RuntimeComponent.didMount(self)
	local lastMenuCloseTime = 0
	self._maid:GiveTask(UserInputService.InputBegan:Connect(function(inputEvent, gameProcessed)
		local pressedKeyCode, matchingButtons, buttonKeyCodes, isTable, currentButton
		if gameProcessed then
			if (inputEvent.KeyCode == Enum.KeyCode.ButtonA or inputEvent.KeyCode == Enum.KeyCode.ButtonR3) and ((inputEvent.KeyCode ~= Enum.KeyCode.ButtonA or not (GuiService.SelectedObject or (GuiService.MenuIsOpen or os.clock() - lastMenuCloseTime < 0.1))) and (inputEvent.UserInputType == Enum.UserInputType.Keyboard or inputEvent.UserInputType == Enum.UserInputType.Gamepad1)) then
				pressedKeyCode = inputEvent.KeyCode
				matchingButtons = {}
				for i2, v in ipairs(ActionButtonService.active) do
					if not v.disabled and v.keyCodes then
						buttonKeyCodes = v.keyCodes
						isTable = typeof(buttonKeyCodes) == "table"
						assert(isTable, "keyCodes was not a table")
						if table.find(v.keyCodes, pressedKeyCode) then
							table.insert(matchingButtons, v)
						end
					end
				end
				if #matchingButtons ~= 0 then
					table.sort(matchingButtons, function(buttonA, buttonB)
						return (buttonA.priority or 1) > (buttonB.priority or 1)
					end)
					for i = 1, #matchingButtons do
						currentButton = matchingButtons[i]
						currentButton._keyCodePressed = pressedKeyCode
						currentButton._inputTypePressed = inputEvent.UserInputType
						if currentButton._pressState then
							currentButton._pressState(inputEvent.UserInputType)
						end
						if not currentButton.allowPassThrough then
							break
						end
					end
				end
			end
		elseif inputEvent.UserInputType == Enum.UserInputType.Keyboard or inputEvent.UserInputType == Enum.UserInputType.Gamepad1 then
			pressedKeyCode = inputEvent.KeyCode
			matchingButtons = {}
			for i2, v in ipairs(ActionButtonService.active) do
				if not v.disabled and v.keyCodes then
					buttonKeyCodes = v.keyCodes
					isTable = typeof(buttonKeyCodes) == "table"
					assert(isTable, "keyCodes was not a table")
					if table.find(v.keyCodes, pressedKeyCode) then
						table.insert(matchingButtons, v)
					end
				end
			end
			if #matchingButtons ~= 0 then
				table.sort(matchingButtons, function(buttonA, buttonB)
					return (buttonA.priority or 1) > (buttonB.priority or 1)
				end)
				for i = 1, #matchingButtons do
					currentButton = matchingButtons[i]
					currentButton._keyCodePressed = pressedKeyCode
					currentButton._inputTypePressed = inputEvent.UserInputType
					if currentButton._pressState then
						currentButton._pressState(inputEvent.UserInputType)
					end
					if not currentButton.allowPassThrough then
						break
					end
				end
			end
		end
	end))
	self._maid:GiveTask(UserInputService.InputEnded:Connect(function(inputEvent)
		if inputEvent.UserInputType == Enum.UserInputType.Keyboard or inputEvent.UserInputType == Enum.UserInputType.Gamepad1 then
			local KeyCode = inputEvent.KeyCode
			for i, v in ipairs(ActionButtonService.active) do
				if v._keyCodePressed == KeyCode then
					v._keyCodePressed = nil
					if v._releaseState then
						v._releaseState(inputEvent.UserInputType)
					end
				end
			end
		end
	end))
	self._maid:GiveTask(GuiService.MenuClosed:Connect(function()
		lastMenuCloseTime = os.clock()
	end))
end
function RuntimeComponent._copyStateButton(self, stateTable, groupKey, buttonIndex)
	local onReleasedKey = ("%s_%d_%s"):format(groupKey, buttonIndex, "onReleased")
	local onPressedKey = ("%s_%d_%s"):format(groupKey, buttonIndex, "onPressed")
	local imageKey = ("%s_%d_%s"):format(groupKey, buttonIndex, "image")
	local pressedKey = ("%s_%d_%s"):format(groupKey, buttonIndex, "pressed")
	local keyCodeKey = ("%s_%d_%s"):format(groupKey, buttonIndex, "keyCode")
	local buttonKey = ("%s_%d_%s"):format(groupKey, buttonIndex, "button")
	stateTable[onReleasedKey] = self.state[onReleasedKey]
	stateTable[onPressedKey] = self.state[onPressedKey]
	stateTable[imageKey] = self.state[imageKey]
	stateTable[pressedKey] = self.state[pressedKey]
	stateTable[keyCodeKey] = self.state[keyCodeKey]
	stateTable[buttonKey] = self.state[buttonKey]
end
function RuntimeComponent.render(self)
	if ActionButtonService.enabled then
		local stateTable = {}
		if self.state.countInner then
			for i = 1, self.state.countInner do
				self:_copyStateButton(stateTable, "inner", i)
			end
		end
		if self.state.countOuter then
			for j = 1, self.state.countOuter do
				self:_copyStateButton(stateTable, "outer", j)
			end
		end
		if self.props.DEBUG_forceRadial or self.state.touchControls then
			local size, position
			if self.state.isSmallScreen then
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
				countInner = self.state.countInner,
				countOuter = self.state.countOuter,
				enabled = self.props.enabled,
				color = self.props.color
			}, stateTable))
		else
			return createElement(Grid, Dictionary.merge({
				anchorPoint = Vector2.new(1, 1),
				size = UDim2.new(0.07, 0, 0.5, 0),
				position = self.props.gridPosition,
				countInner = self.state.countInner,
				countOuter = self.state.countOuter,
				enabled = self.props.enabled,
				color = self.props.color
			}, stateTable))
		end
	else
		return nil
	end
end
function RuntimeComponent.willUnmount(self)
	self._maid:Destroy()
end
return RuntimeComponent
