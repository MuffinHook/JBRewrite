local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DuffelBagBinder = require(ReplicatedStorage.Game.DuffelBag.DuffelBagBinder)
local OilRigBinder = require(ReplicatedStorage.OilRig.OilRigBinder)
local RobberyConsts = require(ReplicatedStorage.Robbery.RobberyConsts)
local Audio = require(ReplicatedStorage.Std.Audio)
local Maid = require(ReplicatedStorage.Std.Maid)
OilRigBinder:Start()
DuffelBagBinder:GetClassAddedSignal():Connect(function(self)
	local instance = Maid.new()
	local function handleRobbery()
		instance:DoCleaning()
		local var12 = self:GetRobbery()
		if self:GetOwner() == Players.LocalPlayer and var12 == RobberyConsts.ENUM_ROBBERY.OIL_RIG then
			local localPlayer = Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 1837697591, {
				Looped = true,
				Volume = 0.4,
				Group = game:GetService("SoundService").RobberyMusic
			})
			instance:GiveTask(function()
				Audio.promiseFadeTo(localPlayer, 0, 0.5):andThen(function()
					localPlayer:Destroy()
				end)
			end)
		end
	end
	handleRobbery()
	self._maid:GiveTask(self:GetRobberyChangedSignal():Connect(handleRobbery))
	self._maid:GiveTask(instance)
end)
