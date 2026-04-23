local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage.Std.Signal)
local Maid = require(ReplicatedStorage.Std.Maid)
local RayCast = require(ReplicatedStorage.Module.RayCast)
local RocketLauncherUtils = require(ReplicatedStorage.RocketLauncher.RocketLauncherUtils)
local Audio = require(ReplicatedStorage.Std.Audio)
local t = {
	explosion_large_02 = 2205008239,
	nitro_loop = 9058734199,
	nitro_ignite = 1386598740
}
local t2 = {}
t2.__index = t2
function t2.new() --[[ Line: 17 | Upvalues: t2 (copy), Maid (copy), Signal (copy) ]]
	local t = {}
	setmetatable(t, t2)
	t.Maid = Maid.new()
	t.OnRocketQueueEmptied = Signal.new()
	t.OnRocketExploded = Signal.new()
	t:Setup()
	return t
end
function t2.CreatePart(p1, p2, p3) --[[ Line: 28 | Upvalues: ReplicatedStorage (copy), Audio (copy), t (copy) ]]
	local v1 = ReplicatedStorage.Resource.ItemSystem.Projectiles.Rocket:Clone()
	v1.CFrame = CFrame.new(Vector3.new(), p3) + p2
	v1.Parent = workspace
	p1:AddSmoke(v1)
	Audio.ObjectLocal(v1, t.nitro_ignite, {
		Pitch = 0.7,
		TimePosition = 0.6,
		Volume = 0.3
	})
	local v2 = Audio.ObjectLocal(v1, t.nitro_loop, {
		Pitch = 0.6,
		Volume = 1
	})
	v2.Looped = true
	v2.EmitterSize = 25
	v2.Parent = v1
	return v1
end
function t2.AddSmoke(p1, p2) --[[ Line: 44 | Upvalues: ReplicatedStorage (copy) ]]
	ReplicatedStorage.Resource.ItemSystem.Projectiles.RocketFire:Clone().Parent = p2
	ReplicatedStorage.Resource.ItemSystem.Projectiles.RocketSmoke:Clone().Parent = p2
end
function t2.Launch(p1, p2, p3, p4) --[[ Line: 50 ]]
	assert(p2)
	assert(p3)
	assert(p4)
	local t = {
		p2,
		p3,
		p4,
		p1:CreatePart(p2, p3),
		6
	}
	table.insert(p1.ListRocket, t)
end
function t2.Setup(p1) --[[ Line: 66 | Upvalues: RunService (copy) ]]
	p1.ListRocket = {}
	p1.IgnoreList = {}
	local v1 = RunService.Heartbeat:Connect(function() --[[ Line: 70 | Upvalues: p1 (copy) ]]
		p1:Update()
	end)
	p1.Maid:GiveTask(function() --[[ Line: 74 | Upvalues: p1 (copy), v1 (ref) ]]
		if #p1.ListRocket > 0 then
			p1.OnRocketQueueEmptied:Connect(function() --[[ Line: 77 | Upvalues: v1 (ref), p1 (ref) ]]
				v1:Disconnect()
				v1 = nil
				p1.OnRocketQueueEmptied:Destroy()
				p1.OnRocketQueueEmptied = nil
				p1.OnRocketExploded:Destroy()
				p1.OnRocketExploded = nil
			end)
		else
			v1:Disconnect()
			v1 = nil
			p1.OnRocketQueueEmptied:Destroy()
			p1.OnRocketQueueEmptied = nil
			p1.OnRocketExploded:Destroy()
			p1.OnRocketExploded = nil
		end
	end)
end
function t2.Update(p1) --[[ Line: 95 | Upvalues: RayCast (copy), Audio (copy) ]]
	local v1 = tick()
	local v2 = v1 - (p1.LastUpdate or v1)
	p1.LastUpdate = v1
	local v3 = #p1.ListRocket
	for i = v3, 1, -1 do
		local v4
		local v5 = p1.ListRocket[i]
		local v6 = v5[1]
		local v7 = v5[2]
		local v8 = v5[3]
		local v9 = v5[4]
		local v10 = v5[5]
		if v10 > 0 then
			local v11 = v8 * v2
			if nil == nil then
				local v12, v13, _, _2 = RayCast.RayIgnoreNonCollideWithIgnoreList(v6, v7, v11, p1.IgnoreList)
				if v12 == nil then
					v4 = v13
				else
					v4 = v13
					v10 = 0
				end
			else
				v4 = nil
			end
			v9.CFrame = CFrame.new(Vector3.new(), v7) + v4
			v9.Velocity = v7 * v8
			v5[1] = v4
			v5[2] = v7
			v5[3] = v8
			v5[5] = v10 - v2
		else
			v9.Transparency = 1
			game.Debris:AddItem(v9, 1)
			local v14 = next
			local v15, v16 = v9:GetChildren()
			for v17, v18 in v14, v15, v16 do
				if v18:IsA("Sound") then
					Audio.FadeOut(v18, 0.3)
				elseif v18:IsA("ParticleEmitter") then
					v18.Enabled = false
				end
			end
			p1:ExplodeAt(v6)
			v5[4] = nil
			table.remove(p1.ListRocket, i)
		end
	end
	if v3 > 0 and #p1.ListRocket == 0 then
		p1.OnRocketQueueEmptied:Fire()
	end
end
function t2.ExplodeAt(p1, p2) --[[ Line: 147 | Upvalues: RocketLauncherUtils (copy) ]]
	RocketLauncherUtils.explodeAt(p2)
	p1.OnRocketExploded:Fire(p2)
end
function t2.Destroy(p1) --[[ Line: 151 ]]
	p1.Maid:Destroy()
	p1.Maid = nil
end
return t2