local GamepadService = game:GetService("GamepadService")
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local CurrentCamera = workspace.CurrentCamera
return {
	rotatedLine = function(x1, y1, x2, y2, scale)
		local deltaX = x2 - x1
		local deltaY = y2 - y1
		return (x1 + x2) * 0.5, (y1 + y2) * 0.5, math.sqrt(deltaY * deltaY * scale * scale + deltaX * deltaX), math.atan2(deltaY * scale, deltaX)
	end,
	isSmallScreen = function()
		return math.min(CurrentCamera.ViewportSize.X, CurrentCamera.ViewportSize.y) <= 500
	end,
	shouldHaveTouchControls = function()
		return UserInputService.TouchEnabled
	end,
	getViewportSizeChangedSignal = function()
		return workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize")
	end,
	selectIfGamepad = function(guiElement)
		if GuiService.AutoSelectGuiEnabled then
			GamepadService:EnableGamepadCursor(guiElement)
		elseif UserInputService:GetLastInputType() == Enum.UserInputType.Gamepad1 then
			GuiService.SelectedObject = guiElement
		end
	end,
	isGuiAncestryVisible = function(guiElement)
		while (not guiElement:IsA("GuiObject") or guiElement.Visible) and (not guiElement:IsA("ScreenGui") or guiElement.Enabled) do
			guiElement = guiElement.Parent
			if not guiElement then
				return true
			end
		end
		return false
	end
}
