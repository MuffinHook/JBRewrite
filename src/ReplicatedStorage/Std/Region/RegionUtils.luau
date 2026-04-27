local RunService = game:GetService("RunService")
local ServerStorage = game:GetService("ServerStorage")
local serverPlayerUtils = if RunService:IsServer() and (ServerStorage:FindFirstChild("Game") and ServerStorage.Game:FindFirstChild("ServerPlayerUtils")) then require(ServerStorage.Game.ServerPlayerUtils) else nil
local regionUtils = {}
local PointToObjectSpace = CFrame.new().PointToObjectSpace
local function castBase(prism, offset, pointToCheck)
	local objectSpacePoint = PointToObjectSpace(prism, pointToCheck) + offset * 0.5
	return if objectSpacePoint.X >= 0 and (objectSpacePoint.X < offset.X and (objectSpacePoint.Y >= 0 and (objectSpacePoint.Y < offset.Y and objectSpacePoint.Z >= 0))) then objectSpacePoint.Z < offset.Z else false
end
function regionUtils.CastPoint(prism, pointToCheck)
	local size = prism.s
	local objectSpacePoint = PointToObjectSpace(prism.c, pointToCheck) + size * 0.5
	return if objectSpacePoint.X >= 0 and (objectSpacePoint.X < size.X and (objectSpacePoint.Y >= 0 and (objectSpacePoint.Y < size.Y and objectSpacePoint.Z >= 0))) then objectSpacePoint.Z < size.Z else false
end
function regionUtils.isPointInPart(part, position)
	assert(typeof(part) == "Instance", "Invalid part passed")
	assert(typeof(position) == "Vector3", "Invalid pos passed")
	local Size = part.Size
	local objectSpacePoint = PointToObjectSpace(part.CFrame, position) + Size * 0.5
	return if objectSpacePoint.X >= 0 and (objectSpacePoint.X < Size.X and (objectSpacePoint.Y >= 0 and (objectSpacePoint.Y < Size.Y and objectSpacePoint.Z >= 0))) then objectSpacePoint.Z < Size.Z else false
end
function regionUtils.ConditionPart(region, targetPart)
	return region:CastPoint(targetPart.Position)
end
function regionUtils.ConditionPlayer(region, targetPlayer)
	local Character = targetPlayer.Character
	if Character then
		local Humanoid = Character:FindFirstChild("Humanoid")
		if Humanoid then
			if Humanoid.Health < 0.001 then
				return false
			else
				local RootPart = Humanoid.RootPart
				if RootPart then
					return region:CastPoint(serverPlayerUtils and serverPlayerUtils.getLastPosition(targetPlayer) or RootPart.Position)
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
end
function regionUtils.NilCondition()
	return false
end
function regionUtils.ConditionFacing(region, targetPlayer)
	local Character = targetPlayer.Character
	if Character then
		local Humanoid = Character:FindFirstChild("Humanoid")
		if Humanoid and not (Humanoid.Health < 0.001) then
			local RootPart = Humanoid.RootPart
			if RootPart then
				local rootPartCFrame = RootPart.CFrame
				for i = 1, #region.Prisms do
					local isTargetFacing, isCloseEnough
					local prism = region.Prisms[i]
					local vectorToTarget = prism.p - rootPartCFrame.p
					local isFacingTarget = rootPartCFrame.LookVector:Dot(vectorToTarget.Unit) > 0.8
					isTargetFacing = prism.LookVector:Dot(vectorToTarget.Unit) < 0
					isCloseEnough = vectorToTarget.Magnitude < 8
					if isTargetFacing and (isFacingTarget and isCloseEnough) then
						return true
					end
				end
			end
		end
	end
	return false
end
function regionUtils.ConditionClose(region, targetPlayer)
	local Character = targetPlayer.Character
	if Character then
		local Humanoid = Character:FindFirstChild("Humanoid")
		if Humanoid and not (Humanoid.Health < 0.001) then
			local RootPart = Humanoid.RootPart
			if RootPart then
				local targetCFrame = serverPlayerUtils and CFrame.new(serverPlayerUtils.getLastPosition(targetPlayer)) or RootPart.CFrame
				for i = 1, #region.Prisms do
					if (region.Prisms[i].c.p - targetCFrame.p).Magnitude < 0.5 * region.Prisms[i].s.Magnitude then
						return true
					end
				end
			end
		end
	end
	return false
end
function regionUtils.getPrism(center, size)
	return {
		c = center,
		s = size
	}
end
return regionUtils
