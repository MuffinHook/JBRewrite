local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DrownConsts = require(ReplicatedStorage.Drown.DrownConsts)
local Raycast = require(ReplicatedStorage.Std.Raycast)
return {
	setDrownPercent = function(p1, p2) --[[ Name: setDrownPercent | Line: 7 | Upvalues: Players (copy), DrownConsts (copy) ]]
		assert(p1 and p1.Parent == Players, "Invalid player")
		assert(type(p2) == "number", "Invalid value")
		p1:SetAttribute(DrownConsts.DROWN_PERCENT_ATTR_NAME, p2)
	end,
	getDrownPercent = function(p1) --[[ Name: getDrownPercent | Line: 12 | Upvalues: Players (copy), DrownConsts (copy) ]]
		assert(p1 and p1.Parent == Players, "Invalid player")
		return p1:GetAttribute(DrownConsts.DROWN_PERCENT_ATTR_NAME)
	end,
	getDrownPercentChangedSignal = function(p1) --[[ Name: getDrownPercentChangedSignal | Line: 16 | Upvalues: Players (copy), DrownConsts (copy) ]]
		assert(p1 and p1.Parent == Players, "Invalid player")
		return p1:GetAttributeChangedSignal(DrownConsts.DROWN_PERCENT_ATTR_NAME)
	end,
	getIsPlayerDrowning = function(p1) --[[ Name: getIsPlayerDrowning | Line: 20 | Upvalues: Raycast (copy) ]]
		local Character = p1.Character
		if Character then
			local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
			if HumanoidRootPart then
				local Head = Character:FindFirstChild("Head")
				if Head then
					if HumanoidRootPart.Position.Y > 180 then
						return false
					else
						local v1 = Region3.new(Head.CFrame.Position - Vector3.new(2, 2, 2), Head.CFrame.Position + Vector3.new(2, 2, 2)):ExpandToGrid(4)
						debug.profilebegin("getIsPlayingDrowning ReadVoxels")
						local v2 = workspace.Terrain:ReadVoxels(v1, 4)
						debug.profileend()
						local Size = v2.Size
						if (function() --[[ Name: doesWaterVoxelExist | Line: 47 | Upvalues: Size (copy), v2 (copy) ]]
							for i = 1, Size.X do
								for j = 1, Size.Y do
									for k = 1, Size.Z do
										if v2[i][j][k] == Enum.Material.Water then
											return true
										end
									end
								end
							end
							return false
						end)() then
							local v3 = RaycastParams.new()
							v3.IgnoreWater = false
							v3.FilterDescendantsInstances = { workspace.Terrain }
							v3.FilterType = Enum.RaycastFilterType.Include
							local v4 = Raycast.collidable(Head.Position, Vector3.new(-0, -1, -0), 10, v3)
							return (not v4 or v4.Material ~= Enum.Material.Water) and true or false
						else
							return false
						end
					end
				else
					return false
				end
			else
				return false
			end
		else
			return false
		end
	end
}