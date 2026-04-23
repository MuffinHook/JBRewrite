local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Signal = require(script.Parent.Signal)
local v1 = if UserInputService.PreferredInput == Enum.PreferredInput.Touch then Enum.UserInputType.Touch elseif UserInputService.PreferredInput == Enum.PreferredInput.Gamepad then Enum.UserInputType.Gamepad1 else Enum.UserInputType.Keyboard
local t = {
	onInputTypeChanged = Signal.new(),
	getPlatformSpecificInputType = function() --[[ Name: getPlatformSpecificInputType | Line: 18 | Upvalues: v1 (ref) ]]
		return v1
	end
}
function t.isGamepad() --[[ Line: 21 | Upvalues: t (copy) ]]
	local isGamepad1 = t.getPlatformSpecificInputType() == Enum.UserInputType.Gamepad1
	return isGamepad1
end
function t.isTouch() --[[ Line: 25 | Upvalues: t (copy) ]]
	local isTouch = t.getPlatformSpecificInputType() == Enum.UserInputType.Touch
	return isTouch
end
function t.isKeyboard() --[[ Line: 28 | Upvalues: t (copy) ]]
	local isKeyboard = t.getPlatformSpecificInputType() == Enum.UserInputType.Keyboard
	return isKeyboard
end
function t.selectIfGamepad(p1) --[[ Line: 31 | Upvalues: RunService (copy), t (copy), GuiService (copy) ]]
	if RunService:IsRunning() and t.isGamepad() then
		GuiService:Select(p1)
		if p1 and not GuiService.SelectedObject:IsDescendantOf(p1) then
			warn("failed to select", p1:GetFullName())
		end
	end
end
local function determineNewPlatformSpecificInputType(p1) --[[ Line: 44 ]]
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
local function checkInputTypeChanged() --[[ Line: 55 | Upvalues: UserInputService (copy), v1 (ref), t (copy) ]]
	local v12 = UserInputService:GetLastInputType()
	local v2 = if v12 == Enum.UserInputType.Gamepad1 then Enum.UserInputType.Gamepad1 elseif v12 == Enum.UserInputType.Touch then Enum.UserInputType.Touch elseif v12 == Enum.UserInputType.Keyboard then Enum.UserInputType.Keyboard else nil
	if v2 and v2 ~= v1 then
		v1 = v2
		t.onInputTypeChanged:Fire(v2)
	end
end
UserInputService.InputBegan:Connect(function(p1, p2) --[[ Line: 63 | Upvalues: UserInputService (copy), v1 (ref), t (copy) ]]
	local v12 = UserInputService:GetLastInputType()
	local v2 = if v12 == Enum.UserInputType.Gamepad1 then Enum.UserInputType.Gamepad1 elseif v12 == Enum.UserInputType.Touch then Enum.UserInputType.Touch elseif v12 == Enum.UserInputType.Keyboard then Enum.UserInputType.Keyboard else nil
	if v2 and v2 ~= v1 then
		v1 = v2
		t.onInputTypeChanged:Fire(v2)
	end
end)
UserInputService.InputChanged:Connect(function(p1, p2) --[[ Line: 66 | Upvalues: UserInputService (copy), v1 (ref), t (copy) ]]
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