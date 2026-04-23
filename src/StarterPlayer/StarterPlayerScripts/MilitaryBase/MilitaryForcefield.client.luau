local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local C4System = require(ReplicatedStorage.Game.C4.C4System)
local CharacterUtil = require(ReplicatedStorage.Game.CharacterUtil)
local Falling = require(ReplicatedStorage.Game.Falling)
local GameUtil = require(ReplicatedStorage.Game.GameUtil)
local BulletEmitter = require(ReplicatedStorage.Game.ItemSystem.BulletEmitter)
local Paraglide = require(ReplicatedStorage.Game.Paraglide)
local PlayerUtils = require(ReplicatedStorage.Game.PlayerUtils)
local InventoryItemBinder = require(ReplicatedStorage.Inventory.InventoryItemBinder)
local InventoryItemSystem = require(ReplicatedStorage.Inventory.InventoryItemSystem)
local Settings = require(ReplicatedStorage.Resource.Settings)
local Audio = require(ReplicatedStorage.Std.Audio)
local Binder = require(ReplicatedStorage.Std.Binder)
local CharacterUtils = require(ReplicatedStorage.Std.CharacterUtils)
local Fade = require(ReplicatedStorage.Std.Fade)
local Maid = require(ReplicatedStorage.Std.Maid)
local RateLimiter = require(ReplicatedStorage.Std.RateLimiter)
local VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
local LocalPlayer = Players.LocalPlayer
local v1 = RateLimiter.new(1, 3)
local function flingPlayer(p1, p2) --[[ Line: 41 | Upvalues: LocalPlayer (copy), v1 (copy), Audio (copy), Falling (copy), Paraglide (copy), VehicleUtils (copy), CharacterUtil (copy), C4System (copy) ]]
	local PrimaryPart = LocalPlayer.Character.PrimaryPart
	if PrimaryPart then
		if PrimaryPart.CollisionGroup == "PlayersInTrain" then
		elseif v1:UseBudget(1) then
			Audio.ObjectLocal(PrimaryPart, 17183453324, {
				Volume = 0.5
			})
			if Falling.IsSkydiving() then
				Falling.StopSkydiving()
			end
			if Paraglide.IsFlying() then
				Paraglide.ParachuteStop()
			end
			if VehicleUtils.GetLocalVehiclePacket() ~= nil then
				CharacterUtil.OnJump()
				task.wait(0.3)
			end
			C4System.onExplode(p1, 100000, 98, 98, false)
			p2(true)
			task.delay(0.2, function() --[[ Line: 65 | Upvalues: p2 (copy) ]]
				p2(false)
			end)
		end
	end
