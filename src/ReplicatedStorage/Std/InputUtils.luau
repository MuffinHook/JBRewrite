-- Reviewed by Claude
-- variables reassigned
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Signal = require(script.Parent.Signal)
local v1 = if UserInputService.PreferredInput == Enum.PreferredInput.Touch then Enum.UserInputType.Touch elseif UserInputService.PreferredInput == Enum.PreferredInput.Gamepad then Enum.UserInputType.Gamepad1 else Enum.UserInputType.Keyboard
local t = {
	onInputTypeChanged = Signal.new(),
	getPlatformSpecificInputType = function()
		return v1
	end
}
function t.isGamepad()
	local isGamepad1 = t.getPlatformSpecificInputType() == Enum.UserInputType.Gamepad1
	return isGamepad1
end
function t.isTouch()
	local isTouch = t.getPlatformSpecificInputType() == Enum.UserInputType.Touch
	return isTouch
end
function t.isKeyboard()
	local isKeyboard = t.getPlatformSpecificInputType() == Enum.UserInputType.Keyboard
	return isKeyboard
end
function t.selectIfGamepad(p1)
	if RunService:IsRunning() and t.isGamepad() then
		GuiService:Select(p1)
		if p1 and not GuiService.SelectedObject:IsDescendantOf(p1) then
			warn("failed to select", p1:GetFullName())
		end
	end
end
local function determineNewPlatformSpecificInputType(p1)
	if p1 == Enum.UserInputType.Gamepad1 then
		return Enum.UserInputType.Gamepad1
	elseif p1 == Enum.UserInputType.Touch then
		return Enum.UserInputType.Touch
	elseif p1 == Enum.UserInputType.Keyboard then
		return Enum.UserInputType.Keyboard
	else
		return nil
	end
end
local function checkInputTypeChanged()
	local v12 = UserInputService:GetLastInputType()
	local v2 = if v12 == Enum.UserInputType.Gamepad1 then Enum.UserInputType.Gamepad1 elseif v12 == Enum.UserInputType.Touch then Enum.UserInputType.Touch elseif v12 == Enum.UserInputType.Keyboard then Enum.UserInputType.Keyboard else nil
	if v2 and v2 ~= v1 then
		v1 = v2
		t.onInputTypeChanged:Fire(v2)
	end
end
UserInputService.InputBegan:Connect(function(p1, p2)
	local v12 = UserInputService:GetLastInputType()
	local v2 = if v12 == Enum.UserInputType.Gamepad1 then Enum.UserInputType.Gamepad1 elseif v12 == Enum.UserInputType.Touch then Enum.UserInputType.Touch elseif v12 == Enum.UserInputType.Keyboard then Enum.UserInputType.Keyboard else nil
	if v2 and v2 ~= v1 then
		v1 = v2
		t.onInputTypeChanged:Fire(v2)
	end
end)
UserInputService.InputChanged:Connect(function(p1, p2)
	local v12, v2
	if p1.UserInputType == Enum.UserInputType.Gamepad1 then
		if p1.KeyCode == Enum.KeyCode.Thumbstick1 or p1.KeyCode == Enum.KeyCode.Thumbstick2 then
			if not (p1.Position.Magnitude < 0.2) then
				v12 = UserInputService:GetLastInputType()
				v2 = if v12 == Enum.UserInputType.Gamepad1 then Enum.UserInputType.Gamepad1 elseif v12 == Enum.UserInputType.Touch then Enum.UserInputType.Touch elseif v12 == Enum.UserInputType.Keyboard then Enum.UserInputType.Keyboard else nil
				if v2 and v2 ~= v1 then
					v1 = v2
					t.onInputTypeChanged:Fire(v2)
				end
			end
		elseif p1.KeyCode == Enum.KeyCode.ButtonL2 or p1.KeyCode == Enum.KeyCode.ButtonR2 then
			if not (p1.Position.Z < 0.2) then
				v12 = UserInputService:GetLastInputType()
				v2 = if v12 == Enum.UserInputType.Gamepad1 then Enum.UserInputType.Gamepad1 elseif v12 == Enum.UserInputType.Touch then Enum.UserInputType.Touch elseif v12 == Enum.UserInputType.Keyboard then Enum.UserInputType.Keyboard else nil
				if v2 and v2 ~= v1 then
					v1 = v2
					t.onInputTypeChanged:Fire(v2)
				end
			end
		else
			v12 = UserInputService:GetLastInputType()
			v2 = if v12 == Enum.UserInputType.Gamepad1 then Enum.UserInputType.Gamepad1 elseif v12 == Enum.UserInputType.Touch then Enum.UserInputType.Touch elseif v12 == Enum.UserInputType.Keyboard then Enum.UserInputType.Keyboard else nil
			if v2 and v2 ~= v1 then
				v1 = v2
				t.onInputTypeChanged:Fire(v2)
			end
		end
	else
		v12 = UserInputService:GetLastInputType()
		v2 = if v12 == Enum.UserInputType.Gamepad1 then Enum.UserInputType.Gamepad1 elseif v12 == Enum.UserInputType.Touch then Enum.UserInputType.Touch elseif v12 == Enum.UserInputType.Keyboard then Enum.UserInputType.Keyboard else nil
		if v2 and v2 ~= v1 then
			v1 = v2
			t.onInputTypeChanged:Fire(v2)
		end
	end
end)
return t
