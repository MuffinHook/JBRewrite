local LocalPlayer = game:GetService("Players").LocalPlayer
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local CamShaker = require(ReplicatedStorage.Game.CamShaker.CamShaker)
local UI = require(ReplicatedStorage.Module.UI)
local Audio = require(ReplicatedStorage.Std.Audio)
local Promise = require(ReplicatedStorage.Std.Promise)
local CircleAction = UI.CircleAction
local jewelEvent = nil
local eventManager = nil
local function PlaySound(targetPart, soundId)
	local Sound = Instance.new("Sound")
	Sound.SoundId = ("rbxassetid://%d"):format(soundId)
	Sound.Volume = 0.75
	Sound.Parent = targetPart
	Sound:Play()
	task.delay(1, function()
		game.Debris:AddItem(Sound, Sound.TimeLength)
	end)
end
local function AddedJewel(jewelPart)
	CircleAction.Add({
		Part = jewelPart,
		Name = "Grab Jewel",
		Timed = true,
		Duration = 3,
		Dist = 8,
		Callback = function(part, isActive)
			if isActive then
				jewelEvent:FireServer("kvrm5wlx", jewelPart.Name)
				Audio.ObjectLocal(LocalPlayer.PlayerGui, 6875006205, {
					Volume = 0.4
				})
			end
			return true
		end
	}, jewelPart)
end
local function AddedLaserButton(laserPart)
	CircleAction.Add({
		Part = laserPart,
		Name = "",
		Dist = 8,
		Callback = function(part, isActive)
			if isActive then
				jewelEvent:FireServer("kvrm5wlx", "LaserButton")
			end
			return true
		end
	}, laserPart)
end
return {
	Init = function(config)
		eventManager = config.em
		jewelEvent = config.Event
		local Sound = Instance.new("Sound")
		Sound.SoundId = "rbxassetid://1837825257"
		Sound.Looped = true
		Sound.Volume = 0
		Sound.SoundGroup = game:GetService("SoundService").RobberyMusic
		Sound.Parent = LocalPlayer.PlayerGui
		local function FadeInSound()
			Sound:Play()
			Audio.FadeTo(Sound, 1, 2)
		end
		local function FadeOutSound()
			Audio.FadeTo(Sound, 0, 2)
			task.wait(2)
			Sound:Stop()
		end
		function eventManager.kx2z39za(jewelPart)
			task.delay(0.2, function()
				jewelPart.Transparency = 0.25
				TweenService:Create(jewelPart, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false), {
					Transparency = 0.4
				}):Play()
			end)
		end
		function eventManager.yo65te3x(shouldShake, jewelParts)
			PlaySound(LocalPlayer, 1837831244)
			task.delay(1, function()
				PlaySound(LocalPlayer, 1843025542)
			end)
			task.spawn(FadeInSound)
			if shouldShake then
				for index, jewelPart in jewelParts do
					jewelPart.CanCollide = true
					task.delay(2, function()
						jewelPart.CanCollide = false
					end)
				end
				local CurrentCamera = workspace.CurrentCamera
				local originalCFrame = CurrentCamera.CFrame
				local camShaker = CamShaker.new(Enum.RenderPriority.Camera.Value + 2, function(offsetCFrame)
					originalCFrame = CurrentCamera.CFrame
					CurrentCamera.CFrame = CurrentCamera.CFrame * offsetCFrame
				end)
				local heartbeatConnection = RunService.Heartbeat:Connect(function()
					CurrentCamera.CFrame = originalCFrame
				end)
				camShaker:Start()
				camShaker:Shake(CamShaker.Presets.Explosion)
				Promise.delay(2):andThenCall(function()
					camShaker:Stop()
					heartbeatConnection:Disconnect()
				end)
			end
		end
		function eventManager.eckwjayf()
			task.spawn(FadeOutSound)
		end
		local nextIterator = next
		local jewelList, endIndex = CollectionService:GetTagged("RobberyJewelryJewel")
		for jewelIndex, jewelInstance in nextIterator, jewelList, endIndex do
			if jewelInstance:GetAttribute("LaserButton") then
				AddedLaserButton(jewelInstance)
			else
				AddedJewel(jewelInstance)
			end
		end
		CollectionService:GetInstanceAddedSignal("RobberyJewelryJewel"):Connect(function(jewelPart)
			if jewelPart:GetAttribute("LaserButton") then
				AddedLaserButton(jewelPart)
			else
				AddedJewel(jewelPart)
			end
		end)
		CollectionService:GetInstanceRemovedSignal("RobberyJewelryJewel"):Connect(CircleAction.Remove)
	end
}
