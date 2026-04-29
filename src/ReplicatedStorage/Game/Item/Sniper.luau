local Lighting = game:GetService("Lighting")
local LocalPlayer = game:GetService("Players").LocalPlayer
game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Std.Audio)
local Spring = require(ReplicatedStorage.Std.Spring)
local ItemCamera = require(ReplicatedStorage.Game.ItemSystem.ItemCamera)
local Gun = require(script.Parent.Gun)
local Sniper = {
	__ClassName = "Sniper"
}
Sniper.__index = Sniper
setmetatable(Sniper, Gun)
function Sniper.new(p1, p2, p3)
	local instance = Gun.new(p1, p2, p3)
	setmetatable(instance, Sniper)
	instance:Setup(p3)
	if instance.Local then
		local ScopeGui = ReplicatedStorage.Resource.ItemSystem.Gui.ScopeGui
		assert(ScopeGui)
		local scopeGui = ScopeGui:Clone()
		scopeGui.ScreenInsets = Enum.ScreenInsets.None
		scopeGui.DisplayOrder = -1
		scopeGui.Enabled = false
		scopeGui.Parent = LocalPlayer.PlayerGui
		instance.ScopeGui = scopeGui
		instance.Maid:GiveTask(scopeGui)
		local BlurEffect = Instance.new("BlurEffect")
		BlurEffect.Size = 0
		BlurEffect.Enabled = false
		BlurEffect.Parent = Lighting
		instance.Blur = BlurEffect
		instance.Maid:GiveTask(BlurEffect)
		instance.SpringBlur = Spring.new(0, 0, 0.8, 5)
	end
	return instance
end
function Sniper.Heartbeat(self)
	if self.Local then
		local blurValue = self.SpringBlur:Update()
		if blurValue >= 0.01 and self.IsScoping then
			if self.Blur.Enabled == false then
				self.Blur.Enabled = true
			end
			self.Blur.Size = blurValue
		elseif self.Blur.Enabled == true then
			self.Blur.Enabled = false
		end
	end
end
function Sniper.ShootSound(self, p2)
	if not p2 then
		Audio.ObjectLocal(self.Tip, self.Config.Sound.shoot, {
			Pitch = 1 + math.random() * 0.1 - 0.05,
			Volume = 0.6
		})
	end
end
function Sniper.ScopeBegin(self)
	if Gun.ScopeBegin(self) == false then
		return false
	end
	Audio.ObjectLocal(self.Tip, self.Config.Sound.scope)
	if self.Local then
		self._cameraSensitivity = ItemCamera.getSensitivity()
		ItemCamera.setSensitivity(self._cameraSensitivity * 0.05)
		self._CameraDistance = ItemCamera.GetCameraDistance()
		ItemCamera.SetCameraDistance(0)
		self.ScopeGui.Enabled = true
		self.SpringBlur:Accelerate(500)
	end
end
function Sniper.ScopeEnd(self)
	if Gun.ScopeEnd(self) == false then
		return false
	end
	if self.Local then
		if self._CameraDistance ~= nil then
			ItemCamera.SetCameraDistance(self._CameraDistance)
			self._CameraDistance = nil
		end
		if self._cameraSensitivity ~= nil then
			ItemCamera.setSensitivity(self._cameraSensitivity)
			self._cameraSensitivity = nil
		end
		self.ScopeGui.Enabled = false
	end
end
function Sniper.ReloadDropAmmoVisual(self)  end
function Sniper.ReloadRefillAmmoVisual(self)  end
function Sniper.ReloadDropAmmoSound(self)
	Audio.ObjectLocal(self.Tip, self.Config.Sound.mag_out, {
		RollOffMaxDistance = 129
	})
end
function Sniper.ReloadRefillAmmoSound(self)
	Audio.ObjectLocal(self.Tip, self.Config.Sound.mag_in, {
		RollOffMaxDistance = 129
	})
	task.wait(0.5)
	Audio.ObjectLocal(self.Tip, self.Config.Sound.cock, {
		RollOffMaxDistance = 129
	})
	task.wait(0.2)
end
return Sniper
