-- Reviewed by Claude
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
local function randomVector()
	local cframe = math.random() * 2 - 1
	local localPlayer = math.random() * 2 - 1
	return Vector3.new(cframe, localPlayer, math.random() * 2 - 1).Unit
end
local function offsetLookAtTarget(self, p2, p3, p4, p5, p6)
	if p4 == 0 or (p5 == 0 or p6 == 0) then
		return 0, 0
	else
		local cframe = p4 * p4 + p6 * p6
		local localPlayer = p6 < 0 and math.atan(p4 / p6) or math.pi - math.atan(-p4 / p6)
		local var4 = localPlayer + (self * self < cframe and math.asin(self / cframe ^ 0.5) or math.asin(cframe ^ 0.5 / self))
		local var5 = p6 * math.cos(var4) + p4 * math.sin(var4)
		local var6 = p5 * p5 + var5 * var5
		local var7 = var5 < 0 and math.atan(-p5 / var5) or math.atan(p5 / var5)
		return var4, var7 - (p2 * p2 < var6 and math.asin(p2 / var6 ^ 0.5) or math.asin(var6 ^ 0.5 / p2))
	end
end
local function shortAngleDist(self, p2)
	local cframe = (p2 - self) % 6.283185307179586
	return 2 * cframe % 6.283185307179586 - cframe
end
local function getNearestPlayer(self, p2)
	local cframe = p2 or (1 / 0)
	local localPlayer = nil
	for i, v in ipairs(Players:GetPlayers()) do
		local var3 = PlayerUtils.getRootPart(v)
		if var3 then
			local Magnitude = (var3.Position - self).Magnitude
			if Magnitude < cframe then
				cframe = Magnitude
				localPlayer = v
			end
		end
	end
	return localPlayer
end
local function getNearestOpp(self, p2, p3)
	local cframe = p3 or (1 / 0)
	local localPlayer = nil
	for var3, var4 in Players:GetPlayers() do
		if not self:HasPermissionToEnter(var4) then
			local var5 = PlayerUtils.getHumanoid(var4)
			if var5 and var5.Health > 0 then
				local RootPart = var5.RootPart
				if RootPart then
					local Magnitude = (RootPart.Position - p2).Magnitude
					if Magnitude < cframe then
						cframe = Magnitude
						localPlayer = var4
					end
				end
			end
		end
	end
	return localPlayer
