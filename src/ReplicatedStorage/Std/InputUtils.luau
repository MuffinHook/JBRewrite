local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Signal = require(script.Parent.Signal)
local currentInputType = if UserInputService.PreferredInput == Enum.PreferredInput.Touch then Enum.UserInputType.Touch elseif UserInputService.PreferredInput == Enum.PreferredInput.Gamepad then Enum.UserInputType.Gamepad1 else Enum.UserInputType.Keyboard
local InputUtils = {
	onInputTypeChanged = Signal.new(),
	getPlatformSpecificInputType = function()
		return currentInputType
	end
}
function InputUtils.isGamepad()
	local isGamepad1 = InputUtils.getPlatformSpecificInputType() == Enum.UserInputType.Gamepad1
	return isGamepad1
end
function InputUtils.isTouch()
	local isTouch = InputUtils.getPlatformSpecificInputType() == Enum.UserInputType.Touch
	return isTouch
end
function InputUtils.isKeyboard()
	local isKeyboard = InputUtils.getPlatformSpecificInputType() == Enum.UserInputType.Keyboard
	return isKeyboard
end
function InputUtils.selectIfGamepad(guiObject)
	if RunService:IsRunning() and InputUtils.isGamepad() then
		GuiService:Select(guiObject)
		if guiObject and not GuiService.SelectedObject:IsDescendantOf(guiObject) then
			warn("failed to select", guiObject:GetFullName())
		end
	end
end
local function determineNewPlatformSpecificInputType(inputType)
	if inputType == Enum.UserInputType.Gamepad1 then
		return Enum.UserInputType.Gamepad1
	elseif inputType == Enum.UserInputType.Touch then
		return Enum.UserInputType.Touch
	elseif inputType == Enum.UserInputType.Keyboard then
		return Enum.UserInputType.Keyboard
	else
		return nil
	end
end
local function checkInputTypeChanged()
	local lastInputType = UserInputService:GetLastInputType()
	local determinedInputType = if lastInputType == Enum.UserInputType.Gamepad1 then Enum.UserInputType.Gamepad1 elseif lastInputType == Enum.UserInputType.Touch then Enum.UserInputType.Touch elseif lastInputType == Enum.UserInputType.Keyboard then Enum.UserInputType.Keyboard else nil
	if determinedInputType and determinedInputType ~= currentInputType then
		currentInputType = determinedInputType
		InputUtils.onInputTypeChanged:Fire(determinedInputType)
	end
end
UserInputService.InputBegan:Connect(function(inputObject, gameProcessed)
	local lastInputType = UserInputService:GetLastInputType()
	local determinedInputType = if lastInputType == Enum.UserInputType.Gamepad1 then Enum.UserInputType.Gamepad1 elseif lastInputType == Enum.UserInputType.Touch then Enum.UserInputType.Touch elseif lastInputType == Enum.UserInputType.Keyboard then Enum.UserInputType.Keyboard else nil
	if determinedInputType and determinedInputType ~= currentInputType then
		currentInputType = determinedInputType
		InputUtils.onInputTypeChanged:Fire(determinedInputType)
	end
end)
UserInputService.InputChanged:Connect(function(inputObject, gameProcessed)
	local lastInputType, determinedInputType
	if inputObject.UserInputType == Enum.UserInputType.Gamepad1 then
		if inputObject.KeyCode == Enum.KeyCode.Thumbstick1 or inputObject.KeyCode == Enum.KeyCode.Thumbstick2 then
			if not (inputObject.Position.Magnitude < 0.2) then
				lastInputType = UserInputService:GetLastInputType()
				determinedInputType = if lastInputType == Enum.UserInputType.Gamepad1 then Enum.UserInputType.Gamepad1 elseif lastInputType == Enum.UserInputType.Touch then Enum.UserInputType.Touch elseif lastInputType == Enum.UserInputType.Keyboard then Enum.UserInputType.Keyboard else nil
				if determinedInputType and determinedInputType ~= currentInputType then
					currentInputType = determinedInputType
					InputUtils.onInputTypeChanged:Fire(determinedInputType)
				end
			end
		elseif inputObject.KeyCode == Enum.KeyCode.ButtonL2 or inputObject.KeyCode == Enum.KeyCode.ButtonR2 then
			if not (inputObject.Position.Z < 0.2) then
				lastInputType = UserInputService:GetLastInputType()
				determinedInputType = if lastInputType == Enum.UserInputType.Gamepad1 then Enum.UserInputType.Gamepad1 elseif lastInputType == Enum.UserInputType.Touch then Enum.UserInputType.Touch elseif lastInputType == Enum.UserInputType.Keyboard then Enum.UserInputType.Keyboard else nil
				if determinedInputType and determinedInputType ~= currentInputType then
					currentInputType = determinedInputType
					InputUtils.onInputTypeChanged:Fire(determinedInputType)
				end
			end
		else
			lastInputType = UserInputService:GetLastInputType()
			determinedInputType = if lastInputType == Enum.UserInputType.Gamepad1 then Enum.UserInputType.Gamepad1 elseif lastInputType == Enum.UserInputType.Touch then Enum.UserInputType.Touch elseif lastInputType == Enum.UserInputType.Keyboard then Enum.UserInputType.Keyboard else nil
			if determinedInputType and determinedInputType ~= currentInputType then
				currentInputType = determinedInputType
				InputUtils.onInputTypeChanged:Fire(determinedInputType)
			end
		end
	else
		lastInputType = UserInputService:GetLastInputType()
		determinedInputType = if lastInputType == Enum.UserInputType.Gamepad1 then Enum.UserInputType.Gamepad1 elseif lastInputType == Enum.UserInputType.Touch then Enum.UserInputType.Touch elseif lastInputType == Enum.UserInputType.Keyboard then Enum.UserInputType.Keyboard else nil
		if determinedInputType and determinedInputType ~= currentInputType then
			currentInputType = determinedInputType
			InputUtils.onInputTypeChanged:Fire(determinedInputType)
		end
	end
end)
return InputUtils
