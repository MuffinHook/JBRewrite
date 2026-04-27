local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Gun = require(script.Parent.Gun)
local PlasmaGun = require(ReplicatedStorage.Game.Item.PlasmaGun)
local Audio = require(ReplicatedStorage.Std.Audio)
local PlasmaShotgunClass = {
	__ClassName = "PlasmaShotgun"
}
PlasmaShotgunClass.__index = PlasmaShotgunClass
setmetatable(PlasmaShotgunClass, PlasmaGun)
function PlasmaShotgunClass.Init(self)  end
function PlasmaShotgunClass.new(self, itemTemplate, config)
	local plasmaGunInstance = PlasmaGun.new(self, itemTemplate, config)
	setmetatable(plasmaGunInstance, PlasmaShotgunClass)
	plasmaGunInstance:Setup(config)
	return plasmaGunInstance
end
function PlasmaShotgunClass.SetupModel(self)
	Gun.SetupModel(self)
end
function PlasmaShotgunClass.ShootSound(self, suppressSound)
	if not suppressSound then
		Audio.ObjectLocal(self.Tip, 17183453324, {
			Volume = 0.35,
			TimePosition = 0.05
		})
	end
end
return PlasmaShotgunClass
