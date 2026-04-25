-- Reviewed by Claude
-- variables reassigned
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
function RocketWorld.CreatePart(p1, p2, p3)
	local rocketPart = ReplicatedStorage.Resource.ItemSystem.Projectiles.Rocket:Clone()
	rocketPart.CFrame = CFrame.new(Vector3.new(), p3) + p2
	rocketPart.Parent = workspace
	p1:AddSmoke(rocketPart)
	Audio.ObjectLocal(rocketPart, audioAssets.nitro_ignite, {
		Pitch = 0.7,
		TimePosition = 0.6,
		Volume = 0.3
	})
	local v2 = Audio.ObjectLocal(rocketPart, audioAssets.nitro_loop, {
		Pitch = 0.6,
		Volume = 1
	})
	v2.Looped = true
	v2.EmitterSize = 25
	v2.Parent = rocketPart
	return rocketPart
end
function RocketWorld.AddSmoke(p1, p2)
	ReplicatedStorage.Resource.ItemSystem.Projectiles.RocketFire:Clone().Parent = p2
	ReplicatedStorage.Resource.ItemSystem.Projectiles.RocketSmoke:Clone().Parent = p2
end
function RocketWorld.Launch(p1, p2, p3, p4)
	assert(p2)
	assert(p3)
	assert(p4)
	local rocketData = {
		p2,
		p3,
		p4,
		p1:CreatePart(p2, p3),
		6
	}
	table.insert(p1.ListRocket, rocketData)
end
function RocketWorld.Setup(p1)
	p1.ListRocket = {}
	p1.IgnoreList = {}
	local heartbeatConnection = RunService.Heartbeat:Connect(function()
		p1:Update()
	end)
	p1.Maid:GiveTask(function()
		if #p1.ListRocket > 0 then
			p1.OnRocketQueueEmptied:Connect(function()
				heartbeatConnection:Disconnect()
				heartbeatConnection = nil
				p1.OnRocketQueueEmptied:Destroy()
				p1.OnRocketQueueEmptied = nil
				p1.OnRocketExploded:Destroy()
				p1.OnRocketExploded = nil
			end)
		else
			heartbeatConnection:Disconnect()
			heartbeatConnection = nil
			p1.OnRocketQueueEmptied:Destroy()
			p1.OnRocketQueueEmptied = nil
			p1.OnRocketExploded:Destroy()
			p1.OnRocketExploded = nil
		end
	end)
end
function RocketWorld.Update(p1)
	local currentTime = tick()
	local deltaTime = currentTime - (p1.LastUpdate or currentTime)
	p1.LastUpdate = currentTime
	local rocketCount = #p1.ListRocket
	for i = rocketCount, 1, -1 do
		local v4
		local rocketData = p1.ListRocket[i]
		local origin = rocketData[1]
		local direction = rocketData[2]
		local speed = rocketData[3]
		local rocketPart = rocketData[4]
		local lifetimeRemaining = rocketData[5]
		if lifetimeRemaining > 0 then
			local distance = speed * deltaTime
			if nil == nil then
				local hitInstance, hitPosition, _, materialList = RayCast.RayIgnoreNonCollideWithIgnoreList(origin, direction, distance, p1.IgnoreList)
				if hitInstance == nil then
					v4 = hitPosition
				else
					v4 = hitPosition
					lifetimeRemaining = 0
				end
			else
				v4 = nil
			end
			rocketPart.CFrame = CFrame.new(Vector3.new(), direction) + v4
			rocketPart.Velocity = direction * speed
			rocketData[1] = v4
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
			p1:ExplodeAt(origin)
			rocketData[4] = nil
			table.remove(p1.ListRocket, i)
		end
	end
	if rocketCount > 0 and #p1.ListRocket == 0 then
		p1.OnRocketQueueEmptied:Fire()
	end
end
function RocketWorld.ExplodeAt(p1, p2)
	RocketLauncherUtils.explodeAt(p2)
	p1.OnRocketExploded:Fire(p2)
end
function RocketWorld.Destroy(p1)
	p1.Maid:Destroy()
	p1.Maid = nil
end
return RocketWorld
