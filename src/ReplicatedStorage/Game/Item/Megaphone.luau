local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.ActionButton.ActionButtonService)
local Basic = require(script.Parent.Basic)
local t = {
	Motion = {
		Hip = {
			Springs = {
				ItemOffset = Vector3.new(0, 0.8, -1.7),
				ItemRotation = Vector3.new(),
				NeckRotation = Vector3.new(),
				WaistRotation = Vector3.new()
			}
		},
		RightWristRotation = CFrame.new(),
		LeftWristRotation = CFrame.new()
	},
	FunSounds = {
		{
			Name = "Siren",
			IconId = "rbxassetid://4939739355",
			SoundId = 690529934
		},
		{
			Name = "Drop Weapons",
			SoundId = 8990461116
		},
		{
			Name = "Countdown",
			SoundId = 8990459885
		},
		{
			Name = "ChampionTrumpets",
			SoundId = 12413440203
		}
	}
}
local function wireup(p1, p2) --[[ Line: 41 ]]
	local Wire = Instance.new("Wire")
	Wire.SourceInstance = p1
	Wire.TargetInstance = p2
	Wire.Parent = p2
	return Wire
end
local function split(p1, p2) --[[ Line: 49 ]]
	local SourceInstance = p1.SourceInstance
	local TargetInstance = p1.TargetInstance
	p1.TargetInstance = p2
	local Wire = Instance.new("Wire")
	Wire.SourceInstance = p2
	Wire.TargetInstance = TargetInstance
	Wire.Parent = TargetInstance
end
local t2 = {
	__ClassName = "Megaphone"
}
t2.__index = t2
setmetatable(t2, Basic)
function t2.new(p1, p2, p3) --[[ Line: 60 | Upvalues: Basic (copy), t (copy), t2 (copy) ]]
	local v1 = Basic.new(p1, p2, t, p3)
	setmetatable(v1, t2)
	local AudioEmitter = Instance.new("AudioEmitter")
	local AudioPlayer = Instance.new("AudioPlayer")
	local Wire = Instance.new("Wire")
	local Wire_2 = Instance.new("Wire")
	AudioPlayer.Volume = 0.5
	AudioPlayer.Parent = AudioEmitter
	Wire.Parent = AudioEmitter
	Wire.SourceInstance = AudioPlayer
	Wire.TargetInstance = AudioEmitter
	Wire_2.Parent = AudioEmitter
	Wire_2.TargetInstance = AudioEmitter
	if p1:FindFirstChild("AudioDeviceInput") then
		Wire_2.SourceInstance = p1.AudioDeviceInput
	end
	local AudioDistortion = Instance.new("AudioDistortion", Wire)
	AudioDistortion.Level = 0.4
	local SourceInstance = Wire.SourceInstance
	local TargetInstance = Wire.TargetInstance
	Wire.TargetInstance = AudioDistortion
	local Wire_3 = Instance.new("Wire")
	Wire_3.SourceInstance = AudioDistortion
	Wire_3.TargetInstance = TargetInstance
	Wire_3.Parent = TargetInstance
	local AudioDistortion_2 = Instance.new("AudioDistortion", Wire_2)
	AudioDistortion_2.Level = 0.5
	local SourceInstance_2 = Wire_2.SourceInstance
	local TargetInstance_2 = Wire_2.TargetInstance
	Wire_2.TargetInstance = AudioDistortion_2
	local Wire_4 = Instance.new("Wire")
	Wire_4.SourceInstance = AudioDistortion_2
	Wire_4.TargetInstance = TargetInstance_2
	Wire_4.Parent = TargetInstance_2
	local AudioFader = Instance.new("AudioFader", Wire_2)
	AudioFader.Volume = 2
	local SourceInstance_3 = Wire_2.SourceInstance
	local TargetInstance_3 = Wire_2.TargetInstance
	Wire_2.TargetInstance = AudioFader
	local Wire_5 = Instance.new("Wire")
	Wire_5.SourceInstance = AudioFader
	Wire_5.TargetInstance = TargetInstance_3
	Wire_5.Parent = TargetInstance_3
	AudioEmitter.Parent = v1.Model.Model.Body.EmmitAttachment
	v1.Model.Model.TeamColor.BrickColor = p1.TeamColor
	v1.AudioPlayer = AudioPlayer
	v1.Maid:GiveTask(AudioEmitter)
	if v1.Local then
		Wire_2.TargetInstance = nil
	end
	v1:DefaultDisableCamLock()
	return v1
end
function t2.GetLeftArmPosition(p1) --[[ Line: 115 ]]
	return nil
end
function t2.InputBegan(p1, p2, p3) --[[ Line: 118 | Upvalues: t (copy), Basic (copy) ]]
	local v1 = if p2.UserInputType == Enum.UserInputType.MouseButton1 then true elseif p2.UserInputType == Enum.UserInputType.Gamepad1 then p2.KeyCode == Enum.KeyCode.ButtonR2 else false
	if p1.AudioPlayer and v1 then
		local v2 = "rbxassetid://" .. t.FunSounds[2].SoundId
		if p1.AudioPlayer.Asset ~= v2 then
			p1.AudioPlayer.Asset = v2
			p1.AudioPlayer.TimePosition = 0
		end
		p1.AudioPlayer:Play()
	end
	if p1.Local and v1 then
		p1:BroadcastInputBegan(p2)
	end
	Basic.InputBegan(p1, p2, p3)
end
function t2.InputEnded(p1) --[[ Line: 137 ]] end
return t2