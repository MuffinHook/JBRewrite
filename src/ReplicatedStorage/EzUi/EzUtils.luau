local GamepadService = game:GetService("GamepadService")
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local CurrentCamera = workspace.CurrentCamera
return {
	rotatedLine = function(p1, p2, p3, p4, p5) --[[ Name: rotatedLine | Line: 8 ]]
		local v1 = p3 - p1
		local v2 = p4 - p2
		return (p1 + p3) * 0.5, (p2 + p4) * 0.5, math.sqrt(v2 * v2 * p5 * p5 + v1 * v1), math.atan2(v2 * p5, v1)
	end,
	isSmallScreen = function() --[[ Name: isSmallScreen | Line: 18 | Upvalues: CurrentCamera (copy) ]]
		return math.min(CurrentCamera.ViewportSize.X, CurrentCamera.ViewportSize.y) <= 500
	end,
	shouldHaveTouchControls = function() --[[ Name: shouldHaveTouchControls | Line: 24 | Upvalues: UserInputService (copy) ]]
		return UserInputService.TouchEnabled
	end,
	getViewportSizeChangedSignal = function() --[[ Name: getViewportSizeChangedSignal | Line: 27 ]]
		return workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize")
	end,
	selectIfGamepad = function(p1) --[[ Name: selectIfGamepad | Line: 30 | Upvalues: GuiService (copy), GamepadService (copy), UserInputService (copy) ]]
		if GuiService.AutoSelectGuiEnabled then
			GamepadService:EnableGamepadCursor(p1)
		elseif UserInputService:GetLastInputType() == Enum.UserInputType.Gamepad1 then
			GuiService.SelectedObject = p1
		end
	end,
	isGuiAncestryVisible = function(p1) --[[ Name: isGuiAncestryVisible | Line: 40 ]]
		while (not p1:IsA("GuiObject") or p1.Visible) and (not p1:IsA("ScreenGui") or p1.Enabled) do
			p1 = p1.Parent
			if not p1 then
				return true
			end
		end
		return false
	end
}