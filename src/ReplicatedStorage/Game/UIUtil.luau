local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EzUtils = require(ReplicatedStorage.EzUi.EzUtils)
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local uiUtilModule = {
	ChatModule = nil,
	IsSmallScreen = function()
		return math.min(CurrentCamera.ViewportSize.X, CurrentCamera.ViewportSize.y) <= 500
	end
}
function uiUtilModule.GetChatModule()
	if uiUtilModule.ChatModule then
		return uiUtilModule.ChatModule
	else
		local ChatScript = LocalPlayer.PlayerScripts:FindFirstChild("ChatScript")
		if ChatScript == nil then
			return nil
		else
			local ChatMain = ChatScript:FindFirstChild("ChatMain")
			if ChatMain == nil then
				return nil
			else
				local chatModuleResult = nil
				local success, errorMessage = pcall(function()
					chatModuleResult = require(ChatMain)
				end)
				if success then
					uiUtilModule.ChatModule = chatModuleResult
					return uiUtilModule.ChatModule
				else
					warn(errorMessage)
					return nil
				end
			end
		end
	end
end
function uiUtilModule.GetChatVisible()
	local chatModule = uiUtilModule.GetChatModule()
	if chatModule == nil or chatModule.GetVisibility == nil then
		warn("Could not set chat visibility. API changed?")
		return false
	else
		local visibilityResult = nil
		local getVisibilitySuccess, getVisibilityError = pcall(function()
			visibilityResult = chatModule:GetVisibility()
		end)
		if not getVisibilitySuccess then
			warn(getVisibilityError)
		end
		return visibilityResult
	end
end
function uiUtilModule.SetChatVisible(isVisible)
	local chatModule = uiUtilModule.GetChatModule()
	if chatModule == nil or chatModule.SetVisible == nil then
		warn("Could not set chat visibility. API changed?")
		return false
	else
		local setVisibleSuccess, setVisibleError = pcall(function()
			chatModule:SetVisible(isVisible)
		end)
		if not setVisibleSuccess then
			warn(setVisibleError)
		end
		return true
	end
end
function uiUtilModule.getJumpButtonPosition()
	local isSmallScreen = uiUtilModule.IsSmallScreen()
	local buttonOffset = if isSmallScreen then 70 else 120
	return isSmallScreen and UDim2.new(1, -(buttonOffset * 1.5 - 10), 1, -buttonOffset - 20) or UDim2.new(1, -(buttonOffset * 1.5 - 10), 1, -buttonOffset * 1.75)
end
function uiUtilModule.selectIfGamepad(guiElement)
	EzUtils.selectIfGamepad(guiElement)
end
return uiUtilModule
