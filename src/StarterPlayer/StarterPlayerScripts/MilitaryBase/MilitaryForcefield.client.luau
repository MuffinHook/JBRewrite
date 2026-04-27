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
local forcefieldImpactLimiter = RateLimiter.new(1, 3)
local function flingPlayer(hitPlayer, toggleFlashCallback)
	local PrimaryPart = LocalPlayer.Character.PrimaryPart
	if PrimaryPart then
		if PrimaryPart.CollisionGroup == "PlayersInTrain" then
		elseif forcefieldImpactLimiter:UseBudget(1) then
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
			C4System.onExplode(hitPlayer, 100000, 98, 98, false)
			toggleFlashCallback(true)
			task.delay(0.2, function()
				toggleFlashCallback(false)
			end)
		end
	end
end
Binder.new("MilitaryForcefield", function(forcefieldPart)
	local maid = Maid.new()
	local forcefieldCenterPosition = forcefieldPart.Position - Vector3.new(0, 1, 0) * forcefieldPart.Position.Y
	local forcefieldRadius = forcefieldPart.Size.X / 2
	local Size = forcefieldPart.Size
	local Position = forcefieldPart.Position
	local configTable = {
		Position = forcefieldCenterPosition,
		Radius = forcefieldRadius,
		Part = forcefieldPart
	}
	BulletEmitter._militaryForcefield = configTable
	maid:GiveTask(function()
		if BulletEmitter._militaryForcefield == configTable then
			BulletEmitter._militaryForcefield = nil
		end
	end)
	local configTable = {}
	local function toggleFlash(shouldFlash)
		for decalIndex, decal in configTable do
			local transparency
			transparency = if shouldFlash then 0 else 1
			decal.Transparency = transparency
		end
	end
	local minDetectionRadius = forcefieldRadius - 50
	local maxDetectionRadius = forcefieldRadius + 50
	local lastToggleTime = 0
	for faceIndex, faceNormalId in Enum.NormalId:GetEnumItems() do
		local Decal = Instance.new("Decal")
		Decal.Face = faceNormalId
		Decal.Texture = "rbxassetid://50282315"
		Decal.Color3 = Color3.fromRGB(475, 280, 510)
		Decal.Transparency = 1
		Decal.Parent = forcefieldPart
		table.insert(configTable, Decal)
		maid:GiveTask(Decal)
	end
	maid:GiveTask(Audio.ObjectLocal(forcefieldPart, 17183453324, {
		DoNotPlay = true
	}))
	local function isServerDisabled()
		return forcefieldPart:GetAttribute("Disabled") == true
	end
	local enableForcefield = nil
	local hasKeyAccess = false
	local hasKeyAccess = InventoryItemSystem.playerHasItem(LocalPlayer, "Key") == true
	local hasKeyAccess = true
	local function updatePermsToEnter()
		hasKeyAccess = hasKeyAccess or PlayerUtils.getTeamId(LocalPlayer) == Settings.EnumTeam.Police
		forcefieldPart.CanCollide = not hasKeyAccess and hasKeyAccess
		if not (hasKeyAccess or hasKeyAccess) and (forcefieldPart:GetAttribute("Disabled") ~= true and enableForcefield) then
			enableForcefield()
		end
	end
	local canEnterForcefield = hasKeyAccess or PlayerUtils.getTeamId(LocalPlayer) == Settings.EnumTeam.Police
	forcefieldPart.CanCollide = not canEnterForcefield and hasKeyAccess
	if not (canEnterForcefield or hasKeyAccess) and (forcefieldPart:GetAttribute("Disabled") ~= true and enableForcefield) then
		enableForcefield()
	end
	maid:GiveTask(GameUtil.OnTeamChanged:Connect(updatePermsToEnter))
	maid:GiveTask(InventoryItemBinder:GetClassAddedSignal():Connect(function(inventoryItem)
		if inventoryItem:GetOwner() == LocalPlayer and inventoryItem:GetName() == "Key" then
			hasKeyAccess = true
			canEnterForcefield = hasKeyAccess or PlayerUtils.getTeamId(LocalPlayer) == Settings.EnumTeam.Police
			forcefieldPart.CanCollide = not canEnterForcefield and hasKeyAccess
			if not (canEnterForcefield or hasKeyAccess) and (forcefieldPart:GetAttribute("Disabled") ~= true and enableForcefield) then
				enableForcefield()
			end
		end
	end))
	maid:GiveTask(InventoryItemBinder:GetClassRemovingSignal():Connect(function(inventoryItem)
		if inventoryItem:GetOwner() == LocalPlayer and inventoryItem:GetName() == "Key" then
			hasKeyAccess = false
			canEnterForcefield = hasKeyAccess or PlayerUtils.getTeamId(LocalPlayer) == Settings.EnumTeam.Police
			forcefieldPart.CanCollide = not canEnterForcefield and hasKeyAccess
			if not (canEnterForcefield or hasKeyAccess) and (forcefieldPart:GetAttribute("Disabled") ~= true and enableForcefield) then
				enableForcefield()
			end
		end
	end))
	local function getSoundAttachment()
		local SoundAttachment = forcefieldPart:FindFirstChild("SoundAttachment")
		if not SoundAttachment then
			local SoundAttachment_2 = Instance.new("Attachment")
			SoundAttachment_2.Name = "SoundAttachment"
			SoundAttachment_2.Parent = forcefieldPart
			SoundAttachment_2.Position = Vector3.new(-0, -1, -0) * forcefieldRadius / 2
			SoundAttachment = SoundAttachment_2
		end
		return SoundAttachment
	end
	local audioFadeTween = nil
	local isAudioPlaying = false
	local SoundAttachment = forcefieldPart:FindFirstChild("SoundAttachment")
	if not SoundAttachment then
		SoundAttachment = Instance.new("Attachment")
		SoundAttachment.Name = "SoundAttachment"
		SoundAttachment.Parent = forcefieldPart
		SoundAttachment.Position = Vector3.new(-0, -1, -0) * forcefieldRadius / 2
	end
	local forcefieldAudio = Audio.ObjectLocal(SoundAttachment, 104027245185669, {
		Volume = 2,
		RollOffMaxDistance = forcefieldRadius + 200,
		RollOffMinDistance = forcefieldRadius,
		Looped = true
	})
	maid:GiveTask(function()
		if audioFadeTween then
			audioFadeTween:cancel()
		end
		forcefieldAudio:Destroy()
	end)
	local function safeActiveFadeTo(targetVolume, fadeDuration)
		if audioFadeTween then
			audioFadeTween:cancel()
		end
		audioFadeTween = Audio.promiseFadeTo(forcefieldAudio, targetVolume, fadeDuration)
	end
	local characterSpawnedAudio = false
	maid:GiveTask(CharacterUtils.observeLocalCharacterAdded(function(character, previousCharacter)
		if audioFadeTween then
			audioFadeTween:cancel()
		end
		forcefieldAudio.Volume = 0.2
		characterSpawnedAudio = true
	end))
	local enableTweenInfo = TweenInfo.new(0.6, Enum.EasingStyle.Bounce, Enum.EasingDirection.In)
	local disableTweenInfo = TweenInfo.new(0.8, Enum.EasingStyle.Bounce, Enum.EasingDirection.In)
	local sizeTweenInfo = TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
	local function disableForcefield()
		if hasKeyAccess then
			hasKeyAccess = false
			canEnterForcefield = hasKeyAccess or PlayerUtils.getTeamId(LocalPlayer) == Settings.EnumTeam.Police
			forcefieldPart.CanCollide = not canEnterForcefield and hasKeyAccess
			if not (canEnterForcefield or hasKeyAccess) and (forcefieldPart:GetAttribute("Disabled") ~= true and enableForcefield) then
				enableForcefield()
			end
			local SoundAttachment = forcefieldPart:FindFirstChild("SoundAttachment")
			if not SoundAttachment then
				local SoundAttachment_2 = Instance.new("Attachment")
				SoundAttachment_2.Name = "SoundAttachment"
				SoundAttachment_2.Parent = forcefieldPart
				SoundAttachment_2.Position = Vector3.new(-0, -1, -0) * forcefieldRadius / 2
				SoundAttachment = SoundAttachment_2
			end
			maid:GiveTask(Audio.ObjectLocal(SoundAttachment, 2992428082, {
				Volume = 0.6,
				RollOffMaxDistance = forcefieldRadius + 200,
				RollOffMinDistance = forcefieldRadius
			}))
			TweenService:Create(forcefieldPart, disableTweenInfo, {
				Transparency = 1
			}):Play()
			for beamIndex, beam in forcefieldPart.Parent:QueryDescendants("Beam") do
				beam.Enabled = false
			end
			if audioFadeTween then
				audioFadeTween:cancel()
			end
			audioFadeTween = Audio.promiseFadeTo(forcefieldAudio, 0, 1)
		end
	end
	enableForcefield = function()
		if hasKeyAccess then
			return
		end
		hasKeyAccess = true
		canEnterForcefield = hasKeyAccess or PlayerUtils.getTeamId(LocalPlayer) == Settings.EnumTeam.Police
		forcefieldPart.CanCollide = not canEnterForcefield and hasKeyAccess
		if not (canEnterForcefield or hasKeyAccess) and (forcefieldPart:GetAttribute("Disabled") ~= true and enableForcefield) then
			enableForcefield()
		end
		local SoundAttachment = forcefieldPart:FindFirstChild("SoundAttachment")
		if not SoundAttachment then
			local SoundAttachment_2 = Instance.new("Attachment")
			SoundAttachment_2.Name = "SoundAttachment"
			SoundAttachment_2.Parent = forcefieldPart
			SoundAttachment_2.Position = Vector3.new(-0, -1, -0) * forcefieldRadius / 2
			SoundAttachment = SoundAttachment_2
		end
		maid:GiveTask(Audio.ObjectLocal(SoundAttachment, 4058366615, {
			Volume = 0.45,
			RollOffMaxDistance = forcefieldRadius + 200,
			RollOffMinDistance = forcefieldRadius - 50
		}))
		TweenService:Create(forcefieldPart, enableTweenInfo, {
			Transparency = -5
		}):Play()
		task.delay(0.5, function()
			for beamIndex, beam in forcefieldPart.Parent:QueryDescendants("Beam") do
				beam.Enabled = true
			end
		end)
		forcefieldPart.Size = Size * 0.7
		local partRef = forcefieldPart
		partRef.Position = partRef.Position - Vector3.new(0, (Size.Y - forcefieldPart.Size.Y) / 2, 0)
		TweenService:Create(forcefieldPart, sizeTweenInfo, {
			Size = Size,
			Position = Position
		}):Play()
		if hasKeyAccess then
			if audioFadeTween then
				audioFadeTween:cancel()
			end
			audioFadeTween = Audio.promiseFadeTo(forcefieldAudio, 0.2, 1)
		else
			if audioFadeTween then
				audioFadeTween:cancel()
			end
			audioFadeTween = Audio.promiseFadeTo(forcefieldAudio, 1.7, 1)
		end
	end
	local function updateServerState()
		if forcefieldPart:GetAttribute("Disabled") == true and hasKeyAccess then
			disableForcefield()
		else
			if not (forcefieldPart:GetAttribute("Disabled") == true or hasKeyAccess) then
				enableForcefield()
			end
		end
	end
	maid:GiveTask(forcefieldPart:GetAttributeChangedSignal("Disabled"):Connect(updateServerState))
	task.spawn(updateServerState)
	forcefieldPart.Transparency = -5
	forcefieldPart.LocalTransparencyModifier = 1
	for beamIndex, beam in forcefieldPart.Parent:QueryDescendants("Beam") do
		beam.LocalTransparencyModifier = 1
		beam.Enabled = true
	end
	local lastHeartbeatTime = 0
	local isWithinAudioRange = false
	maid:GiveTask(RunService.Heartbeat:Connect(function()
		local currentTime = os.clock()
		if not (currentTime < lastHeartbeatTime) then
			local Character = LocalPlayer.Character
			local primaryPart = Character and Character.PrimaryPart
			if primaryPart then
				local Position = primaryPart.Position
				local Magnitude = (forcefieldCenterPosition - Position).Magnitude
				local updateInterval = if 400 + forcefieldRadius < Magnitude then 1 else 0.05
				lastHeartbeatTime = currentTime + updateInterval
				local isWithinAudioRangeCheck = Magnitude < 1800 + forcefieldRadius
				if isWithinAudioRangeCheck and not isWithinAudioRange then
					isWithinAudioRange = true
					maid._distFade = Maid.new()
					for descendantIndex, descendant in forcefieldPart.Parent:QueryDescendants("Beam, BasePart#Forcefield") do
						maid._distFade:GiveTask(Fade.linear(descendant, "LocalTransparencyModifier", 0, 3))
					end
				elseif not isWithinAudioRangeCheck and isWithinAudioRange then
					isWithinAudioRange = false
					maid._distFade = Maid.new()
					for descendantIndex, descendant in forcefieldPart.Parent:QueryDescendants("Beam, BasePart#Forcefield") do
						maid._distFade:GiveTask(Fade.linear(descendant, "LocalTransparencyModifier", 1, 3))
					end
				end
				if updateInterval == 0.05 then
					local canPlayerToggle = if minDetectionRadius < Magnitude and (Magnitude < maxDetectionRadius and Position.Y >= forcefieldCenterPosition.Y) then canEnterForcefield else false
					if canPlayerToggle then
						lastToggleTime = os.clock()
					end
					if canPlayerToggle and hasKeyAccess then
						disableForcefield()
					elseif not (canPlayerToggle or hasKeyAccess) then
						local isServerDisabledCheck = forcefieldPart:GetAttribute("Disabled") == true
						if not isServerDisabledCheck and os.clock() - lastToggleTime > 3 then
							enableForcefield()
						end
					end
					if if forcefieldRadius - 4 < Magnitude and Magnitude < forcefieldRadius + 6 then Position.Y >= forcefieldCenterPosition.Y else false and (not canEnterForcefield and hasKeyAccess) then
						flingPlayer(forcefieldCenterPosition, toggleFlash)
					end
					local isInsideForcefield = Magnitude < forcefieldRadius
					configTable.Ignore = isInsideForcefield
					if isInsideForcefield ~= isAudioPlaying or characterSpawnedAudio then
						isAudioPlaying = false
						characterSpawnedAudio = isInsideForcefield
						if characterSpawnedAudio then
							if isInsideForcefield then
								if audioFadeTween then
									audioFadeTween:cancel()
								end
								audioFadeTween = Audio.promiseFadeTo(forcefieldAudio, 0.2, 1)
								return
							end
							if audioFadeTween then
								audioFadeTween:cancel()
							end
							audioFadeTween = Audio.promiseFadeTo(forcefieldAudio, 1.7, 1)
						end
					end
				end
			end
		end
	end))
	return maid
end):Start()
