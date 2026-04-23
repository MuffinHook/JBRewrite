local RunService = game:GetService("RunService")
local ServerStorage = game:GetService("ServerStorage")
local v1 = if RunService:IsServer() and (ServerStorage:FindFirstChild("Game") and ServerStorage.Game:FindFirstChild("ServerPlayerUtils")) then require(ServerStorage.Game.ServerPlayerUtils) else nil
local t = {}
local PointToObjectSpace = CFrame.new().PointToObjectSpace
local function castBase(p1, p2, p3) --[[ Line: 20 | Upvalues: PointToObjectSpace (copy) ]]
	local v1 = PointToObjectSpace(p1, p3) + p2 * 0.5
	return if v1.X >= 0 and (v1.X < p2.X and (v1.Y >= 0 and (v1.Y < p2.Y and v1.Z >= 0))) then v1.Z < p2.Z else false
end
function t.CastPoint(p1, p2) --[[ Line: 24 | Upvalues: PointToObjectSpace (copy) ]]
	local s = p1.s
	local v1 = PointToObjectSpace(p1.c, p2) + s * 0.5
	return if v1.X >= 0 and (v1.X < s.X and (v1.Y >= 0 and (v1.Y < s.Y and v1.Z >= 0))) then v1.Z < s.Z else false
end
function t.isPointInPart(p1, p2) --[[ Line: 30 | Upvalues: PointToObjectSpace (copy) ]]
	assert(typeof(p1) == "Instance", "Invalid part passed")
	assert(typeof(p2) == "Vector3", "Invalid pos passed")
	local Size = p1.Size
	local v4 = PointToObjectSpace(p1.CFrame, p2) + Size * 0.5
	return if v4.X >= 0 and (v4.X < Size.X and (v4.Y >= 0 and (v4.Y < Size.Y and v4.Z >= 0))) then v4.Z < Size.Z else false
end
function t.ConditionPart(p1, p2) --[[ Line: 35 ]]
	return p1:CastPoint(p2.Position)
end
function t.ConditionPlayer(p1, p2) --[[ Line: 39 | Upvalues: v1 (ref) ]]
	local Character = p2.Character
	if Character then
		local Humanoid = Character:FindFirstChild("Humanoid")
		if Humanoid then
			if Humanoid.Health < 0.001 then
				return false
			else
				local RootPart = Humanoid.RootPart
				if RootPart then
					return p1:CastPoint(v1 and v1.getLastPosition(p2) or RootPart.Position)
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
function t.NilCondition() --[[ Line: 61 ]]
	return false
end
function t.ConditionFacing(p1, p2) --[[ Line: 65 ]]
	local Character = p2.Character
	if Character then
		local Humanoid = Character:FindFirstChild("Humanoid")
		if Humanoid and not (Humanoid.Health < 0.001) then
			local RootPart = Humanoid.RootPart
			if RootPart then
				local v1 = RootPart.CFrame
				for i = 1, #p1.Prisms do
					local v2, v3
					local v4 = p1.Prisms[i]
					local v5 = v4.p - v1.p
					local v6 = v1.LookVector:Dot(v5.Unit) > 0.8
					v2 = v4.LookVector:Dot(v5.Unit) < 0
					v3 = v5.Magnitude < 8
					if v2 and (v6 and v3) then
						return true
					end
				end
			end
		end
	end
	return false
end
function t.ConditionClose(p1, p2) --[[ Line: 101 | Upvalues: v1 (ref) ]]
	local Character = p2.Character
	if Character then
		local Humanoid = Character:FindFirstChild("Humanoid")
		if Humanoid and not (Humanoid.Health < 0.001) then
			local RootPart = Humanoid.RootPart
			if RootPart then
				local v12 = v1 and CFrame.new(v1.getLastPosition(p2)) or RootPart.CFrame
				for i = 1, #p1.Prisms do
					if (p1.Prisms[i].c.p - v12.p).Magnitude < 0.5 * p1.Prisms[i].s.Magnitude then
						return true
					end
				end
			end
		end
	end
	return false
end
function t.getPrism(p1, p2) --[[ Line: 133 ]]
	return {
		c = p1,
		s = p2
	}
end
return t