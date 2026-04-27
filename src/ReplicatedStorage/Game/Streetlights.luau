local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Binder = require(ReplicatedStorage.Std.Binder)
local Maid = require(ReplicatedStorage.Std.Maid)
local StreetlightClass = {}
StreetlightClass.__index = StreetlightClass
function StreetlightClass.new(streetlightObject)
	local instance = {}
	setmetatable(instance, StreetlightClass)
	instance._maid = Maid.new()
	instance._obj = streetlightObject
	return instance
end
function StreetlightClass.SetValue(self, enabled)
	local Light = self._obj:FindFirstChild("Light")
	Light:FindFirstChildWhichIsA("Light", true).Enabled = enabled
	Light.Material = enabled and Enum.Material.Neon or Enum.Material.SmoothPlastic
end
function StreetlightClass.Destroy(self)
	local _maid = self._maid
	self._maid = nil
	_maid:Destroy()
	setmetatable(self, nil)
end
local StreetlightsModule = {
	_enabled = false
}
function StreetlightsModule.init()
	local binder = Binder.new("Streetlight", StreetlightClass)
	StreetlightsModule._binder = binder
	binder:GetClassAddedSignal():Connect(function(streetlight)
		streetlight:SetValue(StreetlightsModule._enabled)
	end)
	binder:Start()
end
function StreetlightsModule.SetEnabled(enabled)
	StreetlightsModule._enabled = enabled
	for i, streetlight in ipairs(StreetlightsModule._binder:GetAll()) do
		if streetlight.SetValue then
			streetlight:SetValue(enabled)
		end
		wait(math.random() * 0.1)
	end
end
function StreetlightsModule.Flicker()
	local isLit = true
	for i = 1, 10 do
		isLit = not isLit
		for i2, streetlight in ipairs(StreetlightsModule._binder:GetAll()) do
			streetlight:SetValue(isLit)
		end
		wait(0.2)
	end
	for i, streetlight in ipairs(StreetlightsModule._binder:GetAll()) do
		streetlight:SetValue(StreetlightsModule._enabled)
	end
end
return StreetlightsModule
