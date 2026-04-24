-- Reviewed by Claude
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DrownConsts = require(ReplicatedStorage.Drown.DrownConsts)
local Raycast = require(ReplicatedStorage.Std.Raycast)
return {
	setDrownPercent = function(player, drownPercent)
		assert(player and player.Parent == Players, "Invalid player")
		assert(type(drownPercent) == "number", "Invalid value")
		player:SetAttribute(DrownConsts.DROWN_PERCENT_ATTR_NAME, drownPercent)
	end,
	getDrownPercent = function(player)
		assert(player and player.Parent == Players, "Invalid player")
		return player:GetAttribute(DrownConsts.DROWN_PERCENT_ATTR_NAME)
	end,
	getDrownPercentChangedSignal = function(player)
		assert(player and player.Parent == Players, "Invalid player")
		return player:GetAttributeChangedSignal(DrownConsts.DROWN_PERCENT_ATTR_NAME)
	end,
	getIsPlayerDrowning = function(player)
		local Character = player.Character
		if Character then
			local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
			if HumanoidRootPart then
				local Head = Character:FindFirstChild("Head")
				if Head then
					if HumanoidRootPart.Position.Y > 180 then
						return false
					else
						local drownRegion = Region3.new(Head.CFrame.Position - Vector3.new(2, 2, 2), Head.CFrame.Position + Vector3.new(2, 2, 2)):ExpandToGrid(4)
						debug.profilebegin("getIsPlayingDrowning ReadVoxels")
						local voxelReads = workspace.Terrain:ReadVoxels(drownRegion, 4)
						debug.profileend()
						local Size = voxelReads.Size
						if (function()
						for i = 1, Size.X do
						for j = 1, Size.Y do
						for k = 1, Size.Z do
						if voxelReads[i][j][k] == Enum.Material.Water then
											return true
										end
									end
								end
							end
							return false
						end)() then
							local raycastParams = RaycastParams.new()
							raycastParams.IgnoreWater = false
							raycastParams.FilterDescendantsInstances = { workspace.Terrain }
							raycastParams.FilterType = Enum.RaycastFilterType.Include
							local raycastResult = Raycast.collidable(Head.Position, Vector3.new(-0, -1, -0), 10, raycastParams)
							return (not raycastResult or raycastResult.Material ~= Enum.Material.Water) and true or false
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
