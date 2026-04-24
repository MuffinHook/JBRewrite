-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Std.Audio)
local Joint = require(ReplicatedStorage.Std.Joint)
local Spring = require(ReplicatedStorage.Std.Spring)
local GamepassUtils = require(ReplicatedStorage.Gamepass.GamepassUtils)
local GamepassSystem = require(ReplicatedStorage.Gamepass.GamepassSystem)
local Gun = require(script.Parent.Gun)
local t = {
	__ClassName = "Pistol"
}
t.__index = t
setmetatable(t, Gun)
function t.new(p1, p2, p3)
	local v1 = Gun.new(p1, p2, p3)
	setmetatable(v1, t)
	v1._hasSWAT = false
	v1:Setup(p3)
	return v1
end
function t.SetupModel(p1)
	if p1.Player and (p1.Player.DisplayName and GamepassSystem.doesPlayerOwnCached(p1.Player, GamepassUtils.EnumGamepass.SWAT)) then
		p1._hasSWAT = true
		Gun.SetupModel(p1, "PistolSWAT")
	else
		Gun.SetupModel(p1)
	end
	local Slide = p1.Model.Motion.Slide
	local v1 = Joint.Motor(Slide, p1.BoundingBox)
	Slide.Anchored = false
	local v2 = Spring.new(Vector3.new(), Vector3.new(), 0.9, 40)
	p1.MotorSlide = v1
	p1.SpringSlide = v2
end
function t.UpdateItemSprings(p1)
	Gun.UpdateItemSprings(p1)
	p1.SlidePosition = p1.SpringSlide:Update()
end
function t.UpdateItemJoints(p1)
	Gun.UpdateItemJoints(p1)
	p1.MotorSlide.C1 = CFrame.new(p1.SlidePosition)
end
function t.ShootSound(p1, p2)
	if not p2 then
		if p1._hasSWAT then
			Audio.ObjectLocal(p1.Tip, p1.Config.Sound.pistol_shot_silenced, {
				Pitch = 1
			})
		else
			Audio.ObjectLocal(p1.Tip, p1.Config.Sound.gun_pistol_shot_04, {
				Pitch = 1
			})
		end
		delay(0.1, function()
			Audio.ObjectLocal(p1.Tip, p1.Config.Sound.gun_pistol_slide_fast_01, {
				Volume = 0.3,
				Pitch = 1 + math.random() * 0.1 - 0.05
			})
		end)
		p1.SpringSlide:Accelerate(Vector3.new(0, 0, 30))
	end
end
function t.ReloadDropAmmoSound(p1)
	Audio.ObjectLocal(p1.Tip, p1.Config.Sound.gun_pistol_remove_mag_01, {
		RollOffMaxDistance = 129
	})
end
function t.ReloadRefillAmmoSound(p1)
	Audio.ObjectLocal(p1.Tip, p1.Config.Sound.gun_pistol_insert_mag_01, {
		RollOffMaxDistance = 129
	})
	wait(0.4)
	Audio.ObjectLocal(p1.Tip, p1.Config.Sound.gun_pistol_slide_fast_01, {
		RollOffMaxDistance = 129
	})
	wait(0.1)
end
return t