end
Binder.new("MilitaryForcefield", function(p1) --[[ Line: 70 | Upvalues: Maid (copy), BulletEmitter (copy), Audio (copy), InventoryItemSystem (copy), LocalPlayer (copy), PlayerUtils (copy), Settings (copy), GameUtil (copy), InventoryItemBinder (copy), CharacterUtils (copy), TweenService (copy), RunService (copy), Fade (copy), flingPlayer (copy) ]]
	local v1 = Maid.new()
	local v2 = p1.Position - Vector3.new(0, 1, 0) * p1.Position.Y
	local v3 = p1.Size.X / 2
	local Size = p1.Size
	local Position = p1.Position
	local t = {
		Position = v2,
		Radius = v3,
		Part = p1
	}
	BulletEmitter._militaryForcefield = t
	v1:GiveTask(function() --[[ Line: 89 | Upvalues: BulletEmitter (ref), t (copy) ]]
		if BulletEmitter._militaryForcefield == t then
			BulletEmitter._militaryForcefield = nil
		end
	end)
	local t2 = {}
	local function toggleFlash(p1) --[[ Line: 96 | Upvalues: t2 (copy) ]]
		for v2, v3 in t2 do
			local v1
			v1 = if p1 then 0 else 1
			v3.Transparency = v1
		end
	end
	local v4 = v3 - 50
	local v5 = v3 + 50
	local v6 = 0
	for v7, v8 in Enum.NormalId:GetEnumItems() do
		local Decal = Instance.new("Decal")
		Decal.Face = v8
		Decal.Texture = "rbxassetid://50282315"
		Decal.Color3 = Color3.fromRGB(475, 280, 510)
		Decal.Transparency = 1
		Decal.Parent = p1
		table.insert(t2, Decal)
		v1:GiveTask(Decal)
	end
	v1:GiveTask(Audio.ObjectLocal(p1, 17183453324, {
		DoNotPlay = true
	}))
	local function isServerDisabled() --[[ Line: 114 | Upvalues: p1 (copy) ]]
		return p1:GetAttribute("Disabled") == true
	end
	local v9 = nil
	local v10 = false
	local v11 = InventoryItemSystem.playerHasItem(LocalPlayer, "Key") == true
	local v12 = true
	local function updatePermsToEnter() --[[ Line: 123 | Upvalues: v10 (ref), v11 (ref), PlayerUtils (ref), LocalPlayer (ref), Settings (ref), p1 (copy), v12 (ref), v9 (ref) ]]
		v10 = v11 or PlayerUtils.getTeamId(LocalPlayer) == Settings.EnumTeam.Police
		p1.CanCollide = not v10 and v12
		if not (v10 or v12) and (p1:GetAttribute("Disabled") ~= true and v9) then
			v9()
		end
	end
	local v14 = v11 or PlayerUtils.getTeamId(LocalPlayer) == Settings.EnumTeam.Police
	p1.CanCollide = not v14 and v12
	if not (v14 or v12) and (p1:GetAttribute("Disabled") ~= true and v9) then
		v9()
	end
	v1:GiveTask(GameUtil.OnTeamChanged:Connect(updatePermsToEnter))
	v1:GiveTask(InventoryItemBinder:GetClassAddedSignal():Connect(function(p12) --[[ Line: 133 | Upvalues: LocalPlayer (ref), v11 (ref), v14 (ref), PlayerUtils (ref), Settings (ref), p1 (copy), v12 (ref), v9 (ref) ]]
		if p12:GetOwner() == LocalPlayer and p12:GetName() == "Key" then
			v11 = true
			v14 = v11 or PlayerUtils.getTeamId(LocalPlayer) == Settings.EnumTeam.Police
			p1.CanCollide = not v14 and v12
			if not (v14 or v12) and (p1:GetAttribute("Disabled") ~= true and v9) then
				v9()
			end
		end
	end))
	v1:GiveTask(InventoryItemBinder:GetClassRemovingSignal():Connect(function(p12) --[[ Line: 139 | Upvalues: LocalPlayer (ref), v11 (ref), v14 (ref), PlayerUtils (ref), Settings (ref), p1 (copy), v12 (ref), v9 (ref) ]]
		if p12:GetOwner() == LocalPlayer and p12:GetName() == "Key" then
			v11 = false
			v14 = v11 or PlayerUtils.getTeamId(LocalPlayer) == Settings.EnumTeam.Police
			p1.CanCollide = not v14 and v12
			if not (v14 or v12) and (p1:GetAttribute("Disabled") ~= true and v9) then
				v9()
			end
		end
	end))
	local function getSoundAttachment() --[[ Line: 147 | Upvalues: p1 (copy), v3 (copy) ]]
		local SoundAttachment = p1:FindFirstChild("SoundAttachment")
		if not SoundAttachment then
			local SoundAttachment_2 = Instance.new("Attachment")
			SoundAttachment_2.Name = "SoundAttachment"
			SoundAttachment_2.Parent = p1
			SoundAttachment_2.Position = Vector3.new(-0, -1, -0) * v3 / 2
			SoundAttachment = SoundAttachment_2
		end
		return SoundAttachment
	end
	local v16 = nil
	local v17 = false
	local SoundAttachment = p1:FindFirstChild("SoundAttachment")
	if not SoundAttachment then
		SoundAttachment = Instance.new("Attachment")
		SoundAttachment.Name = "SoundAttachment"
		SoundAttachment.Parent = p1
		SoundAttachment.Position = Vector3.new(-0, -1, -0) * v3 / 2
	end
	local v18 = Audio.ObjectLocal(SoundAttachment, 104027245185669, {
		Volume = 2,
		RollOffMaxDistance = v3 + 200,
		RollOffMinDistance = v3,
		Looped = true
	})
	v1:GiveTask(function() --[[ Line: 166 | Upvalues: v16 (ref), v18 (copy) ]]
		if v16 then
			v16:cancel()
		end
		v18:Destroy()
	end)
	local function safeActiveFadeTo(p1, p2) --[[ Line: 173 | Upvalues: v16 (ref), Audio (ref), v18 (copy) ]]
		if v16 then
			v16:cancel()
		end
		v16 = Audio.promiseFadeTo(v18, p1, p2)
	end
	local v19 = false
	v1:GiveTask(CharacterUtils.observeLocalCharacterAdded(function(p1, p2) --[[ Line: 181 | Upvalues: v16 (ref), v18 (copy), v19 (ref) ]]
		if v16 then
			v16:cancel()
		end
		v18.Volume = 0.2
		v19 = true
	end))
	local v20 = TweenInfo.new(0.6, Enum.EasingStyle.Bounce, Enum.EasingDirection.In)
	local v21 = TweenInfo.new(0.8, Enum.EasingStyle.Bounce, Enum.EasingDirection.In)
	local v22 = TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
	local function disableForcefield() --[[ Line: 192 | Upvalues: v12 (ref), v14 (ref), v11 (ref), PlayerUtils (ref), LocalPlayer (ref), Settings (ref), p1 (copy), v9 (ref), v1 (copy), Audio (ref), v3 (copy), TweenService (ref), v21 (copy), v16 (ref), v18 (copy) ]]
		if v12 then
			v12 = false
			v14 = v11 or PlayerUtils.getTeamId(LocalPlayer) == Settings.EnumTeam.Police
			p1.CanCollide = not v14 and v12
			if not (v14 or v12) and (p1:GetAttribute("Disabled") ~= true and v9) then
				v9()
			end
			local SoundAttachment = p1:FindFirstChild("SoundAttachment")
			if not SoundAttachment then
				local SoundAttachment_2 = Instance.new("Attachment")
				SoundAttachment_2.Name = "SoundAttachment"
				SoundAttachment_2.Parent = p1
				SoundAttachment_2.Position = Vector3.new(-0, -1, -0) * v3 / 2
				SoundAttachment = SoundAttachment_2
			end
			v1:GiveTask(Audio.ObjectLocal(SoundAttachment, 2992428082, {
				Volume = 0.6,
				RollOffMaxDistance = v3 + 200,
				RollOffMinDistance = v3
			}))
			TweenService:Create(p1, v21, {
				Transparency = 1
			}):Play()
			for v6, v7 in p1.Parent:QueryDescendants("Beam") do
				v7.Enabled = false
			end
			if v16 then
				v16:cancel()
			end
			v16 = Audio.promiseFadeTo(v18, 0, 1)
		end
	end
	v9 = function() --[[ Line: 211 | Upvalues: v12 (ref), v14 (ref), v11 (ref), PlayerUtils (ref), LocalPlayer (ref), Settings (ref), p1 (copy), v9 (ref), v1 (copy), Audio (ref), v3 (copy), TweenService (ref), v20 (copy), Size (copy), v22 (copy), Position (copy), v17 (ref), v16 (ref), v18 (copy) ]]
		if v12 then
			return
		end
		v12 = true
		v14 = v11 or PlayerUtils.getTeamId(LocalPlayer) == Settings.EnumTeam.Police
		p1.CanCollide = not v14 and v12
		if not (v14 or v12) and (p1:GetAttribute("Disabled") ~= true and v9) then
			v9()
		end
		local SoundAttachment = p1:FindFirstChild("SoundAttachment")
		if not SoundAttachment then
			local SoundAttachment_2 = Instance.new("Attachment")
			SoundAttachment_2.Name = "SoundAttachment"
			SoundAttachment_2.Parent = p1
			SoundAttachment_2.Position = Vector3.new(-0, -1, -0) * v3 / 2
			SoundAttachment = SoundAttachment_2
		end
		v1:GiveTask(Audio.ObjectLocal(SoundAttachment, 4058366615, {
			Volume = 0.45,
			RollOffMaxDistance = v3 + 200,
			RollOffMinDistance = v3 - 50
		}))
		TweenService:Create(p1, v20, {
			Transparency = -5
		}):Play()
		task.delay(0.5, function() --[[ Line: 225 | Upvalues: p1 (ref) ]]
			for v1, v2 in p1.Parent:QueryDescendants("Beam") do
				v2.Enabled = true
			end
		end)
		p1.Size = Size * 0.7
		local v7 = p1
		v7.Position = v7.Position - Vector3.new(0, (Size.Y - p1.Size.Y) / 2, 0)
		TweenService:Create(p1, v22, {
			Size = Size,
			Position = Position
		}):Play()
		if v17 then
			if v16 then
				v16:cancel()
			end
			v16 = Audio.promiseFadeTo(v18, 0.2, 1)
		else
			if v16 then
				v16:cancel()
			end
			v16 = Audio.promiseFadeTo(v18, 1.7, 1)
		end
	end
	local function updateServerState() --[[ Line: 249 | Upvalues: p1 (copy), v12 (ref), disableForcefield (copy), v9 (ref) ]]
		if p1:GetAttribute("Disabled") == true and v12 then
			disableForcefield()
		else
			if not (p1:GetAttribute("Disabled") == true or v12) then
				v9()
			end
		end
	end
	v1:GiveTask(p1:GetAttributeChangedSignal("Disabled"):Connect(updateServerState))
	task.spawn(updateServerState)
	p1.Transparency = -5
	p1.LocalTransparencyModifier = 1
	for v23, v24 in p1.Parent:QueryDescendants("Beam") do
		v24.LocalTransparencyModifier = 1
		v24.Enabled = true
	end
	local v25 = 0
	local v26 = false
	v1:GiveTask(RunService.Heartbeat:Connect(function() --[[ Line: 268 | Upvalues: v25 (ref), LocalPlayer (ref), v2 (copy), v3 (copy), v26 (ref), v1 (copy), Maid (ref), p1 (copy), Fade (ref), v4 (copy), v5 (copy), v14 (ref), v6 (ref), v12 (ref), disableForcefield (copy), v9 (ref), flingPlayer (ref), toggleFlash (copy), t (copy), v17 (ref), v19 (ref), v16 (ref), Audio (ref), v18 (copy) ]]
		local v13 = os.clock()
		if not (v13 < v25) then
			local Character = LocalPlayer.Character
			local v22 = Character and Character.PrimaryPart
			if v22 then
				local Position = v22.Position
				local Magnitude = (v2 - Position).Magnitude
				local v32 = if 400 + v3 < Magnitude then 1 else 0.05
				v25 = v13 + v32
				local v42 = Magnitude < 1800 + v3
				if v42 and not v26 then
					v26 = true
					v1._distFade = Maid.new()
					for v52, v62 in p1.Parent:QueryDescendants("Beam, BasePart#Forcefield") do
						v1._distFade:GiveTask(Fade.linear(v62, "LocalTransparencyModifier", 0, 3))
					end
				elseif not v42 and v26 then
					v26 = false
					v1._distFade = Maid.new()
					for v7, v8 in p1.Parent:QueryDescendants("Beam, BasePart#Forcefield") do
						v1._distFade:GiveTask(Fade.linear(v8, "LocalTransparencyModifier", 1, 3))
					end
				end
				if v32 == 0.05 then
					local v92 = if v4 < Magnitude and (Magnitude < v5 and Position.Y >= v2.Y) then v14 else false
					if v92 then
						v6 = os.clock()
					end
					if v92 and v12 then
						disableForcefield()
					elseif not (v92 or v12) then
						local v10 = p1:GetAttribute("Disabled") == true
						if not v10 and os.clock() - v6 > 3 then
							v9()
						end
					end
					if if v3 - 4 < Magnitude and Magnitude < v3 + 6 then Position.Y >= v2.Y else false and (not v14 and v12) then
						flingPlayer(v2, toggleFlash)
					end
					local v122 = Magnitude < v3
					t.Ignore = v122
					if v122 ~= v17 or v19 then
						v19 = false
						v17 = v122
						if v12 then
							if v122 then
								if v16 then
									v16:cancel()
								end
								v16 = Audio.promiseFadeTo(v18, 0.2, 1)
								return
							end
							if v16 then
								v16:cancel()
							end
							v16 = Audio.promiseFadeTo(v18, 1.7, 1)
						end
					end
				end
			end
		end
	end))
	return v1
end):Start()