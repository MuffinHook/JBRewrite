local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BulletEmitter = require(ReplicatedStorage.Game.ItemSystem.BulletEmitter)
local PlayerUtils = require(ReplicatedStorage.Game.PlayerUtils)
local Spring = require(ReplicatedStorage.Std.Spring)
local Audio = require(ReplicatedStorage.Std.Audio)
local RayCast = require(ReplicatedStorage.Module.RayCast)
local Interval = require(ReplicatedStorage.Std.Interval)
local RunService = game:GetService("RunService")
require(ReplicatedStorage.Clan.ClanUtils)
local function randomVector() --[[ Line: 14 ]]
	local v1 = math.random() * 2 - 1
	local v2 = math.random() * 2 - 1
	return Vector3.new(v1, v2, math.random() * 2 - 1).Unit
end
local function offsetLookAtTarget(p1, p2, p3, p4, p5, p6) --[[ Line: 22 ]]
	if p4 == 0 or (p5 == 0 or p6 == 0) then
		return 0, 0
	else
		local v1 = p4 * p4 + p6 * p6
		local v2 = p6 < 0 and math.atan(p4 / p6) or math.pi - math.atan(-p4 / p6)
		local v4 = v2 + (p1 * p1 < v1 and math.asin(p1 / v1 ^ 0.5) or math.asin(v1 ^ 0.5 / p1))
		local v5 = p6 * math.cos(v4) + p4 * math.sin(v4)
		local v6 = p5 * p5 + v5 * v5
		local v7 = v5 < 0 and math.atan(-p5 / v5) or math.atan(p5 / v5)
		return v4, v7 - (p2 * p2 < v6 and math.asin(p2 / v6 ^ 0.5) or math.asin(v6 ^ 0.5 / p2))
	end
end
local function shortAngleDist(p1, p2) --[[ Line: 36 ]]
	local v1 = (p2 - p1) % 6.283185307179586
	return 2 * v1 % 6.283185307179586 - v1
end
local function getNearestPlayer(p1, p2) --[[ Line: 41 | Upvalues: Players (copy), PlayerUtils (copy) ]]
	local v1 = p2 or (1 / 0)
	local v2 = nil
	for i, v in ipairs(Players:GetPlayers()) do
		local v3 = PlayerUtils.getRootPart(v)
		if v3 then
			local Magnitude = (v3.Position - p1).Magnitude
			if Magnitude < v1 then
				v1 = Magnitude
				v2 = v
			end
		end
	end
	return v2
end
local function getNearestOpp(p1, p2, p3) --[[ Line: 56 | Upvalues: Players (copy), PlayerUtils (copy) ]]
	local v1 = p3 or (1 / 0)
	local v2 = nil
	for v3, v4 in Players:GetPlayers() do
		if not p1:HasPermissionToEnter(v4) then
			local v5 = PlayerUtils.getHumanoid(v4)
			if v5 and v5.Health > 0 then
				local RootPart = v5.RootPart
				if RootPart then
					local Magnitude = (RootPart.Position - p2).Magnitude
					if Magnitude < v1 then
						v1 = Magnitude
						v2 = v4
					end
				end
			end
		end
	end
	return v2
