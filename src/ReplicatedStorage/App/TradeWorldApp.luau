local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Std.Audio)
local LevelUISystem = require(ReplicatedStorage.Game.Level2.LevelUISystem)
return {
	init = function()
		Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 9742813686, {
			Looped = true,
			Volume = 0.1
		})
		Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 9742811639, {
			Looped = true,
			Volume = 0.4,
			GroupName = "RobberyMusic"
		})
		LevelUISystem.hideTopbar()
	end
}