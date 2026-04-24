-- Reviewed by Claude
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
	delay(1, function()
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
				jewelEvent:FireServer("k" .. ("uoc0rvi9o"):sub(5, 6):reverse() .. "m5wlx", jewelPart.Name)
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
				jewelEvent:FireServer("k" .. ("m0jvrvmjdv"):sub(5, 6):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("f5mwc"):sub(3, 3):reverse() .. "" .. "" .. ("f55i"):sub(3, 3):reverse() .. "" .. "" .. ("klwp"):sub(2, 3):reverse():reverse():reverse():reverse():reverse() .. "x", "LaserButton")
			end
			return true
		end
	}, laserPart)
end
return {
	Init = function(config)
		local eventManager = config.em
		jewelEvent = config.Event
		eventManager = eventManager
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
		function em.kx2z39za(p1)
			task.delay(0.2, function()
				p1.Transparency = 0.25
				TweenService:Create(p1, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false), {
					Transparency = 0.4
				}):Play()
			end)
		end
		function em.yo65te3x(p1, p2)
			PlaySound(LocalPlayer, 1837831244)
			delay(1, function()
				PlaySound(LocalPlayer, 1843025542)
			end)
			spawn(FadeInSound)
			if p1 then
				for v1, v2 in p2 do
					v2.CanCollide = true
					task.delay(2, function()
						v2.CanCollide = false
					end)
				end
				local CurrentCamera = workspace.CurrentCamera
				local v3 = CurrentCamera.CFrame
				local v4 = CamShaker.new(Enum.RenderPriority.Camera.Value + 2, function(p1)
					v3 = CurrentCamera.CFrame
					CurrentCamera.CFrame = CurrentCamera.CFrame * p1
				end)
				local v5 = RunService.Heartbeat:Connect(function()
					CurrentCamera.CFrame = v3
				end)
				v4:Start()
				v4:Shake(CamShaker.Presets.Explosion)
				Promise.delay(2):andThenCall(function()
					v4:Stop()
					v5:Disconnect()
				end)
			end
		end
		function em.eckwjayf()
			spawn(FadeOutSound)
		end
		local v22 = next
		local v3, v4 = CollectionService:GetTagged("RobberyJewelryJewel")
		for v5, v6 in v22, v3, v4 do
			if v6:GetAttribute("LaserButton") then
				AddedLaserButton(v6)
			else
				AddedJewel(v6)
			end
		end
		CollectionService:GetInstanceAddedSignal("RobberyJewelryJewel"):Connect(function(p1)
			if p1:GetAttribute("LaserButton") then
				AddedLaserButton(p1)
			else
				AddedJewel(p1)
			end
		end)
		CollectionService:GetInstanceRemovedSignal("RobberyJewelryJewel"):Connect(CircleAction.Remove)
	end
}