end
local t = {
	bullet_impact_bass = 2837091387,
	reload = 6602025903,
	shoot = 6602025330,
	detected = 6602024939,
	motor = 6602024532
}
local v1 = nil
return {
	init = function(p1) --[[ Name: init | Line: 89 | Upvalues: v1 (ref) ]]
		v1 = p1.Event
	end,
	setup = function(p1) --[[ Name: setup | Line: 92 | Upvalues: Spring (copy), BulletEmitter (copy), Players (copy), LocalPlayer (copy), v1 (ref), Audio (copy), t (copy), offsetLookAtTarget (copy), RunService (copy), PlayerUtils (copy), getNearestOpp (copy), getNearestPlayer (copy), RayCast (copy), Interval (copy) ]]
		local _obj = p1._obj
		local v12 = 0
		local v2 = 0
		local v3 = Spring.new(v12, 0, 0.6, 15)
		local v4 = Spring.new(v2, 0, 0.6, 15)
		local v5 = Spring.new(0, 0, 0.7, 70)
		local v6 = BulletEmitter.new(true)
		v6.IgnoreList = assert({})
		v6.LifeSpan = 1
		v6.IgnoreLocalPlayer = false
		v6.ShieldBlockPct = 0.5
		v6.GravityVector = Vector3.new(0, -49.05, 0)
		p1._maid:GiveTask(v6.OnLocalHitPlayer:Connect(function(p12) --[[ Line: 110 | Upvalues: Players (ref), LocalPlayer (ref), p1 (copy), v1 (ref), Audio (ref), t (ref) ]]
			local v12 = Players:GetPlayerFromCharacter(p12.Parent)
			if v12 then
				if v12 == LocalPlayer then
					local v2 = p1:GetHome()
					if not (v2 and v2:HasPermissionToEnter(v12)) then
						v1:FireServer("xe6v1us6", 3, "Shot")
					end
				end
				Audio.ObjectLocal(p12.RootPart, t.bullet_impact_bass, {
					Volume = 1
				})
			end
		end))
		local v7 = os.clock()
		local function updateRotation(p1) --[[ Line: 132 | Upvalues: v7 (ref), _obj (copy), offsetLookAtTarget (ref), v12 (ref), v2 (ref), v3 (copy), v4 (copy), v5 (copy) ]]
			local v1 = os.clock()
			local v22 = v1 - v7
			v7 = v1
			local v32 = _obj.Pivot.CFrame
			local v42 = v32:PointToObjectSpace(p1)
			local v52, v6 = offsetLookAtTarget(0.3935546875, 1.7648589611053467, nil, v42.x, v42.y, v42.z)
			v12 = v6
			local v72 = (v52 - v2) % 6.283185307179586
			v2 = v2 + math.clamp(2 * v72 % 6.283185307179586 - v72, -2.5132741228718345 * v22, 2.5132741228718345 * v22)
			local v8 = v3:SetTarget(v6)
			local v9 = v4:SetTarget(v2)
			local v10 = v5:Update()
			_obj.Top:SetPrimaryPartCFrame(v32 * CFrame.Angles(0, v9, 0) * CFrame.Angles(v8, 0, 0) * CFrame.new(0, 0, v10))
		end
		p1._maid:GiveTask(v6)
		local function fire() --[[ Line: 159 | Upvalues: _obj (copy), v6 (copy), v5 (copy), Audio (ref), t (ref) ]]
			local v1 = _obj.Top.Tip.CFrame
			v6:Emit(v1.p, v1.LookVector + Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1).Unit * 0.01, 300)
			v5:Accelerate(40)
			Audio.ObjectLocal(_obj.Top.Tip, t.shoot, {
				Volume = 0.5
			})
		end
		local v8 = Audio.ObjectLocal(_obj.Pivot, t.motor, {
			Looped = true,
			DoNotPlay = true,
			Volume = 0.3
		})
		local v9 = 20
		local v10 = os.clock()
		local v11 = nil
		local v122 = os.clock()
		p1._maid:GiveTask(RunService.Heartbeat:Connect(function() --[[ Line: 179 | Upvalues: PlayerUtils (ref), LocalPlayer (ref), p1 (copy), v6 (copy), getNearestOpp (ref), getNearestPlayer (ref), _obj (copy), RayCast (ref), v11 (ref), v8 (copy), v122 (ref), Audio (ref), t (ref), v10 (ref), updateRotation (copy), v9 (ref), fire (copy) ]]
			local v1 = os.clock()
			local v2 = PlayerUtils.getRootPart(LocalPlayer)
			if v2 then
				if not ((v2.Position - p1._obj.PrimaryPart.Position).Magnitude > 128) then
					v6:Update()
					local v3 = nil
					local v4 = nil
					local v5 = p1:GetHome()
					local v62 = v5:GetOwnerId()
					if not (p1:GetGhosted() or p1:IsBeingDragged()) then
						if v62 then
							local v7 = getNearestOpp(v5, p1._obj.PrimaryPart.Position, 64)
							if v7 then
								local v82 = PlayerUtils.getRootPart(v7)
								v4 = v82.Parent
								v3 = v82.Position
							end
						else
							local v92 = getNearestPlayer(p1._obj.PrimaryPart.Position, 64)
							if v92 then
								local v102 = PlayerUtils.getRootPart(v92)
								v4 = v102.Parent
								v3 = v102.Position
							end
						end
					end
					if v3 then
						local Position = _obj.Top.Tip.Position
						local v112 = v3 - Position
						local v12, v13 = RayCast.RayIgnoreNonCollide(Position, v112.Unit, v112.Magnitude, _obj)
						if (v13 - v3).Magnitude > 1 and (not v4 or v12 and not v12:IsDescendantOf(v4)) then
							v3 = nil
						end
					end
					if v3 then
						if not v11 then
							if not v8.IsPlaying then
								v8:Play()
							end
							if v1 - v122 > 2 then
								v122 = v1
								Audio.ObjectLocal(_obj.Pivot, t.detected, {
									Volume = 1
								})
								v10 = v1 + 0.5
							end
						end
						updateRotation(v3)
						if v1 - v10 > 0.1 then
							v10 = v1
							if v9 > 0 then
								v9 = v9 - 1
								fire()
							else
								v10 = v1 + 3
								v9 = 20
								Audio.ObjectLocal(_obj.Pivot, t.reload, {
									Volume = 1
								})
							end
						end
					end
					if not v3 and (v11 and v8.IsPlaying) then
						v8:Stop()
					end
					v11 = v3
				end
			end
		end))
		local v13 = false
		p1._maid:GiveTask(Interval.every(0.5):Connect(function() --[[ Line: 264 | Upvalues: v13 (ref), _obj (copy) ]]
			v13 = not v13
			_obj.Top.Light.Color = v13 and Color3.new(0/255, 255/255, 0/255) or Color3.new(255/255, 0/255, 0/255)
		end))
	end
}