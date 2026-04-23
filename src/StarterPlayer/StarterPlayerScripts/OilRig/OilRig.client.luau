local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DuffelBagBinder = require(ReplicatedStorage.Game.DuffelBag.DuffelBagBinder)
local OilRigBinder = require(ReplicatedStorage.OilRig.OilRigBinder)
local RobberyConsts = require(ReplicatedStorage.Robbery.RobberyConsts)
local Audio = require(ReplicatedStorage.Std.Audio)
local Maid = require(ReplicatedStorage.Std.Maid)
OilRigBinder:Start()
DuffelBagBinder:GetClassAddedSignal():Connect(function(p1) --[[ Line: 10 | Upvalues: Maid (copy), Players (copy), RobberyConsts (copy), Audio (copy) ]]
	local v1 = Maid.new()
	local function handleRobbery() --[[ Line: 12 | Upvalues: v1 (copy), p1 (copy), Players (ref), RobberyConsts (ref), Audio (ref) ]]
		v1:DoCleaning()
		local v12 = p1:GetRobbery()
		if p1:GetOwner() == Players.LocalPlayer and v12 == RobberyConsts.ENUM_ROBBERY.OIL_RIG then
			local v2 = Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 1837697591, {
				Looped = true,
				Volume = 0.4,
				Group = game:GetService("SoundService").RobberyMusic
			})
			v1:GiveTask(function() --[[ Line: 21 | Upvalues: Audio (ref), v2 (copy) ]]
				Audio.promiseFadeTo(v2, 0, 0.5):andThen(function() --[[ Line: 22 | Upvalues: v2 (ref) ]]
					v2:Destroy()
				end)
			end)
		end
	end
	handleRobbery()
	p1._maid:GiveTask(p1:GetRobberyChangedSignal():Connect(handleRobbery))
	p1._maid:GiveTask(v1)
end)