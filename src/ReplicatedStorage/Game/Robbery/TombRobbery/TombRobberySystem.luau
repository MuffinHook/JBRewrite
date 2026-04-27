local LocalPlayer = game:GetService("Players").LocalPlayer
local SoundService = game:GetService("SoundService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local waitForChild = require(ReplicatedStorage.Std.waitForChild)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local Promise = require(ReplicatedStorage.Std.Promise)
local Audio = require(ReplicatedStorage.Std.Audio)
local Binder = require(ReplicatedStorage.Std.Binder)
local CartSystem = require(ReplicatedStorage.Game.Cart.CartSystem)
local DoorUtils = require(ReplicatedStorage.Door2.DoorUtils)
local Maid = require(ReplicatedStorage.Std.Maid)
local CircleAction = require(ReplicatedStorage.Module.UI).CircleAction
local TombRobberyConsts = require(script.Parent.TombRobberyConsts)
local tombRemoteEvent = nil
local TombRobberySystem = {}
function TombRobberySystem.init(remoteEvent)
	tombRemoteEvent = remoteEvent.Event
	local ambientMusicInstance = nil
	local stormMusicInstance = nil
	local isAmbientTrackActive = nil
	local musicTransitionPromise = nil
	local function playMusic()
		if musicTransitionPromise then
			musicTransitionPromise:cancel()
			musicTransitionPromise = nil
		end
		if not ambientMusicInstance then
			ambientMusicInstance = Audio.ObjectLocal(LocalPlayer.PlayerGui, 9062816634, {
				Looped = true,
				Volume = 0
			})
			ambientMusicInstance.SoundGroup = SoundService.RobberyMusic
		end
		if not stormMusicInstance then
			stormMusicInstance = Audio.ObjectLocal(LocalPlayer.PlayerGui, 9062816122, {
				Looped = true,
				Volume = 0
			})
			stormMusicInstance.SoundGroup = SoundService.RobberyMusic
		end
		local fadePromises = {}
		fadePromises[1] = Audio.promiseFadeTo(ambientMusicInstance, if isAmbientTrackActive then 1 else 0, 3)
		fadePromises[2] = Audio.promiseFadeTo(stormMusicInstance, if isAmbientTrackActive then 0 else 1, 3)
		musicTransitionPromise = Promise.all(fadePromises):andThen(function()
			musicTransitionPromise = nil
		end)
	end
	local function stopMusic()
		if musicTransitionPromise then
			musicTransitionPromise:cancel()
			musicTransitionPromise = nil
		end
		musicTransitionPromise = Promise.all({ Audio.promiseFadeTo(ambientMusicInstance, 0, 1):andThen(function()
				ambientMusicInstance:Destroy()
				ambientMusicInstance = nil
			end), Audio.promiseFadeTo(stormMusicInstance, 0, 1):andThen(function()
				stormMusicInstance:Destroy()
				stormMusicInstance = nil
			end) }):andThen(function()
			musicTransitionPromise = nil
		end)
	end
	local function changeTrack()
		if ambientMusicInstance and stormMusicInstance then
			if musicTransitionPromise then
				musicTransitionPromise:await()
			end
			if ambientMusicInstance and stormMusicInstance then
				local fadePromises = {}
				fadePromises[1] = Audio.promiseFadeTo(ambientMusicInstance, if isAmbientTrackActive then 1 else 0, 2)
				fadePromises[2] = Audio.promiseFadeTo(stormMusicInstance, if isAmbientTrackActive then 0 else 1, 2)
				musicTransitionPromise = Promise.all(fadePromises):andThen(function()
					musicTransitionPromise = nil
				end)
			end
		end
	end
	waitForChild(LocalPlayer.PlayerGui, TombRobberyConsts.MUSIC_ENABLED_VALUE_NAME):andThen(function(musicEnabledValue)
		musicEnabledValue.Changed:Connect(function(isEnabled)
			if isEnabled then
				playMusic()
			else
				stopMusic()
			end
		end)
		if musicEnabledValue.Value then
			playMusic()
		end
	end)
	waitForChild(LocalPlayer.PlayerGui, TombRobberyConsts.MUSIC_TRACK_VALUE_NAME):andThen(function(trackValue)
		trackValue.Changed:Connect(function(newTrackValue)
			isAmbientTrackActive = newTrackValue
			changeTrack()
		end)
		isAmbientTrackActive = trackValue.Value
		changeTrack()
	end)
	local function hookCharacter(character)
		local Humanoid = character:WaitForChild("Humanoid")
		local duckAnimationTrack = Humanoid:LoadAnimation(ReplicatedStorage.Resource.CartDuckAnimation)
		TombRobberySystem._duckTrack = duckAnimationTrack
		local duckCharacterDeathConnection = nil
		duckCharacterDeathConnection = Humanoid.Died:Connect(function()
			duckCharacterDeathConnection:Disconnect()
			duckAnimationTrack:Destroy()
			TombRobberySystem._duckTrack = nil
		end)
	end
	if LocalPlayer.Character then
		hookCharacter(LocalPlayer.Character)
	end
	LocalPlayer.CharacterAdded:Connect(hookCharacter)
	TombRobberySystem.setupSpikes()
	TombRobberySystem.setupGems()
	TombRobberySystem.setupWood()
	TombRobberySystem.setupBranches()
end
function TombRobberySystem.setupSpikes()
	local lastGlobalSpikeHitTime = 0
	Binder.new(TombRobberyConsts.SPIKE_TAG_NAME, function(spikeModel)
		RxInstanceUtils.yieldForProperty(spikeModel, "PrimaryPart")
		local spikeInnerModel = DoorUtils.getInnerModel(spikeModel)
		RxInstanceUtils.yieldForProperty(spikeInnerModel, "PrimaryPart")
		local spikeMaid = Maid.new()
		local lastLocalSpikeHitTime = 0
		spikeInnerModel.PrimaryPart.Touched:Connect(function(touchingPart)
			if touchingPart.Parent == LocalPlayer.Character and not ((touchingPart.Position - LocalPlayer.Character.PrimaryPart.Position).Magnitude > 32) then
				local currentSpikeHitTime = os.clock()
				if currentSpikeHitTime - lastLocalSpikeHitTime > 1 and currentSpikeHitTime - lastGlobalSpikeHitTime > 0.5 then
					lastLocalSpikeHitTime = currentSpikeHitTime
					lastGlobalSpikeHitTime = currentSpikeHitTime
					tombRemoteEvent:FireServer("xe6v1us6", 36, "Spikes")
				end
			end
		end)
		DoorUtils.getDoorOpenChangedSignal(spikeModel):Connect(function()
			if DoorUtils.getOpen(spikeModel) then
				lastLocalSpikeHitTime = 0
			end
		end)
		return spikeMaid
	end):Start()
end
function TombRobberySystem.setupGems()
	Binder.new(TombRobberyConsts.GEM_TAG_NAME, function(gemModel)
		RxInstanceUtils.yieldForProperty(gemModel, "PrimaryPart")
		local gemMaid = Maid.new()
		local function action(actionPosition, isActivated)
			if isActivated then
				local collectRemote = gemModel:FindFirstChild(TombRobberyConsts.GEM_COLLECT_REMOTE_NAME)
				assert(collectRemote)
				collectRemote:FireServer()
				return true
			end
		end
		local function preUpdateFun(actionObj)
			actionObj.Enabled = actionObj.Part.Transparency < 0.999
		end
		local PrimaryPart = gemModel.PrimaryPart
		CircleAction.Add({
			Part = PrimaryPart,
			Name = "Collect",
			NoRay = true,
			Timed = false,
			Dist = 8,
			Callback = action,
			PreUpdateFun = preUpdateFun,
			PreUpdatePeriod = 0.5
		}, PrimaryPart)
		gemMaid:GiveTask(function()
			CircleAction.Remove(PrimaryPart)
		end)
		return gemMaid
	end):Start()
end
function TombRobberySystem.duck()
	local _duckTrack = TombRobberySystem._duckTrack
	if _duckTrack then
		if TombRobberySystem._duckPromise then
			TombRobberySystem._duckPromise:cancel()
			TombRobberySystem._duckPromise = nil
		end
		_duckTrack:Play()
		TombRobberySystem._duckPromise = Promise.delay(2):andThen(function()
			_duckTrack:Stop()
			TombRobberySystem._duckPromise = nil
		end)
	end
end
local function preUpdateFun(rayResult)
	local ignoreList = {}
	if LocalPlayer.Character then
		table.insert(ignoreList, LocalPlayer.Character)
		local cart = CartSystem.getCartForCharacter(LocalPlayer.Character)
		if cart then
			table.insert(ignoreList, cart._obj)
		end
	end
	rayResult.IgnoreOverride = ignoreList
end
function TombRobberySystem.setupWood()
	Binder.new(TombRobberyConsts.WOOD_TAG_NAME, function(woodModel)
		local woodMaid = Maid.new()
		CircleAction.Add({
			Part = woodModel,
			Name = "Duck",
			NoRay = true,
			Timed = false,
			Dist = 36,
			Callback = function(actionObj, isActivated)
				if isActivated then
					TombRobberySystem.duck()
					actionObj.Enabled = false
					Promise.delay(2):andThen(function()
						actionObj.Enabled = true
					end)
					return true
				end
			end,
			PreUpdateFun = preUpdateFun,
			PreUpdatePeriod = 0.2
		}, woodModel)
		woodMaid:GiveTask(function()
			CircleAction.Remove(woodModel)
		end)
		local lastWoodTouchTime = 0
		woodMaid:GiveTask(woodModel.Touched:Connect(function(touchingPart)
			if touchingPart:IsDescendantOf(LocalPlayer.Character) then
				if (touchingPart.Position - LocalPlayer.Character.PrimaryPart.Position).Magnitude > 32 then
					return
				end
				local currentTouchTime = os.clock()
				if currentTouchTime - lastWoodTouchTime < 10 then
					return
				end
				lastWoodTouchTime = currentTouchTime
				if TombRobberySystem._duckTrack and not TombRobberySystem._duckTrack.IsPlaying then
					tombRemoteEvent:FireServer("xe6v1us6", 30, "Duck")
					Audio.ObjectLocal(woodModel, 6875020869, {
						Volume = 0.6,
						RollOffMaxDistance = 64
					})
				else
					Audio.ObjectLocal(woodModel, 3772601178, {
						Volume = 0.2,
						RollOffMaxDistance = 64
					})
				end
			end
		end))
		return woodMaid
	end):Start()
end
function TombRobberySystem.setupBranches()
	Binder.new(TombRobberyConsts.BRANCH_SWITCH_TAG_NAME, function(branchModel)
		local branchMaid = Maid.new()
		local function action(switchActionPosition, isActivated)
			if isActivated then
				branchModel:WaitForChild(TombRobberyConsts.BRANCH_SWITCH_REMOTE_NAME):FireServer()
				return true
			end
		end
		CircleAction.Add({
			Part = branchModel.PrimaryPart,
			ValidRoot = branchModel.Parent,
			Name = "Switch",
			Dist = 80,
			Callback = action,
			PreUpdateFun = preUpdateFun,
			PreUpdatePeriod = 0.2
		}, branchModel)
		branchMaid:GiveTask(function()
			CircleAction.Remove(branchModel)
		end)
		return branchMaid
	end):Start()
end
return TombRobberySystem
