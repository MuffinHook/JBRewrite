-- Reviewed by Claude
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EzUtils = require(ReplicatedStorage.EzUi.EzUtils)
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local t = {
	ChatModule = nil,
	IsSmallScreen = function()
		return math.min(CurrentCamera.ViewportSize.X, CurrentCamera.ViewportSize.y) <= 500
	end
}
function t.GetChatModule()
	if t.ChatModule then
		return t.ChatModule
	else
		local ChatScript = LocalPlayer.PlayerScripts:FindFirstChild("ChatScript")
		if ChatScript == nil then
			return nil
		else
			local ChatMain = ChatScript:FindFirstChild("ChatMain")
			if ChatMain == nil then
				return nil
			else
				local v1 = nil
				local v2, v3 = pcall(function()
					v1 = require(ChatMain)
				end)
				if v2 then
					t.ChatModule = v1
					return t.ChatModule
				else
					warn(v3)
					return nil
				end
			end
		end
	end
end
function t.GetChatVisible()
	local v1 = t.GetChatModule()
	if v1 == nil or v1.GetVisibility == nil then
		warn("Could not set chat visibility. API changed?")
		return false
	else
		local v2 = nil
		local v3, v4 = pcall(function()
			v2 = v1:GetVisibility()
		end)
		if not v3 then
			warn(v4)
		end
		return v2
	end
end
function t.SetChatVisible(p1)
	local v1 = t.GetChatModule()
	if v1 == nil or v1.SetVisible == nil then
		warn("Could not set chat visibility. API changed?")
		return false
	else
		local v2, v3 = pcall(function()
			v1:SetVisible(p1)
		end)
		if not v2 then
			warn(v3)
		end
		return true
	end
end
function t.getJumpButtonPosition()
	local v1 = t.IsSmallScreen()
	local v2 = if v1 then 70 else 120
	return v1 and UDim2.new(1, -(v2 * 1.5 - 10), 1, -v2 - 20) or UDim2.new(1, -(v2 * 1.5 - 10), 1, -v2 * 1.75)
end
function t.selectIfGamepad(p1)
	EzUtils.selectIfGamepad(p1)
end
return t
