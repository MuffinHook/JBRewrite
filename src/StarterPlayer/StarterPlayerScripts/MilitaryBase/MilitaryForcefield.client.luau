-- Reviewed by Claude
-- variables reassigned
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
local function flingPlayer(p1, p2)
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
			task.delay(0.2, function()
				p2(false)
			end)
		end
	end
end
Binder.new("MilitaryForcefield", function(p1)
	local v1 = Maid.new()
	local vector = p1.Position - Vector3.new(0, 1, 0) * p1.Position.Y
	local v3 = p1.Size.X / 2
	local Size = p1.Size
	local Position = p1.Position
	local configTable = {
		Position = vector,
		Radius = v3,
		Part = p1
	}
	BulletEmitter._militaryForcefield = configTable
	v1:GiveTask(function()
		if BulletEmitter._militaryForcefield == configTable then
			BulletEmitter._militaryForcefield = nil
		end
	end)
	local configTable = {}
	local function toggleFlash(p1)
		for vector, v3 in configTable do
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
		table.insert(configTable, Decal)
		v1:GiveTask(Decal)
	end
	v1:GiveTask(Audio.ObjectLocal(p1, 17183453324, {
		DoNotPlay = true
	}))
	local function isServerDisabled()
		return p1:GetAttribute("Disabled") == true
	end
	local v9 = nil
	local isEnabled = false
	local isEnabled = InventoryItemSystem.playerHasItem(LocalPlayer, "Key") == true
	local isEnabled = true
	local function updatePermsToEnter()
		isEnabled = isEnabled or PlayerUtils.getTeamId(LocalPlayer) == Settings.EnumTeam.Police
		p1.CanCollide = not isEnabled and isEnabled
		if not (isEnabled or isEnabled) and (p1:GetAttribute("Disabled") ~= true and v9) then
			v9()
		end
	end
	local v14 = isEnabled or PlayerUtils.getTeamId(LocalPlayer) == Settings.EnumTeam.Police
	p1.CanCollide = not v14 and isEnabled
	if not (v14 or isEnabled) and (p1:GetAttribute("Disabled") ~= true and v9) then
		v9()
	end
	v1:GiveTask(GameUtil.OnTeamChanged:Connect(updatePermsToEnter))
	v1:GiveTask(InventoryItemBinder:GetClassAddedSignal():Connect(function(p12)
		if p12:GetOwner() == LocalPlayer and p12:GetName() == "Key" then
			isEnabled = true
			v14 = isEnabled or PlayerUtils.getTeamId(LocalPlayer) == Settings.EnumTeam.Police
			p1.CanCollide = not v14 and isEnabled
			if not (v14 or isEnabled) and (p1:GetAttribute("Disabled") ~= true and v9) then
				v9()
			end
		end
	end))
	v1:GiveTask(InventoryItemBinder:GetClassRemovingSignal():Connect(function(p12)
		if p12:GetOwner() == LocalPlayer and p12:GetName() == "Key" then
			isEnabled = false
			v14 = isEnabled or PlayerUtils.getTeamId(LocalPlayer) == Settings.EnumTeam.Police
			p1.CanCollide = not v14 and isEnabled
			if not (v14 or isEnabled) and (p1:GetAttribute("Disabled") ~= true and v9) then
				v9()
			end
		end
	end))
	local function getSoundAttachment()
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
	local isEnabled = false
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
	v1:GiveTask(function()
		if v16 then
			v16:cancel()
		end
		v18:Destroy()
	end)
	local function safeActiveFadeTo(p1, p2)
		if v16 then
			v16:cancel()
		end
		v16 = Audio.promiseFadeTo(v18, p1, p2)
	end
	local isEnabled = false
	v1:GiveTask(CharacterUtils.observeLocalCharacterAdded(function(p1, p2)
		if v16 then
			v16:cancel()
		end
		v18.Volume = 0.2
		isEnabled = true
	end))
	local v20 = TweenInfo.new(0.6, Enum.EasingStyle.Bounce, Enum.EasingDirection.In)
	local v21 = TweenInfo.new(0.8, Enum.EasingStyle.Bounce, Enum.EasingDirection.In)
	local v22 = TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
	local function disableForcefield()
		if isEnabled then
			isEnabled = false
			v14 = isEnabled or PlayerUtils.getTeamId(LocalPlayer) == Settings.EnumTeam.Police
			p1.CanCollide = not v14 and isEnabled
			if not (v14 or isEnabled) and (p1:GetAttribute("Disabled") ~= true and v9) then
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
	v9 = function()
		if isEnabled then
			return
		end
		isEnabled = true
		v14 = isEnabled or PlayerUtils.getTeamId(LocalPlayer) == Settings.EnumTeam.Police
		p1.CanCollide = not v14 and isEnabled
		if not (v14 or isEnabled) and (p1:GetAttribute("Disabled") ~= true and v9) then
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
		task.delay(0.5, function()
			for v1, vector in p1.Parent:QueryDescendants("Beam") do
				vector.Enabled = true
			end
		end)
		p1.Size = Size * 0.7
		local v7 = p1
		v7.Position = v7.Position - Vector3.new(0, (Size.Y - p1.Size.Y) / 2, 0)
		TweenService:Create(p1, v22, {
			Size = Size,
			Position = Position
		}):Play()
		if isEnabled then
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
	local function updateServerState()
		if p1:GetAttribute("Disabled") == true and isEnabled then
			disableForcefield()
		else
			if not (p1:GetAttribute("Disabled") == true or isEnabled) then
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
	local isEnabled = false
	v1:GiveTask(RunService.Heartbeat:Connect(function()
		local v13 = os.clock()
		if not (v13 < v25) then
			local Character = LocalPlayer.Character
			local v22 = Character and Character.PrimaryPart
			if v22 then
				local Position = v22.Position
				local Magnitude = (vector - Position).Magnitude
				local v32 = if 400 + v3 < Magnitude then 1 else 0.05
				v25 = v13 + v32
				local v42 = Magnitude < 1800 + v3
				if v42 and not isEnabled then
					isEnabled = true
					v1._distFade = Maid.new()
					for v52, v62 in p1.Parent:QueryDescendants("Beam, BasePart#Forcefield") do
						v1._distFade:GiveTask(Fade.linear(v62, "LocalTransparencyModifier", 0, 3))
					end
				elseif not v42 and isEnabled then
					isEnabled = false
					v1._distFade = Maid.new()
					for v7, v8 in p1.Parent:QueryDescendants("Beam, BasePart#Forcefield") do
						v1._distFade:GiveTask(Fade.linear(v8, "LocalTransparencyModifier", 1, 3))
					end
				end
				if v32 == 0.05 then
					local isEnabled = if v4 < Magnitude and (Magnitude < v5 and Position.Y >= vector.Y) then v14 else false
					if isEnabled then
						v6 = os.clock()
					end
					if isEnabled and isEnabled then
						disableForcefield()
					elseif not (isEnabled or isEnabled) then
						local isEnabled = p1:GetAttribute("Disabled") == true
						if not isEnabled and os.clock() - v6 > 3 then
							v9()
						end
					end
					if if v3 - 4 < Magnitude and Magnitude < v3 + 6 then Position.Y >= vector.Y else false and (not v14 and isEnabled) then
						flingPlayer(vector, toggleFlash)
					end
					local v122 = Magnitude < v3
					configTable.Ignore = v122
					if v122 ~= isEnabled or isEnabled then
						isEnabled = false
						isEnabled = v122
						if isEnabled then
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
