local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local audioModule = nil
local RayCast = require(ReplicatedStorage.Module.RayCast)
local timeModule = nil
local function CalculateConstants(originPosition, initialVelocity, targetPosition, timeDelta, ignoreList)
	local timeDelta = timeDelta or 0.25
	local calculatedPosition = originPosition + initialVelocity * timeDelta + Vector3.new(0, -98.10000000000001 * timeDelta * timeDelta, 0)
	local Unit = (targetPosition - calculatedPosition).Unit
	local _, rayHitPosition = RayCast.RayIgnoreNonCollideWithIgnoreList(calculatedPosition, Unit, 999, ignoreList or {})
	local velocityDot = initialVelocity:Dot(Unit)
	return calculatedPosition, timeDelta, ((velocityDot * velocityDot + 3000 * (rayHitPosition - calculatedPosition).Magnitude) ^ 0.5 - velocityDot) / 1500, rayHitPosition
end
local zeroVector = nil
local Missile = {}
Missile.__index = Missile
function Missile.new(originCFrame, initialVelocity, targetPosition, modelName, dropPeriod, ignoreList)
	local missileInstance = setmetatable({}, Missile)
	if not modelName then
		modelName = "RocketPart"
	end
	missileInstance.Rotation = CFrame.Angles(0, 0, 0)
	if modelName == "RocketPart" then
		missileInstance.Rotation = CFrame.Angles(0, math.pi, 0)
	end
	local missileModel = ReplicatedStorage.Resource[modelName]:Clone()
	missileModel.CanCollide = false
	missileModel.Anchored = true
	missileModel.Parent = workspace
	missileModel.CFrame = originCFrame * missileInstance.Rotation
	missileInstance.Part = missileModel
	missileInstance.Origin = originCFrame
	missileInstance.OriginVelocity = initialVelocity
	missileInstance.Target = targetPosition
	missileInstance.DropPeriod = dropPeriod
	missileInstance.IgnoreList = ignoreList
	return missileInstance
end
function Missile.Animate(self, currentTime)
	local currentTime = currentTime or timeModule.GetNowSync()
	local OriginVelocity = self.OriginVelocity
	local LookVector = (self.Origin * self.Rotation).LookVector
	local launchPosition, ignitionTime, explosionDelay, _ = CalculateConstants(self.Origin.p, OriginVelocity, self.Target, self.DropPeriod, self.IgnoreList)
	local Unit = (self.Target - launchPosition).Unit
	local velocityAlignment = OriginVelocity:Dot(Unit)
	local lastHeartbeatTime = currentTime - 1/30
	local function Ignite()
		self.Part.Fire.Enabled = true
		audioModule.ObjectLocal(self.Part, 1386598740, {
			TimePosition = 0.5,
			Volume = 0.5
		})
		audioModule.ObjectLocal(self.Part, 9058734199, {
			Volume = 0.6,
			Pitch = 0.6,
			EmitterSize = 25
		})
	end
	local function Heartbeat()
		local nowTime = timeModule.GetNowSync()
		local elapsedTime = nowTime - currentTime
		local frameDelta = nowTime - lastHeartbeatTime
		lastHeartbeatTime = nowTime
		if elapsedTime - frameDelta < ignitionTime and ignitionTime <= elapsedTime then
			Ignite()
		end
		if elapsedTime - frameDelta < ignitionTime + explosionDelay and ignitionTime + explosionDelay <= elapsedTime then
			self:Explode()
		end
		if elapsedTime < ignitionTime then
			self.Part.CFrame = self.Origin * self.Rotation + OriginVelocity * elapsedTime + Vector3.new(0, -98.10000000000001 * elapsedTime * elapsedTime, 0)
		elseif elapsedTime < ignitionTime + explosionDelay then
			local explosionPhaseTime = elapsedTime - ignitionTime
			self.Part.CFrame = CFrame.new(zeroVector, (LookVector:Lerp(Unit, (math.min(explosionPhaseTime * 10, 1))))) + launchPosition + velocityAlignment * Unit * explosionPhaseTime + Unit * (750 * explosionPhaseTime * explosionPhaseTime)
		end
	end
	self.Runtime = RunService.Heartbeat:Connect(Heartbeat)
end
function Missile.Explode(self)
	task.delay(2, function()
		self:Destroy()
	end)
	self.Part.Transparency = 1
	self.Part.CanCollide = false
	self.Part.Fire.Enabled = false
	local Explosion = Instance.new("Explosion")
	Explosion.ExplosionType = Enum.ExplosionType.NoCraters
	Explosion.DestroyJointRadiusPercent = 0
	Explosion.Position = self.Part.Position
	Explosion.Parent = workspace
	local Sound = Instance.new("Sound")
	Sound.SoundId = "rbxassetid://55224766"
	Sound.Parent = self.Part
	Sound.Volume = 0.8
	Sound:Play()
end
function Missile.Destroy(self)
	self.Part:Destroy()
	self.Part = nil
	self.Runtime:Disconnect()
	self.Runtime = nil
end
return {
	CalculateConstants = CalculateConstants,
	LaunchMissile = function(originCFrame, initialVelocity, targetPosition, currentTime, dropPeriod, ignoreList, alignmentVector)
		Missile.new(originCFrame, initialVelocity, targetPosition, dropPeriod, ignoreList, alignmentVector):Animate(currentTime)
	end,
	Init = function()
		zeroVector = Vector3.new()
		audioModule = require(ReplicatedStorage.Std.Audio)
		timeModule = require(ReplicatedStorage.Module.Time)
	end
}
