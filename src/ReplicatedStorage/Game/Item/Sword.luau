-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Std.Audio)
local CharacterUtil = require(ReplicatedStorage.Game.CharacterUtil)
local Melee = require(script.Parent.Melee)
local SwordConfig = {
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
		sword_lunge = 3772602113
	},
	ReloadTime = 0.5
}
local EventRemote = nil
local Sword = {
	__ClassName = "Sword"
}
Sword.__index = Sword
setmetatable(Sword, Melee)
function Sword.Init(p1)
	EventRemote = p1.Event
end
function Sword.new(p1, p2, p3)
	local swordInstance = Melee.new(p1, p2, SwordConfig, p3)
	setmetatable(swordInstance, Sword)
	swordInstance.TrailLengthTime = 0
	return swordInstance
end
function Sword.SwingLunge(p1)
	Audio.ObjectLocal(p1.Center, p1.Config.Sound.sword_lunge, {
		TimePosition = 0.1,
		Volume = 0.3
	})
	p1.SpringItemOffset:SetTarget(Vector3.new(0, 2, 0.5))
	p1.SpringItemRotation:SetTarget(Vector3.new(-1.4137167, 0, 0))
	delay(0.25, function()
		p1.SpringWaistRotation:Accelerate(Vector3.new(-6.2831855, 9.424778, 0))
		p1.SpringItemOffset:Accelerate(Vector3.new(0, 0, -30))
		if p1.Local then
			CharacterUtil.WalkSpeedSpring:Accelerate(35)
			EventRemote:FireServer("m" .. ("q36r"):sub(3, 3):reverse() .. "" .. "" .. ("lipmrx"):sub(3, 5):reverse():reverse():reverse() .. "df6", 2)
		end
	end)
	delay(0.45, function()
		p1.SpringItemOffset:SetTarget(p1.Config.Motion.Hip.Springs.ItemOffset)
		p1.SpringItemRotation:SetTarget(p1.Config.Motion.Hip.Springs.ItemRotation)
	end)
	p1.TrailLengthTime = 0.45
end
function Sword.SwingSwoosh(p1)
	Audio.ObjectLocal(p1.Center, p1.Config.Sound.sword_swoosh, {
		Volume = 0.75
	})
	p1.SpringItemOffset:Accelerate(Vector3.new(10, 30, 5))
	p1.SpringItemRotation:Accelerate(Vector3.new(-31.415928, 23.561945, 0))
	p1.SpringWaistRotation:Accelerate(Vector3.new(-3.1415927, 15.707964, 0))
	p1.SpringNeckRotation:Accelerate(Vector3.new(1.2566371, -3.1415927, 0))
	p1.TrailLengthTime = 0.1
	if p1.Local then
		EventRemote:FireServer("m" .. ("k6k"):sub(2, 2):reverse():reverse():reverse() .. "" .. "" .. ("k8mry802"):sub(3, 4):reverse() .. "" .. "" .. ("tdpa"):sub(2, 3):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("w0ldfho5"):sub(5, 5):reverse():reverse():reverse() .. "6", 1)
	end
end
function Sword.Stepped(p1)
	local currentTime = workspace:GetServerTimeNow()
	p1.Model.Trail.Trail.Enabled = currentTime - p1:_getLastUse() < p1.TrailLengthTime
	Melee.Stepped(p1)
end
return Sword
