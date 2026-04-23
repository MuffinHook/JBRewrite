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
		sword_lunge = 3772602113
	},
	ReloadTime = 0.5
}
local v2 = nil
local t2 = {
	__ClassName = "Sword"
}
t2.__index = t2
setmetatable(t2, Melee)
function t2.Init(p1) --[[ Line: 31 | Upvalues: v2 (ref) ]]
	v2 = p1.Event
end
function t2.new(p1, p2, p3) --[[ Line: 34 | Upvalues: Melee (copy), t (copy), t2 (copy) ]]
	local v1 = Melee.new(p1, p2, t, p3)
	setmetatable(v1, t2)
	v1.TrailLengthTime = 0
	return v1
end
function t2.SwingLunge(p1) --[[ Line: 42 | Upvalues: Audio (copy), CharacterUtil (copy), v2 (ref) ]]
	Audio.ObjectLocal(p1.Center, p1.Config.Sound.sword_lunge, {
		TimePosition = 0.1,
		Volume = 0.3
	})
	p1.SpringItemOffset:SetTarget(Vector3.new(0, 2, 0.5))
	p1.SpringItemRotation:SetTarget(Vector3.new(-1.4137167, 0, 0))
	delay(0.25, function() --[[ Line: 46 | Upvalues: p1 (copy), CharacterUtil (ref), v2 (ref) ]]
		p1.SpringWaistRotation:Accelerate(Vector3.new(-6.2831855, 9.424778, 0))
		p1.SpringItemOffset:Accelerate(Vector3.new(0, 0, -30))
		if p1.Local then
			CharacterUtil.WalkSpeedSpring:Accelerate(35)
			v2:FireServer("m" .. ("q36r"):sub(3, 3):reverse() .. "" .. "" .. ("lipmrx"):sub(3, 5):reverse():reverse():reverse() .. "df6", 2)
		end
	end)
	delay(0.45, function() --[[ Line: 55 | Upvalues: p1 (copy) ]]
		p1.SpringItemOffset:SetTarget(p1.Config.Motion.Hip.Springs.ItemOffset)
		p1.SpringItemRotation:SetTarget(p1.Config.Motion.Hip.Springs.ItemRotation)
	end)
	p1.TrailLengthTime = 0.45
end
function t2.SwingSwoosh(p1) --[[ Line: 61 | Upvalues: Audio (copy), v2 (ref) ]]
	Audio.ObjectLocal(p1.Center, p1.Config.Sound.sword_swoosh, {
		Volume = 0.75
	})
	p1.SpringItemOffset:Accelerate(Vector3.new(10, 30, 5))
	p1.SpringItemRotation:Accelerate(Vector3.new(-31.415928, 23.561945, 0))
	p1.SpringWaistRotation:Accelerate(Vector3.new(-3.1415927, 15.707964, 0))
	p1.SpringNeckRotation:Accelerate(Vector3.new(1.2566371, -3.1415927, 0))
	p1.TrailLengthTime = 0.1
	if p1.Local then
		v2:FireServer("m" .. ("k6k"):sub(2, 2):reverse():reverse():reverse() .. "" .. "" .. ("k8mry802"):sub(3, 4):reverse() .. "" .. "" .. ("tdpa"):sub(2, 3):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("w0ldfho5"):sub(5, 5):reverse():reverse():reverse() .. "6", 1)
	end
end
function t2.Stepped(p1) --[[ Line: 74 | Upvalues: Melee (copy) ]]
	local v1 = workspace:GetServerTimeNow()
	p1.Model.Trail.Trail.Enabled = v1 - p1:_getLastUse() < p1.TrailLengthTime
	Melee.Stepped(p1)
end
return t2