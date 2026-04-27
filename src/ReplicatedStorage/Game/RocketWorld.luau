local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage.Std.Signal)
local Maid = require(ReplicatedStorage.Std.Maid)
local RayCast = require(ReplicatedStorage.Module.RayCast)
local RocketLauncherUtils = require(ReplicatedStorage.RocketLauncher.RocketLauncherUtils)
local Audio = require(ReplicatedStorage.Std.Audio)
local audioAssets = {
	explosion_large_02 = 2205008239,
	nitro_loop = 9058734199,
	nitro_ignite = 1386598740
}
local RocketWorld = {}
RocketWorld.__index = RocketWorld
function RocketWorld.new()
	local instance = {}
	setmetatable(instance, RocketWorld)
	instance.Maid = Maid.new()
	instance.OnRocketQueueEmptied = Signal.new()
	instance.OnRocketExploded = Signal.new()
	instance:Setup()
	return instance
end
function RocketWorld.CreatePart(self, offsetPosition, direction)
	local rocketPart = ReplicatedStorage.Resource.ItemSystem.Projectiles.Rocket:Clone()
	rocketPart.CFrame = CFrame.new(Vector3.new(), direction) + offsetPosition
	rocketPart.Parent = workspace
	self:AddSmoke(rocketPart)
	Audio.ObjectLocal(rocketPart, audioAssets.nitro_ignite, {
		Pitch = 0.7,
		TimePosition = 0.6,
		Volume = 0.3
	})
	local loopingSound = Audio.ObjectLocal(rocketPart, audioAssets.nitro_loop, {
		Pitch = 0.6,
		Volume = 1
	})
	loopingSound.Looped = true
	loopingSound.EmitterSize = 25
	loopingSound.Parent = rocketPart
	return rocketPart
end
function RocketWorld.AddSmoke(self, rocketPart)
	ReplicatedStorage.Resource.ItemSystem.Projectiles.RocketFire:Clone().Parent = rocketPart
	ReplicatedStorage.Resource.ItemSystem.Projectiles.RocketSmoke:Clone().Parent = rocketPart
end
function RocketWorld.Launch(self, origin, direction, speed)
	assert(origin)
	assert(direction)
	assert(speed)
	local rocketData = {
		origin,
		direction,
		speed,
		self:CreatePart(origin, direction),
		6
	}
	table.insert(self.ListRocket, rocketData)
end
function RocketWorld.Setup(self)
	self.ListRocket = {}
	self.IgnoreList = {}
	local heartbeatConnection = RunService.Heartbeat:Connect(function()
		self:Update()
	end)
	self.Maid:GiveTask(function()
		if #self.ListRocket > 0 then
			self.OnRocketQueueEmptied:Connect(function()
				heartbeatConnection:Disconnect()
				heartbeatConnection = nil
				self.OnRocketQueueEmptied:Destroy()
				self.OnRocketQueueEmptied = nil
				self.OnRocketExploded:Destroy()
				self.OnRocketExploded = nil
			end)
		else
			heartbeatConnection:Disconnect()
			heartbeatConnection = nil
			self.OnRocketQueueEmptied:Destroy()
			self.OnRocketQueueEmptied = nil
			self.OnRocketExploded:Destroy()
			self.OnRocketExploded = nil
		end
	end)
end
function RocketWorld.Update(self)
	local currentTime = tick()
	local deltaTime = currentTime - (self.LastUpdate or currentTime)
	self.LastUpdate = currentTime
	local rocketCount = #self.ListRocket
	for i = rocketCount, 1, -1 do
		local nextPosition
		local rocketData = self.ListRocket[i]
		local origin = rocketData[1]
		local direction = rocketData[2]
		local speed = rocketData[3]
		local rocketPart = rocketData[4]
		local lifetimeRemaining = rocketData[5]
		if lifetimeRemaining > 0 then
			local distance = speed * deltaTime
			if nil == nil then
				local hitInstance, hitPosition, _, materialList = RayCast.RayIgnoreNonCollideWithIgnoreList(origin, direction, distance, self.IgnoreList)
				if hitInstance == nil then
					nextPosition = hitPosition
				else
					nextPosition = hitPosition
					lifetimeRemaining = 0
				end
			else
				nextPosition = nil
			end
			rocketPart.CFrame = CFrame.new(Vector3.new(), direction) + nextPosition
			rocketPart.Velocity = direction * speed
			rocketData[1] = nextPosition
			rocketData[2] = direction
			rocketData[3] = speed
			rocketData[5] = lifetimeRemaining - deltaTime
		else
			rocketPart.Transparency = 1
			game.Debris:AddItem(rocketPart, 1)
			local nextFunction = next
			local childrenIterator, childrenState = rocketPart:GetChildren()
			for childIndex, child in nextFunction, childrenIterator, childrenState do
				if child:IsA("Sound") then
					Audio.FadeOut(child, 0.3)
				elseif child:IsA("ParticleEmitter") then
					child.Enabled = false
				end
			end
			self:ExplodeAt(origin)
			rocketData[4] = nil
			table.remove(self.ListRocket, i)
		end
	end
	if rocketCount > 0 and #self.ListRocket == 0 then
		self.OnRocketQueueEmptied:Fire()
	end
end
function RocketWorld.ExplodeAt(self, explosionPosition)
	RocketLauncherUtils.explodeAt(explosionPosition)
	self.OnRocketExploded:Fire(explosionPosition)
end
function RocketWorld.Destroy(self)
	self.Maid:Destroy()
	self.Maid = nil
end
return RocketWorld
