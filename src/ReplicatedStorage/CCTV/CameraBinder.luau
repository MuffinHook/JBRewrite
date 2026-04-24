-- Reviewed by Claude
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ManifestBinder = require(ReplicatedStorage.ManifestBinder)
local Maid = require(ReplicatedStorage.Std.Maid)
local Audio = require(ReplicatedStorage.Std.Audio)
local CameraConsts = require(script.Parent.CameraConsts)
local CameraBinder = {}
CameraBinder.__index = CameraBinder
function CameraBinder.new(cameraObj, cameraData)
	local self = {}
	setmetatable(self, CameraBinder)
	self.obj = cameraObj
	self._maid = Maid.new()
	self._maid:GiveTask(cameraData.spotRemote.OnClientEvent:Connect(function(spotData)
		if spotData.isViewer then
			local spottedPlayer = Players:GetPlayerFromCharacter(spotData.spottedCharacter)
			if spottedPlayer then
				spottedPlayer:SetAttribute("CCTVSpotted", true)
				task.delay(CameraConsts.SPOT_DURATION, function()
					spottedPlayer:SetAttribute("CCTVSpotted", false)
				end)
			end
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 8274149535, {
				Volume = 0.5,
				RollOffMinDistance = 16,
				RollOffMaxDistance = 128
			})
		end
	end))
	return self
end
function CameraBinder.Damage(self)
	self.obj:FindFirstChild("DamageRemote"):FireServer()
end
function CameraBinder.Spot(self, targetPlayer)
	self.obj:FindFirstChild("SpotRemote"):FireServer(targetPlayer)
end
function CameraBinder.Destroy(self)
	self._maid:Destroy()
	setmetatable(self, nil)
end
return ManifestBinder.new("CCTVCamera", {
	spotRemote = "SpotRemote"
}, CameraBinder)
