local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Gun = require(script.Parent.Gun)
local PlasmaGun = require(ReplicatedStorage.Game.Item.PlasmaGun)
local PlasmaPistolClass = {
	__ClassName = "PlasmaPistol"
}
PlasmaPistolClass.__index = PlasmaPistolClass
setmetatable(PlasmaPistolClass, PlasmaGun)
function PlasmaPistolClass.Init(player)  end
function PlasmaPistolClass.new(player, arg2, arg3)
	local instance = PlasmaGun.new(player, arg2, arg3)
	setmetatable(instance, PlasmaPistolClass)
	instance:Setup(arg3)
	return instance
end
function PlasmaPistolClass.SetupModel(gun)
	Gun.SetupModel(gun)
end
return PlasmaPistolClass
