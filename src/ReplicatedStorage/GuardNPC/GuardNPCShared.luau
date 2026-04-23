local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Raycast = require(ReplicatedStorage.Std.Raycast)
local GuardNPCConsts = require(ReplicatedStorage.GuardNPC.GuardNPCConsts)
local GuardNPCUtils = require(ReplicatedStorage.GuardNPC.GuardNPCUtils)
local t = {}
local function collidableFunc(p1) --[[ Line: 10 ]]
	if p1.Transparency >= 0.999 then
		return false
	else
		return p1.CanCollide
	end
end
function t.canSeeTarget(p1, p2, p3) --[[ Line: 17 | Upvalues: GuardNPCUtils (copy), GuardNPCConsts (copy), Raycast (copy), collidableFunc (copy) ]]
	if typeof(p2) == "Vector3" then
		return false
	else
		local Position = p1.HumanoidRootPart.Position
		local v1 = GuardNPCUtils.getMaxShootDist(p1) or GuardNPCConsts.MAX_SHOOT_DIST
		local v2 = GuardNPCUtils.getMaxAllowedShootDistanceFromDefenseTarget(p1)
		local v3, v4, v5, v6, v7, v8
		if GuardNPCUtils.getIsTargetingInvolvedPlayer(p1) or not v2 then
			v3 = p2.Position - Position
			v4 = v3.Magnitude
			v5 = math.min(v4, v1)
			v6 = Raycast.collidable(Position, v3.Unit, v5, p3, collidableFunc)
			if v6 then
				v7 = v6.Instance
				v8 = v6.Position
			else
				v8 = Position + v3.Unit * v5
				v7 = nil
			end
			if v7 and (v7:IsDescendantOf(p2.Parent) or v7:IsDescendantOf(workspace.Vehicles)) then
				return true
			else
				return (v8 - p2.Position).Magnitude < 1
			end
		else
			if v2 < (p2.Position - GuardNPCUtils.getDefenseTargetPos(p1)).Magnitude then
				return false
			else
				v3 = p2.Position - Position
				v4 = v3.Magnitude
				v5 = math.min(v4, v1)
				v6 = Raycast.collidable(Position, v3.Unit, v5, p3, collidableFunc)
				if v6 then
					v7 = v6.Instance
					v8 = v6.Position
				else
					v8 = Position + v3.Unit * v5
					v7 = nil
				end
				if v7 and (v7:IsDescendantOf(p2.Parent) or v7:IsDescendantOf(workspace.Vehicles)) then
					return true
				else
					return (v8 - p2.Position).Magnitude < 1
				end
			end
		end
	end
end
return t