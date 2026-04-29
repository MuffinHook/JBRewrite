local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Std.Audio)
local Joint = require(ReplicatedStorage.Std.Joint)
local Spring = require(ReplicatedStorage.Std.Spring)
local GamepassUtils = require(ReplicatedStorage.Gamepass.GamepassUtils)
local GamepassSystem = require(ReplicatedStorage.Gamepass.GamepassSystem)
local Gun = require(script.Parent.Gun)
local PistolClass = {
	__ClassName = "Pistol"
}
PistolClass.__index = PistolClass
setmetatable(PistolClass, Gun)
function PistolClass.new(p1, p2, p3)
	local gunInstance = Gun.new(p1, p2, p3)
	setmetatable(gunInstance, PistolClass)
	gunInstance._hasSWAT = false
	gunInstance:Setup(p3)
	return gunInstance
end
function PistolClass.SetupModel(self)
	if self.Player and (self.Player.DisplayName and GamepassSystem.doesPlayerOwnCached(self.Player, GamepassUtils.EnumGamepass.SWAT)) then
		self._hasSWAT = true
		Gun.SetupModel(self, "PistolSWAT")
	else
		Gun.SetupModel(self)
	end
	local Slide = self.Model.Motion.Slide
	local slideMotor = Joint.Motor(Slide, self.BoundingBox)
	Slide.Anchored = false
	local slideSpring = Spring.new(Vector3.new(), Vector3.new(), 0.9, 40)
	self.MotorSlide = slideMotor
	self.SpringSlide = slideSpring
end
function PistolClass.UpdateItemSprings(self)
	Gun.UpdateItemSprings(self)
	self.SlidePosition = self.SpringSlide:Update()
end
function PistolClass.UpdateItemJoints(self)
	Gun.UpdateItemJoints(self)
	self.MotorSlide.C1 = CFrame.new(self.SlidePosition)
end
function PistolClass.ShootSound(self, isSilenced)
	if not isSilenced then
		if self._hasSWAT then
			Audio.ObjectLocal(self.Tip, self.Config.Sound.pistol_shot_silenced, {
				Pitch = 1
			})
		else
			Audio.ObjectLocal(self.Tip, self.Config.Sound.gun_pistol_shot_04, {
				Pitch = 1
			})
		end
		task.delay(0.1, function()
			Audio.ObjectLocal(self.Tip, self.Config.Sound.gun_pistol_slide_fast_01, {
				Volume = 0.3,
				Pitch = 1 + math.random() * 0.1 - 0.05
			})
		end)
		self.SpringSlide:Accelerate(Vector3.new(0, 0, 30))
	end
end
function PistolClass.ReloadDropAmmoSound(self)
	Audio.ObjectLocal(self.Tip, self.Config.Sound.gun_pistol_remove_mag_01, {
		RollOffMaxDistance = 129
	})
end
function PistolClass.ReloadRefillAmmoSound(self)
	Audio.ObjectLocal(self.Tip, self.Config.Sound.gun_pistol_insert_mag_01, {
		RollOffMaxDistance = 129
	})
	task.wait(0.4)
	Audio.ObjectLocal(self.Tip, self.Config.Sound.gun_pistol_slide_fast_01, {
		RollOffMaxDistance = 129
	})
	task.wait(0.1)
end
return PistolClass
