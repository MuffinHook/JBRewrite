-- Reviewed by Claude
local t = {}
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ScriptContext = game:GetService("ScriptContext")
function t.initClient()
	local Postie = require(script.Parent.GameAnalytics.Postie)
	ScriptContext.Error:Connect(function(p1, p2, p3)
		if p3 then
			local v1 = nil
			local v2, _ = pcall(function()
				v1 = p3:GetFullName()
			end)
			if v2 then
				ReplicatedStorage.GameAnalyticsError:FireServer(p1, p2, v1)
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
return t
