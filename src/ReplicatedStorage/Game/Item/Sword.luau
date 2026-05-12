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
function Sword.Init(eventConfig)
	EventRemote = eventConfig.Event
end
function Sword.new(weaponUser, damageConfig, fireRateMultiplier)
	local swordInstance = Melee.new(weaponUser, damageConfig, SwordConfig, fireRateMultiplier)
	setmetatable(swordInstance, Sword)
	swordInstance.TrailLengthTime = 0
	return swordInstance
end
function Sword.SwingLunge(swordInstance)
	Audio.ObjectLocal(swordInstance.Center, swordInstance.Config.Sound.sword_lunge, {
		TimePosition = 0.1,
		Volume = 0.3
	})
	swordInstance.SpringItemOffset:SetTarget(Vector3.new(0, 2, 0.5))
	swordInstance.SpringItemRotation:SetTarget(Vector3.new(-1.4137167, 0, 0))
	task.delay(0.25, function()
		swordInstance.SpringWaistRotation:Accelerate(Vector3.new(-math.tau, 9.424778, 0))
		swordInstance.SpringItemOffset:Accelerate(Vector3.new(0, 0, -30))
		if swordInstance.Local then
			CharacterUtil.WalkSpeedSpring:Accelerate(35)
			EventRemote:FireServer("swingBatonOrSword", 2)
		end
	end)
	task.delay(0.45, function()
		swordInstance.SpringItemOffset:SetTarget(swordInstance.Config.Motion.Hip.Springs.ItemOffset)
		swordInstance.SpringItemRotation:SetTarget(swordInstance.Config.Motion.Hip.Springs.ItemRotation)
	end)
	swordInstance.TrailLengthTime = 0.45
end
function Sword.SwingSwoosh(swordInstance)
	Audio.ObjectLocal(swordInstance.Center, swordInstance.Config.Sound.sword_swoosh, {
		Volume = 0.75
	})
	swordInstance.SpringItemOffset:Accelerate(Vector3.new(10, 30, 5))
	swordInstance.SpringItemRotation:Accelerate(Vector3.new(-31.415928, 23.561945, 0))
	swordInstance.SpringWaistRotation:Accelerate(Vector3.new(-math.pi, 15.707964, 0))
	swordInstance.SpringNeckRotation:Accelerate(Vector3.new(1.2566371, -math.pi, 0))
	swordInstance.TrailLengthTime = 0.1
	if swordInstance.Local then
		EventRemote:FireServer("swingBatonOrSword", 1)
	end
end
function Sword.Stepped(swordInstance)
	local currentTime = workspace:GetServerTimeNow()
	swordInstance.Model.Trail.Trail.Enabled = currentTime - swordInstance:_getLastUse() < swordInstance.TrailLengthTime
	Melee.Stepped(swordInstance)
end
return Sword
