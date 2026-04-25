-- Reviewed by Claude
-- variables reassigned
local GameAnalyticsClientModule = {}
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ScriptContext = game:GetService("ScriptContext")
function GameAnalyticsClientModule.initClient()
	local Postie = require(script.Parent.GameAnalytics.Postie)
	ScriptContext.Error:Connect(function(errorMessage, errorTraceback, errorSource)
		if errorSource then
			local sourceFullName = nil
			local pcallSuccess, _ = pcall(function()
				sourceFullName = errorSource:GetFullName()
			end)
			if pcallSuccess then
				ReplicatedStorage.GameAnalyticsError:FireServer(errorMessage, errorTraceback, sourceFullName)
			end
		end
	end)
	local function getPlatform()
		if GuiService:IsTenFootInterface() then
			return "Console"
		elseif UserInputService.TouchEnabled and not UserInputService.MouseEnabled then
			return "Mobile"
		else
			return "Desktop"
		end
	end
	Postie.setCallback("getPlatform", getPlatform)
end
return GameAnalyticsClientModule
