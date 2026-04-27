local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Audio = require(ReplicatedStorage.Std.Audio)
local PlayerUtils = require(ReplicatedStorage.Game.PlayerUtils)
local Interval = require(ReplicatedStorage.Std.Interval)
local ProximitySoundConsts = require(script.Parent.ProximitySoundConsts)
local ProximitySound = {}
ProximitySound.__index = ProximitySound
function ProximitySound.new(targetPart)
	local instance = {}
	setmetatable(instance, ProximitySound)
	instance._maid = Maid.new()
	if not targetPart:GetAttribute(ProximitySoundConsts.ENABLED_ATTR_NAME) then
		targetPart:SetAttribute(ProximitySoundConsts.ENABLED_ATTR_NAME, false)
	end
	if not targetPart:GetAttribute(ProximitySoundConsts.RADIUS_ATTR_NAME) then
		targetPart:SetAttribute(ProximitySoundConsts.RADIUS_ATTR_NAME, 32)
	end
	if not targetPart:GetAttribute(ProximitySoundConsts.MAX_VOLUME_ATTR_NAME) then
		targetPart:SetAttribute(ProximitySoundConsts.MAX_VOLUME_ATTR_NAME, 1)
	end
	instance._target = 0
	instance._current = 0
	local function updateEnabled()
		if targetPart:GetAttribute(ProximitySoundConsts.ENABLED_ATTR_NAME) then
			instance:Listen(targetPart)
		else
			instance._maid._stop = nil
		end
	end
	instance._maid:GiveTask(targetPart:GetAttributeChangedSignal(ProximitySoundConsts.ENABLED_ATTR_NAME):Connect(updateEnabled))
	if targetPart:GetAttribute(ProximitySoundConsts.ENABLED_ATTR_NAME) then
		instance:Listen(targetPart)
	else
		instance._maid._stop = nil
	end
	return instance
end
function ProximitySound.Listen(self, soundPart)
	local audioInstance = nil
	local isPlaying = false
	local fadePromise = nil
	local maid = self._maid
	maid._listenLoop = Interval.every(0.5):Connect(function()
		local playerRootPart = PlayerUtils.getRootPart(LocalPlayer)
		if playerRootPart and playerRootPart:IsDescendantOf(workspace) then
			local radius = soundPart:GetAttribute(ProximitySoundConsts.RADIUS_ATTR_NAME)
			if (playerRootPart.Position - soundPart.Position).Magnitude / radius <= 1 then
				if not isPlaying then
					if fadePromise then
						fadePromise:cancel()
						fadePromise = nil
					end
					if not audioInstance then
						audioInstance = Audio.ObjectLocal(soundPart, soundPart:GetAttribute(ProximitySoundConsts.ID_ATTR_NAME), {
							Looped = true,
							Volume = 0,
							RollOffMaxDistance = radius + 64,
							RollOffMinDistance = radius * 0.1
						})
					end
					isPlaying = true
					fadePromise = Audio.promiseFadeTo(audioInstance, 1, 1):andThen(function()
						fadePromise = nil
					end)
				end
			elseif isPlaying then
				if fadePromise then
					fadePromise:cancel()
					fadePromise = nil
				end
				isPlaying = false
				fadePromise = Audio.promiseFadeTo(audioInstance, 0, 1):andThen(function()
					audioInstance:Destroy()
					audioInstance = nil
				end):andThen(function()
					fadePromise = nil
				end)
			end
		end
	end)
	function maid._stop()
		maid._listenLoop = nil
		if fadePromise then
			fadePromise:cancel()
			fadePromise = nil
		end
		if audioInstance then
			Audio.promiseFadeTo(audioInstance, 0, 1):andThen(function()
				audioInstance:Destroy()
				audioInstance = nil
			end)
		end
	end
end
function ProximitySound.Destroy(self)
	local maid = self._maid
	self._maid = nil
	maid:Destroy()
end
return ProximitySound
