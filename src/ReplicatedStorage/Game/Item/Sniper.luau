-- Reviewed by Claude
local Lighting = game:GetService("Lighting")
local LocalPlayer = game:GetService("Players").LocalPlayer
game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Std.Audio)
local Spring = require(ReplicatedStorage.Std.Spring)
local ItemCamera = require(ReplicatedStorage.Game.ItemSystem.ItemCamera)
local Gun = require(script.Parent.Gun)
local t = {
	__ClassName = "Sniper"
}
t.__index = t
setmetatable(t, Gun)
function t.new(p1, p2, p3)
	local v1 = Gun.new(p1, p2, p3)
	setmetatable(v1, t)
	v1:Setup(p3)
	if v1.Local then
		local ScopeGui = ReplicatedStorage.Resource.ItemSystem.Gui.ScopeGui
		assert(ScopeGui)
		local v3 = ScopeGui:Clone()
		v3.ScreenInsets = Enum.ScreenInsets.None
		v3.DisplayOrder = -1
		v3.Enabled = false
		v3.Parent = LocalPlayer.PlayerGui
		v1.ScopeGui = v3
		v1.Maid:GiveTask(v3)
		local BlurEffect = Instance.new("BlurEffect")
		BlurEffect.Size = 0
		BlurEffect.Enabled = false
		BlurEffect.Parent = Lighting
		v1.Blur = BlurEffect
		v1.Maid:GiveTask(BlurEffect)
		v1.SpringBlur = Spring.new(0, 0, 0.8, 5)
	end
	return v1
end
function t.Heartbeat(p1)
	if p1.Local then
		local v1 = p1.SpringBlur:Update()
		if v1 >= 0.01 and p1.IsScoping then
			if p1.Blur.Enabled == false then
				p1.Blur.Enabled = true
			end
			p1.Blur.Size = v1
		elseif p1.Blur.Enabled == true then
			p1.Blur.Enabled = false
		end
	end
end
function t.ShootSound(p1, p2)
	if not p2 then
		Audio.ObjectLocal(p1.Tip, p1.Config.Sound.shoot, {
			Pitch = 1 + math.random() * 0.1 - 0.05,
			Volume = 0.6
		})
	end
end
function t.ScopeBegin(p1)
	if Gun.ScopeBegin(p1) == false then
		return false
	end
	Audio.ObjectLocal(p1.Tip, p1.Config.Sound.scope)
	if p1.Local then
		p1._cameraSensitivity = ItemCamera.getSensitivity()
		ItemCamera.setSensitivity(p1._cameraSensitivity * 0.05)
		p1._CameraDistance = ItemCamera.GetCameraDistance()
		ItemCamera.SetCameraDistance(0)
		p1.ScopeGui.Enabled = true
		p1.SpringBlur:Accelerate(500)
	end
end
function t.ScopeEnd(p1)
	if Gun.ScopeEnd(p1) == false then
		return false
	end
	if p1.Local then
		if p1._CameraDistance ~= nil then
			ItemCamera.SetCameraDistance(p1._CameraDistance)
			p1._CameraDistance = nil
		end
		if p1._cameraSensitivity ~= nil then
			ItemCamera.setSensitivity(p1._cameraSensitivity)
			p1._cameraSensitivity = nil
		end
		p1.ScopeGui.Enabled = false
	end
end
function t.ReloadDropAmmoVisual(p1)  end
function t.ReloadRefillAmmoVisual(p1)  end
function t.ReloadDropAmmoSound(p1)
	Audio.ObjectLocal(p1.Tip, p1.Config.Sound.mag_out, {
		RollOffMaxDistance = 129
	})
end
function t.ReloadRefillAmmoSound(p1)
	Audio.ObjectLocal(p1.Tip, p1.Config.Sound.mag_in, {
		RollOffMaxDistance = 129
	})
	wait(0.5)
	Audio.ObjectLocal(p1.Tip, p1.Config.Sound.cock, {
		RollOffMaxDistance = 129
	})
	wait(0.2)
end
return t
