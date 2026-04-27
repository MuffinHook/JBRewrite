local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RayCast = require(ReplicatedStorage.Module.RayCast)
local instance = nil
local timeModule = nil
local t = {}
t.__index = t
function t.new(initialPosition, initialVelocity)
	local bombInstance = setmetatable({}, t)
	bombInstance.p0 = initialPosition
	bombInstance.v0 = initialVelocity
	local bombModel = ReplicatedStorage.Resource.HeliBomb:Clone()
	instance.WeldAllTo(bombModel, bombModel.Rocket)
	bombModel.Rocket.Anchored = true
	bombModel.Rocket.CFrame = initialPosition
	bombModel.Parent = workspace
	bombInstance.Model = bombModel
	return bombInstance
end
local gravityConstant = Vector3.new()
local bombRotationOffset = CFrame.Angles(0, math.pi, 0)
function t.Animate(bombInstance, startTime)
	local elapsedTime = startTime or timeModule.GetNowSync()
	local lastFrameTime = elapsedTime
	local function Heartbeat()
		local currentTime = timeModule.GetNowSync()
		local deltaTime = currentTime - elapsedTime
		local frameDelta = currentTime - lastFrameTime
		lastFrameTime = currentTime
		local velocityVector = bombInstance.v0 * deltaTime + Vector3.new(0, -98.10000000000001 * deltaTime * deltaTime, 0)
		bombInstance.Model.Rocket.CFrame = CFrame.new(gravityConstant, (bombInstance.p0.LookVector:Lerp(Vector3.new(0, -1, 0), (math.min(1, deltaTime * 4/3))))) * bombRotationOffset + bombInstance.p0.p + velocityVector
		if deltaTime - frameDelta < 0.3 and deltaTime > 0.3 then
			bombInstance.Model.Fire.Particle.Enabled = true
		end
		if deltaTime > 0.3 then
			local rayHit, hitPosition = RayCast.RayIgnoreNonCollide(bombInstance.p0.p + velocityVector, Vector3.new(0, -1, 0), math.abs(bombInstance.v0.Y + -196.20000000000002 * deltaTime) * frameDelta, bombInstance.Model)
			if rayHit then
				bombInstance:Explode(hitPosition)
			end
		end
		if deltaTime > 5 and not bombInstance.Exploded then
			bombInstance:Destroy()
		end
	end
	bombInstance.Runtime = RunService.Heartbeat:Connect(Heartbeat)
end
local eventRemote = nil
function t.Explode(bombInstance, explosionPosition)
	bombInstance.Exploded = true
	delay(2, function()
		bombInstance:Destroy()
	end)
	if bombInstance.Runtime then
		bombInstance.Runtime:Disconnect()
		bombInstance.Runtime = nil
	end
	bombInstance.Model.Fire.Particle.Enabled = false
	bombInstance.Model.Rocket.Transparency = 1
	local Explosion = Instance.new("Explosion")
	Explosion.ExplosionType = Enum.ExplosionType.NoCraters
	Explosion.DestroyJointRadiusPercent = 0
	Explosion.Position = explosionPosition
	Explosion.Parent = workspace
	local Sound = Instance.new("Sound")
	Sound.SoundId = "rbxassetid://55224766"
	Sound.Parent = bombInstance.Model.Rocket
	Sound.Volume = 0.8
	Sound:Play()
	local Character = Players.LocalPlayer.Character
	if Character then
		local Humanoid = Character:FindFirstChild("Humanoid")
		if Humanoid then
			local RootPart = Humanoid.RootPart
			if RootPart then
				local distanceVector = RootPart.Position - explosionPosition
				local damageFalloff = math.max(24 - distanceVector.Magnitude, 0) / 24
				if damageFalloff > 0.001 then
					RootPart.Velocity = RootPart.Velocity + distanceVector.Unit * damageFalloff * 30
					if bombInstance._owner then
						print(bombInstance._owner)
						eventRemote:FireServer("x941csnt", damageFalloff * 50, bombInstance._owner, "Bomb")
						return
					end
					eventRemote:FireServer("xe6v1us6", damageFalloff * 50, "Explode")
				end
			end
		end
	end
end
function t.SetOwner(bombInstance, ownerPlayer)
	bombInstance._owner = ownerPlayer
end
function t.Destroy(bombInstance)
	if bombInstance.Runtime then
		bombInstance.Runtime:Disconnect()
		bombInstance.Runtime = nil
	end
	bombInstance.Model:Destroy()
end
local function DropBomb(spawnPosition, spawnVelocity, spawnTime, bombOwner)
	local bomb = t.new(spawnPosition, spawnVelocity)
	bomb:SetOwner(bombOwner)
	bomb:Animate(spawnTime)
end
return {
	Init = function(configModule)
		eventRemote = configModule.Event
		timeModule = require(ReplicatedStorage.Module.Time)
		instance = require(ReplicatedStorage.Std.Joint)
	end,
	DropBomb = DropBomb
}
