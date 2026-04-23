game:GetService("Debris")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CombatUtils = require(ReplicatedStorage.Combat.CombatUtils)
local Maid = require(ReplicatedStorage.Std.Maid)
local Signal = require(ReplicatedStorage.Std.Signal)
local RayCast = require(ReplicatedStorage.Module.RayCast)
local GuardNPCBinder = require(ReplicatedStorage.GuardNPC.GuardNPCBinder)
local Audio = require(ReplicatedStorage.Std.Audio)
require(ReplicatedStorage.Module.Time)
local PlayerUtils = require(ReplicatedStorage.Game.PlayerUtils)
local ForcefieldService = require(ReplicatedStorage.Forcefield.ForcefieldService)
require(ReplicatedStorage.Std.Raycast)
local ItemSystem = require(ReplicatedStorage.Game.ItemSystem.ItemSystem)
local Math = require(ReplicatedStorage.Module.Math)
local InventoryItemUtils = require(ReplicatedStorage.Inventory.InventoryItemUtils)
local t = {
	bullet_flyby_01 = 2121003369,
	bullet_flyby_04 = 2121003636,
	bullet_impact_body_thump_01 = 2121003873,
	bullet_impact_bass = 2837091387
}
local function IntersectRaySphereF(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11) --[[ Line: 33 ]]
	local v1 = p7 * p7 * p4 * p4 + p7 * p7 * p5 * p5 + p7 * p7 * p6 * p6
	local v2 = 2 * (p7 * p4 * (p1 - p8) + p7 * p5 * (p2 - p9) + p7 * p6 * (p3 - p10))
	local v3 = v2 * v2 - 4 * v1 * (p8 * p8 + p9 * p9 + p10 * p10 + p1 * p1 + p2 * p2 + p3 * p3 - 2 * (p8 * p1 + p9 * p2 + p10 * p3) - p11 * p11)
	if math.abs(v1) < 0.001 or v3 < 0 then
		return nil, nil
	else
		local v4 = v3 ^ 0.5
		local v5 = (-v2 - v4) / (2 * v1)
		local v6 = (-v2 + v4) / (2 * v1)
		if v1 * (1 - v5) * (v6 - v5) < 0 or v1 * v6 * (v6 - v5) < 0 then
			return nil, nil
		else
			return v5, v6
		end
	end
end
local function IntersectRaySphere(p1, p2, p3, p4, p5) --[[ Line: 52 | Upvalues: IntersectRaySphereF (copy) ]]
	return IntersectRaySphereF(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z, p3, p4.x, p4.y, p4.z, p5)
end
local Part = Instance.new("Part")
Part.Anchored = true
Part.CFrame = CFrame.new(0, 0, 0)
Part.CanCollide = false
Part.Transparency = 1
Part.Parent = workspace
local v1 = Instance.new("Folder")
v1.Parent = workspace
local t2 = {}
t2.__index = t2
function t2.new(p1) --[[ Line: 79 | Upvalues: t2 (copy), Maid (copy), Signal (copy) ]]
	assert(p1 ~= nil)
	local t = {}
	setmetatable(t, t2)
	t.Maid = Maid.new()
	local v3 = Signal.new()
	t.Maid:GiveTask(v3)
	local v4 = Signal.new()
	t.Maid:GiveTask(v4)
	local v5 = Signal.new()
	t.Maid:GiveTask(v5)
	local v6 = Signal.new()
	t.Maid:GiveTask(v6)
	t.BulletWhizEnabled = true
	t.Local = p1
	t.IgnoreList = {}
	t.IgnoreLocalPlayer = true
	t.OnLocalHitPlayer = v3
	t.OnHitSurface = v4
	t.OnQueueEmptied = v5
	t.OnShieldDamage = v6
	t.Bullets = {}
	t.LastUpdate = nil
	t.LastPlayedWhizSound = nil
	t.GravityVector = nil
	t.LifeSpan = nil
	t.Color = Color3.fromRGB(255, 235, 141)
	t._mapLastHitSurface = {}
	t._customCollidableFunc = t:_buildCustomCollidableFunc()
	return t
