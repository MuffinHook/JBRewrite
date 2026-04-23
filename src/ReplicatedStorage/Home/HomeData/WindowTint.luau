local ReplicatedStorage = game:GetService("ReplicatedStorage")
local WindowTint = require(ReplicatedStorage.Game.Garage.StoreData.WindowTint)
return {
	getInstance = function(p1) --[[ Name: getInstance | Line: 5 ]]
		local Part = Instance.new("Part")
		Part.Shape = Enum.PartType.Ball
		Part.Size = Vector3.new(4, 4, 4)
		Part.TopSurface = 0
		Part.BottomSurface = 0
		Part.Color = Color3.new(p1.Value, p1.Value, p1.Value)
		Part.Anchored = true
		Part.CFrame = CFrame.new()
		return Part
	end,
	updateCamera = function(p1, p2) --[[ Name: updateCamera | Line: 16 ]]
		local v1 = os.clock() / 2
		p1.CFrame = CFrame.Angles(0, v1 % 6.283185307179586, 0) * CFrame.Angles(math.sin(v1) * 0.25 - 0.3, 0, 0) * CFrame.new(0, 0, 8)
	end,
	getItems = function() --[[ Name: getItems | Line: 22 | Upvalues: WindowTint (copy) ]]
		return WindowTint.Items
	end,
	apply = function(p1, p2) --[[ Name: apply | Line: 25 ]]
		local Windows = p2:FindFirstChild("Windows")
		if Windows then
			local count = 0
			for v1, v2 in Windows:GetChildren() do
				if v2:IsA("BasePart") then
					count = count + 1
					if p1 and not p1.None then
						v2.Transparency = p1.Value
					else
						v2.Transparency = v2:GetAttribute("OriginalTransparency")
					end
				end
			end
			assert(count > 0, "No parts to apply to")
		else
			warn("Missing subModel")
		end
	end
}