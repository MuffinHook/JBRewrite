local ReplicatedStorage = game:GetService("ReplicatedStorage")
local WindowTint = require(ReplicatedStorage.Game.Garage.StoreData.WindowTint)
return {
	getInstance = function(tintConfig)
		local Part = Instance.new("Part")
		Part.Shape = Enum.PartType.Ball
		Part.Size = Vector3.new(4, 4, 4)
		Part.TopSurface = 0
		Part.BottomSurface = 0
		Part.Color = Color3.new(tintConfig.Value, tintConfig.Value, tintConfig.Value)
		Part.Anchored = true
		Part.CFrame = CFrame.new()
		return Part
	end,
	updateCamera = function(camera, p2)
		local progress = os.clock() / 2
		camera.CFrame = CFrame.Angles(0, progress % math.tau, 0) * CFrame.Angles(math.sin(progress) * 0.25 - 0.3, 0, 0) * CFrame.new(0, 0, 8)
	end,
	getItems = function()
		return WindowTint.Items
	end,
	apply = function(tintConfig, targetModel)
		local Windows = targetModel:FindFirstChild("Windows")
		if Windows then
			local count = 0
			for index, windowPart in Windows:GetChildren() do
				if windowPart:IsA("BasePart") then
					count = count + 1
					if tintConfig and not tintConfig.None then
						windowPart.Transparency = tintConfig.Value
					else
						windowPart.Transparency = windowPart:GetAttribute("OriginalTransparency")
					end
				end
			end
			assert(count > 0, "No parts to apply to")
		else
			warn("Missing subModel")
		end
	end
}
