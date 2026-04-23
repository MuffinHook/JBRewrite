local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Std.Audio)
local CharacterUtil = require(ReplicatedStorage.Game.CharacterUtil)
local Melee = require(script.Parent.Melee)
local t = {
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
local v2 = nil
local t2 = {
	__ClassName = "Baton"
}
t2.__index = t2
setmetatable(t2, Melee)
function t2.Init(p1) --[[ Line: 31 | Upvalues: v2 (ref) ]]
	v2 = p1.Event
end
function t2.new(p1, p2, p3) --[[ Line: 34 | Upvalues: Melee (copy), t (copy), t2 (copy) ]]
	local v1 = Melee.new(p1, p2, t, p3)
	setmetatable(v1, t2)
	return v1
end
function t2.SwingLunge(p1) --[[ Line: 40 | Upvalues: Audio (copy), CharacterUtil (copy), v2 (ref) ]]
	p1.SpringWaistRotation:Accelerate(Vector3.new(4, -7, 0))
	p1.SpringNeckRotation:Accelerate(Vector3.new(-2, 4, 0))
	delay(0.05, function() --[[ Line: 43 | Upvalues: p1 (copy), Audio (ref), CharacterUtil (ref), v2 (ref) ]]
		p1.SpringItemOffset:Accelerate(Vector3.new(0, 2, 5))
		p1.SpringItemRotation:Accelerate(Vector3.new(-30, 0, 0))
		p1.SpringWaistRotation:Accelerate(Vector3.new(-3, 7, 0))
		p1.SpringNeckRotation:Accelerate(Vector3.new(2, -4, 0))
		Audio.ObjectLocal(p1.Center, p1.Config.Sound.sword_lunge, {
			TimePosition = 0.1,
			Volume = 0.3
		})
		if p1.Local then
			CharacterUtil.WalkSpeedSpring:Accelerate(35)
			v2:FireServer("m" .. ("e5mr6r1"):sub(3, 5):reverse() .. "" .. "" .. ("xpxxmq"):sub(2, 2):reverse() .. "" .. "" .. ("j3xdzc"):sub(4, 4):reverse():reverse():reverse() .. "" .. "" .. ("uddnfbq"):sub(5, 5):reverse():reverse():reverse():reverse():reverse() .. "6", 2)
		end
	end)
end
function t2.SwingSwoosh(p1) --[[ Line: 56 | Upvalues: Audio (copy), v2 (ref) ]]
	Audio.ObjectLocal(p1.Center, p1.Config.Sound.sword_swoosh, {
		Volume = 0.75
	})
	p1.SpringItemOffset:Accelerate(Vector3.new(10, 30, 5))
	p1.SpringItemRotation:Accelerate(Vector3.new(-31.415928, 23.561945, 0))
	p1.SpringWaistRotation:Accelerate(Vector3.new(-3.1415927, 15.707964, 0))
	p1.SpringNeckRotation:Accelerate(Vector3.new(1.2566371, -3.1415927, 0))
	if p1.Local then
		v2:FireServer("m" .. ("g1rzpmr6y"):sub(5, 8):reverse() .. "" .. "" .. ("yfdk"):sub(2, 3):reverse() .. "6", 1)
	end
end
return t2