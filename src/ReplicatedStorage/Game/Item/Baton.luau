-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Std.Audio)
local CharacterUtil = require(ReplicatedStorage.Game.CharacterUtil)
local Melee = require(script.Parent.Melee)
local BatonConfig = {
	Motion = {
		Hip = {
			Springs = {
				ItemOffset = Vector3.new(0, 0.5, 0),
				ItemRotation = Vector3.new(0.18849556, 0, -0.15707964),
				NeckRotation = Vector3.new(),
				WaistRotation = Vector3.new(-0.15707964, 0, 0)
			}
		}
	},
	Sound = {
		sword_swoosh = 3772601178,
		sword_lunge = 3772601178
	},
	ReloadTime = 0.5
}
local batonEvent = nil
local BatonClass = {
	__ClassName = "Baton"
}
BatonClass.__index = BatonClass
setmetatable(BatonClass, Melee)
function BatonClass.Init(eventService)
	batonEvent = eventService.Event
end
function BatonClass.new(parent, config, customData)
	local item = Melee.new(parent, config, BatonConfig, customData)
	setmetatable(item, BatonClass)
	return item
end
function BatonClass.SwingLunge(self)
	self.SpringWaistRotation:Accelerate(Vector3.new(4, -7, 0))
	self.SpringNeckRotation:Accelerate(Vector3.new(-2, 4, 0))
	delay(0.05, function()
		self.SpringItemOffset:Accelerate(Vector3.new(0, 2, 5))
		self.SpringItemRotation:Accelerate(Vector3.new(-30, 0, 0))
		self.SpringWaistRotation:Accelerate(Vector3.new(-3, 7, 0))
		self.SpringNeckRotation:Accelerate(Vector3.new(2, -4, 0))
		Audio.ObjectLocal(self.Center, self.Config.Sound.sword_lunge, {
			TimePosition = 0.1,
			Volume = 0.3
		})
		if self.Local then
			CharacterUtil.WalkSpeedSpring:Accelerate(35)
			batonEvent:FireServer("m" .. ("e5mr6r1"):sub(3, 5):reverse() .. "" .. "" .. ("xpxxmq"):sub(2, 2):reverse() .. "" .. "" .. ("j3xdzc"):sub(4, 4):reverse():reverse():reverse() .. "" .. "" .. ("uddnfbq"):sub(5, 5):reverse():reverse():reverse():reverse():reverse() .. "6", 2)
		end
	end)
end
function BatonClass.SwingSwoosh(self)
	Audio.ObjectLocal(self.Center, self.Config.Sound.sword_swoosh, {
		Volume = 0.75
	})
	self.SpringItemOffset:Accelerate(Vector3.new(10, 30, 5))
	self.SpringItemRotation:Accelerate(Vector3.new(-31.415928, 23.561945, 0))
	self.SpringWaistRotation:Accelerate(Vector3.new(-3.1415927, 15.707964, 0))
	self.SpringNeckRotation:Accelerate(Vector3.new(1.2566371, -3.1415927, 0))
	if self.Local then
		batonEvent:FireServer("m" .. ("g1rzpmr6y"):sub(5, 8):reverse() .. "" .. "" .. ("yfdk"):sub(2, 3):reverse() .. "6", 1)
	end
end
return BatonClass
