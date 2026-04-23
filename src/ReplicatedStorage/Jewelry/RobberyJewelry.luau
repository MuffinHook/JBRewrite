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
local v1 = nil
local v2 = nil
local function PlaySound(p1, p2) --[[ Line: 14 ]]
	local Sound = Instance.new("Sound")
	Sound.SoundId = ("rbxassetid://%d"):format(p2)
	Sound.Volume = 0.75
	Sound.Parent = p1
	Sound:Play()
	delay(1, function() --[[ Line: 20 | Upvalues: Sound (copy) ]]
		game.Debris:AddItem(Sound, Sound.TimeLength)
	end)
end
local function AddedJewel(p1) --[[ Line: 25 | Upvalues: v1 (ref), Audio (copy), LocalPlayer (copy), CircleAction (copy) ]]
	CircleAction.Add({
		Part = p1,
		Name = "Grab Jewel",
		Timed = true,
		Duration = 3,
		Dist = 8,
		Callback = function(p12, p2) --[[ Name: Action | Line: 26 | Upvalues: v1 (ref), p1 (copy), Audio (ref), LocalPlayer (ref) ]]
			if p2 then
				v1:FireServer("k" .. ("uoc0rvi9o"):sub(5, 6):reverse() .. "m5wlx", p1.Name)
				Audio.ObjectLocal(LocalPlayer.PlayerGui, 6875006205, {
					Volume = 0.4
				})
			end
			return true
		end
	}, p1)
end
local function AddedLaserButton(p1) --[[ Line: 43 | Upvalues: v1 (ref), CircleAction (copy) ]]
	CircleAction.Add({
		Part = p1,
		Name = "",
		Dist = 8,
		Callback = function(p1, p2) --[[ Name: Action | Line: 44 | Upvalues: v1 (ref) ]]
			if p2 then
				v1:FireServer("k" .. ("m0jvrvmjdv"):sub(5, 6):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("f5mwc"):sub(3, 3):reverse() .. "" .. "" .. ("f55i"):sub(3, 3):reverse() .. "" .. "" .. ("klwp"):sub(2, 3):reverse():reverse():reverse():reverse():reverse() .. "x", "LaserButton")
			end
			return true
		end
	}, p1)
end
return {
	Init = function(p1) --[[ Name: Init | Line: 58 | Upvalues: v1 (ref), v2 (ref), LocalPlayer (copy), Audio (copy), TweenService (copy), PlaySound (copy), CamShaker (copy), RunService (copy), Promise (copy), CollectionService (copy), AddedLaserButton (copy), AddedJewel (copy), CircleAction (copy) ]]
		local em = p1.em
		v1 = p1.Event
		v2 = em
		local Sound = Instance.new("Sound")
		Sound.SoundId = "rbxassetid://1837825257"
		Sound.Looped = true
		Sound.Volume = 0
		Sound.SoundGroup = game:GetService("SoundService").RobberyMusic
		Sound.Parent = LocalPlayer.PlayerGui
		local function FadeInSound() --[[ Line: 69 | Upvalues: Sound (copy), Audio (ref) ]]
			Sound:Play()
			Audio.FadeTo(Sound, 1, 2)
		end
		local function FadeOutSound() --[[ Line: 73 | Upvalues: Audio (ref), Sound (copy) ]]
			Audio.FadeTo(Sound, 0, 2)
			task.wait(2)
			Sound:Stop()
		end
		function em.kx2z39za(p1) --[[ Line: 79 | Upvalues: TweenService (ref) ]]
			task.delay(0.2, function() --[[ Line: 80 | Upvalues: p1 (copy), TweenService (ref) ]]
				p1.Transparency = 0.25
				TweenService:Create(p1, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false), {
					Transparency = 0.4
				}):Play()
			end)
		end
		function em.yo65te3x(p1, p2) --[[ Line: 90 | Upvalues: PlaySound (ref), LocalPlayer (ref), FadeInSound (copy), CamShaker (ref), RunService (ref), Promise (ref) ]]
			PlaySound(LocalPlayer, 1837831244)
			delay(1, function() --[[ Line: 92 | Upvalues: PlaySound (ref), LocalPlayer (ref) ]]
				PlaySound(LocalPlayer, 1843025542)
			end)
			spawn(FadeInSound)
			if p1 then
				for v1, v2 in p2 do
					v2.CanCollide = true
					task.delay(2, function() --[[ Line: 101 | Upvalues: v2 (copy) ]]
						v2.CanCollide = false
					end)
				end
				local CurrentCamera = workspace.CurrentCamera
				local v3 = CurrentCamera.CFrame
				local v4 = CamShaker.new(Enum.RenderPriority.Camera.Value + 2, function(p1) --[[ Line: 107 | Upvalues: v3 (ref), CurrentCamera (copy) ]]
					v3 = CurrentCamera.CFrame
					CurrentCamera.CFrame = CurrentCamera.CFrame * p1
				end)
				local v5 = RunService.Heartbeat:Connect(function() --[[ Line: 111 | Upvalues: CurrentCamera (copy), v3 (ref) ]]
					CurrentCamera.CFrame = v3
				end)
				v4:Start()
				v4:Shake(CamShaker.Presets.Explosion)
				Promise.delay(2):andThenCall(function() --[[ Line: 117 | Upvalues: v4 (copy), v5 (copy) ]]
					v4:Stop()
					v5:Disconnect()
				end)
			end
		end
		function em.eckwjayf() --[[ Line: 122 | Upvalues: FadeOutSound (copy) ]]
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
		CollectionService:GetInstanceAddedSignal("RobberyJewelryJewel"):Connect(function(p1) --[[ Line: 133 | Upvalues: AddedLaserButton (ref), AddedJewel (ref) ]]
			if p1:GetAttribute("LaserButton") then
				AddedLaserButton(p1)
			else
				AddedJewel(p1)
			end
		end)
		CollectionService:GetInstanceRemovedSignal("RobberyJewelryJewel"):Connect(CircleAction.Remove)
	end
}