end
function t2.Emit(p1, p2, p3, p4) --[[ Line: 121 | Upvalues: Part (copy), v1 (copy) ]]
	local LineHandleAdornment = Instance.new("LineHandleAdornment")
	LineHandleAdornment.Adornee = Part
	LineHandleAdornment.AdornCullingMode = Enum.AdornCullingMode.Automatic
	LineHandleAdornment.Transparency = 0
	LineHandleAdornment.Color3 = p1.Color
	LineHandleAdornment.Thickness = 2
	LineHandleAdornment.SizeRelativeOffset = Vector3.new(0, 0, 0)
	LineHandleAdornment.Length = 0
	LineHandleAdornment.CFrame = CFrame.new()
	LineHandleAdornment.Parent = v1
	local t = {
		p2,
		p3,
		p4,
		LineHandleAdornment,
		p1.LifeSpan,
		p2
	}
	local t2 = {}
	for i, v in ipairs(p1.IgnoreList) do
		t2[#t2 + 1] = v
	end
	t[7] = t2
	p1.Bullets[#p1.Bullets + 1] = t
end
local t3 = { t.bullet_flyby_01, t.bullet_flyby_04 }
local t4 = {}
local function getWhizPart() --[[ Line: 151 | Upvalues: t4 (copy) ]]
	local v1 = table.remove(t4)
	if v1 then
		return v1
	else
		local Part = Instance.new("Part")
		Part.Transparency = 1
		Part.Anchored = true
		Part.CanCollide = false
		Part.Size = Vector3.new(1, 1, 1)
		return Part
	end
end
local function returnWhizPart(p1) --[[ Line: 163 | Upvalues: t4 (copy) ]]
	p1.Parent = nil
	if #t4 < 8 then
		t4[#t4 + 1] = p1
	else
		p1:Destroy()
	end
end
function t2.PlayWhiz(p1, p2, p3) --[[ Line: 171 | Upvalues: t4 (copy), Audio (copy), t3 (copy), returnWhizPart (copy) ]]
	local v1 = table.remove(t4)
	local v2
	if v1 then
		v2 = v1
	else
		local Part = Instance.new("Part")
		Part.Transparency = 1
		Part.Anchored = true
		Part.CanCollide = false
		Part.Size = Vector3.new(1, 1, 1)
		v2 = Part
	end
	v2.Position = p2
	v2.Parent = workspace
	Audio.ObjectLocal(v2, t3[math.random(1, #t3)], {
		TimePosition = 0.3,
		Volume = 0.6 * (1 - p3 / 10),
		Pitch = 1 + math.random() * 0.1 - 0.05
	})
	task.delay(3, returnWhizPart, v2)
end
function t2.CheckWhiz(p1, p2) --[[ Line: 185 | Upvalues: PlayerUtils (copy), LocalPlayer (copy) ]]
	local v1 = tick()
	local v2 = PlayerUtils.getRootPart(LocalPlayer)
	if v2 ~= nil then
		local v3 = p2[1]
		local Magnitude = (v3 - v2.Position).Magnitude
		if Magnitude < 10 and (p2[3] > 100 and v1 - (p1.LastPlayedWhizSound or 0) > 0.1) then
			p1:PlayWhiz(v3, Magnitude)
			p1.LastPlayedWhizSound = v1
		end
	end
end
function t2._buildCustomCollidableFunc(p1) --[[ Line: 198 ]]
	return function(p12) --[[ Line: 199 | Upvalues: p1 (copy) ]]
		if p12:GetAttribute("InvisibleToBullets") == true then
			return false
		else
			if not p12.CanCollide and p1._listRootPart then
				for i, v in ipairs(p1._listRootPart) do
					local _ = p12:IsDescendantOf(v.Parent)
				end
			end
			return true
		end
	end
end
local t5 = {
	HairAttachment = true,
	HatAttachment = true,
	FaceFrontAttachment = true,
	FaceCenterAttachment = true
}
function t2.Update(p1) --[[ Line: 223 | Upvalues: LocalPlayer (copy), CollectionService (copy), GuardNPCBinder (copy), ForcefieldService (copy), t2 (copy), Players (copy), IntersectRaySphereF (copy), ItemSystem (copy), InventoryItemUtils (copy), Math (copy), CombatUtils (copy), RayCast (copy), t5 (copy) ]]
	debug.profilebegin("BulletEmitter Update")
	local v1 = tick()
	local v2 = v1 - (p1.LastUpdate or v1)
	p1.LastUpdate = v1
	local v3 = nil
	local v4 = p1.Local or p1.SimulateLocal
	if v4 then
		v3 = {}
		local t = {}
		local v5 = if LocalPlayer.Character then LocalPlayer.Character.PrimaryPart else nil
		for v7, v8 in CollectionService:GetTagged("Humanoid") do
			local v6
			if v8:IsDescendantOf(workspace) then
				local RootPart = v8.RootPart
				if RootPart and not t[RootPart] then
					t[RootPart] = true
					v6 = not p1.IgnoreLocalPlayer or RootPart ~= v5
					if p1.IgnoreGuards and GuardNPCBinder:Get(RootPart.Parent) then
						v6 = false
					end
					if v6 then
						v3[#v3 + 1] = RootPart
					end
				end
			end
		end
		p1._listRootPart = v3
	end
	local v9 = p1.ShieldBlockPct or 1
	local v10 = #p1.Bullets
	local LifeSpan = p1.LifeSpan
	local ListShields = ForcefieldService.ListShields
	local v11 = #ListShields
	if t2._militaryForcefield and (t2._militaryForcefield.Part.Transparency < 1 and not t2._militaryForcefield.Ignore) then
		local v12 = table.clone(ListShields)
		v12[v11 + 1] = t2._militaryForcefield
		ListShields = v12
	end
	local v13 = Players:GetPlayers()
	for i = v10, 1, -1 do
		local v14, v15, v16, v17
		local v18 = p1.Bullets[i]
		local v19 = v18[1]
		local sum = v18[2]
		local v20 = v18[3]
		local v21 = v18[4]
		local v22 = v18[5]
		if v22 > 0 and sum then
			local v23 = v20 * v2
			local v24 = nil
			local v25 = nil
			local v26 = nil
			local v27 = nil
			local v28 = nil
			v14 = v19
			if not v24 then
				for i2, v in ipairs(ListShields) do
					local Position = v.Position
					local v29 = IntersectRaySphereF(v19.x, v19.y, v19.z, sum.x, sum.y, sum.z, v23, Position.x, Position.y, Position.z, v.Radius)
					if v29 ~= nil and math.random() < v9 then
						v24 = true
						local v30 = v19 + v29 * sum * v23
						local Unit = (v30 - Position).Unit
						v14 = v30 + Unit * 0.001
						sum = sum - 2 * sum:Dot(Unit) * Unit
						if not v.Part then
							p1.OnShieldDamage:Fire(v, v14, Unit, v25)
						end
						break
					end
				end
				for v31, v32 in v13 do
					local v33 = ItemSystem.GetEquipped(v32)
					if v33 and InventoryItemUtils.getName(v33.inventoryItemValue) == "ShieldSWAT" then
						local BulletCollide = v33.Model:FindFirstChild("Skeleton"):FindFirstChild("BulletCollide")
						local v34 = Math.IntersectRayPlane(v19, sum, BulletCollide.Position, BulletCollide.CFrame.LookVector)
					end
				end
			end
			if not v24 and v4 then
				for i2, v in ipairs(v3) do
					local Position = v.Position
					local v36 = IntersectRaySphereF(v19.x, v19.y, v19.z, sum.x, sum.y, sum.z, v23, Position.x, Position.y, Position.z, (CombatUtils.getRootPartHitRadius(v)))
					if v36 ~= nil then
						v14 = v19 + v36 * sum * v23
						local Unit = (v14 - Position).Unit
						local Humanoid = v.Parent:FindFirstChild("Humanoid")
						if not Humanoid or Humanoid.Health ~= 0 then
							v26 = Humanoid
							v27 = true
							v24 = v
							break
						end
						v24 = v
						v26 = nil
					end
				end
			end
			if not v24 then
				local v37, v38, v39, v40 = RayCast.RayIgnoreNonCollideWithIgnoreList(v19, sum, v23, v18[7], nil, nil, p1._customCollidableFunc)
				if v37 then
					v18[7][#v18[7] + 1] = v37
					if v4 then
						v15 = v37
						v14 = v38
						v16 = v39
						v17 = v40
						for v41, v42 in v3 do
							if v15:IsDescendantOf(v42.Parent) then
								local Humanoid = v42.Parent:FindFirstChild("Humanoid")
								local _ = Humanoid and Humanoid.Health > 0
							end
						end
						if v26 then
							local v43 = Players:GetPlayerFromCharacter(v26.Parent) ~= nil
							if not v43 and v15.Name == "Head" then
								v28 = true
							elseif not v43 then
								local Attachment = v15:FindFirstChildOfClass("Attachment")
								if Attachment and t5[Attachment.Name] then
									v28 = true
								end
							end
						end
					else
						v15 = v37
						v14 = v38
						v16 = v39
						v17 = v40
					end
					p1.OnHitSurface:Fire(v15, v14, v16, v17)
					v27 = true
				else
					v14 = v38
				end
			end
			if v26 then
				local v44 = v18[6]
				local v45 = LifeSpan - (v22 - v2 * ((v14 - v19).Magnitude / v23))
				local _ = GuardNPCBinder:Get(v26.Parent) == nil
				p1.OnLocalHitPlayer:Fire(v26, 0.7483072263887747 * v44.x - 0.6609848067581097 * v44.y - 0.055994465523689876 * v44.z, 0.2852117920578111 * sum.x + 0.3968011188544949 * sum.y - 0.8724695443091369 * sum.z, 0.7483072263887747 * v14.x - 0.6609848067581097 * v14.y - 0.055994465523689876 * v14.z, 0.7483072263887747 * v45, 0.2852117920578111 * v44.x + 0.3968011188544949 * v44.y - 0.8724695443091369 * v44.z, 0.5989077797169704 * v44.x + 0.6369049829533174 * v44.y + 0.485449805936436 * v44.z, 0.2852117920578111 * v45, 0.5989077797169704 * sum.x + 0.6369049829533174 * sum.y + 0.485449805936436 * sum.z, 0.7483072263887747 * sum.x - 0.6609848067581097 * sum.y - 0.055994465523689876 * sum.z, 0.5989077797169704 * v14.x + 0.6369049829533174 * v14.y + 0.485449805936436 * v14.z, 0.2852117920578111 * v14.x + 0.3968011188544949 * v14.y - 0.8724695443091369 * v14.z, 0.5989077797169704 * v45, {
					isHeadshot = v28
				})
			end
			if v27 then
				v22 = 0
			end
			v21.Length = (v14 - v19).Magnitude
			v21.CFrame = CFrame.new(v14, v19)
			if p1.Local == false and p1.BulletWhizEnabled then
				p1:CheckWhiz(v18)
			end
			if p1.GravityVector ~= nil then
				sum = sum + p1.GravityVector * v2 / v20
			end
			v18[1] = v14
			v18[2] = sum
			v18[3] = v20
			v18[5] = v22 - v2
		else
			v21:Destroy()
			v18[4] = nil
			table.remove(p1.Bullets, i)
		end
	end
	if v10 > 0 and #p1.Bullets == 0 then
		p1.OnQueueEmptied:Fire()
	end
	debug.profileend()
end
function t2.Destroy(p1) --[[ Line: 546 ]]
	for i = #p1.Bullets, 1, -1 do
		local v1 = p1.Bullets[i]
		v1[4]:Destroy()
		v1[4] = nil
	end
	p1.Bullets = nil
	p1.Maid:Destroy()
	p1.Maid = nil
end
return t2