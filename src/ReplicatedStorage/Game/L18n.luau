-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Localization = require(ReplicatedStorage.Module.Localization)
return function(p1)
	local ScreenGui = p1.ScreenGui
	local L18n = workspace:FindFirstChild("L18n")
	if L18n then
		for i, v in ipairs(L18n:GetChildren()) do
			local SurfaceGui = v:FindFirstChild("SurfaceGui")
			if SurfaceGui ~= nil then
				local TextLabel = SurfaceGui:FindFirstChild("TextLabel")
				if TextLabel ~= nil then
					TextLabel.Text = Localization:FormatByKey(("world.%s"):format(v.Name))
				end
			end
		end
	end
end