end
local t = {
	bullet_impact_bass = 2837091387,
	reload = 6602025903,
	shoot = 6602025330,
	detected = 6602024939,
	motor = 6602024532
}
local cframe = nil
return {
	init = function(self)
		cframe = self.Event
	end,
	setup = function(self)
		local _obj = self._obj
		local var12 = 0
		local localPlayer = 0
		local var3 = Spring.new(var12, 0, 0.6, 15)
		local var4 = Spring.new(localPlayer, 0, 0.6, 15)
		local var5 = Spring.new(0, 0, 0.7, 70)
		local var6 = BulletEmitter.new(true)
		var6.IgnoreList = assert({})
		var6.LifeSpan = 1
		var6.IgnoreLocalPlayer = false
		var6.ShieldBlockPct = 0.5
		var6.GravityVector = Vector3.new(0, -49.05, 0)
		self._maid:GiveTask(var6.OnLocalHitPlayer:Connect(function(p12)
			local var12 = Players:GetPlayerFromCharacter(p12.Parent)
			if var12 then
				if var12 == LocalPlayer then
					local localPlayer = self:GetHome()
					if not (localPlayer and localPlayer:HasPermissionToEnter(var12)) then
						cframe:FireServer("xe6v1us6", 3, "Shot")
					end
				end
				Audio.ObjectLocal(p12.RootPart, t.bullet_impact_bass, {
					Volume = 1
				})
			end
		end))
		local var7 = os.clock()
		local function updateRotation(self)
			local cframe = os.clock()
			local var22 = cframe - var7
			var7 = cframe
			local cframe32 = _obj.Pivot.CFrame
			local var42 = cframe32:PointToObjectSpace(self)
			local v52, var6 = offsetLookAtTarget(0.3935546875, 1.7648589611053467, nil, var42.x, var42.y, var42.z)
			var12 = var6
			local var72 = (v52 - localPlayer) % 6.283185307179586
			localPlayer = localPlayer + math.clamp(2 * var72 % 6.283185307179586 - var72, -2.5132741228718345 * var22, 2.5132741228718345 * var22)
			local var8 = var3:SetTarget(var6)
			local var9 = var4:SetTarget(localPlayer)
			local var10 = var5:Update()
			_obj.Top:SetPrimaryPartCFrame(cframe32 * CFrame.Angles(0, var9, 0) * CFrame.Angles(var8, 0, 0) * CFrame.new(0, 0, var10))
		end
		self._maid:GiveTask(var6)
		local function fire()
			local cframe = _obj.Top.Tip.CFrame
			var6:Emit(cframe.p, cframe.LookVector + Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1).Unit * 0.01, 300)
			var5:Accelerate(40)
			Audio.ObjectLocal(_obj.Top.Tip, t.shoot, {
				Volume = 0.5
			})
		end
		local var8 = Audio.ObjectLocal(_obj.Pivot, t.motor, {
			Looped = true,
			DoNotPlay = true,
			Volume = 0.3
		})
		local var9 = 20
		local var10 = os.clock()
		local var11 = nil
		local var122 = os.clock()
		self._maid:GiveTask(RunService.Heartbeat:Connect(function()
			local cframe = os.clock()
			local localPlayer = PlayerUtils.getRootPart(LocalPlayer)
			if localPlayer then
				if not ((localPlayer.Position - self._obj.PrimaryPart.Position).Magnitude > 128) then
					var6:Update()
					local var3 = nil
					local var4 = nil
					local var5 = self:GetHome()
					local var62 = var5:GetOwnerId()
					if not (self:GetGhosted() or self:IsBeingDragged()) then
						if var62 then
							local var7 = getNearestOpp(var5, self._obj.PrimaryPart.Position, 64)
							if var7 then
								local var82 = PlayerUtils.getRootPart(var7)
								var4 = var82.Parent
								var3 = var82.Position
							end
						else
							local var92 = getNearestPlayer(self._obj.PrimaryPart.Position, 64)
							if var92 then
								local var102 = PlayerUtils.getRootPart(var92)
								var4 = var102.Parent
								var3 = var102.Position
							end
						end
					end
					if var3 then
						local Position = _obj.Top.Tip.Position
						local var112 = var3 - Position
						local var12, var13 = RayCast.RayIgnoreNonCollide(Position, var112.Unit, var112.Magnitude, _obj)
						if (var13 - var3).Magnitude > 1 and (not var4 or var12 and not var12:IsDescendantOf(var4)) then
							var3 = nil
						end
					end
					if var3 then
						if not var11 then
							if not var8.IsPlaying then
								var8:Play()
							end
							if cframe - var122 > 2 then
								var122 = cframe
								Audio.ObjectLocal(_obj.Pivot, t.detected, {
									Volume = 1
								})
								var10 = cframe + 0.5
							end
						end
						updateRotation(var3)
						if cframe - var10 > 0.1 then
							var10 = cframe
							if var9 > 0 then
								var9 = var9 - 1
								fire()
							else
								var10 = cframe + 3
								var9 = 20
								Audio.ObjectLocal(_obj.Pivot, t.reload, {
									Volume = 1
								})
							end
						end
					end
					if not var3 and (var11 and var8.IsPlaying) then
						var8:Stop()
					end
					var11 = var3
				end
			end
		end))
		local var13 = false
		self._maid:GiveTask(Interval.every(0.5):Connect(function()
			var13 = not var13
			_obj.Top.Light.Color = var13 and Color3.new(0/255, 255/255, 0/255) or Color3.new(255/255, 0/255, 0/255)
		end))
	end
}
