local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Raycast = require(ReplicatedStorage.Std.Raycast)
local GuardNPCConsts = require(ReplicatedStorage.GuardNPC.GuardNPCConsts)
local GuardNPCUtils = require(ReplicatedStorage.GuardNPC.GuardNPCUtils)
local GuardNPCShared = {}
local function collidableFunc(instance)
	if instance.Transparency >= 0.999 then
		return false
	else
		return instance.CanCollide
	end
end
function GuardNPCShared.canSeeTarget(guardNPC, targetCharacter, ignoreList)
	if typeof(targetCharacter) == "Vector3" then
		return false
	else
		local Position = guardNPC.HumanoidRootPart.Position
		local maxShootDistance = GuardNPCUtils.getMaxShootDist(guardNPC) or GuardNPCConsts.MAX_SHOOT_DIST
		local maxDefenseDistance = GuardNPCUtils.getMaxAllowedShootDistanceFromDefenseTarget(guardNPC)
		local directionVector, distance, raycastDistance, raycastHit, hitInstance, hitPosition
		if GuardNPCUtils.getIsTargetingInvolvedPlayer(guardNPC) or not maxDefenseDistance then
			directionVector = targetCharacter.Position - Position
			distance = directionVector.Magnitude
			raycastDistance = math.min(distance, maxShootDistance)
			raycastHit = Raycast.collidable(Position, directionVector.Unit, raycastDistance, ignoreList, collidableFunc)
			if raycastHit then
				hitInstance = raycastHit.Instance
				hitPosition = raycastHit.Position
			else
				hitPosition = Position + directionVector.Unit * raycastDistance
				hitInstance = nil
			end
			if hitInstance and (hitInstance:IsDescendantOf(targetCharacter.Parent) or hitInstance:IsDescendantOf(workspace.Vehicles)) then
				return true
			else
				return (hitPosition - targetCharacter.Position).Magnitude < 1
			end
		else
			if maxDefenseDistance < (targetCharacter.Position - GuardNPCUtils.getDefenseTargetPos(guardNPC)).Magnitude then
				return false
			else
				directionVector = targetCharacter.Position - Position
				distance = directionVector.Magnitude
				raycastDistance = math.min(distance, maxShootDistance)
				raycastHit = Raycast.collidable(Position, directionVector.Unit, raycastDistance, ignoreList, collidableFunc)
				if raycastHit then
					hitInstance = raycastHit.Instance
					hitPosition = raycastHit.Position
				else
					hitPosition = Position + directionVector.Unit * raycastDistance
					hitInstance = nil
				end
				if hitInstance and (hitInstance:IsDescendantOf(targetCharacter.Parent) or hitInstance:IsDescendantOf(workspace.Vehicles)) then
					return true
				else
					return (hitPosition - targetCharacter.Position).Magnitude < 1
				end
			end
		end
	end
end
return GuardNPCShared
