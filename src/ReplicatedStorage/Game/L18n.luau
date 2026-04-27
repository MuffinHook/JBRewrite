local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Localization = require(ReplicatedStorage.Module.Localization)
return function(parent)
	local ScreenGui = parent.ScreenGui
	local L18n = workspace:FindFirstChild("L18n")
	if L18n then
		for i, childInstance in ipairs(L18n:GetChildren()) do
			local SurfaceGui = childInstance:FindFirstChild("SurfaceGui")
			if SurfaceGui ~= nil then
				local TextLabel = SurfaceGui:FindFirstChild("TextLabel")
				if TextLabel ~= nil then
					TextLabel.Text = Localization:FormatByKey(("world.%s"):format(childInstance.Name))
				end
			end
		end
	end
end
