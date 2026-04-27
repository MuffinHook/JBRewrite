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
	local randomX = math.random() * 2 - 1
	local randomY = math.random() * 2 - 1
	return Vector3.new(randomX, randomY, math.random() * 2 - 1).Unit
end
local function offsetLookAtTarget(self, targetDistance, p3, pitchX, pitchY, pitchZ)
	if pitchX == 0 or (pitchY == 0 or pitchZ == 0) then
		return 0, 0
	else
		local horizontalDistance = pitchX * pitchX + pitchZ * pitchZ
		local baseAngle = pitchZ < 0 and math.atan(pitchX / pitchZ) or math.pi - math.atan(-pitchX / pitchZ)
		local elevationAngle = baseAngle + (self * self < horizontalDistance and math.asin(self / horizontalDistance ^ 0.5) or math.asin(horizontalDistance ^ 0.5 / self))
		verticalComponent = pitchZ * math.cos(elevationAngle) + pitchX * math.sin(elevationAngle)
		squaredDistance = pitchY * pitchY + verticalComponent * verticalComponent
		local rollAngle = verticalComponent < 0 and math.atan(-pitchY / verticalComponent) or math.atan(pitchY / verticalComponent)
		return elevationAngle, rollAngle - (targetDistance * targetDistance < squaredDistance and math.asin(targetDistance / squaredDistance ^ 0.5) or math.asin(squaredDistance ^ 0.5 / targetDistance))
	end
end
local function shortAngleDist(self, angleTarget)
	local angleDiff = (angleTarget - self) % math.tau
	return 2 * angleDiff % math.tau - angleDiff
end
local function getNearestPlayer(self, maxDistance)
	local closestDistance = maxDistance or (1 / 0)
	local closestPlayer = nil
	for i, v in ipairs(Players:GetPlayers()) do
		local playerRootPart = PlayerUtils.getRootPart(v)
		if playerRootPart then
			local Magnitude = (playerRootPart.Position - self).Magnitude
			if Magnitude < closestDistance then
				closestDistance = Magnitude
				closestPlayer = v
			end
		end
	end
	return closestPlayer
end
local function getNearestOpp(self, targetPosition, maxDistance)
	local closestDistance = maxDistance or (1 / 0)
	local closestEnemy = nil
	for playerIndex, player in Players:GetPlayers() do
		if not self:HasPermissionToEnter(player) then
			local humanoid = PlayerUtils.getHumanoid(player)
			if humanoid and humanoid.Health > 0 then
				local RootPart = humanoid.RootPart
				if RootPart then
					local Magnitude = (RootPart.Position - targetPosition).Magnitude
					if Magnitude < closestDistance then
						closestDistance = Magnitude
						closestEnemy = player
					end
				end
			end
		end
	end
	return closestEnemy
