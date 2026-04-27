local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Audio = require(ReplicatedStorage.Std.Audio)
local CharacterUtils = require(ReplicatedStorage.Std.CharacterUtils)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local ZiplineConsts = require(ReplicatedStorage.Zipline.ZiplineConsts)
local audioFadeTask = nil
local cameraFieldOfViewTween = nil
CharacterUtils.observeLocalCharacterAdded(function(character, subscriptionManager)
	subscriptionManager:GiveTask(RxInstanceUtils.observeAttribute(character, ZiplineConsts.OnZiplineAttrName, function(isOnZipline, subscriptionManager)
		if isOnZipline == true and character:FindFirstChild("Head") then
			workspace.CurrentCamera.CameraSubject = character.Head
			cameraFieldOfViewTween = TweenService:Create(workspace.CurrentCamera, TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				FieldOfView = 90
			})
			cameraFieldOfViewTween:Play()
			local localPlayer = Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 114263747201737, {
				Looped = true,
				Volume = 0
			})
			audioFadeTask = Audio.promiseFadeTo(localPlayer, 1.5, 0.5):finally(function()
				audioFadeTask = nil
			end)
			subscriptionManager:GiveTask(function()
				workspace.CurrentCamera.CameraSubject = character.Humanoid
				if audioFadeTask then
					audioFadeTask:cancel()
					audioFadeTask = nil
				end
				if cameraFieldOfViewTween then
					cameraFieldOfViewTween:Cancel()
					cameraFieldOfViewTween = nil
				end
				cameraFieldOfViewTween = TweenService:Create(workspace.CurrentCamera, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
					FieldOfView = 70
				})
				cameraFieldOfViewTween:Play()
				Audio.promiseFadeTo(localPlayer, 0, 0.4):finally(function()
					localPlayer:Destroy()
				end)
			end)
		end
	end))
end)
