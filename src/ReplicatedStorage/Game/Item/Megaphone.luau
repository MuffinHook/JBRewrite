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
local function wireup(source, target)
	local Wire = Instance.new("Wire")
	Wire.SourceInstance = source
	Wire.TargetInstance = target
	Wire.Parent = target
	return Wire
end
local function split(wire, newTarget)
	local SourceInstance = wire.SourceInstance
	local TargetInstance = wire.TargetInstance
	wire.TargetInstance = newTarget
	local newWire = Instance.new("Wire")
	newWire.SourceInstance = newTarget
	newWire.TargetInstance = TargetInstance
	newWire.Parent = TargetInstance
end
local Megaphone = {
	__ClassName = "Megaphone"
}
Megaphone.__index = Megaphone
setmetatable(Megaphone, Basic)
function Megaphone.new(self, itemInstance, motionConfig)
	local newInstance = Basic.new(self, itemInstance, t, motionConfig)
	setmetatable(newInstance, Megaphone)
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
	if self:FindFirstChild("AudioDeviceInput") then
		Wire_2.SourceInstance = self.AudioDeviceInput
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
	AudioEmitter.Parent = newInstance.Model.Model.Body.EmmitAttachment
	newInstance.Model.Model.TeamColor.BrickColor = self.TeamColor
	newInstance.AudioPlayer = AudioPlayer
	newInstance.Maid:GiveTask(AudioEmitter)
	if newInstance.Local then
		Wire_2.TargetInstance = nil
	end
	newInstance:DefaultDisableCamLock()
	return newInstance
end
function Megaphone.GetLeftArmPosition(self)
	return nil
end
function Megaphone.InputBegan(self, input, inputState)
	local isClickInput = if input.UserInputType == Enum.UserInputType.MouseButton1 then true elseif input.UserInputType == Enum.UserInputType.Gamepad1 then input.KeyCode == Enum.KeyCode.ButtonR2 else false
	if self.AudioPlayer and isClickInput then
		local soundAsset = "rbxassetid://" .. t.FunSounds[2].SoundId
		if self.AudioPlayer.Asset ~= soundAsset then
			self.AudioPlayer.Asset = soundAsset
			self.AudioPlayer.TimePosition = 0
		end
		self.AudioPlayer:Play()
	end
	if self.Local and isClickInput then
		self:BroadcastInputBegan(input)
	end
	Basic.InputBegan(self, input, inputState)
end
function Megaphone.InputEnded(self) end
return Megaphone