end
local soundIds = {
	bullet_impact_bass = 2837091387,
	reload = 6602025903,
	shoot = 6602025330,
	detected = 6602024939,
	motor = 6602024532
}
local eventRemote = nil
return {
	init = function(self)
		eventRemote = self.Event
	end,
	setup = function(self)
		local _obj = self._obj
		local targetRollAngle = 0
		local targetElevationAngle = 0
		local rollAngleSpring = Spring.new(targetRollAngle, 0, 0.6, 15)
		local elevationAngleSpring = Spring.new(targetElevationAngle, 0, 0.6, 15)
		local recoilSpring = Spring.new(0, 0, 0.7, 70)
		local bulletEmitter = BulletEmitter.new(true)
		bulletEmitter.IgnoreList = assert({})
		bulletEmitter.LifeSpan = 1
		bulletEmitter.IgnoreLocalPlayer = false
		bulletEmitter.ShieldBlockPct = 0.5
		bulletEmitter.GravityVector = Vector3.new(0, -49.05, 0)
		self._maid:GiveTask(bulletEmitter.OnLocalHitPlayer:Connect(function(hitPart)
			local hitPlayer = Players:GetPlayerFromCharacter(hitPart.Parent)
			if hitPlayer then
				if hitPlayer == LocalPlayer then
					local playerHome = self:GetHome()
					if not (playerHome and playerHome:HasPermissionToEnter(hitPlayer)) then
						eventRemote:FireServer("xe6v1us6", 3, "Shot")
					end
				end
				Audio.ObjectLocal(hitPart.RootPart, soundIds.bullet_impact_bass, {
					Volume = 1
				})
			end
		end))
		local lastUpdateTime = os.clock()
		local function updateRotation(targetPos)
			local currentTime = os.clock()
			local deltaTime = currentTime - lastUpdateTime
			lastUpdateTime = currentTime
			local turretCFrame = _obj.Pivot.CFrame
			local relativePos = turretCFrame:PointToObjectSpace(targetPos)
			local elevationAngle, rollAngle = offsetLookAtTarget(0.3935546875, 1.7648589611053467, nil, relativePos.x, relativePos.y, relativePos.z)
			targetRollAngle = rollAngle
			local angleOffset = (elevationAngle - targetElevationAngle) % math.tau
			targetElevationAngle = targetElevationAngle + math.clamp(2 * angleOffset % math.tau - angleOffset, -2.5132741228718345 * deltaTime, 2.5132741228718345 * deltaTime)
			local rollAngleTarget = rollAngleSpring:SetTarget(rollAngle)
			local elevationAngleTarget = elevationAngleSpring:SetTarget(targetElevationAngle)
			local recoilAmount = recoilSpring:Update()
			_obj.Top:SetPrimaryPartCFrame(turretCFrame * CFrame.Angles(0, elevationAngleTarget, 0) * CFrame.Angles(rollAngleTarget, 0, 0) * CFrame.new(0, 0, recoilAmount))
		end
		self._maid:GiveTask(bulletEmitter)
		local function fire()
			local tipCFrame = _obj.Top.Tip.CFrame
			bulletEmitter:Emit(tipCFrame.p, tipCFrame.LookVector + Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1).Unit * 0.01, 300)
			recoilSpring:Accelerate(40)
			Audio.ObjectLocal(_obj.Top.Tip, soundIds.shoot, {
				Volume = 0.5
			})
		end
		local motorAudio = Audio.ObjectLocal(_obj.Pivot, soundIds.motor, {
			Looped = true,
			DoNotPlay = true,
			Volume = 0.3
		})
		local ammoCount = 20
		local lastFireTime = os.clock()
		local targetPosition = nil
		local lastDetectionTime = os.clock()
		self._maid:GiveTask(RunService.Heartbeat:Connect(function()
			local currentTime = os.clock()
			local playerRootPart = PlayerUtils.getRootPart(LocalPlayer)
			if playerRootPart then
				if not ((playerRootPart.Position - self._obj.PrimaryPart.Position).Magnitude > 128) then
					bulletEmitter:Update()
					local targetPos = nil
					local targetCharacter = nil
					local currentHome = self:GetHome()
					local homeOwnerId = currentHome:GetOwnerId()
					if not (self:GetGhosted() or self:IsBeingDragged()) then
						if homeOwnerId then
							local nearestEnemy = getNearestOpp(currentHome, self._obj.PrimaryPart.Position, 64)
							if nearestEnemy then
								local enemyRootPart = PlayerUtils.getRootPart(nearestEnemy)
								targetCharacter = enemyRootPart.Parent
								targetPos = enemyRootPart.Position
							end
						else
							local nearestFriend = getNearestPlayer(self._obj.PrimaryPart.Position, 64)
							if nearestFriend then
								local friendRootPart = PlayerUtils.getRootPart(nearestFriend)
								targetCharacter = friendRootPart.Parent
								targetPos = friendRootPart.Position
							end
						end
					end
					if targetPos then
						local tipPosition = _obj.Top.Tip.Position
						local directionToTarget = targetPos - tipPosition
						local hitPosition, hitInstance = RayCast.RayIgnoreNonCollide(tipPosition, directionToTarget.Unit, directionToTarget.Magnitude, _obj)
						if (hitPosition - targetPos).Magnitude > 1 and (not targetCharacter or hitInstance and not hitInstance:IsDescendantOf(targetCharacter)) then
							targetPos = nil
						end
					end
					if targetPos then
						if not targetPosition then
							if not motorAudio.IsPlaying then
								motorAudio:Play()
							end
							if currentTime - lastDetectionTime > 2 then
								lastDetectionTime = currentTime
								Audio.ObjectLocal(_obj.Pivot, soundIds.detected, {
									Volume = 1
								})
								lastFireTime = currentTime + 0.5
							end
						end
						updateRotation(targetPos)
						if currentTime - lastFireTime > 0.1 then
							lastFireTime = currentTime
							if ammoCount > 0 then
								ammoCount = ammoCount - 1
								fire()
							else
								lastFireTime = currentTime + 3
								ammoCount = 20
								Audio.ObjectLocal(_obj.Pivot, soundIds.reload, {
									Volume = 1
								})
							end
						end
					end
					if not targetPos and (targetPosition and motorAudio.IsPlaying) then
						motorAudio:Stop()
					end
					targetPosition = targetPos
				end
			end
		end))
		local isLightOn = false
		self._maid:GiveTask(Interval.every(0.5):Connect(function()
			isLightOn = not isLightOn
			_obj.Top.Light.Color = isLightOn and Color3.new(0/255, 255/255, 0/255) or Color3.new(255/255, 0/255, 0/255)
		end))
	end
}
